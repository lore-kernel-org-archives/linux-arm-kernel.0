From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 17:31:42 +0000
Subject: [PATCH 5/6] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20131211144755.GF596@darko.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-5-git-send-email-broonie@kernel.org>
 <20131211144755.GF596@darko.cambridge.arm.com>
Message-ID: <20131211173142.GD11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 02:47:55PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 01:13:25PM +0000, Mark Brown wrote:

> > The power numbers are the same as for ARMv7 since it seems that the
> > expected differential between the big and little cores is very similar on
> > both ARMv7 and ARMv8.

> I have no idea ;). We don't have real silicon yet, so that's just a wild
> guess.

I was going on some typical DMIPS/MHz numbers that I'd found so
hopefully it's not a complete guess, though it will vary and that's just
one benchmark with all the realism problems that entails.  The ratio
seemed to be about the same as the equivalent for the ARMv7 cores so
given that it's a finger in the air thing it didn't seem worth drilling
down much further.

> > +static const struct cpu_efficiency table_efficiency[] = {
> > +	{ "arm,cortex-a57", 3891 },
> > +	{ "arm,cortex-a53", 2048 },
> > +	{ NULL, },
> > +};

> I also don't think we can just have absolute numbers here. I'm pretty
> sure these were generated on TC2 but other platforms may have different
> max CPU frequencies, memory subsystem, level and size of caches. The
> "average" efficiency and difference will be different.

The CPU frequencies at least are taken care of already, these numbers
get scaled for each core.  Once we're talking about things like the
memory I'd also start worrying about application specific effects.
There's also going to be stuff like thermal management which get fed in
here and which varies during runtime.

I don't know where the numbers came from for v7.

> Can we define this via DT? It's a bit strange since that's a constant
> used by the Linux scheduler but highly related to hardware.

I really don't think that's a good idea at this point, it seems better
for the DT to stick to factual descriptions of what's present rather
than putting tuning numbers in there.  If the wild guesses are in the
kernel source it's fairly easy to improve them, if they're baked into
system DTs that becomes harder.

I think it's important not to overthink what we're doing here - the
information we're trying to convey is that the A57s are a lot faster
than the A53s.  Getting the numbers "right" is good and helpful but it's
not so critical that we should let perfect be the enemy of good.  This
should at least give ARMv8 implementations about equivalent performance
to ARMv7 with this stuff.

I'm also worried about putting numbers into the DT now with all the
scheduler work going on, this time next year we may well have a
completely different idea of what we want to tell the scheduler.  It may
be that we end up being able to explicitly tell the scheduler about
things like the memory architecture, or that the scheduler just gets
smarter and can estimate all this stuff at runtime.  

Customisation seems better provided at runtime than in the DT, that's
more friendly to application specific tuning and it means that we're
less committed to what's in the DT so we can improve things as our
understanding increases.  If it was punting to platform data and we
could just update it if we decided it wasn't ideal it'd be less of an
issue but punting to something that ought to be an ABI isn't awesome.

Once we've got more experience with the silicon and the scheduler work
has progressed we might decide it's helpful to put tuning controls into
DT but starting from that point feels like it's more likely to cause
problems than help.  With where we are now something simple and in the
ballpark is going to get us a long way.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/6b8f55f4/attachment.sig>
