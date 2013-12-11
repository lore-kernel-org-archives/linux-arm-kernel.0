From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 16:00:34 +0000
Subject: [PATCH 3/6] arm64: dts: Add a devicetree for the ARMv8 4xA53
 4xA57 FVP
In-Reply-To: <20131211150433.GD17681@e106331-lin.cambridge.arm.com>
References: <20131211150433.GD17681@e106331-lin.cambridge.arm.com>
Message-ID: <20131211160034.GA11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 03:04:33PM +0000, Mark Rutland wrote:
> On Wed, Dec 11, 2013 at 02:11:48PM +0000, Mark Brown wrote:
> > On Wed, Dec 11, 2013 at 01:55:36PM +0000, Mark Rutland wrote:
> > > On Wed, Dec 11, 2013 at 01:13:23PM +0000, Mark Brown wrote:

> > > > +/memreserve/ 0x80000000 0x00010000;

> > > While we are admittedly missing them elsewhere, it would be nice to have
> > > a comment stating what the memreserve is for. With a proper PSCI
> > > implementation, I don't see why this should be necessary.

> > Could you tell me what it's there for?  Like you say everyone else has
> > it with no comments and the source doesn't either...

> When using the bootwrapper, the bootwrapper itself takes up a portion of
> memory (along with the spin-table) which would otherwise be available to
> the kernel. This is also true with my bootwrapper PSCI implementation.
> The memreserve tells the kernel not to stomp over this memory (though it
> will map it in).

OK, I'll try to distill that down to a comment (and add the same comment
to the other DTs).  However see below...

> With a proper firmware, I'd expect the PSCI implementation to be outside
> of the memory exposed to non-secure software, and thus there shouldn't
> be anything to reserve.

> It's possible that there is a reason for the reservation, but I'd rather
> we understood it than we propagated and codified a misunderstanding.

It'd certainly be nice if it were clearer.

> I don't see the name issue as a big problem. This DT has never been part
> of the kernel tree, so there's no filename compatibility issue to deal
> with. Existing users of the DT will already have to be modified to get
> the DTs from a new source.

I'm more worried about existing users not noticing that this is a DT for
the same thing.

> There should be nothing hanging off the compatible string for the
> platform yet -- we have no board files or platform blobs in the arm64
> port. If the model name is being used as anything other than a handy
> indicator to users, then that's broken anyway.

Yeah, that doesn't seem at all risky.

> > > > +	psci {
> > > > +		compatible = "arm,psci";
> > > > +		method = "smc";
> > > > +		cpu_suspend = <0xc4000001>;
> > > > +		cpu_off = <0x84000002>;
> > > > +		cpu_on = <0xc4000003>;
> > > > +	};

> > > Are these IDs right? One of these IDs is a different width than the
> > > others.

> > I have no idea, I have no documentation for any of this stuff other than
> > the DT you guys release on github - it's just copied verbatim from
> > there.

> So this goes with the trusted firmware?

This is on the ARM github site so I'm not 100% sure how tied that is.

> > > Which firmware/bootloader does this correspond to?

> > I'm testing using the Linaro 13.11 release.

> Release of what? I'm not familiar with the entire stack Linaro manage.

> I guess the trusted firmware is being used, as mentioned above?

The only release Linaro have for ARMv8 is an OE one AFAICT which I got
from here:

    http://releases.linaro.org/13.11/openembedded/aarch64

According to the notes there it includes the trusted firmware.  The
above is all the information I have on it.

> Ok. While I have concerns regarding the topology code, I'm not averse to
> describing the clock-frequency here.

> However I worry about how configurable clocks are going to be handled
> here. On the 32-bit side I see some platforms with clock-frequency and
> others with clocks. We should figure out what the expected way to handle
> configurable clocks before we add the code for handling a fixed rate
> clock here, or we're going to back ourselves into a corner where this
> support can only work on a subset of systems.

Well, we can always extend later.  I do share your concerns about doing
this using clock-frequency though, that's why I specified it as being
the maximum when I copied it into the kernel bindings.  That's clearly
the intention of the existing ARMv7 implementation.

One trick here is that this is all happening rather early in boot so
going through the whole clock tree might be entertaining, though we can
probably go round and do another pass when cpufreq comes up.

> I'd rather that the elements we are unsure about were dropped from the
> DT for the timebeing rather than being present but incorrect. There's
> less room for something to blow up that way, and it makes it clearer
> where the deficiencies are.

OK.  To be honest I'm leaning towards letting you guys upstream this
given that all the information I have on it is the DT so from my point
of view I'm unsure about essentially all of it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/619d4490/attachment.sig>
