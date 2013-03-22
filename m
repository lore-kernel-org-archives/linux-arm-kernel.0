From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 22 Mar 2013 11:43:00 -0600
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130322062854.GS21478@lunn.ch>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-6-git-send-email-gregory.clement@free-electrons.com>
 <20130321201533.GN21478@lunn.ch> <20130321212236.1015295d@skate>
 <20130321205545.GA8358@obsidianresearch.com>
 <20130322062854.GS21478@lunn.ch>
Message-ID: <20130322174300.GA10230@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 07:28:54AM +0100, Andrew Lunn wrote:

> IO space needs to stay where it is, somewhere in the top 1GB, because
> it is limited to the 32bit address space.

Yes
 
> We must have some SDRAM in the bottom of the 40bit address range in
> order that DMA works. Bounce buffers are used for anything which is
> outside of the bottom 32bits.

Yes :(
 
> SDRAM can only be split on ranks. I assume this is also a synonym for
> chip select? 

Yes, rank is the JEDEC term. All CS inputs on every DRAM die in a rank
should be asserted at once. Note that splitting the SDRAM address map
by rank is only one choice, other chipsets can do bank interleaving
across ranks for greater performance..

> Ideally we want the boot loader to setup the split, since it is not
> very easy to move stuff around in a running system. Alternatively,
> the

Yes, there are several possibilities, but they will all require the DT
to describe the ranks on the DRAM bus directly.

> It might be possible, in theory, to copy code into the SRAM and run
> from SRAM while moving the SDRAM around. But i get the feeling its not
> very easy.

This doesn't help, the issue is the kernel has already started and is
already placed in SDRAM, so you can't really touch the mapping that
contains the kernel. The work is more of a complexity to determine
what the bootloader did and re-do it in a way that dosen't move any
memory the kernel has touched up to that point.

> If there is 4GB in the system, it is probably going to be split with
> 2GB low and 2GB high. This is probably the most important use case,
> since throwing away 1/4 of your SDRAM is much worse than 1/8, or 1/16.

Think about things in terms of rank size. A 4GB system could have 1, 2
or 4 GB ranks, and each is a different case. 1GB ranks should have a
3/1 split, 2GB ranks a 2/2 or 3/0 split, and 4GB ranks are forced into
a 2/0 split (due to alignment needs).

> With 16GB, there is no choice other than 4GB/12GB with 1GB discarded.

4x4GB ranks would be a 2/12GB split with 2GB of discard, a rank size
must be a power of two.

At a certain point low mem exhaustion becomes a serious issue for
Linux, a system that can't DMA to 85% of its memory is incredibly
broken, IMHO.

Jason
