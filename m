From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 14:20:14 +0000
Subject: [PATCH 3/6] ARM: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <1384457866-16135-4-git-send-email-santosh.shilimkar@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131115142014.GN16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:37:43PM -0500, Santosh Shilimkar wrote:
> Slab allocator can allocate memory beyond the lowmem watermark
> which can lead to false failure of virt_addr_valid().

This is definitely going to cause problems.

> So drop the check. The issue was seen with percpu_alloc()
> in KVM code which was allocating memory beyond lowmem watermark.
> 
> Am not completly sure whether this is the right fix and if it could
> impact any other user of virt_addr_valid(). Without this fix as
> pointed out the KVM init was failing in my testing.

virt_addr_valid() gets used in some places to check whether the virtual
address is part of the lowmem mapping and explicitly not part of vmalloc()
or DMA coherent space:

drivers/mtd/nand/gpmi-nand/gpmi-nand.c
drivers/net/wireless/ath/ath6kl/sdio.c

It opens up the checks in include/linux/scatterlist.h to start accepting
non-streaming DMA capable buffers as well.

It also bypasses a check in the slab code to ensure that it's a potentially
valid pointer that was handed out by slab.

.. etc ..
