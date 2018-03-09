From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:44 +0800
Subject: [PATCH 01/39] mm: Introduce lm_alias
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-2-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <labbott@redhat.com>

commit 568c5fe5a54 upstream.

Certain architectures may have the kernel image mapped separately to
alias the linear map. Introduce a macro lm_alias to translate a kernel
image symbol into its linear alias. This is used in part with work to
add CONFIG_DEBUG_VIRTUAL support for arm64.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 55f950afb60d..648f14335a9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -59,6 +59,14 @@ extern int sysctl_legacy_va_layout;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
+#ifndef page_to_virt
+#define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
+#endif
+
+#ifndef lm_alias
+#define lm_alias(x)	__va(__pa_symbol(x))
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
-- 
2.16.2.440.gc6284da
