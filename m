From: keescook@chromium.org (Kees Cook)
Date: Wed, 29 Mar 2017 11:15:58 -0700
Subject: [RFC v2][PATCH 06/11] ARM: domains: Extract common USER domain init
In-Reply-To: <1490811363-93944-1-git-send-email-keescook@chromium.org>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
Message-ID: <1490811363-93944-7-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everything but the USER domain is the same with CONFIG_CPU_SW_DOMAIN_PAN
or not. This extracts the differences for a common DACR_INIT macro so it
is easier to make future changes (like adding the WR_RARE domain).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/domain.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 99d9f630d6b6..8b33bd7f6bf9 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -59,18 +59,18 @@
 #define domain_val(dom,type)	((type) << (2 * (dom)))
 
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
-#define DACR_INIT \
-	(domain_val(DOMAIN_USER, DOMAIN_NOACCESS) | \
-	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
-	 domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
-	 domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
+#define __DACR_INIT_USER \
+	domain_val(DOMAIN_USER, DOMAIN_NOACCESS)
 #else
+#define __DACR_INIT_USER \
+	domain_val(DOMAIN_USER, DOMAIN_CLIENT)
+#endif
+
 #define DACR_INIT \
-	(domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
+	(__DACR_INIT_USER | \
 	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 	 domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
-#endif
 
 #define __DACR_DEFAULT \
 	domain_val(DOMAIN_KERNEL, DOMAIN_CLIENT) | \
-- 
2.7.4
