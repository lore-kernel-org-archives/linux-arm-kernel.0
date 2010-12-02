From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 21:32:13 +0000
Subject: [PATCH 01/02] omap: dsp: remove shm from normal memory
In-Reply-To: <1289440225-27221-2-git-send-email-omar.ramirez@ti.com>
References: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
	<1289440225-27221-2-git-send-email-omar.ramirez@ti.com>
Message-ID: <20101202213213.GI10461@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 07:50:24PM -0600, Omar Ramirez Luna wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Also, don't be picky about the location, which incidentally fixes the
> build since MEMBLOCK_REAL_LIMIT is gone on 2.6.37.

That comment is wrong.  memblock_alloc() is still as picky as the
original.

phys_addr_t __init memblock_alloc(phys_addr_t size, phys_addr_t align)
{
        return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
}

        /* Pump up max_addr */
        if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
                end = memblock.current_limit;

and current_limit is initialized to what was MEMBLOCK_REAL_LIMIT.  So,
memblock_alloc() will always allocate from lowmem.
