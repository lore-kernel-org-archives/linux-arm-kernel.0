From: mvs@tigris.de (Maximilian Schwerin)
Date: Mon, 17 Sep 2012 15:08:44 +0200
Subject: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
Message-ID: <1347887324-22884-1-git-send-email-mvs@tigris.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change allows preventing the message "Uncompressing Linux..." from
being sent to serial port. This is necessary if the primary serial port is
used for something other than kernel debugging (e.g. some external device
controlled by serial commands).

Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
---
 arch/arm/Kconfig.debug          |    9 +++++++++
 arch/arm/boot/compressed/misc.c |    4 ++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e968a52..96e90dc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -46,6 +46,15 @@ config OLD_MCOUNT
 	depends on FUNCTION_TRACER && FRAME_POINTER
 	default y
 
+config DEBUG_DECOMPRESS_KERNEL
+	bool "Using serial port during decompressing kernel"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  If you say Y here you will confirm the start and the end of
+	  decompressing Linux seeing "Uncompressing Linux... " and
+	  " done, booting the kernel.\n" on console.
+
 config DEBUG_USER
 	bool "Verbose user fault messages"
 	help
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 8e2a8fc..edf4a35 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -144,11 +144,15 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 
 	arch_decomp_setup();
 
+#ifdef CONFIG_DEBUG_DECOMPRESS_KERNEL
 	putstr("Uncompressing Linux...");
+#endif /* CONFIG_DEBUG_DECOMPRESS_KERNEL */
 	ret = do_decompress(input_data, input_data_end - input_data,
 			    output_data, error);
 	if (ret)
 		error("decompressor returned an error");
+#ifdef CONFIG_DEBUG_DECOMPRESS_KERNEL
 	else
 		putstr(" done, booting the kernel.\n");
+#endif /* CONFIG_DEBUG_DECOMPRESS_KERNEL */
 }
-- 
1.7.0.4
