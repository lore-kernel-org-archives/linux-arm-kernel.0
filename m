From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 May 2012 15:50:26 +0300
Subject: Regression for non-eMMC cards with commit fa550189?
In-Reply-To: <20120529124732.GD12766@atomide.com>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
 <20120529074047.GE16340@arwen.pp.htv.fi>
 <20120529124732.GD12766@atomide.com>
Message-ID: <20120529125024.GM9577@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 29, 2012 at 05:47:32AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120529 00:46]:
> > 
> > Can you enable debugging on menelaus so we see what the driver is doing ?
> > 
> > I believe that to change the VMMC's supply voltage you need to turn off
> > the regulator, meaning LDO_CTRL7[1:0] = 0b00.
> 
> Looks like it's some kind of race between the slots that now gets triggered
> in the omap driver.
> 
> Commenting out the second slot in the board file fixes things. I tried adding
> a mutex to protect the sequence between POWER_UP and POWER_ON, but no luck yet.
> 
> Also adding printk statements here and there makes it work again.

does this help ?

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 518091c..5a224fc 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -397,8 +397,8 @@ static int n8x0_mmc_late_init(struct device *dev)
 	if (r < 0)
 		return r;
 
-	n8x0_mmc_set_power(dev, 0, MMC_POWER_ON, 16); /* MMC_VDD_28_29 */
-	n8x0_mmc_set_power(dev, 1, MMC_POWER_ON, 16);
+//	n8x0_mmc_set_power(dev, 0, MMC_POWER_ON, 16); /* MMC_VDD_28_29 */
+//	n8x0_mmc_set_power(dev, 1, MMC_POWER_ON, 16);
 
 	r = menelaus_set_mmc_slot(1, 1, 0, 1);
 	if (r < 0)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120529/3cde1dc1/attachment.sig>
