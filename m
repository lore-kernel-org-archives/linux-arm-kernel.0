From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 15 Dec 2014 09:06:03 +0800
Subject: [RFC PATCH] hw/arm/virt: Add support for NUMA on ARM64
In-Reply-To: <CAFEAcA85pW2J1JjjxxKGeN3fC-u4ZJ7PLYPiX3jWMjtdOfamsA@mail.gmail.com>
References: <1417524986-9196-1-git-send-email-zhaoshenglong@huawei.com>
 <CAFEAcA85pW2J1JjjxxKGeN3fC-u4ZJ7PLYPiX3jWMjtdOfamsA@mail.gmail.com>
Message-ID: <548E33FB.9090702@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/8 21:49, Peter Maydell wrote:
> On 2 December 2014 at 12:56, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> Add support for NUMA on ARM64. Tested successfully running a guest
>> Linux kernel with the following patch applied:
> 
> I'm still hoping for review from somebody who better understands
> how QEMU and NUMA should interact, but in the meantime some comments
> at a code level:
> 
>>  hw/arm/boot.c |   25 ------------
>>  hw/arm/virt.c |  120 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  2 files changed, 113 insertions(+), 32 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 0014c34..c20fee4 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -335,7 +335,6 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>  {
>>      void *fdt = NULL;
>>      int size, rc;
>> -    uint32_t acells, scells;
>>
>>      if (binfo->dtb_filename) {
>>          char *filename;
>> @@ -369,30 +368,6 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>          return 0;
>>      }
>>
>> -    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells");
>> -    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells");
>> -    if (acells == 0 || scells == 0) {
>> -        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
>> -        goto fail;
>> -    }
>> -
>> -    if (scells < 2 && binfo->ram_size >= (1ULL << 32)) {
>> -        /* This is user error so deserves a friendlier error message
>> -         * than the failure of setprop_sized_cells would provide
>> -         */
>> -        fprintf(stderr, "qemu: dtb file not compatible with "
>> -                "RAM size > 4GB\n");
>> -        goto fail;
>> -    }
>> -
>> -    rc = qemu_fdt_setprop_sized_cells(fdt, "/memory", "reg",
>> -                                      acells, binfo->loader_start,
>> -                                      scells, binfo->ram_size);
>> -    if (rc < 0) {
>> -        fprintf(stderr, "couldn't set /memory/reg\n");
>> -        goto fail;
>> -    }
>> -
> 
> This patchset seems to be moving the initialization of a lot of
> the dtb from this generic code into the virt board. That doesn't
> seem right to me -- why would NUMA support be specific to the
> virt board? I would expect support for this to be in the generic
> code (possibly controlled with a board option for "I support NUMA").
> As it is your patch will break support for every other
> board that uses device trees, because they rely on this code
> which you've deleted here.
> 

Good suggestion. Will fix this :-)

>>      if (binfo->kernel_cmdline && *binfo->kernel_cmdline) {
>>          rc = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>>                                       binfo->kernel_cmdline);
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 78f618d..9d18a91 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -170,8 +170,6 @@ static void create_fdt(VirtBoardInfo *vbi)
>>       * to fill in necessary properties later
>>       */
>>      qemu_fdt_add_subnode(fdt, "/chosen");
>> -    qemu_fdt_add_subnode(fdt, "/memory");
>> -    qemu_fdt_setprop_string(fdt, "/memory", "device_type", "memory");
>>
>>      /* Clock node, for the benefit of the UART. The kernel device tree
>>       * binding documentation claims the PL011 node clock properties are
>> @@ -235,6 +233,116 @@ static void fdt_add_psci_node(const VirtBoardInfo *vbi)
>>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>>  }
>>
>> +static int virt_memory_init(MachineState *machine,
>> +                            MemoryRegion *system_memory,
>> +                            const VirtBoardInfo *vbi)
>> +{
>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +    CPUState *cpu;
>> +    int min_cpu = 0, max_cpu = 0;
>> +    int i, j, count, len;
>> +    uint32_t acells, scells;
>> +
>> +    acells = qemu_fdt_getprop_cell(vbi->fdt, "/", "#address-cells");
>> +    scells = qemu_fdt_getprop_cell(vbi->fdt, "/", "#size-cells");
>> +    if (acells == 0 || scells == 0) {
>> +        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
>> +        goto fail;
>> +    }
>> +
>> +    if (scells < 2 && machine->ram_size >= (1ULL << 32)) {
>> +        /* This is user error so deserves a friendlier error message
>> +         * than the failure of setprop_sized_cells would provide
>> +         */
>> +        fprintf(stderr, "qemu: dtb file not compatible with "
>> +                "RAM size > 4GB\n");
>> +        goto fail;
>> +    }
>> +
>> +    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
>> +                                         machine->ram_size);
>> +    memory_region_add_subregion(system_memory, vbi->memmap[VIRT_MEM].base, ram);
>> +
>> +    hwaddr mem_base = vbi->memmap[VIRT_MEM].base;
>> +
>> +    if (!nb_numa_nodes) {
>> +        qemu_fdt_add_subnode(vbi->fdt, "/memory");
>> +        qemu_fdt_setprop_string(vbi->fdt, "/memory", "device_type", "memory");
>> +        qemu_fdt_setprop_sized_cells(vbi->fdt, "/memory", "reg",
>> +                                      acells, mem_base,
>> +                                      scells, machine->ram_size);
>> +        return 0;
>> +    }
>> +
>> +    qemu_fdt_add_subnode(vbi->fdt, "/numa-map");
>> +    qemu_fdt_setprop_cell(vbi->fdt, "/numa-map", "#address-cells", 0x2);
>> +    qemu_fdt_setprop_cell(vbi->fdt, "/numa-map", "#size-cells", 0x1);
>> +    qemu_fdt_setprop_cell(vbi->fdt, "/numa-map", "#node-count", 0x2);
>> +
>> +    uint64_t *mem_map = g_malloc0(nb_numa_nodes * sizeof(uint64_t) * 6);
>> +    uint64_t *cpu_map = g_malloc0(nb_numa_nodes * sizeof(uint64_t) * 6);
>> +    uint64_t *node_matrix = g_malloc0(nb_numa_nodes * nb_numa_nodes
>> +                                      * sizeof(uint64_t) * 6);
> 
> g_new0() is usually better than g_malloc0(count * sizeof(thing));
> 

