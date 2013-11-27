From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Nov 2013 08:31:52 +0100
Subject: [PATCH] pinctrl: imx1-core populate subdevices
In-Reply-To: <529567FB.5090501@gtsys.com.hk>
References: <CACRpkda2dO6DvurEhaTVGJv8nDyEGOEeLCap-_+1e1mHtD0XyQ@mail.gmail.com>
 <1384193987-20740-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdaQcY43wnfD_phsi6rCo3oUmOUcei+gb9phyGT7F1iZyA@mail.gmail.com>
 <529567FB.5090501@gtsys.com.hk>
Message-ID: <20131127073152.GA28465@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 27, 2013 at 11:33:15AM +0800, Chris Ruehl wrote:
> On Wednesday, November 20, 2013 04:01 AM, Linus Walleij wrote:
> >On Mon, Nov 11, 2013 at 7:19 PM, Markus Pargmann<mpa@pengutronix.de>  wrote:
> >
> >>Support gpio devicetree subnodes to allow a more detailed DT hardware
> >>description.
> >>
> >>Signed-off-by: Markus Pargmann<mpa@pengutronix.de>
> >
> >Looks good to me.
> >
> >Tentatively applied this, the DT people may want to say something
> >about this.
> >
> >Yours,
> >Linus Walleij
> >--
> 
> Hi,
> 
> I tried the new configuration but the kernel oops when probing the
> dm9000 caused by insufficient resources more likely the real reason
> that somehow the gpio6: triggers a problem
> 
> 
> [    0.115718] irq: no irq domain found for
> /soc/aipi at 10000000/iomuxc at 10015000/gpio at 10015500 !
> [    0.115768] ------------[ cut here ]------------
> [    0.115853] WARNING: CPU: 0 PID: 1 at drivers/of/platform.c:171
> of_device_alloc+0x110/0x15c()
> [    0.117824] ---[ end trace 0e10ae727e6e0ab1 ]---
> [    0.121236] Failed to request board ext/int gpios
> [    0.152712] imx27-pinctrl 10015000.iomuxc: initialized IMX pinctrl driver

The imx27-pinctrl driver seems to be initialized after the irq is
requested. So this issue should be the same as in [1].

Regards,

Markus

[1] [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
http://archive.arm.linux.org.uk/lurker/message/20131123.004335.61d5c21b.en.html

> 
> 
> iomuxc: iomuxc at 10015000 {
>         compatible = "fsl,imx27-iomuxc";
>         reg = <0x10015000 0x600>;
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges;
> 
>         gpio1: gpio at 10015000 {
>              compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
>              reg = <0x10015000 0x100>;
>              interrupts = <8>;
>              gpio-controller;
>              #gpio-cells = <2>;
>              interrupt-controller;
>              #interrupt-cells = <2>;
>         };
> ...
>         gpio6: gpio at 10015500 {
>              compatible = "fsl,imx27-gpio", "fsl,imx21-gpio";
>              reg = <0x10015500 0x100>;
>              interrupts = <8>;
>              gpio-controller;
>              #gpio-cells = <2>;
>              interrupt-controller;
>              #interrupt-cells = <2>;
>         };
> };
> 
> Kernel Linux version 3.13.0-rc1-next-20131125-dirty
> 
> With kind regards
> Chris
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
