From: chris.brandt@renesas.com (Chris Brandt)
Date: Mon,  1 Feb 2016 09:08:56 -0500
Subject: [PATCH v2] ARM: proc-v7.S: Adjust stack address when XIP_KERNEL
In-Reply-To: <1454105474-3009-1-git-send-email-chris.brandt@renesas.com>
References: <1454105474-3009-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <1454335736-10084-1-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nico@linaro.org>

When XIP_KERNEL is enabled, the virt to phys address translation for RAM
is not the same as the virt to phys address translation for .text.
The only way to know where physical RAM is located is to use
PLAT_PHYS_OFFSET.
The MACRO will be useful for other places where there is a similar problem.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
* Fixed Signed-off to show correct author
---
 arch/arm/include/asm/memory.h | 8 ++++++++
 arch/arm/mm/proc-v7.S         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index c79b57b..7dd2ab5 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -134,6 +134,14 @@
  */
 #define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
 
+#ifdef CONFIG_XIP_KERNEL
+#define PHYS_OFFSET_FIXUP \
+	( XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) - PAGE_OFFSET + \
+	  PLAT_PHYS_OFFSET - CONFIG_XIP_PHYS_ADDR )
+#else
+#define PHYS_OFFSET_FIXUP 0
+#endif
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0f92d57..1595fb2 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -487,7 +487,7 @@ __errata_finish:
 
 	.align	2
 __v7_setup_stack_ptr:
-	.word	__v7_setup_stack - .
+	.word	__v7_setup_stack - . + PHYS_OFFSET_FIXUP
 ENDPROC(__v7_setup)
 
 	.bss
-- 
1.9.1
