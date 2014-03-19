From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Mar 2014 17:33:32 +0900
Subject: [PATCH v2 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and
 SSDK-GH7 board
In-Reply-To: <20140318181054.GF2941@e106331-lin.cambridge.arm.com>
References: <1394491879-5320-1-git-send-email-kgene.kim@samsung.com>
 <1394491879-5320-2-git-send-email-kgene.kim@samsung.com>
 <20140311182922.GD3263@e106331-lin.cambridge.arm.com>
 <01c501cf3dac$022879b0$06796d10$@samsung.com>
 <20140313103329.GD5035@e106331-lin.cambridge.arm.com>
 <010f01cf3f24$7002adb0$50080910$@samsung.com>
 <20140318181054.GF2941@e106331-lin.cambridge.arm.com>
Message-ID: <019601cf434d$eb5c47f0$c214d7d0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:
> 
> On Fri, Mar 14, 2014 at 01:26:31AM +0000, Kukjin Kim wrote:
> > > > > > +		cpu at 000 {
> > > > > > +			device_type = "cpu";
> > > > > > +			compatible = "arm,armv8";
> > > > >
> > > > > The "arm,armv8" should be a fallback rather than the only entry. The
> > > > > precise core should be first (see arch/arm64/boot/dts/apm-storm.dtsi for
> > > > > an example).
> > > > >
> > > > Well, do I really need another name if GH7 has just 'ARMv8 core' exactly?
> > >
> > > Yes please. You presumably don't have "just 'ARMv8 core'", but rather a
> > > specific ARMv8 implementation.
> > >
> > OK, so in my understanding if it is really _just_ 'ARMv8 core' from S/W point
> > of view, "arm,armv8" should be fine. I will make sure.
> 
> It will work, sure. But the compatible list should also list the
> specific CPU. From the S/W point of view there are likely
> implementation-defined registers which mean that no real CPU will be
> "just" an ARMv8 core.
> 
Well, IMHO, SoC is just SoC and we don't think each CPU(core) from SoC and I'm
still wondering why the specific compatible string for CPU is needed in kernel.
And I don't see any custom handling for GH7 SoC. Note sorry, I don't get about
implementation-defined registers.

> We have enough trouble with DTBs for 32-bit SoCs not listing things they
> should. I see no reason to be lax here.
> 
Could you please let me know what was the problem?
If it could be on exynos, would be helpful to me.

> > > > > > +	gic: interrupt-controller at 1C000000 {
> > > > > > +		compatible = "arm,cortex-a15-gic";
> > > > >
> > > > > We should have a more specific compatible string early in the list here
> > > > > too.
> > > > >
> > > > Well, I think more specific compatible string is not required for gic, there
> > > > were discussion about using another compatible string for gic-v2. And
> > > > cortex-a15-gic should be fine at this moment and if another name is required
> > > > as per previous discussion, we will then.
> > >
> > > While it's probably ok to have "arm,cortex-a15-gic" in the compatible
> > > list, it would be good to also have a more specific string, so we can
> > > identify the GIC implementation precisely in future (in case we need to
> > > perform any workarounds, or there's some kind of optimisation we could
> > > perform for some implementations).
> > >
> > Hmm... let's use just it for now then add another specific string later ;-)
> 
> Why not do this from the start? Then we can actually rely on the DTB
> rather than it being useless.
> 
I mean, we need to use current GIC implementation for GH7 SoC at this moment.

> > > > > > +	pmu {
> > > > > > +		compatible = "arm,armv8-pmuv3";
> > > > >
> > > > > This is missing a specific compatible string.
> > > > >
> > > > I don't know why I need another specific compatible string here because I
> > > > thought the 'armv8-pmuv3' is enough.
> > >
> > > Each CPU microarchitecture has different PMU events and quirks. While
> > > the CPU PMU might be compatible with ARMv8's PMUv3, it will also have
> > > implementation-specific events, and may have quirks we need to work
> > > around in future.
> > >
> > > As with 32-bit, we'd expect these to be of the form
> > > "${implementor},${cpu}-pmu".
> > >
> > OK.
> >
> > +	compatible = "samsung,gh7-pmu", "armv8-pmuv3";
> 
> Is GH7 an SoC or a CPU?
> 
SoC. Similar as above. AFAIK, ARM SoC vendors usually didn't name for each CPU
not SoC if there is no change in core hardware implementation, at least Samsung
didn't name.

OK, if you still have strong objection on this, I will remove PMU support here
until agreement about that.

> > > > > > +		serial at 12c20000 {
> > > > > > +			compatible = "arm,pl011", "arm,primecell";
> > > > > > +			reg = <0 0x12c20000 0 0x10000>;
> > > > > > +			interrupts = <0 420 0>;
> > > > > > +		};
> > > > >
> > > > > These are both missing required clocks.
> > > > >
> > > > Yes right.
> > >
> > > So you'll add these?
> > >
> > To be honest, still I'm not sure how it should be handled because regarding
> > clocks do not need to handle in the kernel for GH7. And for it, I needed to
> > use some HACKs to change clock handling in the kernel. I will provide proper
> > solution soon.
> 
> Are the clocks always-on, fixed-rate clocks, or does some firmware
> manage them dynamically? We have bindings for the former.
> 
Actually, some firmware handles them and basically and kernel doesn't need.

> There's not much point having a DTS upstream that relies on hacks which
> are not.
> 
At the end, we are going to use just upstream kernel for GH7 without any HACKs
but as a preliminary, this is a good start point even there is HACK for a while.

Thanks,
Kukjin
