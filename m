From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:24 +0100
Subject: [RFC PATCH 02/10] arm64: introduce __kimg_to_phys() and __pa_symbol()
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before restricting the domain of __pa()'s argument to the linear mapping,
introduce alternatives __kimg_to_phys() and its alias __pa_symbol() [of
which the latter exists on x86 as well] that can be used to obtain the
physical address of a static object or function in the kernel text.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 2296b32130a1..56d6739430f3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -92,7 +92,10 @@
 				 (__x - kimage_voffset); })
 
 #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET) | PAGE_OFFSET)
+
+#define __kimg_to_phys(x)	((phys_addr_t)(x) - kimage_voffset)
 #define __phys_to_kimg(x)	((unsigned long)((x) + kimage_voffset))
+#define __pa_symbol(x)		__kimg_to_phys(x)
 
 /*
  * Convert a page to/from a physical address
-- 
2.5.0
