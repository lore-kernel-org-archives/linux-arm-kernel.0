From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Jan 2014 19:21:11 +0000
Subject: [PATCH v10 1/4] arm64: topology: Implement basic CPU topology
 support
In-Reply-To: <20140113155004.GF11805@arm.com>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-2-git-send-email-broonie@kernel.org>
 <20140110174558.GI925@arm.com>
 <20140110182705.GR29039@sirena.org.uk>
 <20140113155004.GF11805@arm.com>
Message-ID: <20140113192111.GJ29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 03:50:04PM +0000, Catalin Marinas wrote:
> On Fri, Jan 10, 2014 at 06:27:05PM +0000, Mark Brown wrote:
> > On Fri, Jan 10, 2014 at 05:45:59PM +0000, Catalin Marinas wrote:
> > > The patches seem fine otherwise, apart from the last one which I
> > > won't merge until we get some real numbers.

> > As I previously said I am really concerned about diverging from what
> > arm32 has done here

> There is no diverging, these are new processors with possibly different
> values for these parameters.

I would argue that not providing the numbers at all is a divergence,
we can be reasonably confident that the A53 and A57 do differ.  We're
giving the scheduler a ballpark figure here, it's not an exact science.

> > and the numbers don't seem any less real than the
> > ones we're using there (they were generated in an identical fashion).

> Were the numbers in this patch generated in any way or simply copied
> from arch/arm?

Both IIRC - I did initially cut'n'paste but then went to try to find
numbers for the A53 and A57, came up with the idea of using the DMIPS
numbers to do that independently and then realised that the numbers I
was getting when I tried to do the maths were the same.  I only found
out Vincent had done the same thing in one of the earlier reviews for
the patches.

> > Given the hardware availability for arm64 in general is limited and
> > likely to be even more so for big.LITTLE systems it seems like asking
> > for problems down the line to do something different.

> I'm not saying we do something different, only that we can add the
> numbers once we get hold of some real hardware.

I'm saying we can tune them later on if we need to but that the finger
in the air saying there is expected to be a performance difference is
likely to be helpful.  The scheduler shouldn't be *that* fragile and I
expect you'll find that even with silicon it will be possible to have
endless debates about precisely which benchmarks to use.  In reality
good enough is probably fine, even with real hardware I'm not sure we
know exactly what to measure.

Hopefully people will be able to take released kernels and get them
doing useful stuff right off the bat and unless the information turns
out to be way off the mark I don't think people are going to be that
worried.  The more stress that gets put on picking the numbers the
harder it will be.

I think Nico was right in an earlier version of this discussion when he
said that we're likely to end up with the scheduler doing runtime tuning.
Long term if these remain I'd expect they'll be providing a hint to make
sure it starts off in roughly the right place and in the meantime the
scheduler does need some help here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140113/65092db9/attachment.sig>
