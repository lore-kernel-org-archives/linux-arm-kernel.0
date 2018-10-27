From: rppt@linux.ibm.com (Mike Rapoport)
Date: Sat, 27 Oct 2018 10:13:42 +0100
Subject: [PATCH v4 1/2] arm64: Get rid of __early_init_dt_declare_initrd()
In-Reply-To: <20181026223951.30936-2-f.fainelli@gmail.com>
References: <20181026223951.30936-1-f.fainelli@gmail.com>
 <20181026223951.30936-2-f.fainelli@gmail.com>
Message-ID: <20181027091341.GB6770@rapoport-lnx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Fri, Oct 26, 2018 at 03:39:50PM -0700, Florian Fainelli wrote:
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override, just get rid of that
> implementation and perform the virtual to physical conversion of these
> addresses in arm64_memblock_init() where relevant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/include/asm/memory.h |  8 --------
>  arch/arm64/mm/init.c            | 26 ++++++++++++++++----------
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b96442960aea..dc3ca21ba240 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -168,14 +168,6 @@
>  #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
>  #endif
>  
> -#ifdef CONFIG_BLK_DEV_INITRD
> -#define __early_init_dt_declare_initrd(__start, __end)			\
> -	do {								\
> -		initrd_start = (__start);				\
> -		initrd_end = (__end);					\
> -	} while (0)
> -#endif
> -
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/bitops.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3cf87341859f..98ff0f7a0f7a 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -364,6 +364,9 @@ static void __init fdt_enforce_memory_region(void)
>  void __init arm64_memblock_init(void)
>  {
>  	const s64 linear_region_size = -(s64)PAGE_OFFSET;
> +	unsigned long __maybe_unused phys_initrd_size;
> +	u64 __maybe_unused phys_initrd_start;
> +	u64 __maybe_unused base, size;
>  
>  	/* Handle linux,usable-memory-range property */
>  	fdt_enforce_memory_region();
> @@ -414,8 +417,11 @@ void __init arm64_memblock_init(void)
>  		 * initrd to become inaccessible via the linear mapping.
>  		 * Otherwise, this is a no-op
>  		 */
> -		u64 base = initrd_start & PAGE_MASK;
> -		u64 size = PAGE_ALIGN(initrd_end) - base;
> +		phys_initrd_start = __pa(initrd_start);
> +		phys_initrd_size = __pa(initrd_end) - phys_initrd_start;

If initrd_{start,end} are defined by the command line they already would be
physical addresses.

> +
> +		base = phys_initrd_start & PAGE_MASK;
> +		size = PAGE_ALIGN(phys_initrd_size);
>  
>  		/*
>  		 * We can only add back the initrd memory if we don't end up
> @@ -459,15 +465,15 @@ void __init arm64_memblock_init(void)
>  	 * pagetables with memblock.
>  	 */
>  	memblock_reserve(__pa_symbol(_text), _end - _text);
> -#ifdef CONFIG_BLK_DEV_INITRD
> -	if (initrd_start) {
> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> -		/* the generic initrd code expects virtual addresses */
> -		initrd_start = __phys_to_virt(initrd_start);
> -		initrd_end = __phys_to_virt(initrd_end);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +		memblock_reserve(phys_initrd_start, phys_initrd_size);

this is not needed, as we do memblock_reserve() for the same area earlier.

What do you think of my version (below)?

> +		/*
> +		 * initrd_below_start_ok can be changed by
> +		 * __early_init_dt_declare_initrd(), set it back to what
> +		 * we want here.
> +		 */
> +		initrd_below_start_ok = 0;
>  	}
> -#endif
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.17.1
> 

>From 0e5661c6f1ac2d4b08a55d38c6bc224c187af14f Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sat, 27 Oct 2018 12:04:58 +0300
Subject: [PATCH] arm64: Get rid of __early_init_dt_declare_initrd()

ARM64 is the only architecture that re-defines
__early_init_dt_declare_initrd() in order for that function to populate
initrd_start/initrd_end with physical addresses instead of virtual
addresses. Instead of having an override, just get rid of that
implementation and perform the virtual to physical conversion of these
addresses in arm64_memblock_init() where relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 40 +++++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b9644296..dc3ca21 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582c..dd665be3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -61,6 +61,8 @@
 s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
+static phys_addr_t phys_initrd_start, phys_initrd_end;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
 {
@@ -71,8 +73,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		phys_initrd_start = start;
+		phys_initrd_end = start + size;
 	}
 	return 0;
 }
@@ -363,6 +365,7 @@ static void __init fdt_enforce_memory_region(void)
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+	u64 __maybe_unused base, size;
 
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
@@ -407,14 +410,23 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	    (initrd_start || phys_initrd_start)) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		if (phys_initrd_start) {
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = __phys_to_virt(phys_initrd_end);
+		} else if (initrd_start) {
+			phys_initrd_start = __pa(initrd_start);
+			phys_initrd_end = __pa(initrd_end);
+		}
+
+		base = phys_initrd_start & PAGE_MASK;
+		size = PAGE_ALIGN(phys_initrd_end - phys_initrd_start);
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -433,6 +445,13 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+
+			/*
+			 * initrd_below_start_ok can be changed by
+			 * __early_init_dt_declare_initrd(), set it back to what
+			 * we want here.
+			 */
+			initrd_below_start_ok = 0;
 		}
 	}
 
@@ -454,19 +473,10 @@ void __init arm64_memblock_init(void)
 	}
 
 	/*
-	 * Register the kernel text, kernel data, initrd, and initial
+	 * Register the kernel text, kernel data and initial
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start) {
-		memblock_reserve(initrd_start, initrd_end - initrd_start);
-
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(initrd_start);
-		initrd_end = __phys_to_virt(initrd_end);
-	}
-#endif
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.7.4

-- 
Sincerely yours,
Mike.
