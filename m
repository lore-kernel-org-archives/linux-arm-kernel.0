From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Jul 2012 15:19:00 +0200
Subject: [PATCH 5/7] ARM: add early malloc support needed by the decompressor
In-Reply-To: <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120722130301.GI22657@game.jcrosoft.org>
 <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1342963142-30339-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed by lzo but by gunzip, xz and others.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/cpu/start.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/cpu/start.c b/arch/arm/cpu/start.c
index 18c5c83..8ab6fdc 100644
--- a/arch/arm/cpu/start.c
+++ b/arch/arm/cpu/start.c
@@ -28,6 +28,9 @@
 #include <asm-generic/memory_layout.h>
 #include <asm/sections.h>
 
+unsigned long free_mem_ptr;
+unsigned long free_mem_end_ptr;
+
 #ifdef CONFIG_IMAGE_COMPRESSION
 void __naked __section(.text_head_entry) compressed_start(void)
 {
@@ -158,6 +161,10 @@ void __naked __section(.text_ll_return) board_init_lowlevel_return(void)
 	/* clear bss */
 	memset(__bss_start, 0, __bss_stop - __bss_start);
 
+	/* set 128 KiB before the STACK_BASE - 16 address for early malloc */
+	free_mem_ptr = STACK_BASE - 0x20000 - 16;
+	free_mem_end_ptr = STACK_BASE - 16;
+
 	/* flush I-cache before jumping to the copied binary */
 	__asm__ __volatile__("mcr p15, 0, %0, c7, c5, 0" : : "r" (0));
 
-- 
1.7.10
