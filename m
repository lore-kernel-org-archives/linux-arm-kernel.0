From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 31 Mar 2013 19:27:22 -0700 (PDT)
Subject: [PATCH 3/3 v2] ARM: shmobile: bockw: add SMSC ethernet support
In-Reply-To: <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87bo9z56k8.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SMSC ethernet support on Bock-W

Bock-W SMSC needs FPGA settings which enables interrupt.
This patch does it on bockw_init() function.
As notes for future, this FPGA settings should be updated,
since this FPGA is using cascaded interrupt.
Current code is assuming that this FPGA interrupt user is only SMSC.
Becouse of these background, this patch doesn't
have DT settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - not based on PLATFORM_INFO()

 arch/arm/boot/dts/r8a7778-bockw.dts  |    2 +-
 arch/arm/configs/bockw_defconfig     |   34 +++++++++++++++++++++++++++---
 arch/arm/mach-shmobile/Kconfig       |    1 +
 arch/arm/mach-shmobile/board-bockw.c |   38 ++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 735c964..0076b1e 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -22,7 +22,7 @@
 	compatible = "renesas,bockw", "renesas,r8a7778";
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel";
+		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
 	};
 
 	memory {
diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 6037705..6524cdf 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -27,16 +27,40 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-CONFIG_CMDLINE="console=ttySC0,115200 ignore_loglevel"
+CONFIG_CMDLINE="console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp"
 CONFIG_CMDLINE_FORCE=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_SMSC911X=y
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
@@ -55,12 +79,16 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_INOTIFY_USER is not set
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_SWAP=y
+CONFIG_NFS_V4_1=y
+CONFIG_ROOT_NFS=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
-CONFIG_KEYS=y
-CONFIG_CRYPTO=y
 CONFIG_AVERAGE=y
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9125e14..b2219bd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -119,6 +119,7 @@ config MACH_BOCKW
 	bool "BOCK-W platform"
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
+	select RENESAS_INTC_IRQPIN
 	select USE_OF
 
 config MACH_MARZEN
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 56ab56e..38e5e50 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -19,14 +19,52 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/smsc911x.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 
+static struct smsc911x_platform_config smsc911x_data = {
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags		= SMSC911X_USE_32BIT,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+};
+
+static struct resource smsc911x_resources[] = {
+	DEFINE_RES_MEM(0x18300000, 0x1000),
+	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
+};
+
+#define IRQ0MR	0x30
 static void __init bockw_init(void)
 {
+	void __iomem *fpga;
+
 	r8a7778_clock_init();
+	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
+
+	fpga = ioremap_nocache(0x18200000, SZ_1M);
+	if (fpga) {
+		/*
+		 * CAUTION
+		 *
+		 * IRQ0/1 is cascaded interrupt from FPGA.
+		 * it should be cared in the future
+		 * Now, it is assuming IRQ0 was used only from SMSC.
+		 */
+		u16 val = ioread16(fpga + IRQ0MR);
+		val &= ~(1 << 4); /* enable SMSC911x */
+		iowrite16(val, fpga + IRQ0MR);
+		iounmap(fpga);
+
+		platform_device_register_resndata(
+			&platform_bus, "smsc911x", -1,
+			smsc911x_resources, ARRAY_SIZE(smsc911x_resources),
+			&smsc911x_data, sizeof(smsc911x_data));
+	}
 }
 
 static const char *bockw_boards_compat_dt[] __initdata = {
-- 
1.7.9.5
