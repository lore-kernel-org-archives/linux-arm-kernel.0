From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 09:48:32 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <1362758390.25161.17.camel@sakura.staff.proxad.net>
References: <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
 <20130306230412.GA5870@obsidianresearch.com>
 <20130307222004.GA2450@localhost>
 <20130307230516.GA28975@obsidianresearch.com>
 <1362758390.25161.17.camel@sakura.staff.proxad.net>
Message-ID: <20130308164832.GA4094@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 04:59:50PM +0100, Maxime Bizon wrote:
> On Thu, 2013-03-07 at 16:05 -0700, Jason Gunthorpe wrote:
> > 
> > BTW, I've made the same basic choice on our Kirkwood systems. The NAND
> > timing pameters are set by the bootloader and the kernel doesn't touch
> > them. The bootloader knows which flash chip is placed on the board so
> > only it knows the correct timing parameters. There is not any reason
> > to communicate them to the kernel. 
> 
> since you can probe the chip ONFI timings, why are you doing that ?

Hmm, very interesting idea, but there is no implementation of this for
the Marvell NAND driver today.

Ezequiel - how would you forsee fitting something like this in? The
process for NAND would be to set the slowest timings (which have to be
computed based on the TClk frequency), do READID, determine the
fastest supported timings, and then update the timings again.

This seems like something that belongs in the NAND interface driver,
not the device bus driver??

> on a general standpoint, why would you ever want to run with whatever
> the bootloader left in registers if you have full knowledge to reprogram
> them in the kernel ?

Well, because the kernel doesn't support those registers. There are
quite a few of them on our Kirkwood systems, including NAND timing.

Jason
