From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2011 09:09:51 +0100
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
References: <20110705185758.GI8286@n2100.arm.linux.org.uk>
	<CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
	<20110714073453.GK23270@n2100.arm.linux.org.uk>
	<CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
	<CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
Message-ID: <20110715080950.GL23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 03:10:51PM -0700, Colin Cross wrote:
> With CONFIG_CMDLINE_EXTEND, accidentally using two mem= options is
> going to become more common (that's how I did it).  Would you accept a
> patch for 3.1/3.2 that would make incorrect mem= handling more robust?

The issue here is that mem= parameters are not supposed to overlap.
While there can be multiple mem= parameters, there is no sure way to
tell when one should override previous parameters.

> Investigating a little more, the problem happens in free_unused_memmap
> when two banks ordered by bank_start have reverse order bank_end.
> prev_bank_end gets set too low, and the area between bank_end of the
> previous two banks gets freed when a third bank is processed.
> 
> I can either drop extra mem= options if they overlap with a previous
> one, try to copy the memblock data back into meminit after memblock
> has handled the overlapping case, or fix up free_unused_memblock to
> only increase prev_bank_end.

You can't do that.  We keep the original meminfo data because memblock
coalesces the information and that breaks the sparse bank stuff (we need
to know where the boundaries are even when banks are fully populated.)

I think probably the best solution is to get rid of CMDLINE_EXTEND to
stop people walking blindly into this trap.
