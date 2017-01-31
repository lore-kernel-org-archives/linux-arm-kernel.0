From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Tue, 31 Jan 2017 18:36:29 +0530
Subject: [PATCH v3 2/3] ARM: nommu: display vectors base
In-Reply-To: <20170131130446.5829-1-afzal.mohd.ma@gmail.com>
References: <20170131130446.5829-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170131130629.5989-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VECTORS_BASE displays the exception base address. Now on no-MMU as
the exception base address is dynamically estimated, define
VECTORS_BASE to the variable holding it.

As it is the case, limit VECTORS_BASE constant definition to MMU.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

v3:
 Simplify by defining VECTORS_BASE to vectors_base
v2:
 A change to accomodate bisectability resolution on patch 1/4

 arch/arm/include/asm/memory.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 0b5416fe7709..780549a78937 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -83,8 +83,15 @@
 #define IOREMAP_MAX_ORDER	24
 #endif
 
+#define VECTORS_BASE		UL(0xffff0000)
+
 #else /* CONFIG_MMU */
 
+#ifndef __ASSEMBLY__
+extern unsigned long vectors_base;
+#define VECTORS_BASE		vectors_base
+#endif
+
 /*
  * The limitation of user task size can grow up to the end of free ram region.
  * It is difficult to define and perhaps will never meet the original meaning
@@ -111,8 +118,6 @@
 
 #endif /* !CONFIG_MMU */
 
-#define VECTORS_BASE		UL(0xffff0000)
-
 /*
  * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
  * locations
-- 
2.11.0
