From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:31 +0100
Subject: [RFC PATCH 09/10] arm64: insn: avoid __pa translations
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-10-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When taking the physical address of something that is known to be
covered by the kernel text, use __kimg_to_phys() not virt_to_phys()

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/insn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 7371455160e5..bc91e3c2cdb1 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -96,7 +96,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
 	if (module && IS_ENABLED(CONFIG_DEBUG_SET_MODULE_RONX))
 		page = vmalloc_to_page(addr);
 	else if (!module && IS_ENABLED(CONFIG_DEBUG_RODATA))
-		page = virt_to_page(addr);
+		page = phys_to_page(__kimg_to_phys(addr));
 	else
 		return addr;
 
-- 
2.5.0
