From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 24 Jul 2013 14:56:38 +0800
Subject: [PATCH] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <51EE968B.1050103@nvidia.com>
References: <1374574191-24396-1-git-send-email-josephl@nvidia.com>
 <51EE968B.1050103@nvidia.com>
Message-ID: <1374648998.23756.13.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-07-23 at 22:43 +0800, Laxman Dewangan wrote:
> On Tuesday 23 July 2013 03:39 PM, Joseph Lo wrote:
> > The IRQ trigger type of Palmas MFD device (tps65913) is low-level
> > sensitive. The wrong configuration would cause an interrupt storm
> > when booting the system. Fixing it in DT with appropriate interrupt
> > type.
> >
> > Cc: Laxman Dewangan <ldewangan@nvidia.com>
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> >   arch/arm/boot/dts/tegra114-dalmore.dts | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> > index 76529e4..70b9d0c 100644
> > --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> > +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> > @@ -840,7 +840,7 @@
> >   		palmas: tps65913 {
> >   			compatible = "ti,palmas";
> >   			reg = <0x58>;
> > -			interrupts = <0 86 0x4>;
> > +			interrupts = <0 86 0x8>;
> >   
> 
> This fails as GIC does not support the interrupt flag of 8.
> 
Yes, I knew this. But everything works as expected, the IRQ storm
disappears and the IRQ of Palmas RTC is working and can be used as a
wake up signal.

> [   13.007755] genirq: Setting trigger mode 8 for irq 118 failed 
> (gic_set_type+0x0/0xf0)
> [   13.009152] palmas 1-0058: Irq flag is 0x00000000
> 
> I did not get the interrupt storm and even interrupt is not working on tot.
> Two ways to resolve this:
> - Change the interrupt flag to 0 from 4. Or
Actually I fixed this issue two months ago, I had tried to use 0x0 as
the IRQ flag before. It's not working. But I still tried it today, it's
OK now(!!!). The function is what I expect. Maybe something wrong in my
test two months ago. Will fix this in V2.

> - Remove the nvidia,invert-interrupt; for PMC node.
This can avoid IRQ storm but introduce a new issue. The system suspend
would be woken up automatically by Palmas RTC all the time.

Thanks,
Joseph
