From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 20 Nov 2014 11:29:21 +0800
Subject: [PATCH v7 3/4] ARM: mediatek: Add sysirq in
 mt6589/mt8135/mt8127 dtsi
In-Reply-To: <87d28jaxmq.fsf@approximate.cambridge.arm.com>
References: <1416406451-4578-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416406451-4578-4-git-send-email-yingjoe.chen@mediatek.com>
 <87d28jaxmq.fsf@approximate.cambridge.arm.com>
Message-ID: <1416454161.12869.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-19 at 17:49 +0000, Marc Zyngier wrote:
> On Wed, Nov 19 2014 at  2:14:10 pm GMT, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> > Add sysirq settings for mt6589/mt8135/mt8127
> > This also correct timer interrupt flag. The old setting works
> > because boot loader already set polarity for timer interrupt.
> > Without intpol support, the setting was not changed so gic
> > can get the irq correctly.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt6589.dtsi | 14 ++++++++++++--
> >  arch/arm/boot/dts/mt8127.dtsi | 14 ++++++++++++--
> >  arch/arm/boot/dts/mt8135.dtsi | 14 ++++++++++++--
> >  3 files changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/mt6589.dtsi b/arch/arm/boot/dts/mt6589.dtsi
> > index e3c7600..c91b2a9 100644
> > --- a/arch/arm/boot/dts/mt6589.dtsi
> > +++ b/arch/arm/boot/dts/mt6589.dtsi
> > @@ -19,7 +19,7 @@
> >  
> >  / {
> >  	compatible = "mediatek,mt6589";
> > -	interrupt-parent = <&gic>;
> > +	interrupt-parent = <&sysirq>;
> 
> This worries me a bit. Your sysirq cannot handle PPIs, and yet you make
> it the top-level interrupt controller, without amending any PPI.
> 
> Does it mean you do not use *any* PPI? No per-cpu timer, nothing?

Matthias had a patch to enable arch timer[1], but that is not merged
yet. Node using PPI interrupts must add their own interrupt-parent. This
works if we don't have node that use both PPI & SPI interrupts. For
timer, we could do this:

+		timer2: timer {
+			compatible = "arm,armv7-timer";
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			clock-frequency = <13000000>;
+		};

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/277017.html

Joe.C
