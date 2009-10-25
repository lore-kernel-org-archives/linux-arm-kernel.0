From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 14:12:27 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() to always flush the
	I-cache
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dirk Behme reported instability on ARM11 SMP (VIPT non-aliasing cache)
caused by the dynamic linker changing protection on text pages to write
GOT entries.  The problem is due to an interaction between the write
faulting code providing new anonymous pages (which haven't had their
I-cache cleaned due to no VM_EXEC) and change_protection() not doing
any kind of I-cache maintainence.

Work around this by flushing the I-cache in flush_cache_range() for
VM_EXEC VMAs (which is what we have when the region is being made
executable again.)  This ensures that the I-cache will be up to date
with the new COW'd pages.

Note: if users are writing instructions, then they still need to use
the ARM sys_cacheflush API to ensure that the caches are correctly
synchronized.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 9770e27..ee7ce68 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -67,10 +67,9 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 		    :
 		    : "r" (0)
 		    : "cc");
-		__flush_icache_all();
 	}
 
-	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
+	if (vma->vm_flags & VM_EXEC)
 		__flush_icache_all();
 }
 
-- 
1.6.2.5
