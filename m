From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 18 Feb 2014 18:47:50 -0500 (EST)
Subject: [PATCHv4 2/2] arm: Get rid of meminfo
In-Reply-To: <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
References: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
 <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <alpine.LFD.2.11.1402181755031.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Feb 2014, Laura Abbott wrote:

> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

A small comments below.

> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index 8d6a089..0196091 100644
> --- a/arch/arm/include/asm/setup.h
> +++ b/arch/arm/include/asm/setup.h
> @@ -26,29 +26,6 @@ static const struct tagtable __tagtable_##fn __tag = { tag, fn }
>   */
>  #define NR_BANKS	CONFIG_ARM_NR_BANKS

This may go as well now.  Please consider this patch as well for your 
series:

Subject: [PATCH] arm: Get rid of NR_BANKS

This constant is no longer used, except in the atag_to_fdt compatibility
layer where a local definition is now provided.  This could be removed
entirely i.e. having no limits but this is probably not worth it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e254198177..1ca42ed304 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1090,11 +1090,6 @@ source "arch/arm/firmware/Kconfig"
 
 source arch/arm/mm/Kconfig
 
-config ARM_NR_BANKS
-	int
-	default 16 if ARCH_EP93XX
-	default 8
-
 config IWMMXT
 	bool "Enable iWMMXt support" if !CPU_PJ4
 	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index d1153c8a76..9448aa0c66 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -7,6 +7,8 @@
 #define do_extend_cmdline 0
 #endif
 
+#define NR_BANKS 16
+
 static int node_offset(void *fdt, const char *node_path)
 {
 	int offset = fdt_path_offset(fdt, node_path);
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 01960916dd..e0adb9f1bf 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -21,11 +21,6 @@
 #define __tagtable(tag, fn) \
 static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 
-/*
- * Memory map description
- */
-#define NR_BANKS	CONFIG_ARM_NR_BANKS
-
 extern int arm_add_memory(u64 start, u64 size);
 extern void early_print(const char *str, ...);
 extern void dump_machine_table(void);
