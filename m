From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 16 Jun 2016 14:28:58 +0200
Subject: [PATCH 2/2] arm64: drop kernel segment resources from /proc/iomem
In-Reply-To: <1466080138-12193-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1466080138-12193-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1466080138-12193-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By the same reasoning as commit c4004b02f8e5 ("x86: remove the kernel
code/data/bss resources from /proc/iomem"), the kernel code and kernel
data entries in /proc/iomem probably do more harm than good on arm64 as
well. So remove them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 3279defabaa2..f3ec301653a4 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -68,27 +68,6 @@
 phys_addr_t __fdt_pointer __initdata;
 
 /*
- * Standard memory resources
- */
-static struct resource mem_res[] = {
-	{
-		.name = "Kernel code",
-		.start = 0,
-		.end = 0,
-		.flags = IORESOURCE_SYSTEM_RAM
-	},
-	{
-		.name = "Kernel data",
-		.start = 0,
-		.end = 0,
-		.flags = IORESOURCE_SYSTEM_RAM
-	}
-};
-
-#define kernel_code mem_res[0]
-#define kernel_data mem_res[1]
-
-/*
  * The recorded values of x0 .. x3 upon kernel entry.
  */
 u64 __cacheline_aligned boot_args[4];
@@ -201,11 +180,6 @@ static void __init request_standard_resources(void)
 	struct memblock_region *region;
 	struct resource *res;
 
-	kernel_code.start   = virt_to_phys(_text);
-	kernel_code.end     = virt_to_phys(_etext - 1);
-	kernel_data.start   = virt_to_phys(_sdata);
-	kernel_data.end     = virt_to_phys(_end - 1);
-
 	for_each_memblock(memory, region) {
 		res = alloc_bootmem_low(sizeof(*res));
 		res->name  = "System RAM";
@@ -214,13 +188,6 @@ static void __init request_standard_resources(void)
 		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
 		request_resource(&iomem_resource, res);
-
-		if (kernel_code.start >= res->start &&
-		    kernel_code.end <= res->end)
-			request_resource(res, &kernel_code);
-		if (kernel_data.start >= res->start &&
-		    kernel_data.end <= res->end)
-			request_resource(res, &kernel_data);
 	}
 }
 
-- 
1.9.1
