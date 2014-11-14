From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 14 Nov 2014 11:52:05 +0100
Subject: [PATCH v4 4/6] ARM: zynq: Extend SLCR driver to read OCM configuration
In-Reply-To: <cover.1415962281.git.michal.simek@xilinx.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
Message-ID: <1b945376f9979a3b3e7c1231ea7ecead78026b07.1415962281.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get OCM configuration from SLCR.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v4:
- slcr.h has moved to soc/include/ folder. Move definition there too.

Changes in v3: None
Changes in v2: None

 arch/arm/mach-zynq/slcr.c | 15 +++++++++++++++
 include/soc/zynq/slcr.h   |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index b77e42d999c8..f7c606e57525 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -29,6 +29,7 @@
 #define SLCR_A9_CPU_RST_CTRL_OFFSET	0x244 /* CPU Software Reset Control */
 #define SLCR_REBOOT_STATUS_OFFSET	0x258 /* PS Reboot Status */
 #define SLCR_PSS_IDCODE			0x530 /* PS IDCODE */
+#define SLCR_OCM_CFG_OFFSET		0x910 /* OCM Address Mapping */

 #define SLCR_UNLOCK_MAGIC		0xDF0D
 #define SLCR_A9_CPU_CLKSTOP		0x10
@@ -128,6 +129,20 @@ void zynq_slcr_system_reset(void)
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
diff --git a/include/soc/zynq/slcr.h b/include/soc/zynq/slcr.h
index 7b4edab666ee..639723c4f90c 100644
--- a/include/soc/zynq/slcr.h
+++ b/include/soc/zynq/slcr.h
@@ -25,5 +25,6 @@ extern void zynq_slcr_cpu_start(int cpu);
 extern bool zynq_slcr_cpu_state_read(int cpu);
 extern void zynq_slcr_cpu_state_write(int cpu, bool die);
 extern u32 zynq_slcr_get_device_id(void);
+extern u32 zynq_slcr_get_ocm_config(void);

 #endif
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/93b85101/attachment.sig>
