From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 25 Oct 2009 13:35:13 +0000
Subject: [RFC 09/11] ARM: Add I-cache invalidation for VIVT ASID tagged caches
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <5dee6c2014c4724c1ff6923326e93084f337581a.1256683230.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/flush.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index dc66f86..9770e27 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -69,6 +69,9 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 		    : "cc");
 		__flush_icache_all();
 	}
+
+	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
+		__flush_icache_all();
 }
 
 void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
@@ -82,6 +85,9 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 		flush_pfn_alias(pfn, user_addr);
 		__flush_icache_all();
 	}
+
+	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
+		__flush_icache_all();
 }
 
 void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
-- 
1.6.2.5
