From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 30 Jul 2013 17:46:08 +0800
Subject: [PATCH V2] ARM: dts: tegra114: dalmore: fix the irq trigger
 type of Palmas MFD device
In-Reply-To: <51F292D4.9030208@wwwdotorg.org>
References: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
 <51F292D4.9030208@wwwdotorg.org>
Message-ID: <1375177568.1239.16.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 23:16 +0800, Stephen Warren wrote:
> On 07/24/2013 04:54 AM, Joseph Lo wrote:
> > The IRQ trigger type of Palmas MFD device (tps65913) is edge trigger. The
> > wrong configuration would cause an interrupt storm when booting the
> > system. Fixing it in DT with appropriate interrupt type.
> 
> > diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> 
> >  		palmas: tps65913 {
> >  			compatible = "ti,palmas";
> >  			reg = <0x58>;
> > -			interrupts = <0 86 0x4>;
> > +			interrupts = <0 86 0x0>;
> 
> The legal values for that final cell are:
> 
>     - bits[3:0] trigger type and level flags
>         1 = low-to-high edge triggered
>         2 = high-to-low edge triggered
>         4 = active high level-sensitive
>         8 = active low level-sensitive
> 
> 0 isn't one of those values. This patch can't be correct.
> 
> BTW, this cell should use the constants from
> <dt-bindings/interrupt-controller/irq.h>.

Oops. I made a wrong description in the commit message.

Update my test result again.

> 1 = low-to-high edge triggered
No IRQ storm, but the system always auto wake up by Palmas RTC.
> 2 = high-to-low edge triggered
No IRQ storm, but the GIC didn't support this trigger type. The flag
would be re-configured as 0x0.
> 4 = active high level-sensitive
There is a IRQ storm when system booting.
> 8 = active low level-sensitive
No IRQ strom, but the GIC didn't support this trigger type. The flag
would be re-configured as 0x0.

> nvidia, invert-interrupt
Removing this can fix IRQ storm too, but the system always auto wake up
by Palmas RTC.

So we can only three trigger type here.
IRQ_TYPE_NONE 0
IRQ_TYPE_EDGE_FALLING 2
IRQ_TYPE_LEVEL_LOW 8

But using IRQ_TYPE_EDGE_FALLING or IRQ_TYPE_LEVEL_LOW, it would
configure to IRQ_TYPE_NONE. Because the PMIC is low level trigger to PMC
on Dalmore, I would prefer to use IRQ_TYPE_LEVEL_LOW just like the v1.
Any comments?

Thanks,
Joseph
