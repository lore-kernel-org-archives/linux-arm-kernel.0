From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 13:33:45 -0700
Subject: [PATCH 01/11] omap2/3/4: Fix multi.h when omap3 and omap4 are
	selected without omap2
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Message-ID: <20100430203345.25812.27528.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we'll get an error about get_irqnr_and_base being defined
twice. Add an entry for omap4, and use ARCH_OMAP3 for omap3 instead of
ARCH_OMAP3430.

Also fix the check for omap1 to use ARCH_OMAP2PLUS to avoid having to
add ARCH_OMAP4 separately there.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/multi.h |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
index f235d32..ffd909f 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -61,9 +61,9 @@
 #  define OMAP_NAME omap16xx
 # endif
 #endif
-#if (defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
+#ifdef CONFIG_ARCH_OMAP2PLUS
 # if (defined(OMAP_NAME) || defined(MULTI_OMAP1))
-#  error "OMAP1 and OMAP2 can't be selected at the same time"
+#  error "OMAP1 and OMAP2PLUS can't be selected at the same time"
 # endif
 #endif
 #ifdef CONFIG_ARCH_OMAP2420
@@ -82,12 +82,20 @@
 #  define OMAP_NAME omap2430
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP3430
+#ifdef CONFIG_ARCH_OMAP3
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
 #  define MULTI_OMAP2
 # else
-#  define OMAP_NAME omap3430
+#  define OMAP_NAME omap3
+# endif
+#endif
+#ifdef CONFIG_ARCH_OMAP4
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME omap4
 # endif
 #endif
 
