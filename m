From: dhylands@gmail.com (Dave Hylands)
Date: Fri, 20 Aug 2010 20:14:00 -0700
Subject: Problems with dma_alloc_writecombine
Message-ID: <AANLkTi=kbch5XF99nmjRsy_f2akwQwCR7co7eN=SDd0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We've observed a problem with dma_alloc_writecombine when the system
is under heavy load (heavy bus traffic).

We've observed the problem under 2.6.27.18 and 2.6.32.9 (the 2
versions of linux we're using).

Our processor is an ARM1176 (at least I think that's what it is). The
first few lines of the boot show:
Linux version 2.6.32.9 (dhylands at lc-rmna-017) (gcc version 4.3.2 (Wind
River Linux Sourcery G++ 4.3-85) ) #2 PREEMPT Fri Aug 20 18:35:25 PDT
2010
CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387f
CPU: VIPT aliasing data cache, VIPT aliasing instruction cache

We've managed to reduce the problem to the following snippet, which is
run from a ktrhread in a continuous loop:

  void *virtAddr;
  dma_addr_t physAddr;
  unsigned int numBytes = 256;

  for (;;) {
      virtAddr = dma_alloc_writecombine(NULL,
            numBytes, &physAddr, GFP_KERNEL);
      if (virtAddr == NULL) {
         printk(KERN_ERR "Running out of memory\n");
         break;
      }

      /* access DMA memory allocated */
      tmp = virtAddr;
      *tmp = 0x77;

      /* free DMA memory */
      dma_free_writecombine(NULL,
            numBytes, virtAddr, physAddr);

        ...sleep here...
    }

By itself, the code will run forever with no issues. However, as we
increase our bus traffic (typically using DMA) then the *tmp = 0x77
line will eventually cause a page fault. If we add a small delay (a
few microseconds) before the *tmp = 0x77, then we don't see a page
fault, even under heavy load.

This suggests to me that there is some circumstance under which the
write to the PTE hasn't actually been comitted to memory by the time
the *tmp = 0x77 line is executed. We're investigating the bus
priorities to see if the CPU is lower or higher than the DMA
operations.

So far, the evidence suggests that the set_pte_ext inside __dma_alloc
somehow isn't getting written out to memory before the *tmp = 0x77
line.

It feels like the MMU tried to access the PTE while the write (for the
PTE entry) was still in the write fifo. Is this possible?
Would adding a read of the PTE force the CPU to wait until the write
buffer was sufficiently drained such the PTE write is actually
committed to memory?

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
