From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 22:42:39 +0000
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Message-ID: <20110208224239.GA31937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 03:22:59PM -0600, Andrei Warkentin wrote:
> I'm not sure if this is the best place to bring this up, but Russel's
> name is on a fair share of drivers/mmc code, and there does seem to be
> quite a bit of MMC-related discussions. Excuse me in advance if this
> isn't the right forum :-).

I dropped out of MMC stuff once we had a functional infrastructure
in place in the kernel - before that, there were various competing
implementations around.

The implementation that's there was based off what meager information
was available on the MMC protocol, as published by some of the card
manufacturers.  Certainly no one had the backing to be able to get the
official specifications and such like, nor to approach the various
companies to get the sort of details you're talking about.

So, what's there is basically a best-effort to provide something usable
and which works (most of the time.)  And to reflect that, error handling
is almost non-existent.

As part of trying to get better performance out of PIO-based interfaces,
I've recently been putting some effort into making the mmc block driver
a little more rugged in the face of various communication errors.

That's not to say that I'm now taking an active interest in MMC - I'm
not.  I'm just fixing the occasional issue which causes me problem.

As for what you're talking about (controlling the coalescing of requests),
I think you're better off sorting that out with the higher block layers
to restrict the amount of coalescing that happens there.  I think there
are some hooks already in place which allow you to define the maximum
size of any request, but this doesn't take account of read/write
properties.  Maybe that's something the higher block layer should be
extended with?

If so, you'll have to discuss it with the block layer folk.
