From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2016 13:04:06 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <5746E203.4000906@huawei.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
 <20160524130255.GU4892@e104818-lin.cambridge.arm.com>
 <5744FDD0.8060504@huawei.com> <57451DC6.7080106@huawei.com>
 <20160525105022.GC5996@e104818-lin.cambridge.arm.com>
 <5746E203.4000906@huawei.com>
Message-ID: <20160526120406.GI19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 07:46:11PM +0800, Leizhen (ThunderTown) wrote:
> Hi,
> As my tracing, it is returned by "if (!page_mapping(page))", because "mmap" are anonymous pages. I commented below code lines, it works well.
> 	
> 	/* no flushing needed for anonymous pages */
> 	if (!page_mapping(page))
> 		return;
> 
> 
> I printed the page information three times, as below:
> page->mapping=ffff8017baf36961, page->flags=0x1000000000040048
> page->mapping=ffff8017b265bf51, page->flags=0x1000000000040048
> page->mapping=ffff8017b94fc5a1, page->flags=0x1000000000040048
> 
> PG_slab=7, PG_arch_1=9, PG_swapcache=15

Well, I think we first need to establish what the semantics of changing
any region from PROT_READ|PROT_WRITE to PROT_READ|PROT_EXEC are as far
as cache coherence goes.  As I've already said, POSIX says nothing about
this aspect, so the specifications don't define what the expectations
are here.  So, I don't think we can say that anything is wrong.

> > I ran our internal LTP version yesterday and it was fine but didn't
> > realise that we actually patched mprotect04.c to include:
> > 
> > 	__clear_cache((char *)func, (char *)func + page_sz);
> > 
> > just after memcpy().

The question here is what is the justification for this LTP test -
surely, all tests in LTP should refer to some specification justifying
the test, which allows diagnosis of whether the LTP test is wrong or
whether the environment being tested is wrong.

However, the PPC modifications to it appear to justify our kernel
implementation: as has been pointed out, PPC has some additional code
which deals with the cache coherency.  ARM has similar mechanisms with
the cacheflush syscall, whose whole point of existing is to support
self-modifying code (as userspace is not allowed to touch the cache
maintanence instructions.)

So, in the presence of the test justification vaccuum, and the fact
that PPC has added cache maintanence to the test, I think we should
take the exact same approach.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
