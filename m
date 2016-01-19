From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Jan 2016 09:48:52 -0800
Subject: [PATCH 3/5] ARM: OMAP2+: Fix save_secure_ram_context for rodata
In-Reply-To: <1453225734-16993-1-git-send-email-tony@atomide.com>
References: <1453225734-16993-1-git-send-email-tony@atomide.com>
Message-ID: <1453225734-16993-4-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want to write to .text and we can move save_secure_ram_context
into .data as it all gets copied into SRAM anyways.

Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Nishanth Menon <menon.nishanth@gmail.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sleep34xx.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index f7c7bf8..042e4fb 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -93,8 +93,12 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
 	ldmfd	sp!, {pc}	@ restore regs and return
 ENDPROC(enable_omap3630_toggle_l2_on_restore)
 
-	.text
-/* Function to call rom code to save secure ram context */
+/*
+ * Function to call rom code to save secure ram context, This gets
+ * relocated to SRAM, so it can be all in .data section. Otherwise
+ * we need to initialize api_params separately.
+ */
+	.data
 	.align	3
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
@@ -128,6 +132,8 @@ ENDPROC(save_secure_ram_context)
 ENTRY(save_secure_ram_context_sz)
 	.word	. - save_secure_ram_context
 
+	.text
+
 /*
  * ======================
  * == Idle entry point ==
-- 
2.7.0.rc3
