From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 28 Oct 2016 11:23:08 -0700
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161028165555.GA17998@obsidianresearch.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
 <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
 <20161028154740.GC10441@obsidianresearch.com>
 <5ea0e77e-11c5-b4f7-00a9-9c5425ffac5a@suse.com>
 <20161028165555.GA17998@obsidianresearch.com>
Message-ID: <20161028182308.GB18325@live.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 10:55:55AM -0600, Jason Gunthorpe wrote:
> On Fri, Oct 28, 2016 at 06:36:06PM +0200, Matthias Brugger wrote:
> 
> > Sure but we are checking here that the bitstream passed to the kernel is
> > correct.
> 
> The intent to check if it *possible* that the bitstream is
> correct. Correct means that DONE will assert after programming. A 4
> byte bitstream will never assert DONE.
> 
> Arguably the threshold should be larger but we don't know what the
> true minimum is.
> 
> > +	/* All valid bitstreams are multiples of 32 bits */
> > +	if (!count || (count % 4) != 0)
> > +		return -EINVAL;
> > +
> 
> Too clever for my taste.
> 
> Aside from this, is the general idea even OK? In my world I cannonize
> the bitstream to start with the sync word, but others may not be doing
> that.
> 
> I designed this patch based on the prior work to remove the
> auto-detection, eg that the driver should be passed a canonized
> bitstream.

I'm fine with checking for boundary cases where the bitstreams are
obviously too small or wrong size, I'm not convinced that checking using
internal knowledge about the bistream format inside the kernel is the
right place.

> The problem with the way it is now is how hard it is to figure out
> what the right bitstream format should be. Clear instructions to
> canonize by droping the header before the sync word and byteswap so
> the sync word is in the given order is much clearer..

I don't know about you, but for my designs I can just use what drops out
of my Vivado build. Are you unhappy with the way we document which
format to use, or that we don't slice off the beginning (that gets
ignored by hardware?).

Thanks for addressing the issues with the length calculations,

Moritz
