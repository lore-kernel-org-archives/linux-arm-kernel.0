From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Feb 2016 15:44:37 +0100
Subject: [PATCH v2 2/9] arm64: mm: free __init memory via the linear mapping
In-Reply-To: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456757084-1078-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456757084-1078-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of free_initmem_default() expects __init_begin
and __init_end to be covered by the linear mapping, which is no
longer the case. So open code it instead, using addresses that are
explicitly translated from kernel virtual to linear virtual.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a08153c99ffa..cebad6cceda8 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -416,7 +416,8 @@ void __init mem_init(void)
 
 void free_initmem(void)
 {
-	free_initmem_default(0);
+	free_reserved_area(__va(__pa(__init_begin)), __va(__pa(__init_end)),
+			   0, "unused kernel");
 	fixup_init();
 }
 
-- 
2.5.0
