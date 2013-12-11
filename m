From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 14:11:48 +0000
Subject: [PATCH 3/6] arm64: dts: Add a devicetree for the ARMv8 4xA53
 4xA57 FVP
In-Reply-To: <20131211135536.GC17681@e106331-lin.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-3-git-send-email-broonie@kernel.org>
 <20131211135536.GC17681@e106331-lin.cambridge.arm.com>
Message-ID: <20131211141148.GV11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 01:55:36PM +0000, Mark Rutland wrote:
> On Wed, Dec 11, 2013 at 01:13:23PM +0000, Mark Brown wrote:

> > +/dts-v1/;

> > +/memreserve/ 0x80000000 0x00010000;

> While we are admittedly missing them elsewhere, it would be nice to have
> a comment stating what the memreserve is for. With a proper PSCI
> implementation, I don't see why this should be necessary.

Could you tell me what it's there for?  Like you say everyone else has
it with no comments and the source doesn't either...

> > +/ {
> > +	model = "FVP Base";

> FVP Base (is as the name implies) a base upon which particular model
> instances are built. This name should be clarified (e.g. "FVP Base A57x4
> A53x4").

> That also applies to the filename.

I can update these, though they do seem to come from what you guys are
releasing - you might want to follow up on this internally (this applies
to almost all of your review comments, sorry).  It's probably going to
be a bit confusing for users to have the filename change but ho hum :/

> As the FVP is not a vexpress (though it is similar), we should probably
> have "arm,fvp-base" as the fallback and drop the "arm,vexpress" entry.

Is it not intended to be a software emulation of a vexpress and hence
supposed to be broadly compatible with one?

> > +	psci {
> > +		compatible = "arm,psci";
> > +		method = "smc";
> > +		cpu_suspend = <0xc4000001>;
> > +		cpu_off = <0x84000002>;
> > +		cpu_on = <0xc4000003>;
> > +	};

> Are these IDs right? One of these IDs is a different width than the
> others.

I have no idea, I have no documentation for any of this stuff other than
the DT you guys release on github - it's just copied verbatim from
there.

> Which firmware/bootloader does this correspond to?

I'm testing using the Linaro 13.11 release.

> > +		big0: cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a57", "arm,armv8";
> > +			reg = <0x0 0x0>;
> > +			enable-method = "psci";
> > +			clock-frequency = <1000000>;

> Is clock-frequency used anywhere? Is it a useful thing to have
> (regardless of whether ePAPR defines it)?

The topology code for ARMv7 (which I'm following for ARMv8) uses this in
conjunction with the compatible to provide information to the scheduler
about the relative performance of the cores.  

> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <1 13 0xff01>,
> > +			     <1 14 0xff01>,
> > +			     <1 11 0xff01>,
> > +			     <1 10 0xff01>;
> > +		clock-frequency = <100000000>;

> A clock-frequency property in a timer is an indicator that the
> bootloader/firmware is broken and should be fixed. Is this actually
> necessary, or does the firmware/loader program CNTFRQ correctly on all
> CPUs?

I can try to see what happens if I remove it - I doubt anyone has tested
without it...

> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> > +		interrupts = <0 60 4>,
> > +			     <0 61 4>,
> > +			     <0 62 4>,
> > +			     <0 63 4>;
> > +	};

> I assume this is just the A57 cores? That should probably be noted for
> now. In future we'll need to define the relationship between interrupts
> and CPUs, and describe the A53 cores.

Again I don't know, this is just copied verbatim from what you guys
release - I have no additional documentation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/3104db53/attachment.sig>
