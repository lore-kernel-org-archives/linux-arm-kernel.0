From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 May 2012 13:21:01 +0200
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <20120518010138.GA5427@S2101-09.ap.freescale.net>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
Message-ID: <201205181321.01434.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Thu, May 17, 2012 at 04:03:43PM -0700, Subodh Nijsure wrote:
> > Should one be able to run top of the linux-next on MX28 EVK hardware
> > with DT support enabled?
> 
> Yes, I'm running it well with next-20120516.
> 
> > I have attached boot log I see when I try to do that.
> 
> One thing from the boot log worth checking is
> 
>   [    0.820000] stmp_reset_block(f5010000): module reset timeout
> 
> My wild guess is stmp_reset_block call on mmc0 failed on your end.
> 
> > Further if one enables, CONFIG_MTD_NAND_GPMI_NAND=y
> > CONFIG_MTD_NAND_PLATFORM=y code in
> > drivers/mtd/nand/gpmi-nand/gpmi-nand.c doesn't compile because of
> > 
> > this code:
> >         pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> >         if (IS_ERR(pinctrl)) {
> >         
> >                 ret = PTR_ERR(pinctrl);
> >                 goto exit_pin;
> >         
> >         }
> 
> Thanks for reporting it.  It's my bad.  I thought I had mxs_defconfig
> build testing cover the change.  Actually, the gpmi is not enabled in
> mxs_defconfig yet.  I will send the following fix to Arnd and Olof soon.
> 
> @@ -486,7 +486,7 @@ static int __devinit acquire_resources(struct
> gpmi_nand_data *this) if (ret)
>                 goto exit_dma_channels;
> 
> -       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +       pinctrl = devm_pinctrl_get_select_default(&this->pdev->dev);
>         if (IS_ERR(pinctrl)) {
>                 ret = PTR_ERR(pinctrl);
>                 goto exit_pin;

Rebase your uboot on top of git://git.denx.de/u-boot-arm.git -master . u-boot-
imx is missing a patch and won't be updated for next 3 weeks (maintainer is on 
vacation). u-boot-arm has a bugfix for this issue


Best regards,
Marek Vasut
