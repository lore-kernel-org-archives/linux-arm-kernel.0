From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 26 Sep 2010 13:48:36 +0800
Subject: [PATCH 1/1] ARM: mmp: update cpuid of pxa168 and pxa910
In-Reply-To: <1285058637-7490-1-git-send-email-haojian.zhuang@marvell.com>
References: <1285058637-7490-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTimZY0njDNZ_77MeWYObHk2m5=rmmtZMuX=NSNpM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 4:43 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Correct the cpuid of pxa168 and pxa910.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

I've made several modifications based on your patch, let me know if you are
OK with them:

1. public variable of mmp_chip_id to avoid reading of MMP_CHIPID everytime
2. with its complexity, move those #define to static inline functions

Patch as below:

diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index 3b29fa7..189966c 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -14,9 +14,15 @@
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <mach/addr-map.h>
+#include <mach/cputype.h>

 #include "common.h"

+#define MMP_CHIPID	(AXI_VIRT_BASE + 0x82c00)
+
+unsigned int mmp_chip_id;
+EXPORT_SYMBOL(mmp_chip_id);
+
 static struct map_desc standard_io_desc[] __initdata = {
 	{
 		.pfn		= __phys_to_pfn(APB_PHYS_BASE),
@@ -34,4 +40,7 @@ static struct map_desc standard_io_desc[] __initdata = {
 void __init mmp_map_io(void)
 {
 	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
+
+	/* this is early, initialize mmp_chip_id here */
+	mmp_chip_id = __raw_readl(MMP_CHIPID);
 }
diff --git a/arch/arm/mach-mmp/include/mach/cputype.h
b/arch/arm/mach-mmp/include/mach/cputype.h
index 83b1872..f43a68b 100644
--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -4,36 +4,51 @@
 #include <asm/cputype.h>

 /*
- *  CPU   Stepping   OLD_ID       CPU_ID      CHIP_ID
+ *  CPU   Stepping   CPU_ID      CHIP_ID
  *
- * PXA168    A0    0x41159263   0x56158400   0x00A0A333
- * PXA910    Y0    0x41159262   0x56158000   0x00F0C910
- * MMP2	     Z0			0x560f5811
+ * PXA168    S0    0x56158400   0x0000C910
+ * PXA168    A0    0x56158400   0x00A0A168
+ * PXA910    Y1    0x56158400   0x00F2C920
+ * PXA910    A0    0x56158400   0x00F2C910
+ * PXA910    A1    0x56158400   0x00A0C910
+ * PXA920    Y0    0x56158400   0x00F2C920
+ * PXA920    A0    0x56158400   0x00A0C920
+ * PXA920    A1    0x56158400   0x00A1C920
+ * MMP2	     Z0	   0x560f5811   0x00F00410
+ * MMP2      Z1    0x560f5811   0x00E00410
+ * MMP2      A0    0x560f5811   0x00A0A610
  */

+extern unsigned int mmp_chip_id;
+
 #ifdef CONFIG_CPU_PXA168
-#  define __cpu_is_pxa168(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x84; })
+static inline int cpu_is_pxa168(void)
+{
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x84) &&
+		((mmp_chip_id & 0xfff) == 0x168);
+}
 #else
-#  define __cpu_is_pxa168(id)	(0)
+#define cpu_is_pxa168()	(0)
 #endif

+/* cpu_is_pxa910() is shared on both pxa910 and pxa920 */
 #ifdef CONFIG_CPU_PXA910
-#  define __cpu_is_pxa910(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
+static inline int cpu_is_pxa910(void)
+{
+	return (((read_cpuid_id() >> 8) & 0xff) == 0x84) &&
+		(((mmp_chip_id & 0xfff) == 0x910) ||
+		 ((mmp_chip_id & 0xfff) == 0x920));
+}
 #else
-#  define __cpu_is_pxa910(id)	(0)
+#define cpu_is_pxa910()	(0)
 #endif

 #ifdef CONFIG_CPU_MMP2
-#  define __cpu_is_mmp2(id)	\
-	({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x58; })
+static inline int cpu_is_mmp2(void)
+{
+	return (((cpu_readid_id() >> 8) & 0xff) == 0x58);
 #else
-#  define __cpu_is_mmp2(id)	(0)
+#define cpu_is_mmp2()	(0)
 #endif

-#define cpu_is_pxa168()		({ __cpu_is_pxa168(read_cpuid_id()); })
-#define cpu_is_pxa910()		({ __cpu_is_pxa910(read_cpuid_id()); })
-#define cpu_is_mmp2()		({ __cpu_is_mmp2(read_cpuid_id()); })
-
 #endif /* __ASM_MACH_CPUTYPE_H */

> ---
> ?arch/arm/mach-mmp/include/mach/cputype.h | ? 45 ++++++++++++++++++-----------
> ?1 files changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/include/mach/cputype.h b/arch/arm/mach-mmp/include/mach/cputype.h
> index 83b1872..5276c70 100644
> --- a/arch/arm/mach-mmp/include/mach/cputype.h
> +++ b/arch/arm/mach-mmp/include/mach/cputype.h
> @@ -4,36 +4,47 @@
> ?#include <asm/cputype.h>
>
> ?/*
> - * ?CPU ? Stepping ? OLD_ID ? ? ? CPU_ID ? ? ?CHIP_ID
> + * ?CPU ? Stepping ? CPU_ID ? ? ?CHIP_ID
> ?*
> - * PXA168 ? ?A0 ? ?0x41159263 ? 0x56158400 ? 0x00A0A333
> - * PXA910 ? ?Y0 ? ?0x41159262 ? 0x56158000 ? 0x00F0C910
> - * MMP2 ? ? ? ? ? ? Z0 ? ? ? ? ? ? ? ? 0x560f5811
> + * PXA168 ? ?S0 ? ?0x56158400 ? 0x0000C910
> + * PXA168 ? ?A0 ? ?0x56158400 ? 0x00A0A168
> + * PXA910 ? ?Y1 ? ?0x56158400 ? 0x00F2C920
> + * PXA910 ? ?A0 ? ?0x56158400 ? 0x00F2C910
> + * PXA910 ? ?A1 ? ?0x56158400 ? 0x00A0C910
> + * PXA920 ? ?Y0 ? ?0x56158400 ? 0x00F2C920
> + * PXA920 ? ?A0 ? ?0x56158400 ? 0x00A0C920
> + * PXA920 ? ?A1 ? ?0x56158400 ? 0x00A1C920
> + * MMP2 ? ? ? ? ? ? Z0 ? ?0x560f5811 ? 0x00F00410
> + * MMP2 ? ? ?Z1 ? ?0x560f5811 ? 0x00E00410
> + * MMP2 ? ? ?A0 ? ?0x560f5811 ? 0x00A0A610
> ?*/
>
> +#define MMP_CHIPID ? ? ? ? ? ? (AXI_VIRT_BASE + 0x82c00)
> +
> ?#ifdef CONFIG_CPU_PXA168
> -# ?define __cpu_is_pxa168(id) ?\
> - ? ? ? ({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x84; })
> +#define cpu_is_pxa168() ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ({ unsigned int _id = (read_cpuid_id() >> 8) & 0xff; ? ? ? ? ? ?\
> + ? ? ? ? ?unsigned int _mmp_id = (__raw_readl(MMP_CHIPID) & 0xfff); ? ?\
> + ? ? ? ? ?_id == 0x84 && _mmp_id == 0x168; })
> ?#else
> -# ?define __cpu_is_pxa168(id) ?(0)
> +#define cpu_is_pxa168() ? ? ? ?(0)
> ?#endif
>
> +/* cpu_is_pxa910() is shared on both pxa910 and pxa920 */
> ?#ifdef CONFIG_CPU_PXA910
> -# ?define __cpu_is_pxa910(id) ?\
> - ? ? ? ({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x80; })
> +#define cpu_is_pxa910() ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ({ unsigned int _id = (read_cpuid_id() >> 8) & 0xff; ? ? ? ? ? ?\
> + ? ? ? ? ?unsigned int _mmp_id = (__raw_readl(MMP_CHIPID) & 0xfff); ? ?\
> + ? ? ? ? ?(_id == 0x84 && (_mmp_id == 0x910 || _mmp_id == 0x920)); })
> ?#else
> -# ?define __cpu_is_pxa910(id) ?(0)
> +#define cpu_is_pxa910() ? ? ? ?(0)
> ?#endif
>
> ?#ifdef CONFIG_CPU_MMP2
> -# ?define __cpu_is_mmp2(id) ? ?\
> - ? ? ? ({ unsigned int _id = ((id) >> 8) & 0xff; _id == 0x58; })
> +#define cpu_is_mmp2() ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> + ? ? ? ({ unsigned int _id = (read_cpuid_id() >> 8) & 0xff; _id == 0x58; })
> ?#else
> -# ?define __cpu_is_mmp2(id) ? ?(0)
> +#define cpu_is_mmp2() ?(0)
> ?#endif
>
> -#define cpu_is_pxa168() ? ? ? ? ? ? ? ?({ __cpu_is_pxa168(read_cpuid_id()); })
> -#define cpu_is_pxa910() ? ? ? ? ? ? ? ?({ __cpu_is_pxa910(read_cpuid_id()); })
> -#define cpu_is_mmp2() ? ? ? ? ?({ __cpu_is_mmp2(read_cpuid_id()); })
> -
> ?#endif /* __ASM_MACH_CPUTYPE_H */
> --
> 1.5.6.5
>
>
