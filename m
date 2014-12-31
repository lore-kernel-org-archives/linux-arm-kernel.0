From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 31 Dec 2014 17:59:58 +0800
Subject: [RFC PATCH v2] hw/arm/boot: Add support for NUMA on ARM64
Message-ID: <1420019998-8664-1-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for NUMA on ARM64. Tested successfully running a guest
Linux kernel with the following patch applied:

- arm64:numa: adding numa support for arm64 platforms.
http://www.spinics.net/lists/arm-kernel/msg365316.html

Changes v1 ... v2:
Take into account Peter's comments:
* rename virt_memory_init to arm_generate_memory_dtb
* move arm_generate_memory_dtb to boot.c and make it a common func
* use a struct numa_map to generate numa dtb

Example qemu command line:
qemu-system-aarch64 \
    -enable-kvm -smp 4\
    -kernel Image \
    -m 512 -machine virt,kernel_irqchip=on \
    -initrd guestfs.cpio.gz \
    -cpu host -nographic \
    -numa node,mem=256M,cpus=0-1,nodeid=0 \
    -numa node,mem=256M,cpus=2-3,nodeid=1 \
    -append "console=ttyAMA0 root=/dev/ram"

Todo:
1)The NUMA nodes information in DT is not finalized yet, so this
patch might need to be further modified to follow any changes in it.

2)Consider IO-NUMA as well

Please refer to the following url for NUMA DT node details:

- Documentation: arm64/arm: dt bindings for numa.
http://www.spinics.net/lists/arm-kernel/msg380200.html

Example: 2 Node system each having 2 CPUs and a Memory

        numa-map {
                #address-cells = <2>;
                #size-cells = <1>;
                #node-count = <2>;
                mem-map =  <0x0 0x40000000 0>,
                           <0x0 0x50000000 1>;

                cpu-map = <0 1 0>,
                          <2 3 1>;

                node-matrix = <0 0 10>,
                              <0 1 20>,
                              <1 0 20>,
                              <1 1 10>;
        };

- mem-map:      This property defines the association between a range of
                memory and the proximity domain/numa node to which it belongs.

- cpu-map:      This property defines the association of range of processors
                (range of cpu ids) and the proximity domain to which
                the processor belongs.

- node-matrix:  This table provides a matrix that describes the relative
                distance (memory latency) between all System Localities.
                The value of each Entry[i j distance] in node-matrix table,
                where i represents a row of a matrix and j represents a
                column of a matrix, indicates the relative distances
                from Proximity Domain/Numa node i to every other
                node j in the system (including itself).

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 hw/arm/boot.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/virt.c |    7 +---
 2 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 0014c34..df33f4f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -312,6 +312,100 @@ static void set_kernel_args_old(const struct arm_boot_info *info)
     }
 }
 
