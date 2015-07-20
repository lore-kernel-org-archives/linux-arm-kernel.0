From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 20 Jul 2015 16:10:01 +0100
Subject: [PATCH v2 2/5] arm64: mm: Adopt new alternative assembler macros
In-Reply-To: <1437405004-1296-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437405004-1296-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1437405004-1296-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the dynamic patching for ARM64_WORKAROUND_CLEAN_CACHE over to
the newly added alternative assembler macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/mm/cache.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index bdeb5d38c2dd..eb48d5df4a0f 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -143,7 +143,12 @@ __dma_clean_range:
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x0, x0, x3
-1:	alternative_insn "dc cvac, x0", "dc civac, x0", ARM64_WORKAROUND_CLEAN_CACHE
+1:
+alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
+	dc	cvac, x0
+alternative_else
+	dc	civac, x0
+alternative_endif
 	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	1b
-- 
2.4.3
