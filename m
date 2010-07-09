From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 12:41:36 +0100
Subject: [PATCH v2 3/3] ARM: Add barriers to the I/O accessors if
	ARM_DMA_MEM_BUFFERABLE
In-Reply-To: <20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <1278675696.11895.37.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 12:08 +0100, Catalin Marinas wrote:
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 97fb9aa..8f3edef 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -191,6 +191,15 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>  #define writel_relaxed(v,c)    __raw_writel((__force u32) \
>                                         cpu_to_le32(v),__mem_pci(c))
> 
> +#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
> +#define readb(c)               ({ u8  __v = readb_relaxed(c); rmb(); __v; })
> +#define readw(c)               ({ u16 __v = readw_relaxed(c); rmb(); __v; })
> +#define readl(c)               ({ u32 __v = readl_relaxed(c); rmb(); __v; })
> +
> +#define writeb(v,c)            do { wmb(); writeb_relaxed(v,c); } while (0)
> +#define writew(v,c)            do { wmb(); writew_relaxed(v,c); } while (0)
> +#define writel(v,c)            do { wmb(); writel_relaxed(v,c); } while (0)

This part requires a small change. It looks like the e1000e driver
doesn't like the do {...} while (0) constructs in the write*() accessors
(the E1000_WRITE_REG_ARRAY macro). Thanks to Giuseppe for finding this.


diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 8f3edef..b572986 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -196,9 +196,9 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define readw(c)		({ u16 __v = readw_relaxed(c); rmb(); __v; })
 #define readl(c)		({ u32 __v = readl_relaxed(c); rmb(); __v; })
 
-#define writeb(v,c)		do { wmb(); writeb_relaxed(v,c); } while (0)
-#define writew(v,c)		do { wmb(); writew_relaxed(v,c); } while (0)
-#define writel(v,c)		do { wmb(); writel_relaxed(v,c); } while (0)
+#define writeb(v,c)		({ wmb(); writeb_relaxed(v,c); })
+#define writew(v,c)		({ wmb(); writew_relaxed(v,c); })
+#define writel(v,c)		({ wmb(); writel_relaxed(v,c); })
 #else
 #define readb(c)		readb_relaxed(c)
 #define readw(c)		readw_relaxed(c)


-- 
Catalin