+static int arm_generate_memory_dtb(void *fdt, const struct arm_boot_info *binfo,
+                        uint32_t acells, uint32_t scells)
+{
+    CPUState *cpu;
+    int min_cpu = 0, max_cpu = 0;
+    int i = 0, j = 0, k = 0, len = 20;
+    int size = 6;
+    int size_mem = nb_numa_nodes * size;
+    int size_matrix = nb_numa_nodes * size_mem;
+
+    if (!nb_numa_nodes) {
+        qemu_fdt_add_subnode(fdt, "/memory");
+        qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
+        return qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
+                                      acells, binfo->loader_start,
+                                      scells, binfo->ram_size);
+    }
+
+    struct {
+        uint64_t mem_map[size_mem];
+        uint64_t cpu_map[size_mem];
+        uint64_t node_matrix[size_matrix];
+    } numa_map;
+
+    hwaddr mem_base = binfo->loader_start;
+
+    qemu_fdt_add_subnode(fdt, "/numa-map");
+    qemu_fdt_setprop_cell(fdt, "/numa-map", "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/numa-map", "#size-cells", 0x1);
+    qemu_fdt_setprop_cell(fdt, "/numa-map", "#node-count", 0x2);
+
+    for (i = 0; i < nb_numa_nodes; i++) {
+        /* Generate mem_map */
+        char *nodename;
+        nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+        qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                  acells, mem_base,
+                                  scells, numa_info[i].node_mem - 1);
+        numa_map.mem_map[0 + size * i] = 1;
+        numa_map.mem_map[1 + size * i] = 0x0;
+        numa_map.mem_map[2 + size * i] = 1;
+        numa_map.mem_map[3 + size * i] = mem_base;
+        numa_map.mem_map[4 + size * i] = 1;
+        numa_map.mem_map[5 + size * i] = i;
+
+        mem_base += numa_info[i].node_mem;
+        g_free(nodename);
+
+        /* Generate cpu_map */
+        CPU_FOREACH(cpu) {
+            if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
+                if (cpu->cpu_index < min_cpu) {
+                    min_cpu = cpu->cpu_index;
+                }
+                if (cpu->cpu_index > max_cpu) {
+                    max_cpu = cpu->cpu_index;
+                }
+            }
+        }
+
+        numa_map.cpu_map[0 + size * i] = 1;
+        numa_map.cpu_map[1 + size * i] = min_cpu;
+        numa_map.cpu_map[2 + size * i] = 1;
+        numa_map.cpu_map[3 + size * i] = max_cpu;
+        numa_map.cpu_map[4 + size * i] = 1;
+        numa_map.cpu_map[5 + size * i] = i;
+        min_cpu = max_cpu + 1;
+
+        /* Generate node_matrix */
+        for (j = 0; j < nb_numa_nodes; j++) {
+            len = (i == j) ? 10 : 20;
+
+            numa_map.node_matrix[0 + size * k] = 1;
+            numa_map.node_matrix[1 + size * k] = i;
+            numa_map.node_matrix[2 + size * k] = 1;
+            numa_map.node_matrix[3 + size * k] = j;
+            numa_map.node_matrix[4 + size * k] = 1;
+            numa_map.node_matrix[5 + size * k] = len;
+            k++;
+        }
+    }
+
+    qemu_fdt_setprop_sized_cells_from_array(fdt, "/numa-map", "mem-map",
+                        size_mem / 2, numa_map.mem_map);
+    qemu_fdt_setprop_sized_cells_from_array(fdt, "/numa-map", "cpu-map",
+                        size_mem / 2, numa_map.cpu_map);
+    qemu_fdt_setprop_sized_cells_from_array(fdt, "/numa-map", "node-matrix",
+                        size_matrix / 2, numa_map.node_matrix);
+
+    return 0;
+}
+
 /**
  * load_dtb() - load a device tree binary image into memory
  * @addr:       the address to load the image at
@@ -385,9 +479,7 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         goto fail;
     }
 
-    rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
-                                      acells, binfo->loader_start,
-                                      scells, binfo->ram_size);
+    rc = arm_generate_memory_dtb(fdt, binfo, acells, scells);
     if (rc < 0) {
         fprintf(stderr, "couldn't set /memory/reg\n");
         goto fail;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 314e55b..7feddaf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -170,8 +170,6 @@ static void create_fdt(VirtBoardInfo *vbi)
      * to fill in necessary properties later
      */
     qemu_fdt_add_subnode(fdt, "/chosen");
-    qemu_fdt_add_subnode(fdt, "/memory");
-    qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
 
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
@@ -585,9 +583,8 @@ static void machvirt_init(MachineState *machine)
     fdt_add_cpu_nodes(vbi);
     fdt_add_psci_node(vbi);
 
-    memory_region_init_ram(ram, NULL, "mach-virt.ram", machine->ram_size,
-                           &error_abort);
-    vmstate_register_ram_global(ram);
+    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
+                                         machine->ram_size);
     memory_region_add_subregion(sysmem, vbi->memmap[VIRT_MEM].base, ram);
 
     create_flash(vbi);
-- 
1.7.1
