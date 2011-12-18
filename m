From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 19 Dec 2011 10:55:48 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20111219105548.d30839e148800b38bc93d001@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-imx/mach-imx6q.c between commit 1237f0f6ecf6 ("ARM: 7198/1:
arm/imx6: add restart support for imx6q") from the arm tree and commit
477fce49aef4 ("arm/imx6q-sabrelite: add enet phy ksz9021rn fixup") from
the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/mach-imx6q.c
index 05b49bb,bee6334..0000000
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@@ -16,9 -14,10 +16,11 @@@
  #include <linux/irq.h>
  #include <linux/irqdomain.h>
  #include <linux/of.h>
 +#include <linux/of_address.h>
  #include <linux/of_irq.h>
  #include <linux/of_platform.h>
+ #include <linux/phy.h>
+ #include <linux/micrel_phy.h>
  #include <asm/hardware/cache-l2x0.h>
  #include <asm/hardware/gic.h>
  #include <asm/mach/arch.h>
@@@ -26,38 -25,27 +28,57 @@@
  #include <mach/common.h>
  #include <mach/hardware.h>
  
 +void imx6q_restart(char mode, const char *cmd)
 +{
 +	struct device_node *np;
 +	void __iomem *wdog_base;
 +
 +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
 +	wdog_base = of_iomap(np, 0);
 +	if (!wdog_base)
 +		goto soft;
 +
 +	imx_src_prepare_restart();
 +
 +	/* enable wdog */
 +	writew_relaxed(1 << 2, wdog_base);
 +	/* write twice to ensure the request will not get ignored */
 +	writew_relaxed(1 << 2, wdog_base);
 +
 +	/* wait for reset to assert ... */
 +	mdelay(500);
 +
 +	pr_err("Watchdog reset failed to assert reset\n");
 +
 +	/* delay to allow the serial port to show the message */
 +	mdelay(50);
 +
 +soft:
 +	/* we'll take a jump through zero as a poor second */
 +	soft_restart(0);
 +}
 +
+ /* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */
+ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
+ {
+ 	/* min rx data delay */
+ 	phy_write(phydev, 0x0b, 0x8105);
+ 	phy_write(phydev, 0x0c, 0x0000);
+ 
+ 	/* max rx/tx clock delay, min rx/tx control delay */
+ 	phy_write(phydev, 0x0b, 0x8104);
+ 	phy_write(phydev, 0x0c, 0xf0f0);
+ 	phy_write(phydev, 0x0b, 0x104);
+ 
+ 	return 0;
+ }
+ 
  static void __init imx6q_init_machine(void)
  {
+ 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
+ 		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
+ 					   ksz9021rn_phy_fixup);
+ 
  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
  
  	imx6q_pm_init();
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111219/6871fb42/attachment.sig>
