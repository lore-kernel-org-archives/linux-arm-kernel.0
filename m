From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 14 Jun 2016 12:11:38 +0200
Subject: [PATCH 1/1] ARM: dts: imx6qdl.dtsi: add "arm, shared-override"
 for pl310
In-Reply-To: <HE1PR04MB1450F3D1F7C9CA4C859C04D88B540@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1465292365-26038-1-git-send-email-peter.chen@nxp.com>
 <20160611115733.GM20243@tiger> <1465809841.2313.2.camel@pengutronix.de>
 <VI1PR04MB14558D10397904A5C33A73E88B530@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <1465816498.2313.15.camel@pengutronix.de>
 <HE1PR04MB1450F3D1F7C9CA4C859C04D88B540@HE1PR04MB1450.eurprd04.prod.outlook.com>
Message-ID: <1465899098.29321.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Dienstag, den 14.06.2016, 01:30 +0000 schrieb Peter Chen:
>  
> >
> >Am Montag, den 13.06.2016, 09:42 +0000 schrieb Peter Chen:
> >>
> >> >Am Samstag, den 11.06.2016, 19:57 +0800 schrieb Shawn Guo:
> >> >> + Lucas
> >> >>
> >> >> On Tue, Jun 07, 2016 at 05:39:25PM +0800, Peter Chen wrote:
> >> >> > The imx6 SMP system has the same DMA memory coherency issue [1]
> >> >> > with
> >> >> > pl310 L2 controller. With this shared override bit set, the
> >> >> > customer reports the DMA coherency issue is gone. Besides, I have
> >> >> > tested the performance using USB ethernet with/without this bit,
> >> >> > it shows no difference.
> >> >> >
> >> >> > [1] http://patchwork.ozlabs.org/patch/469362/
> >> >> >
> >> >> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> >> >> > ---
> >> >> >  arch/arm/boot/dts/imx6qdl.dtsi | 1 +
> >> >> >  1 file changed, 1 insertion(+)
> >> >> >
> >> >> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
> >> >> > b/arch/arm/boot/dts/imx6qdl.dtsi index ed613eb..30e21ee 100644
> >> >> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> >> >> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> >> >> > @@ -185,6 +185,7 @@
> >> >> >  			cache-level = <2>;
> >> >> >  			arm,tag-latency = <4 2 3>;
> >> >> >  			arm,data-latency = <4 2 3>;
> >> >> > +			arm,shared-override;
> >> >>
> >> >> Lucas had an objection to the change [1], considering the case that
> >> >> kernel is booted as non-secure.
> >> >
> >> >My objection to this change still stands. Configuring the L2C to be
> >> >compliant to the
> >> >ARMv7 ARM is at the same level as the CPU workarounds that can not be
> >> >applied in secure mode. Those must be done in the firmware, if your
> >> >firmware doesn't do it it's plain broken.
> >> >
> >>
> >> Sorry, I not understand what's your mean. We only changes L2
> >> configuration when the cache is disabled, what problem will be?
> >>
> >If the kernel is booted in non-secure mode, the L2 cache configuration register is RO
> >and the kernel will crash on the attempt to write into this register.
> >
> 
> Does that mean current mainline kernel for imx6qdl can't boot with non-secure mode, I see other
> L2 configurations have been changed like "arm, tag-latency" and "arm,data-latency"? Did you try it?

I've just re-read the code and hereby withdraw my objection.

The cache configuration registers will only be touched if the DT
specified values differ from what the firmware has set up already. As
not setting the "shared-override" bit render the platform non compliant
to the ARMv7 ARM, one should hope that any firmware booting the kernel
in secure mode has already set this bit. The crash that will happen
otherwise might be just as good as the silent data corruption resulting
from not setting this bit.

Regards,
Lucas
