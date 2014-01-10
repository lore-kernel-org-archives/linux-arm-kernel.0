From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 10 Jan 2014 12:44:37 -0700
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20140110192032.GQ19878@titan.lakedaemon.net>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20140102194924.GA3321@obsidianresearch.com>
 <1388702192.16958.54.camel@hastur.hellion.org.uk>
 <20140102230832.GB9339@obsidianresearch.com>
 <20140110192032.GQ19878@titan.lakedaemon.net>
Message-ID: <20140110194437.GJ18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 02:20:32PM -0500, Jason Cooper wrote:
> > Jason C: What do you think about applying this [untested]?
> 
> I'm of the opinion that the kernel shouldn't assume the state of the
> system when it begins execution.  Sure it's nice to point fingers at the
> bootloader (especially since it's obviously wrong in this situation),
> but we need Linux to boot on systems with non-upgradeable bootloaders
> which may be broken.  I'm specifically thinking about hobbyists
> modifying boxes they bought at $bigbox stores.

I liked the idea of your impedance matcher fixing up bootloader
problems. It would be pretty easy to have a feroceon specific path in
the impedance matcher to disable the L2.

> So, I'd prefer to handle this more gracefully.  I don't have much
> experience at the low-level init of the caches, couldn't we enable and
> flush rather than throwing the error?

It cannot be solved in cache-feroceon-l2.c.

In many cases you won't even get that far:
- It will blow up in head.S when the cache is off: decompressor wrote
  writeback data to into the L2 and uncached fetches see memory
  content prior to decompression
- It will blow up after head.S enables the L1: decompressor wrote
  data into the L2 but the relocation writes done with the L1 off
  made changes to memory that were not captured in the L2.

So to solve it gracefully it has to be done before the decompressor
enables the L1. Which leaves the bootloader, impedance matcher or
decompressor startup code as possible places.

The code required is a flush invalidate and then disable of the L2
cache, which is only about 5 instructions, but they must be
conditionalized somehow on the CPU type :(

The purpose of my patch is to highlight the problem to the bootloader
people. If you luck out and successfully boot with the L2 cache
enabled you can at least see the message that the bootloader is wrong.

Jason
