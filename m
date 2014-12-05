From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Dec 2014 12:59:32 +0000
Subject: using DMA-API on ARM
In-Reply-To: <5481A855.6000603@broadcom.com>
References: <5481794E.4050406@broadcom.com>
 <20141205094507.GP11285@n2100.arm.linux.org.uk>
 <5481A855.6000603@broadcom.com>
Message-ID: <20141205125932.GR11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 01:43:01PM +0100, Arend van Spriel wrote:
> Ok. You already had a peek in our code checking the memory barriers, which
> does not have the dma_sync_single_for_cpu() "workaround" yet. So here some
> more background. The problem is in DMA_FROM_DEVICE direction. Because of the
> possible reordering issue we first tried using rmb() in the retry loop but
> that did not solve it. Another experiment was to ignore the failed ring
> descriptor entry and proceed. So we get interrupt from device and access the
> ring descriptor entry. This should contain expected value X, however we get
> X-1 back. When proceeding everything works find until hitting the same ring
> descriptor entry again reading X-1 when X+1 would be valid. This lead us to
> the assumption that somehow this entry ended up in cache lines. The issue
> goes away using the dma_sync_single_for_cpu() with DMA_FROM_DEVICE in
> direction parameter.

Can you give some further detail - I think it would help understanding
if you could give:

- the initial numerical state of the descriptor (presumably setup by
  msgbuf.c calling brcmf_commonring_reserve_for_write(), and then
  writing the contents into the ring buffer, followed by
  brcmf_commonring_write_complete().

- time passes, the hardware processes the entry

- the numerical state of the descriptor (which is in error) which you
  read back

- the expected numerical state of the descriptor

> So is there any function interface to verify cache status.

There isn't, but if you dump the virtual address, and you have debugfs
enabled, along with CONFIG_ARM_PTDUMP, you should be able to find the
mapping in /sys/kernel/debug/kernel_page_tables, which will tell you
the attributes that it's mapped using.

What it won't tell you is whether there's an alias of the mapping with
differing attributes.  If you use dma_to_pfn() to convert the DMA handle
into a PFN, we can use that to see whether there could be another mapping
from the kernel page table dump (by checking whether the PFN would be a
lowmem PFN, and therefore whether it's already mapped at it's lowmem
address.)

If you'd like to mail me (in addition to the ring contents above):

- the kernel_page_tables dump
- virtual address of the ring buffer
- dma_to_pfn() converted DMA handle of the ring buffer
- PHYS_PFN_OFFSET for your platform

then I can see whether there is.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
