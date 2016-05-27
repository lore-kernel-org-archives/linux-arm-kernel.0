From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 May 2016 16:40:45 +0200
Subject: v7_dma_inv_range performance/high expense
Message-ID: <20160527144045.GB20214@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks

I have an imx6q, which is a quad core v7 processor. Attached to it via
pcie i have an intel i210 Ethernet controller.

When the ethernet is transmitting, i can get gigabit line rate, and
use one core to about 35% of one core. When receiving, i get around
700Mbps and ksoftirqd/0 is 98% loading a core.

Using perf to profile the ksoftirqd/0 pid is see:

  46.38%  [kernel]  [k] v7_dma_inv_range
  21.25%  [kernel]  [k] l2c210_inv_range
  10.90%  [kernel]  [k] igb_poll
   1.69%  [kernel]  [k] dma_cache_maint_page
   1.27%  [kernel]  [k] eth_type_trans
   1.20%  [kernel]  [k] skb_add_rx_frag

Digging deeper into v7_dma_inv_range i see:

           801182c0 <v7_dma_inv_range>:
           v7_dma_inv_range():
  0.26       mrc    15, 0, r3, cr0, cr0, {1}
  0.07       lsr    r3, r3, #16
             and    r3, r3, #15
  0.04       mov    r2, #4
             lsl    r2, r2, r3
  0.04       sub    r3, r2, #1
             tst    r0, r3
  0.02       bic    r0, r0, r3
  0.03       dsb    sy
  3.01       mcrne  15, 0, r0, cr7, cr14, {1}
  0.54       tst    r1, r3
             bic    r1, r1, r3
  0.08       mcrne  15, 0, r1, cr7, cr14, {1}
  3.82 34:   mcr    15, 0, r0, cr7, cr6, {1}
 88.32       add    r0, r0, r2
             cmp    r0, r1
  1.97       bcc    34
  0.43       dsb    st
  1.37       bx     lr

I'm assuming perf is off by one here, and the add is not taking 88.32%
of the load, rather it is the mcr instruction before it.

The original code in arch/arm/mm/cache-v7.S  says:

        mcr     p15, 0, r0, c7, c6, 1           @ invalidate D / U line

I don't get why a cache invalidate instruction should be so expensive.
It is just throwing away the contents of the cache line, not flushing
it out to DRAM. Should i trust perf? Is a cache invalidate really so
expensive? Or am i totally missing something here?

Thanks
	Andrew
