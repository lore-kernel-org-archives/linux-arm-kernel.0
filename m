From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 28 Nov 2014 18:51:43 +0800
Subject: [PATCH v2] arm64: ARM: Fix the Generic Timers interrupt active
 level description
In-Reply-To: <20141128103843.GW828@e106497-lin.cambridge.arm.com>
References: <1417105283-19575-1-git-send-email-Liviu.Dudau@arm.com>
 <54776FE0.8030600@arm.com> <20141128111252.4a6e8892@xhacker>
 <20141128103843.GW828@e106497-lin.cambridge.arm.com>
Message-ID: <20141128185143.00ee05b5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Nov 2014 02:38:43 -0800
Liviu Dudau <Liviu.Dudau@arm.com> wrote:

> On Fri, Nov 28, 2014 at 03:12:52AM +0000, Jisheng Zhang wrote:
> > Dear Marc and Liviu,
> > 
> > On Thu, 27 Nov 2014 10:39:28 -0800
> > Marc Zyngier <marc.zyngier@arm.com> wrote:
> > 
> > > On 27/11/14 16:21, Liviu Dudau wrote:
> > > > The Cortex-A5x TRM states in paragraph "9.2 Generic Timer functional
> > > > description" that generic timers provide a level not edge interrupt
> > > > output. Fix the device trees to correctly describe this.
> > > > 
> > > > While doing this update the CPU mask to match the number of described
> > > > CPUs as well as the DT bindings documentation for Generic Timers.
> > > > 
> > > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > 
> > > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > > 
> > > 	M.
> > > 
> > > > ---
> > > > 
> > > > Arnd, Olof: This is on top of linux-next/master as it patches Juno's
> > > > as well as all the other ARM DTs.
> > > > 
> > > > --
> > > > 
> > > >  Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++----
> > > >  arch/arm64/boot/dts/arm/foundation-v8.dts            | 8 ++++----
> > > >  arch/arm64/boot/dts/arm/juno.dts                     | 8 ++++----
> > > >  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts           | 8 ++++----
> > > >  4 files changed, 16 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt
> > > > b/Documentation/devicetree/bindings/arm/arch_timer.txt index
> > > > 37b2caf..6d2aa87 100644 ---
> > > > a/Documentation/devicetree/bindings/arm/arch_timer.txt +++
> > > > b/Documentation/devicetree/bindings/arm/arch_timer.txt @@ -27,10
> > > > +27,10 @@ Example: timer {
> > > >  		compatible = "arm,cortex-a15-timer",
> > > >  			     "arm,armv7-timer";
> > > > -		interrupts = <1 13 0xf08>,
> > > > -			     <1 14 0xf08>,
> > > > -			     <1 11 0xf08>,
> > > > -			     <1 10 0xf08>;
> > > > +		interrupts = <1 13 0xf04>,
> > > > +			     <1 14 0xf04>,
> > > > +			     <1 11 0xf04>,
> > > > +			     <1 10 0xf04>;
> > > >  		clock-frequency = <100000000>;
> > > >  	};
> > > >  
> > 
> > Does it mean we also need to fix the interrupt level description under
> > arch/arm/boot/dts? I found they are also wrong or I misunderstand
> > something?
> 
> Hi Jisheng,
> 
> It looks like Marc and I managed to confuse ourselves. The TRM for GIC-500
> and GIC-400 (basically covering most of GICv1 and > GICv2) clearly says
> that for *PPIs* the level triggered interrupts are active-LOW.
> 
> So, this patch is invalid and my v1 version is correct, but Marc tells that
> in that case the GIC driver needs patching (which I'm going to look into).
> 

Got it. Thanks for clarification.
