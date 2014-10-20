From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 20 Oct 2014 15:25:33 +0200
Subject: [PATCH v2 3/3] ARM: zynq: Extend SLCR driver to read OCM configuration
In-Reply-To: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
References: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
Message-ID: <5d26a2b4b91eb33e42491b65f893c97c6ffd6ee5.1413811526.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get OCM configuration from SLCR.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm/mach-zynq/slcr.c | 15 +++++++++++++++
 include/soc/zynq/common.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 22d9d54d2333..3f65e2027875 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -27,6 +27,7 @@
 #define SLCR_A9_CPU_RST_CTRL_OFFSET	0x244 /* CPU Software Reset Control */
 #define SLCR_REBOOT_STATUS_OFFSET	0x258 /* PS Reboot Status */
 #define SLCR_PSS_IDCODE			0x530 /* PS IDCODE */
+#define SLCR_OCM_CFG_OFFSET		0x910 /* OCM Address Mapping */

 #define SLCR_UNLOCK_MAGIC		0xDF0D
 #define SLCR_A9_CPU_CLKSTOP		0x10
@@ -126,6 +127,20 @@ void zynq_slcr_system_reset(void)
 }

 /**
+ * zynq_slcr_get_ocm_config - Get SLCR OCM config
+ *
+ * Return:	OCM config bits
+ */
+u32 zynq_slcr_get_ocm_config(void)
+{
+	u32 val;
+
+	zynq_slcr_read(&val, SLCR_OCM_CFG_OFFSET);
+
+	return val;
+}
+
+/**
  * zynq_slcr_cpu_start - Start cpu
  * @cpu:	cpu number
  */
diff --git a/include/soc/zynq/common.h b/include/soc/zynq/common.h
index 2bc71273c73c..3d0b9a6d76ab 100644
--- a/include/soc/zynq/common.h
+++ b/include/soc/zynq/common.h
@@ -27,6 +27,7 @@ extern void zynq_slcr_cpu_start(int cpu);
 extern bool zynq_slcr_cpu_state_read(int cpu);
 extern void zynq_slcr_cpu_state_write(int cpu, bool die);
 extern u32 zynq_slcr_get_device_id(void);
+extern u32 zynq_slcr_get_ocm_config(void);

 #ifdef CONFIG_SMP
 extern void secondary_startup(void);
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141020/649e2708/attachment.sig>
