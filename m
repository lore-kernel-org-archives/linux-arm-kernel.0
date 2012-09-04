From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 03 Sep 2012 21:50:03 -0700 (PDT)
Subject: [PATCH] ARM: shmobile: r8a7779: remove USB phy initializer
In-Reply-To: <20120904003402.GE6095@verge.net.au>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
 <1346376502-12114-6-git-send-email-horms@verge.net.au>
 <201209032138.41485.arnd@arndb.de>
 <87k3wafxj4.wl%kuninori.morimoto.gx@renesas.com>
 <20120904003402.GE6095@verge.net.au>
Message-ID: <87ehmifl3b.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

f9929ab55cf967791c65a3b58696d77e26d19a6f
(ARM: shmobile: r8a7779: add USB common phy initializer)
added r8a7779 USB phy initializer,
but ARM kernel is trying hard to move driver code out of the platform
and into driver directories.
This patch remove USB phy initializer code from platform.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Simon

This patch remove current USB phy initializer code from platform.
And I sent USB phy driver support patch to USB ML today.
If this driver was accepted, then, I will send a patch to use it.

 arch/arm/mach-shmobile/board-marzen.c        |    5 +-
 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c       |   92 --------------------------
 3 files changed, 2 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 30c794b..ae859d2 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -307,9 +307,8 @@ static void __init marzen_init(void)
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 
-	if (0 == r8a7779_usb_phy_init(0))
-		platform_add_devices(marzen_usb_devices,
-				     ARRAY_SIZE(marzen_usb_devices));
+	platform_add_devices(marzen_usb_devices,
+			     ARRAY_SIZE(marzen_usb_devices));
 }
 
 MACHINE_START(MARZEN, "marzen")
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 00b2eb5..45e61da 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -78,7 +78,6 @@ extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 extern void r8a7740_meram_workaround(void);
-extern int r8a7779_usb_phy_init(u32 usbpctrl0);
 
 extern unsigned int r8a7779_get_core_count(void);
 extern int r8a7779_platform_cpu_kill(unsigned int cpu);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 17fdd1f..af84cb4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -244,98 +244,6 @@ static struct platform_device *r8a7779_early_devices[] __initdata = {
 static struct platform_device *r8a7779_late_devices[] __initdata = {
 };
 
-/* USBH common register */
-#define USBPCTRL0	0x0800
-#define USBPCTRL1	0x0804
-#define USBST		0x0808
-#define USBEH0		0x080C
-#define USBOH0		0x081C
-#define USBCTL0		0x0858
-#define EIIBC1		0x0094
-#define EIIBC2		0x009C
-
-#ifdef CONFIG_ARCH_SUPPORTS_BIG_ENDIAN
-# define xHCI_ENDIAN "BIG"
-# define xHCI_NO_SWAP 0x00000003
-#else
-# define xHCI_ENDIAN "LITTLE"
-# define xHCI_NO_SWAP 0x00000000
-#endif
-
-/*
- * USB initial/install operation.
- *
- * This function setup USB phy.
- * The used value and setting order came from
- * [USB :: Initial setting] on datasheet.
- */
-int __init r8a7779_usb_phy_init(u32 usbpctrl0)
-{
-	void __iomem *reg0, *reg1;
-	int i;
-	u32 val;
-
-	reg0 = ioremap_nocache(0xffe70000, 0x900);
-	reg1 = ioremap_nocache(0xfff70000, 0x900);
-
-	/*----------------------------------------*
-	 * USB phy start-up
-	 *----------------------------------------*/
-
-	/* (1) USB-PHY standby release */
-	iowrite32(0x00000001, (reg0 + USBPCTRL1));
-
-	/* (2) start USB-PHY internal PLL */
-	iowrite32(0x00000003, (reg0 + USBPCTRL1));
-
-	/* (3) USB module status check */
-	for (i = 0; i < 1024; i++) {
-		udelay(10);
-		val = ioread32(reg0 + USBST);
-		if (0xc0000000 == val)
-			goto usb_module_is_working;
-	}
-	pr_err("USB module not ready\n");
-	return -EIO;
-
-usb_module_is_working:
-	/* (4) USB-PHY reset clear */
-	iowrite32(0x00000007, (reg0 + USBPCTRL1));
-
-	/* set platform specific port settings */
-	iowrite32(usbpctrl0, (reg0 + USBPCTRL0));
-
-	/*----------------------------------------*
-	 * EHCI IP Internal Buffer Setting
-	 *----------------------------------------*/
-
-	/* (1) EHCI IP internal buffer setting */
-	iowrite32(0x00ff0040, (reg0 + EIIBC1));
-	iowrite32(0x00ff0040, (reg1 + EIIBC1));
-
-	/* (2) EHCI IP internal buffer enable */
-	iowrite32(0x00000001, (reg0 + EIIBC2));
-	iowrite32(0x00000001, (reg1 + EIIBC2));
-
-	/*----------------------------------------*
-	 * Bus alignment settings
-	 *----------------------------------------*/
-
-	/* (1) EHCI bus alignment */
-	iowrite32(xHCI_NO_SWAP, (reg0 + USBEH0));
-
-	/* (1) OHCI bus alignment */
-	iowrite32(xHCI_NO_SWAP, (reg0 + USBOH0));
-
-	pr_info("USB xHCI alignment was initialized as %s endian no swap\n",
-		xHCI_ENDIAN);
-
-	iounmap(reg0);
-	iounmap(reg1);
-
-	return 0;
-}
-
 void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
-- 
1.7.9.5