Ok

>> +
>> +    for (i = 0; i < nb_numa_nodes; i++) {
>> +        uint64_t buffer[6] = {1, 0x00000000, 1, mem_base, 1, i};
>> +        char *nodename;
>> +        nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
>> +        qemu_fdt_add_subnode(vbi->fdt, nodename);
>> +        qemu_fdt_setprop_string(vbi->fdt, nodename, "device_type", "memory");
>> +        qemu_fdt_setprop_sized_cells(vbi->fdt, nodename, "reg",
>> +                                      acells, mem_base,
>> +                                      scells, numa_info[i].node_mem-1);
>> +        memcpy(mem_map + 6 * i, buffer, 6 * sizeof(*buffer));
> 
> Why do we create a local buffer array and then immediately do nothing
> with it but memcpy() it somewhere else? I suspect this code would
> be clearer if you defined a type (possibly a struct) where you're
> currently using raw uint64_t array[6]. Then you could make your
> mem_map, cpu_map and node_matrix variables have more sensible types
> than raw uint64_t*, and you could just set the right element in them
> using C array syntax rather than these memcpy calls.
> 

OK, thanks for your suggestion.

>> +        mem_base += numa_info[i].node_mem;
>> +        g_free(nodename);
>> +    }
>> +    qemu_fdt_setprop_sized_cells_from_array(vbi->fdt, "/numa-map", "mem-map",
>> +                        (nb_numa_nodes * 6) / 2, mem_map);
> 
> Lots of unnecessary hardcoded 6s here (and above and below).
> 

Will replace them.

>> +
>> +    for (i = 0; i < nb_numa_nodes; i++) {
>> +        CPU_FOREACH(cpu) {
>> +            if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
>> +                if (cpu->cpu_index < min_cpu) {
>> +                    min_cpu = cpu->cpu_index;
>> +                }
>> +                if (cpu->cpu_index > max_cpu) {
>> +                    max_cpu = cpu->cpu_index;
>> +                }
>> +            }
>> +        }
>> +
>> +        uint64_t buffer[6] = {1, min_cpu, 1, max_cpu, 1, i};
>> +        memcpy(cpu_map + 6 * i, buffer, 6 * sizeof(*buffer));
>> +        min_cpu = max_cpu + 1;
>> +    }
>> +
>> +    qemu_fdt_setprop_sized_cells_from_array(vbi->fdt, "/numa-map", "cpu-map",
>> +                        (nb_numa_nodes * 6) / 2, cpu_map);
>> +    count = 0;
>> +    for (i = 0; i < nb_numa_nodes; i++) {
>> +        for (j = 0; j < nb_numa_nodes; j++) {
>> +            len = 20;
>> +            if (i == j) {
>> +                len = 10;
>> +            }
>> +            uint64_t buffer[6] = {1, i, 1, j, 1, len};
>> +            memcpy(node_matrix + 6 * count, buffer, 6 * sizeof(*buffer));
>> +            count++;
>> +        }
>> +    }
>> +    qemu_fdt_setprop_sized_cells_from_array(vbi->fdt, "/numa-map",
>> +        "node-matrix", (nb_numa_nodes * nb_numa_nodes * 6) / 2, node_matrix);
>> +
>> +    g_free(mem_map);
>> +    g_free(cpu_map);
>> +    g_free(node_matrix);
>> +
>> +    return 0;
>> +fail:
>> +    return -1;
>> +}
>> +
>>  static void fdt_add_timer_nodes(const VirtBoardInfo *vbi)
>>  {
>>      /* Note that on A15 h/w these interrupts are level-triggered,
>> @@ -532,7 +640,6 @@ static void machvirt_init(MachineState *machine)
>>      qemu_irq pic[NUM_IRQS];
>>      MemoryRegion *sysmem = get_system_memory();
>>      int n;
>> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>      const char *cpu_model = machine->cpu_model;
>>      VirtBoardInfo *vbi;
>>
>> @@ -585,10 +692,9 @@ static void machvirt_init(MachineState *machine)
>>      fdt_add_cpu_nodes(vbi);
>>      fdt_add_psci_node(vbi);
>>
>> -    memory_region_init_ram(ram, NULL, "mach-virt.ram", machine->ram_size,
>> -                           &error_abort);
>> -    vmstate_register_ram_global(ram);
>> -    memory_region_add_subregion(sysmem, vbi->memmap[VIRT_MEM].base, ram);
>> +    if (virt_memory_init(machine, sysmem, vbi) < 0) {
>> +        exit(1);
>> +    }
>>
>>      create_flash(vbi);
>>
>> --
>> 1.7.1
> 
> thanks
> -- PMM
> 
> .
> 

Thanks for your comments. Anyone else has more comments about this?

Thanks,
Shannon
