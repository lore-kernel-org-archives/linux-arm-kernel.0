From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Nov 2014 17:40:07 +0100
Subject: ARM: mvebu: ethernet packets corruption and I/O coherency
In-Reply-To: <20141119160108.GJ24819@dev0.local>
References: <20141118142520.GD24819@dev0.local>
 <20141118153035.757fe0fc@free-electrons.com>
 <20141119160108.GJ24819@dev0.local>
Message-ID: <20141119174007.640b6ed4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Francesco Dolcini,

On Wed, 19 Nov 2014 17:01:08 +0100, Francesco Dolcini wrote:

> On Tue, Nov 18, 2014 at 03:30:35PM +0100, Thomas Petazzoni wrote:
> > It could indeed be related. I have marked the relevant patches in the 
> > "ARM: mvebu: no I/O coherency on non-SMP and related updates" series as
> > to be backported to stable up to v3.8, so when they get accepted, I'll
> > take care of backporting them.
> 
> I prepared and tested this small patch to fix the problem on kernel
> 3.13.11 and it seems to fix my ethernet packet corruption problem.
> Do you think it is fine?

There's one missing thing: as of 3.13, the mvebu-mbus driver was
directly looking at the DT to see if it had a coherency fabric node,
and if that's the case, then it was enabling the per-MBus window bit
telling that this window uses HW I/O coherency. I'm not sure it causes
some problems in practice, since with your patch all the cache
maintenance operations anyway properly re-enabled. But still, I'd
suggest to modify the mvebu-mbus driver accordingly. See:

	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
	if (np) {
		mbus->hw_io_coherency = 1;
		of_node_put(np);
	}

in drivers/bus/mvebu-mbus.c.

> Do you think that this bug on I/O cache coherency could also trigger some
> sporadic random OOPS and kernel panic? I got an OOPS with a broken LR in
> skb_segment() and a kernel panic in put_page(), but I was never able to
> reproduce any of them.

It's hard to say exactly what could happen with the wrong I/O cache
coherency setup. I would expect only the buffers used for DMA to not be
updated properly, but I might be wrong.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
