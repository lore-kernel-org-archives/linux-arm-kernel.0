From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 22 Feb 2016 16:35:17 +0100
Subject: [PATCH v1] arm: pxa: fix DT node name for PXA27X usb
In-Reply-To: <1456139297-5854-1-git-send-email-ynvich@gmail.com> (Sergei
 Ianovich's message of "Mon, 22 Feb 2016 14:08:17 +0300")
References: <1456139297-5854-1-git-send-email-ynvich@gmail.com>
Message-ID: <87oab8wyfe.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Ianovich <ynvich@gmail.com> writes:

> Without this patch I am getting an error:
> ---8<---
> [   15.709742] ohci-pxa27x: OHCI PXA27x/PXA3x driver
> [   15.737150] pxa27x-ohci: probe of 4c000000.ohci failed with error -2
> ---8<---
>
> The error is generated in drivers/usb/host/ohci-pxa27x.c at line 441:
> ---8<---
> 441:	usb_clk = devm_clk_get(&pdev->dev, NULL);
> 442:	if (IS_ERR(usb_clk))
> 443:		return PTR_ERR(usb_clk);
> ---8<---
>
> The error is caused by different names for the same DT node in pxa2xx.dtsi
> and pxa27x.dtsi.
>
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> CC: Robert Jarzmik <robert.jarzmik@free.fr>
Hi Sergei,

You're right, I haven't seen the pxa2xx.dtsi statement before.

As such, could you amend a bit your patch please to :
 - add:
Fixes: 0ec1939668e5 ("ARM: dts: pxa: add the usb host controller")
 - make the same change in pxa3xx.dtsi, as the same error is there
 - and more globally align pxa2xx.dtsi, pxa27x.dtsi and pxa3xx.dtsi
 - remove the compatible, reg, interrupts and status from both pxa27x.dtsi and
   pxa3xx.dtsi as they are redundant with the included pxa2xxx.dsti one

I'm even wondering if the proper change wouldn't be to scrap the ohci
declarations from pxa27x.dtsi and pxa3xx.dtsi, and only add the "clocks"
property to pxa2xx.dtsi ...

Cheers.

--
Robert
