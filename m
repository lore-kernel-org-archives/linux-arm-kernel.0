From: simon@sequanux.org (Simon Guinot)
Date: Tue,  6 Jul 2010 16:08:45 +0200
Subject: [PATCH v2 1/3] [ARM] Kirkwood: add LaCie Network Space Max v2 support
In-Reply-To: <alpine.LFD.2.00.1007051444030.6020@xanadu.home>
References: <alpine.LFD.2.00.1007051444030.6020@xanadu.home>
Message-ID: <1278425327-16762-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/mach-kirkwood/Kconfig             |    6 +++++
 arch/arm/mach-kirkwood/Makefile            |    1 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   29 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index f638ec1..cc25501 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -94,6 +94,12 @@ config MACH_INETSPACE_V2
 	  Say 'Y' here if you want your kernel to support the
 	  LaCie Internet Space v2 NAS.
 
+config MACH_NETSPACE_MAX_V2
+	bool "LaCie Network Space Max v2 NAS Board"
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  LaCie Network Space Max v2 NAS.
+
 config MACH_NET2BIG_V2
 	bool "LaCie 2Big Network v2 NAS Board"
 	help
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index b7c5d5e..295d7ba 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
 obj-$(CONFIG_MACH_NETSPACE_V2)		+= netspace_v2-setup.o
 obj-$(CONFIG_MACH_INETSPACE_V2)		+= netspace_v2-setup.o
+obj-$(CONFIG_MACH_NETSPACE_MAX_V2)	+= netspace_v2-setup.o
 obj-$(CONFIG_MACH_NET2BIG_V2)		+= netxbig_v2-setup.o
 obj-$(CONFIG_MACH_NET5BIG_V2)		+= netxbig_v2-setup.o
 obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index b96e43b..9f20c8d 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -126,6 +126,18 @@ static void __init netspace_v2_sata_power_init(void)
 	}
 	if (err)
 		pr_err("netspace_v2: failed to setup SATA0 power\n");
+
+	if (machine_is_netspace_max_v2()) {
+		err = gpio_request(NETSPACE_V2_GPIO_SATA1_POWER, "SATA1 power");
+		if (err == 0) {
+			err = gpio_direction_output(
+					NETSPACE_V2_GPIO_SATA1_POWER, 1);
+			if (err)
+				gpio_free(NETSPACE_V2_GPIO_SATA1_POWER);
+		}
+		if (err)
+			pr_err("netspace_v2: failed to setup SATA1 power\n");
+	}
 }
 
 /*****************************************************************************
@@ -249,6 +261,7 @@ static unsigned int netspace_v2_mpp_config[] __initdata = {
 	MPP4_NF_IO6,
 	MPP5_NF_IO7,
 	MPP6_SYSRST_OUTn,
+	MPP7_GPO,		/* Fan speed (bit 1) */
 	MPP8_TW0_SDA,
 	MPP9_TW0_SCK,
 	MPP10_UART0_TXD,
@@ -256,10 +269,13 @@ static unsigned int netspace_v2_mpp_config[] __initdata = {
 	MPP12_GPO,		/* Red led */
 	MPP14_GPIO,		/* USB fuse */
 	MPP16_GPIO,		/* SATA 0 power */
+	MPP17_GPIO,		/* SATA 1 power */
 	MPP18_NF_IO0,
 	MPP19_NF_IO1,
 	MPP20_SATA1_ACTn,
 	MPP21_SATA0_ACTn,
+	MPP22_GPIO,		/* Fan speed (bit 0) */
+	MPP23_GPIO,		/* Fan power */
 	MPP24_GPIO,		/* USB mode select */
 	MPP25_GPIO,		/* Fan rotation fail */
 	MPP26_GPIO,		/* USB device vbus */
@@ -268,6 +284,7 @@ static unsigned int netspace_v2_mpp_config[] __initdata = {
 	MPP30_GPIO,		/* Blue led (command register) */
 	MPP31_GPIO,		/* Board power off */
 	MPP32_GPIO, 		/* Power button (0 = Released, 1 = Pushed) */
+	MPP33_GPO,		/* Fan speed (bit 2) */
 	0
 };
 
@@ -332,3 +349,15 @@ MACHINE_START(INETSPACE_V2, "LaCie Internet Space v2")
 	.timer		= &netspace_v2_timer,
 MACHINE_END
 #endif
+
+#ifdef CONFIG_MACH_NETSPACE_MAX_V2
+MACHINE_START(NETSPACE_MAX_V2, "LaCie Network Space Max v2")
+	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
+	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.init_machine	= netspace_v2_init,
+	.map_io		= kirkwood_map_io,
+	.init_irq	= kirkwood_init_irq,
+	.timer		= &netspace_v2_timer,
+MACHINE_END
+#endif
-- 
1.6.3.1
