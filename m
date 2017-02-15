From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Feb 2017 11:33:59 +0000
Subject: [PATCH] arm64: fix warning about swapper_pg_dir overflow
In-Reply-To: <20170214212718.2792194-1-arnd@arndb.de>
References: <20170214212718.2792194-1-arnd@arndb.de>
Message-ID: <20170215113358.GC9630@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:27:01PM +0100, Arnd Bergmann wrote:
> With 4 levels of 16KB pages, we get this warning about the fact that we are
> copying a whole page into an array that is declared as having only two pointers
> for the top level of the page table:
> 
> arch/arm64/mm/mmu.c: In function 'paging_init':
> arch/arm64/mm/mmu.c:528:2: error: 'memcpy' writing 16384 bytes into a region of size 16 overflows the destination [-Werror=stringop-overflow=]
> 
> This is harmless since we actually reserve a whole page in the definition of the
> array that comes from, and just the extern declaration is short. The pgdir
> is initialized to zero either way, so copying the actual entries here seems
> like the best solution.

Thanks, I'll queue this up for 4.11 with the acks.

Will
