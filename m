From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 30 Nov 2011 03:24:32 +0000
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <20111129192114.GI27267@pengutronix.de>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
 <20180.36084.962507.946237@ipc1.ka-ro>
 <35AB98346D25394A9354ED89C4D76587226AE3@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111129082139.GG27267@pengutronix.de>
 <35AB98346D25394A9354ED89C4D76587226BD8@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111129192114.GI27267@pengutronix.de>
Message-ID: <35AB98346D25394A9354ED89C4D7658722716D@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
 
> 
> We have to deal with a historically grown wrong hardware abstraction
> here. What we have from a hardware point of view is a device consisting
> of:
> 
> - A ehci core (theoretically optional, but seems to be always present)
> - A Synopsys USB device core (optional), the one we currently have four
>   different drivers for.
> - A USB phy (mandatory, but may be nearly invisible from software). The
>   phy may be an external ULPI phy, an internal phy in the SoC, or even
>   selectable between both.
> 
> Currently we have a ehci-mxc driver which claims resources like mem
> regions, interrupts and clocks. We also have the gadget driver
> (currently the fsl_mxc_udc driver) which also claims the same resources.
> Instead we should have a glue driver which claims the resources and
> passes control over to either the host or the gadget driver. This glue
> code should also connect the phy.
> 
> Looking at the code in mainline the msm driver is closest to what we
> want to have. It claims the resources in msm_otg.c and passes control
> over to the ehci or ci13xxx gadget driver depending on the USB id pin or
> a platform decision. What's missing here is some plugin mechanism for
> different phys. That's another historically grown thing that there is
> only a single phy in the Kernel because there can be only one otg
> instance and phys were thought to be present only in otg cores. Heikkis
> patches work in the right direction here.

msm_otg.c is really good code which mainlined this year, it considers
many user situations, like low power, charger, usb wakeup, id/vbus changes
from different hardware/user choice, etc.

In fact, the most difficulties for otg driver (host/device share the same registers controller)
are clock management, power management, usb wakeup, register access among the three
drivers (otg, host and device driver)
> 
> As a conclusion I think that there should be no platform or SoC specific
> code in neither the ehci nor in the gadget driver. Also there shouldn't
> be all these ehci-$SoC.c files in the tree. The way to get there could
> be:
> 
> - Work on Heikkis patches so that we can register usb phys
> - move the USB phy setup code from arch-imx to drivers/usb/phy
> - factor out the common code from the msm_otg driver.
> - create a imx-otg.c which only claims the resources and passes
>   them to the otg common code. Sooner or later not even an imx-otg.c is
>   necessary because we can use a devicetree based driver and then only
>   the phy code will be SoC specific.

I agree with these tasks for refine i.mx usb structure. 
I will try Heikki's patch first.

> 
> I'm sorry that there is no easy way to get proper USB support, but we
> are way beyond the point where the current infrastructure scales.
> In any way, there is no place for more SoC specific code in ehci-mxc.c.
> Instead you should work on moving SoC code out of there.
> 
> Sascha
> 
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
