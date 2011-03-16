From: R65037@freescale.com (Zhu Richard-R65037)
Date: Wed, 16 Mar 2011 09:56:12 +0000
Subject: [RFC PATCH 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
In-Reply-To: <20110315093256.GN29521@pengutronix.de>
References: <1300096544-1946-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1300096544-1946-2-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110315093256.GN29521@pengutronix.de>
Message-ID: <010C9052C42A00499CE76D637FA5EE900CB026@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha:

Best Regards
Richard Zhu


> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Tuesday, March 15, 2011 5:33 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com;
> kernel at pengutronix.de; linux-ide at vger.kernel.org;
> avorontsov at ru.mvista.com; eric at eukrea.com; eric.miao at linaro.org
> Subject: Re: [RFC PATCH 2/2] MX53 Enable the AHCI SATA on MX53 LOCO
>
> On Mon, Mar 14, 2011 at 05:55:44PM +0800, Richard Zhu wrote:
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  arch/arm/mach-mx5/board-mx53_loco.c |  120
> > +++++++++++++++++++++++++++++++++++
> >  1 files changed, 120 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c
> > b/arch/arm/mach-mx5/board-mx53_loco.c
> > index 0a18f8d..9a7bbea 100644
> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> > @@ -23,11 +23,13 @@
> >  #include <linux/fec.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio.h>
> > +#include <linux/ahci_platform.h>
> >
> >  #include <mach/common.h>
> >  #include <mach/hardware.h>
> >  #include <mach/imx-uart.h>
> >  #include <mach/iomux-mx53.h>
> > +#include <mach/ahci_sata.h>
> >
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > @@ -203,6 +205,123 @@ static const struct imxi2c_platform_data
> mx53_loco_i2c_data __initconst = {
> >     .bitrate = 100000,
> >  };
> >
> > +/* HW Initialization, if return 0, initialization is successful. */
> > +static int sata_init(struct device *dev, void __iomem *addr)
>
> Isn't this addr pointer exactly the address you remap again below?
Yes, it is.
Would re-use this parameter later.

>
> > +{
> > +   void __iomem *mmio;
> > +   struct clk *clk;
> > +   int ret = 0;
> > +   u32 tmpdata;
> > +
> > +   clk = clk_get(dev, "imx_sata_clk");
>
> This one is associated with the device, so passing in dev here is ok,
> but...
>
> > +   ret = IS_ERR(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI can't get clock.\n");
> > +           return ret;
> > +   }
> > +   ret = clk_enable(clk);
> > +   if (ret) {
> > +           printk(KERN_ERR "IMX AHCI can't enable clock.\n");
> > +           clk_put(clk);
> > +           return ret;
> > +   }
> > +
> > +   /* FSL IMX AHCI SATA uses the internal usb phy1 clk on loco */
> > +   clk = clk_get(dev, "usb_phy1");
>
> ... this clock is not associated with the device, it just happens to be
> used for this purpose on LOCO. Or is this this really not LOCO specific
> but i.MX53 specific? If this is LOCO specific you should pass NULL as the
> device pointer. If this is i.MX53 specific we should discuss about adding
> a imx53_init_sata as then all of this function is not LOCO specific.
>
This is related to the HW design.
On MX53 SOC, the AHCI bus clk can be sourced from internal USB_PHY1 clk, or one external
crystal oscillator.
I would create external two functions later, one used for internal clk initialization, and
the other would be used when external crystal oscillator is used.
 and move these codes into the internal clk initialization function.
How do you think about it?

>
> Have these patches undergone some Linaro internal review? These are
> really not ready for the wider world.
>
> Sascha
>
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
