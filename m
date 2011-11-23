From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Nov 2011 10:45:31 +0000
Subject: [PATCH] ARM: Add TLB flushing for both entries in a PMD
In-Reply-To: <004d01cca9c9$aeeb0420$0cc10c60$%youn@samsung.com>
References: <20111116103810.12733.23637.stgit@e102109-lin.cambridge.arm.com>
 <004d01cca9c9$aeeb0420$0cc10c60$%youn@samsung.com>
Message-ID: <20111123104531.GC29609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 10:21:37AM +0000, Changhwan Youn wrote:
> I have tested this patch on several exynos machines which 
> have a9 cores and it worked fine.
> Though I'm not sure that android boot and running simple applications
> are enough test for this patch.

Thanks for testing but the A9 would work fine without this patch. The
problem is on A15 where level 1 page table entries (pgd) are cached by
the TLB independently of level 2 entries (pte). The original code is
only flushing one entry in level 1 rather than 2.

The problem was visible with a stress-test application doing mmap/munmap
and then continuously getting level 2 translation fault even if the page
table looked fine to the kernel (because of stale level 1 entry in the
TLB).

LPAE is not affected, only the classic page table format.

-- 
Catalin
