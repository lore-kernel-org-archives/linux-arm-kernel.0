From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:09 +0100
Subject: [PATCH 2/8] ARM: cache: remove redundant dsb instruction from
 v7_coherent_user_range
In-Reply-To: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
References: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
Message-ID: <1399044255-20435-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v7_coherent_user_range takes a virtual address range, cleans the D-side
to PoU and then invalidates the I-side so that subsequent instruction
fetches can see any new data written to the range in question.

Since cache maintenance by MVA is architected to execute in program
order with respect to other cache maintenance operations specifying
the same virtual address, we do not require a barrier between the
D-side clean and the I-side invalidation.

This patch removes the redundant dsb.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-v7.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 615c99e38ba1..b040d3ca20ac 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -282,7 +282,6 @@ ENTRY(v7_coherent_user_range)
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	1b
-	dsb	ishst
 	icache_line_size r2, r3
 	sub	r3, r2, #1
 	bic	r12, r0, r3
-- 
1.9.2
