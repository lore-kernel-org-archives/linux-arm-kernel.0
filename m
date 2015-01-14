From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Jan 2015 17:40:36 +0000
Subject: [PATCH] ARM: mm: use phys_addr_t in __arm_ioremap functions
In-Reply-To: <1421256154-18514-1-git-send-email-vitalya@ti.com>
References: <1421256154-18514-1-git-send-email-vitalya@ti.com>
Message-ID: <20150114174035.GA12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 12:22:34PM -0500, Vitaly Andrianov wrote:
> On a 32 bit ARM architecture with LPAE extension physical addresses
> cannot fit into unsigned long variable.
> 
> This patch fixes the ioremap_page, __map_ioremap_pfn_caller,
> __arm_ioremap and __arm_ioremap_exec functions.

This patch does not do what the description says.  It only touches one
function - ioremap_page(), which from what I can see is never called.

It looks like it was introduced by Hiroshi DOYU without coming through
my core ARM tree (was it even reviewed?) in 2009, but six years on, it
doesn't have any users:

$ git grep 'ioremap_page\>'
arch/arm/include/asm/mach/map.h:extern int ioremap_page(unsigned long virt, unsi...
arch/arm/mm/ioremap.c:int ioremap_page(unsigned long virt, unsigned long phys,
arch/arm/mm/ioremap.c:EXPORT_SYMBOL(ioremap_page);
arch/unicore32/mm/ioremap.c:int ioremap_page(unsigned long virt, unsigned long p...
arch/unicore32/mm/ioremap.c:EXPORT_SYMBOL(ioremap_page);

I'd much rather see a patch deleting ioremap_page().

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
