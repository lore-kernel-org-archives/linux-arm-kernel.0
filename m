From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2011 09:05:41 +0100
Subject: [PATCH] ARM: fix ioremap to allow mapping some specific RAM areas
In-Reply-To: <1307430745-17329-1-git-send-email-m.szyprowski@samsung.com>
References: <1307430745-17329-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110607080541.GA20929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 09:12:25AM +0200, Marek Szyprowski wrote:
> Creating more than one mapping on ARMv6+ might cause unspecified behavior,
> so ioremap() should fail if it was called with area that matches low memory.
> However if the board code removes the specific area from low memory
> mapping on boot (for example by calling memblock_remove()), then creating
> a mapping with ioremap might be desired.
> 
> This patch enables creating mapping for RAM by ioremap call, but only if
> the target area has no low memory mapping yet. This enables board code to
> reserve particular memory areas with memblock_remove() and provide them to
> device drivers with a declare_coherent_memory() call.

NAK.  pfn_valid is already defined like this:

int pfn_valid(unsigned long pfn)
{
        return memblock_is_memory(pfn << PAGE_SHIFT);
}

provided you enable ARCH_HAS_HOLES_MEMORYMODEL, which you must do if
you're punching holes in the memory map.
