From: mgorman@suse.de (Mel Gorman)
Date: Wed, 3 Aug 2011 14:28:39 +0100
Subject: [PATCH] ARM: sparsemem: Enable CONFIG_HOLES_IN_ZONE config
	option for SparseMem and HAS_HOLES_MEMORYMODEL for linux-3.0.
In-Reply-To: <CAFPAmTR79S3AVXrAFL5bMkhs2droL8THUCCPY23Ar5x_oftheQ@mail.gmail.com>
References: <CAFPAmTQByL0YJT8Lvar1Oe+3Q1EREvqPA_GP=hHApJDz5dSOzQ@mail.gmail.com>
	<20110803110555.GD19099@suse.de>
	<CAFPAmTR79S3AVXrAFL5bMkhs2droL8THUCCPY23Ar5x_oftheQ@mail.gmail.com>
Message-ID: <20110803132839.GG19099@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2011 at 05:59:03PM +0530, Kautuk Consul wrote:
> Hi Mel,
> 
> Sorry for the formatting.
> 
> I forgot to include the following entire backtrace:
> #> cp test_huge_file nfsmnt
> kernel BUG at mm/page_alloc.c:849!
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = ce9f0000
> <SNIP>
> Backtrace:
> [<c00269ac>] (__bug+0x0/0x30) from [<c008e8b0>]
> (move_freepages_block+0xd4/0x158)

It's still horribly mangled and pretty much unreadable but at least we
know where the bug is hitting.

> <SNIP>
> 
> Since I was testing on linux-2.6.35.9, line 849 in page_alloc.c is the
> same line as you have mentioned:
> BUG_ON(page_zone(start_page) != page_zone(end_page))
> 
> I reproduce this crash by altering the memory banks' memory ranges
> such that they are not aligned to the SECTION_SIZE_BITS size.

How are you altering the ranges? Are you somehow breaking
the checks based on the information in stuct zone that is in
move_freepages_block()?

It no longer seems like a punching-hole-in-memmap problem. Can
you investigate how and why the range of pages passed in to
move_freepages() belong to different zones?

Thanks.

-- 
Mel Gorman
SUSE Labs
