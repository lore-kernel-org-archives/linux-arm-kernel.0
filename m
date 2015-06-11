From: orca.chen@gmail.com (Min-Hua Chen)
Date: Thu, 11 Jun 2015 08:02:46 +0800
Subject: [PATCHv3 1/2] arm: fix non-section-aligned low memory mapping
In-Reply-To: <20150610224059.GR7557@n2100.arm.linux.org.uk>
References: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
 <1433962773-8402-2-git-send-email-orca.chen@gmail.com>
 <20150610224059.GR7557@n2100.arm.linux.org.uk>
Message-ID: <20150611000246.GC5128@debian777.Home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 11:40:59PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 11, 2015 at 02:59:32AM +0800, Min-Hua Chen wrote:
> > In current design, the memblock.current_limit is set to
> > a section-aligned value in sanity_check_meminfo().
> > 
> > However, the section-aligned memblock may become non-section-aligned
> > after arm_memblock_init(). For example, the first section-aligned
> > memblock is 0x00000000-0x01000000 and sanity_check_meminfo sets
> > current_limit to 0x01000000. After arm_memblock_init, two memory blocks
> > [0x00c00000 - 0x00d00000] and [0x00ff0000 - 0x01000000] are reserved
> > by memblock_reserve() and make the original memory block
> > [0x00000000-0x01000000] becomes:
> 
> There isn't a problem with memblock_reserve().  That just marks the
> memory as reserved, it doesn't steal the memory from the lowmem
> mappings - in fact, it is still expected that reserved memory
> claimed in this way will be mapped.
> 
> Somehow, I don't think this is what you're doing though, because you
> go on to describe a problem which can only happen if you steal memory
> after arm_memblock_init() has returned.

Yes, your are right. The probelm is not caused by memblock_reserve().
It's caused by the memory reserving code in early_init_fdt_scan_reserved_mem(),
which is in arm_memblock_init().

The memory reserving code in of_of_reserved_mem.c allows the reserved
memory blocks to have a "no-map" property. When a reserved-memory
is marked "no-map", the mapping will be removed by memblock_remove() like
arm_memblock_steal() does.

> Don't do this.  There is a specific point in the boot sequence where you
> are permitted to steal memory, which is done inside arm_memblock_init().
> Stealing outside of that is not permitted.
> 
> arm_memblock_steal() is written to BUG_ON() if you attempt to do this
> outside of the permissible code paths.
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
