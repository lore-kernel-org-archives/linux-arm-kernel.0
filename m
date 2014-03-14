From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Mar 2014 10:26:31 +0900
Subject: [PATCH v2 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and
 SSDK-GH7 board
In-Reply-To: <20140313103329.GD5035@e106331-lin.cambridge.arm.com>
References: <1394491879-5320-1-git-send-email-kgene.kim@samsung.com>
 <1394491879-5320-2-git-send-email-kgene.kim@samsung.com>
 <20140311182922.GD3263@e106331-lin.cambridge.arm.com>
 <01c501cf3dac$022879b0$06796d10$@samsung.com>
 <20140313103329.GD5035@e106331-lin.cambridge.arm.com>
Message-ID: <010f01cf3f24$7002adb0$50080910$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland wrote:
> 

[...]

> > > > +/memreserve/ 0x80000000 0x0C400000;
> > >
> > > Please have a comment as to what this memreserve is intended to protect.
> > > This is very large, and we don't want pointless memreserves.
> > >
> > Well, you mean I need to comment about each reserved memory area?
> 
> Please have a comment about what each /memreserve/ is intended to
> protect.
> 
OK and I will try to reduce the size of reserved memory.

> > We need the reserved memory for EL3 monitor, UEFI services, secure
> > interpreter, hypervisor and Scan-chain for debug...BTW isn't it depending on
> > each hardware platform and usage model?
> 
> If it depends on each particular model then it doesn't belong in the
> shared dtsi, and each dts should have the /memreserve/ for that
> platform.
> 
I mean it depends on each SoC not board :-)

> Why would the hypervisor or secure OS memory ever be accessible to the
> kernel such that it would require a memreserve? That sounds
> fundamentally broken.
> 
> I was under the impression that if using UEFI we can identify and
> reserve the UEFI services by walking to UEFI memory map. If we don't use
> them, they don't need to be protected. As such, I don't see why they
> need a memreserve for them.
> 
I need to talk to regarding engineer internally. Then I will update it.

> > Just note, I will change the reserve memory area and size. From at
> > 0xf8000000 and size is 128MB(0x8000000).
> 
> Ok.
> 
> > > What address does the kernel end up getting loaded at on this board?
> > >
> > We load the kernel image from at 0x80080000 after changing the reserve
> > memory area.
> 
> Ok.

[...]

> > > > +		cpu at 000 {
> > > > +			device_type = "cpu";
> > > > +			compatible = "arm,armv8";
> > >
> > > The "arm,armv8" should be a fallback rather than the only entry. The
> > > precise core should be first (see arch/arm64/boot/dts/apm-storm.dtsi for
> > > an example).
> > >
> > Well, do I really need another name if GH7 has just 'ARMv8 core' exactly?
> 
> Yes please. You presumably don't have "just 'ARMv8 core'", but rather a
> specific ARMv8 implementation.
> 
OK, so in my understanding if it is really _just_ 'ARMv8 core' from S/W point
of view, "arm,armv8" should be fine. I will make sure.

> > > > +			reg = <0x0 0x000>;
> > >
> > > Any reason for padding these to three hexadecimal digits (in both the
> > > reg and unit-address)?
> > >
> > Yes, I already commented on Olof's question before, other cores will be
> > added and it should be separated from this.
> 
> Ok.

[...]

> > > > +	gic: interrupt-controller at 1C000000 {
> > > > +		compatible = "arm,cortex-a15-gic";
> > >
> > > We should have a more specific compatible string early in the list here
> > > too.
> > >
> > Well, I think more specific compatible string is not required for gic, there
> > were discussion about using another compatible string for gic-v2. And
> > cortex-a15-gic should be fine at this moment and if another name is required
> > as per previous discussion, we will then.
> 
> While it's probably ok to have "arm,cortex-a15-gic" in the compatible
> list, it would be good to also have a more specific string, so we can
> identify the GIC implementation precisely in future (in case we need to
> perform any workarounds, or there's some kind of optimisation we could
> perform for some implementations).
> 
Hmm... let's use just it for now then add another specific string later ;-)

[...]

> > > > +	pmu {
> > > > +		compatible = "arm,armv8-pmuv3";
> > >
> > > This is missing a specific compatible string.
> > >
> > I don't know why I need another specific compatible string here because I
> > thought the 'armv8-pmuv3' is enough.
> 
> Each CPU microarchitecture has different PMU events and quirks. While
> the CPU PMU might be compatible with ARMv8's PMUv3, it will also have
> implementation-specific events, and may have quirks we need to work
> around in future.
> 
> As with 32-bit, we'd expect these to be of the form
> "${implementor},${cpu}-pmu".
> 
OK.

+	compatible = "samsung,gh7-pmu", "armv8-pmuv3";

> > > > +		interrupts = <0 294 0>,
> > > > +			     <0 295 0>,
> > > > +			     <0 296 0>,
> > > > +			     <0 297 0>,
> > > > +			     <0 298 0>,
> > > > +			     <0 299 0>,
> > > > +			     <0 300 0>,
> > > > +			     <0 301 0>;
> > > > +	};
> > >
> > > There are four CPUs described, yet eight interrupts here. There should
> > > be one per CPU.
> > >
> > Yes right. I added them here by mistake, the other four interrupts will be
> > used for other 4 cores will be added later though.
> 
> Ok.

[...]

> > > > +		serial at 12c20000 {
> > > > +			compatible = "arm,pl011", "arm,primecell";
> > > > +			reg = <0 0x12c20000 0 0x10000>;
> > > > +			interrupts = <0 420 0>;
> > > > +		};
> > >
> > > These are both missing required clocks.
> > >
> > Yes right.
> 
> So you'll add these?
> 
To be honest, still I'm not sure how it should be handled because regarding
clocks do not need to handle in the kernel for GH7. And for it, I needed to
use some HACKs to change clock handling in the kernel. I will provide proper
solution soon.

[...]

> > > > +	model = "SAMSUNG SSDK-GH7 board based on GH7 SoC";
> > >
> > > Is the "based on GH7 SoC" part necessary? Does the "SSDK-GH7" not give
> > > that away?
> > >
> > In this case, yes, SSDK-GH7 is enough but I though, in case of different
> > board adding what SoC is used on the board in that is useful. Anyway, OK.
> 
> Looking at ePAPR, the recommended format is "manufacturer,model", and
> the string is intended to identify a particular implementation. It is
> not intended to give details about the implementation that can be
> derived from the name.
> 
> We seem to have ignored the format (and to some degree purpose) of the
> model property so far, but I don't see any reason to fill it with
> unnecessary information.
> 
OK, agreed. So it should be:

+	model = "samsung,SSDK-GH7";

Thank,
Kukjin
