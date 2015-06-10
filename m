From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jun 2015 23:40:59 +0100
Subject: [PATCHv3 1/2] arm: fix non-section-aligned low memory mapping
In-Reply-To: <1433962773-8402-2-git-send-email-orca.chen@gmail.com>
References: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
 <1433962773-8402-2-git-send-email-orca.chen@gmail.com>
Message-ID: <20150610224059.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 02:59:32AM +0800, Min-Hua Chen wrote:
> In current design, the memblock.current_limit is set to
> a section-aligned value in sanity_check_meminfo().
> 
> However, the section-aligned memblock may become non-section-aligned
> after arm_memblock_init(). For example, the first section-aligned
> memblock is 0x00000000-0x01000000 and sanity_check_meminfo sets
> current_limit to 0x01000000. After arm_memblock_init, two memory blocks
> [0x00c00000 - 0x00d00000] and [0x00ff0000 - 0x01000000] are reserved
> by memblock_reserve() and make the original memory block
> [0x00000000-0x01000000] becomes:

There isn't a problem with memblock_reserve().  That just marks the
memory as reserved, it doesn't steal the memory from the lowmem
mappings - in fact, it is still expected that reserved memory
claimed in this way will be mapped.

Somehow, I don't think this is what you're doing though, because you
go on to describe a problem which can only happen if you steal memory
after arm_memblock_init() has returned.

Don't do this.  There is a specific point in the boot sequence where you
are permitted to steal memory, which is done inside arm_memblock_init().
Stealing outside of that is not permitted.

arm_memblock_steal() is written to BUG_ON() if you attempt to do this
outside of the permissible code paths.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
