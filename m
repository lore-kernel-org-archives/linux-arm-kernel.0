From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 4 Jun 2010 15:51:14 +0800
Subject: [PATCH RFC] Make ISA_DMA_THRESHOLD and MAX_DMA_ADDRESS variables
Message-ID: <AANLkTinOh3iHS4JnKBYiQedufAdVEfJ5R_vSmntA4gJa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 969bc4d4aa226f4d44aa5f5f87b37c75972a9020
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Thu Jun 3 22:58:20 2010 +0800

    [ARM] Make ISA_DMA_THRESHOLD and MAX_DMA_ADDRESS variables

    This differs between SoCs and can be made as variables by encoding the
    DMA-able size into machine_desc, and initializing early.

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/include/asm/dma-mapping.h
b/arch/arm/include/asm/dma-mapping.h
index 69ce072..9273cde 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -10,6 +10,19 @@
 #include <asm/memory.h>

 /*
+ * The DMA mask corresponding to the maximum bus address allocatable
+ * using GFP_DMA.  The default here places no restriction on DMA
+ * allocations.  This must be the smallest DMA mask in the system,
+ * so a successful GFP_DMA allocation will always satisfy this.
+ */
+extern unsigned long ISA_DMA_THRESHOLD;
+
+/*
+ * set_isa_dma_size() initializes both ISA_DMA_THRESHOLD and MAX_DMA_ADDRESS
+ */
+void __init set_isa_dma_size(unsigned long);
+
+/*
  * page_to_dma/dma_to_virt/virt_to_dma are architecture private functions
  * used internally by the DMA-mapping API to provide DMA addresses. They
  * must not be used by drivers.
diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index ca51143..76e21ac 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -6,9 +6,7 @@
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
-#ifndef MAX_DMA_ADDRESS
-#define MAX_DMA_ADDRESS	0xffffffff
-#endif
+extern unsigned long MAX_DMA_ADDRESS;

 #ifdef CONFIG_ISA_DMA_API
 /*
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..67f54c1 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -23,6 +23,7 @@ struct machine_desc {
 	unsigned int		phys_io;	/* start of physical io	*/
 	unsigned int		io_pg_offst;	/* byte offset for io
 						 * page tabe entry	*/
+	unsigned long		isa_dma_size;

 	const char		*name;		/* architecture name	*/
 	unsigned long		boot_params;	/* tagged list		*/
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index fb18aff..e7570bf 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -153,16 +153,6 @@ extern unsigned long phys_offset;
 #define PHYS_OFFSET	phys_offset
 #endif

-/*
- * The DMA mask corresponding to the maximum bus address allocatable
- * using GFP_DMA.  The default here places no restriction on DMA
- * allocations.  This must be the smallest DMA mask in the system,
- * so a successful GFP_DMA allocation will always satisfy this.
- */
-#ifndef ISA_DMA_THRESHOLD
-#define ISA_DMA_THRESHOLD	(0xffffffffULL)
-#endif
-
 #ifndef arch_adjust_zones
 #define arch_adjust_zones(node,size,holes) do { } while (0)
 #elif !defined(CONFIG_ZONE_DMA)
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fc5ce30..660b40c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/smp.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
+#include <linux/dma-mapping.h>

 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -386,6 +387,9 @@ static struct machine_desc * __init
setup_machine(unsigned int nr)
 		while (1);
 	}

+	if (list->isa_dma_size)
+		set_isa_dma_size(list->isa_dma_size);
+
 	printk("Machine: %s\n", list->name);

 	return list;
diff --git a/arch/arm/mach-davinci/board-da830-evm.c
b/arch/arm/mach-davinci/board-da830-evm.c
index 212d970..5b0da02 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -570,6 +570,7 @@ MACHINE_START(DAVINCI_DA830_EVM, "DaVinci
DA830/OMAP-L137 EVM")
 	.phys_io	= IO_PHYS,
 	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.isa_dma_size	= SZ_128M,
 	.map_io		= da830_evm_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c
b/arch/arm/mach-davinci/board-da850-evm.c
index 2ec3095..1d7430e 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -762,6 +762,7 @@ MACHINE_START(DAVINCI_DA850_EVM, "DaVinci
DA850/OMAP-L138 EVM")
 	.phys_io	= IO_PHYS,
 	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.isa_dma_size	= SZ_128M,
 	.map_io		= da850_evm_map_io,
 	.init_irq	= cp_intc_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c
b/arch/arm/mach-davinci/board-dm355-evm.c
index a319101..5b4dbd4 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -354,6 +354,7 @@ MACHINE_START(DAVINCI_DM355_EVM, "DaVinci DM355 EVM")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
+	.isa_dma_size = SZ_128M,
 	.map_io	      = dm355_evm_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c
b/arch/arm/mach-davinci/board-dm355-leopard.c
index f1d8132..4b2b632 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -273,6 +273,7 @@ MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
+	.isa_dma_size = SZ_128M,
 	.map_io	      = dm355_leopard_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c
b/arch/arm/mach-davinci/board-dm365-evm.c
index 84acef1..702c9e2 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -616,6 +616,7 @@ MACHINE_START(DAVINCI_DM365_EVM, "DaVinci DM365 EVM")
 	.phys_io	= IO_PHYS,
 	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (0x80000100),
+	.isa_dma_size	= SZ_128M,
 	.map_io		= dm365_evm_map_io,
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
b/arch/arm/mach-davinci/board-dm644x-evm.c
index 34c8b41..cbfc4ee 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -709,6 +709,7 @@ MACHINE_START(DAVINCI_EVM, "DaVinci DM644x EVM")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (DAVINCI_DDR_BASE + 0x100),
+	.isa_dma_size = SZ_128M,
 	.map_io	      = davinci_evm_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c
b/arch/arm/mach-davinci/board-dm646x-evm.c
index 6d88893..252ddad 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -754,6 +754,7 @@ MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
+	.isa_dma_size = SZ_128M,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
@@ -764,6 +765,7 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (0x80000100),
+	.isa_dma_size = SZ_128M,
 	.map_io       = davinci_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer        = &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c
b/arch/arm/mach-davinci/board-neuros-osd2.c
index 4c30e92..b788927 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -278,6 +278,7 @@ MACHINE_START(NEUROS_OSD2, "Neuros OSD2")
 	.phys_io	= IO_PHYS,
 	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params	= (DAVINCI_DDR_BASE + 0x100),
+	.isa_dma_size	= SZ_128M,
 	.map_io		 = davinci_ntosd2_map_io,
 	.init_irq	= davinci_irq_init,
 	.timer		= &davinci_timer,
diff --git a/arch/arm/mach-davinci/board-sffsdr.c
b/arch/arm/mach-davinci/board-sffsdr.c
index 23e664a..d02e0c8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -157,6 +157,7 @@ MACHINE_START(SFFSDR, "Lyrtech SFFSDR")
 	.phys_io      = IO_PHYS,
 	.io_pg_offst  = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
 	.boot_params  = (DAVINCI_DDR_BASE + 0x100),
+	.isa_dma_size = SZ_128M,
 	.map_io	      = davinci_sffsdr_map_io,
 	.init_irq     = davinci_irq_init,
 	.timer	      = &davinci_timer,
diff --git a/arch/arm/mach-davinci/include/mach/memory.h
b/arch/arm/mach-davinci/include/mach/memory.h
index a91edfb..e08eaf2 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -62,9 +62,6 @@ __arch_adjust_zones(int node, unsigned long *size,
unsigned long *holes)
 #define arch_adjust_zones(node, zone_size, holes) \
         if ((meminfo.bank[0].size >> 20) > 128)
__arch_adjust_zones(node, zone_size, holes)

-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + (128<<20) - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + (128<<20))
-
 #endif

 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-h720x/h7201-eval.c b/arch/arm/mach-h720x/h7201-eval.c
index 78be457..abafa2b 100644
--- a/arch/arm/mach-h720x/h7201-eval.c
+++ b/arch/arm/mach-h720x/h7201-eval.c
@@ -33,6 +33,7 @@ MACHINE_START(H7201, "Hynix GMS30C7201")
 	.phys_io	= 0x80000000,
 	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0001000,
+	.isa_dma_size	= SZ_256M,
 	.map_io		= h720x_map_io,
 	.init_irq	= h720x_init_irq,
 	.timer		= &h7201_timer,
diff --git a/arch/arm/mach-h720x/h7202-eval.c b/arch/arm/mach-h720x/h7202-eval.c
index 8c0ba99..f947b06 100644
--- a/arch/arm/mach-h720x/h7202-eval.c
+++ b/arch/arm/mach-h720x/h7202-eval.c
@@ -75,6 +75,7 @@ MACHINE_START(H7202, "Hynix HMS30C7202")
 	.phys_io	= 0x80000000,
 	.io_pg_offst	= ((0xf0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x40000100,
+	.isa_dma_size	= SZ_256M,
 	.map_io		= h720x_map_io,
 	.init_irq	= h7202_init_irq,
 	.timer		= &h7202_timer,
diff --git a/arch/arm/mach-h720x/include/mach/memory.h
b/arch/arm/mach-h720x/include/mach/memory.h
index ef4c1e2..83a2fa0 100644
--- a/arch/arm/mach-h720x/include/mach/memory.h
+++ b/arch/arm/mach-h720x/include/mach/memory.h
@@ -8,12 +8,5 @@
 #define __ASM_ARCH_MEMORY_H

 #define PHYS_OFFSET	UL(0x40000000)
-/*
- * This is the maximum DMA address that can be DMAd to.
- * There should not be more than (0xd0000000 - 0xc0000000)
- * bytes of RAM.
- */
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)

 #endif
diff --git a/arch/arm/mach-ixp4xx/avila-setup.c
b/arch/arm/mach-ixp4xx/avila-setup.c
index d8bc86d..776fd9f 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -170,6 +170,7 @@ MACHINE_START(AVILA, "Gateworks Avila Network Platform")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= avila_init,
 MACHINE_END

@@ -187,6 +188,7 @@ MACHINE_START(LOFT, "Giant Shoulder Inc Loft board")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= avila_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c
b/arch/arm/mach-ixp4xx/coyote-setup.c
index 31a47f6..111e40b 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -115,6 +115,7 @@ MACHINE_START(ADI_COYOTE, "ADI Engineering Coyote")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= coyote_init,
 MACHINE_END
 #endif
@@ -132,6 +133,7 @@ MACHINE_START(IXDPG425, "Intel IXDPG425")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= coyote_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c
b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 7c1fa54..1ef65d1 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -282,6 +282,7 @@ MACHINE_START(DSMG600, "D-Link DSM-G600 RevA")
 	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
 	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &dsmg600_timer,
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index e7f4bef..4a80c4d 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -276,6 +276,7 @@ MACHINE_START(FSG, "Freecom FSG-3")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= fsg_init,
 MACHINE_END

diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c
b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 2583b2a..fc70112 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -102,6 +102,7 @@ MACHINE_START(GATEWAY7001, "Gateway 7001 AP")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= gateway7001_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c
b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 1c28048..dc33279 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -502,5 +502,6 @@ MACHINE_START(GORAMO_MLR, "MultiLink")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= gmlr_init,
 MACHINE_END
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index c67586b..ea2b547 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -170,6 +170,7 @@ MACHINE_START(GTWX5715, "Gemtek GTWX5715 (Linksys WRV54G)")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= gtwx5715_init,
 MACHINE_END

diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h
b/arch/arm/mach-ixp4xx/include/mach/memory.h
index 98f5e5e..cca6492 100644
--- a/arch/arm/mach-ixp4xx/include/mach/memory.h
+++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
@@ -21,9 +21,6 @@ void ixp4xx_adjust_zones(int node, unsigned long
*size, unsigned long *holes);
 #define arch_adjust_zones(node, size, holes) \
 	ixp4xx_adjust_zones(node, size, holes)

-#define ISA_DMA_THRESHOLD (SZ_64M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_64M)
-
 #endif

 #endif
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c
b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 827cbc4..567ed0e 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -262,6 +262,7 @@ MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= ixdp425_init,
 MACHINE_END
 #endif
@@ -275,6 +276,7 @@ MACHINE_START(IXDP465, "Intel IXDP465 Development Platform")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= ixdp425_init,
 MACHINE_END
 #endif
@@ -288,6 +290,7 @@ MACHINE_START(IXCDP1100, "Intel IXCDP1100
Development Platform")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= ixdp425_init,
 MACHINE_END
 #endif
@@ -301,6 +304,7 @@ MACHINE_START(KIXRP435, "Intel KIXRP435 Reference Platform")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= ixdp425_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c
b/arch/arm/mach-ixp4xx/nas100d-setup.c
index e3ee880..ab3ab60 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -317,6 +317,7 @@ MACHINE_START(NAS100D, "Iomega NAS 100d")
 	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
 	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c
b/arch/arm/mach-ixp4xx/nslu2-setup.c
index c14e003..cbc6536 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -303,6 +303,7 @@ MACHINE_START(NSLU2, "Linksys NSLU2")
 	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
 	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
 	.boot_params	= 0x00000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= ixp4xx_map_io,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &nslu2_timer,
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c
b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index 4dd7486..b8d2d28 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -103,6 +103,7 @@ MACHINE_START(WG302V2, "Netgear WG302 v2 / WAG302 v2")
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.boot_params	= 0x0100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= wg302v2_init,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index f3b5ace..f7e693d 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -353,4 +353,5 @@ MACHINE_START(BALLOON3, "Balloon3")
 	.timer		= &pxa_timer,
 	.init_machine	= balloon3_init,
 	.boot_params	= PHYS_OFFSET + 0x100,
+	.isa_dma_size	= SZ_64M,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bff6e78..932f593 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -511,6 +511,7 @@ static void __init cmx2xx_map_io(void)

 MACHINE_START(ARMCORE, "Compulab CM-X2XX")
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= cmx2xx_map_io,
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index fdda6be..65c04bd 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -779,6 +779,7 @@ static void __init cm_x300_fixup(struct
machine_desc *mdesc, struct tag *tags,
 MACHINE_START(CM_X300, "CM-X300 module")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c
b/arch/arm/mach-pxa/colibri-pxa270.c
index 061c453..634561d 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -140,6 +140,7 @@ MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= colibri_pxa270_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
b/arch/arm/mach-pxa/colibri-pxa300.c
index 45c23fd..571919f 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -188,6 +188,7 @@ MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= colibri_pxa300_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c
b/arch/arm/mach-pxa/colibri-pxa320.c
index ae835fa..a67d0b4 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -218,6 +218,7 @@ MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= colibri_pxa320_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 91fd4fe..769aadc 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -274,6 +274,7 @@ static void __init csb726_init(void)
 MACHINE_START(CSB726, "Cogent CSB726")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io         = pxa_map_io,
 	.init_irq       = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/e330.c b/arch/arm/mach-pxa/e330.c
index 8fde338..d131863 100644
--- a/arch/arm/mach-pxa/e330.c
+++ b/arch/arm/mach-pxa/e330.c
@@ -69,6 +69,7 @@ MACHINE_START(E330, "Toshiba e330")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/e350.c b/arch/arm/mach-pxa/e350.c
index f50f055..ff8ea6f 100644
--- a/arch/arm/mach-pxa/e350.c
+++ b/arch/arm/mach-pxa/e350.c
@@ -70,6 +70,7 @@ MACHINE_START(E350, "Toshiba e350")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/e400.c b/arch/arm/mach-pxa/e400.c
index 55b950f..20152d1 100644
--- a/arch/arm/mach-pxa/e400.c
+++ b/arch/arm/mach-pxa/e400.c
@@ -146,6 +146,7 @@ MACHINE_START(E400, "Toshiba e400")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/e740.c b/arch/arm/mach-pxa/e740.c
index d578021..6be1175 100644
--- a/arch/arm/mach-pxa/e740.c
+++ b/arch/arm/mach-pxa/e740.c
@@ -216,6 +216,7 @@ MACHINE_START(E740, "Toshiba e740")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
index af83caa..cfa6ed6 100644
--- a/arch/arm/mach-pxa/e750.c
+++ b/arch/arm/mach-pxa/e750.c
@@ -217,6 +217,7 @@ MACHINE_START(E750, "Toshiba e750")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/e800.c b/arch/arm/mach-pxa/e800.c
index 8ea97bf..e6ceeb2 100644
--- a/arch/arm/mach-pxa/e800.c
+++ b/arch/arm/mach-pxa/e800.c
@@ -220,6 +220,7 @@ MACHINE_START(E800, "Toshiba e800")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 0517c17..8ff6e18 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1301,6 +1301,7 @@ static void __init em_x270_init(void)

 MACHINE_START(EM_X270, "Compulab EM-X270")
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
@@ -1311,6 +1312,7 @@ MACHINE_END

 MACHINE_START(EXEDA, "Compulab eXeda")
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 96c3451..101c2d3 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -226,6 +226,7 @@ static void __init gumstix_init(void)
 MACHINE_START(GUMSTIX, "Gumstix")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100, /* match u-boot bi_boot_params */
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 848c861..2a3e5ec 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -873,6 +873,7 @@ MACHINE_START(H4700, "HP iPAQ HX4700")
 	.phys_io      = 0x40000000,
 	.io_pg_offst  = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params  = 0xa0000100,
+	.isa_dma_size = SZ_64M,
 	.map_io       = pxa_map_io,
 	.init_irq     = pxa27x_init_irq,
 	.init_machine = hx4700_init,
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 5ccb0ce..6dc7ff0 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -193,6 +193,7 @@ static void __init icontrol_init(void)
 MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/imote2.c b/arch/arm/mach-pxa/imote2.c
index 5161dca..3f9ab27 100644
--- a/arch/arm/mach-pxa/imote2.c
+++ b/arch/arm/mach-pxa/imote2.c
@@ -587,4 +587,5 @@ MACHINE_START(INTELMOTE2, "IMOTE 2")
 	.timer		= &pxa_timer,
 	.init_machine	= imote2_init,
 	.boot_params	= 0xA0000100,
+	.isa_dma_size	= SZ_64M,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/include/mach/memory.h
b/arch/arm/mach-pxa/include/mach/memory.h
index f626730..23e4ae9 100644
--- a/arch/arm/mach-pxa/include/mach/memory.h
+++ b/arch/arm/mach-pxa/include/mach/memory.h
@@ -35,9 +35,6 @@ void cmx2xx_pci_adjust_zones(int node, unsigned long *size,

 #define arch_adjust_zones(node, size, holes) \
 	cmx2xx_pci_adjust_zones(node, size, holes)
-
-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_64M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_64M)
 #endif

 #endif
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 9b90461..5b3c62a 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -439,6 +439,7 @@ static void __init littleton_init(void)
 MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform
(aka Littleton)")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index d279507..01a4d29 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -508,6 +508,7 @@ MACHINE_START(LOGICPD_PXA270, "LogicPD PXA270 Card Engine")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= lpd270_map_io,
 	.init_irq	= lpd270_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 5543c64..9a2e512 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -626,6 +626,7 @@ MACHINE_START(MAINSTONE, "Intel HCDDBBVA0
Development Platform (aka Mainstone)")
 	/* Maintainer: MontaVista Software Inc. */
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,	/* BLOB boot parameter setting */
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= mainstone_map_io,
 	.init_irq	= mainstone_init_irq,
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index d60db87..e0614b1 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -818,6 +818,7 @@ MACHINE_START(MIOA701, "MIO A701")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= &pxa_map_io,
 	.init_irq	= &pxa27x_init_irq,
 	.init_machine	= mioa701_machine_init,
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 6d45039..3109bec 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -94,6 +94,7 @@ static void __init mp900c_init(void)
 MACHINE_START(NEC_MP900, "MobilePro900/C")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0220100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.timer		= &pxa_timer,
 	.map_io		= pxa_map_io,
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 1963819..03b0a5b 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -530,6 +530,7 @@ MACHINE_START(PALMLD, "Palm LifeDrive")
 	.phys_io	= PALMLD_PHYS_IO_START,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= palmld_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 5305a39..419db0e 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -420,6 +420,7 @@ MACHINE_START(PALMT5, "Palm Tungsten|T5")
 	.phys_io	= PALMT5_PHYS_IO_START,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 3d284ff..bd66b91 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -372,6 +372,7 @@ MACHINE_START(PALMTE2, "Palm Tungsten|E2")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index ecc1a40..cf94dbd 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -571,6 +571,7 @@ MACHINE_START(PALMTX, "Palm T|X")
 	.phys_io	= PALMTX_PHYS_IO_START,
 	.io_pg_offst	= io_p2v(0x40000000),
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= palmtx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 3a7925c..6a448e9 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -492,6 +492,7 @@ MACHINE_START(PALMZ72, "Palm Zire72")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= io_p2v(0x40000000),
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 2190af0..631361f 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -259,6 +259,7 @@ static void __init pcm027_map_io(void)
 MACHINE_START(PCM027, "Phytec Messtechnik GmbH phyCORE-PXA270")
 	/* Maintainer: Pengutronix */
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pcm027_map_io,
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d4b61b3..eae2587 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -1073,6 +1073,7 @@ MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= raumfeld_controller_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
@@ -1085,6 +1086,7 @@ MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= raumfeld_connector_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
@@ -1097,6 +1099,7 @@ MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= raumfeld_speaker_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 6968911..dff2671 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -562,6 +562,7 @@ MACHINE_START(TRIZEPS4, "Keith und Koep Trizeps IV module")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= TRIZEPS4_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -573,6 +574,7 @@ MACHINE_START(TRIZEPS4WL, "Keith und Koep Trizeps
IV-WL module")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= TRIZEPS4_SDRAM_BASE + 0x100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index e90114a..550dc53 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -995,6 +995,7 @@ MACHINE_START(VIPER, "Arcom/Eurotech VIPER SBC")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= viper_map_io,
 	.init_irq	= viper_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 9884fa9..5fc7700 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -608,6 +608,7 @@ MACHINE_START(VPAC270, "Voipac PXA270")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index d3b4e3f..113382f 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -184,6 +184,7 @@ MACHINE_START(XCEP, "Iskratel XCEP")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.init_machine	= xcep_init,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index f5d1ae3..9d7c2e4 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -601,6 +601,7 @@ static void __init z2_init(void)
 MACHINE_START(ZIPIT2, "Zipit Z2")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 03b9cb9..6acd425 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -903,6 +903,7 @@ MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= ((io_p2v(0x40000000) >> 18) & 0xfffc),
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.map_io		= zeus_map_io,
 	.init_irq	= zeus_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index c479cbe..d9419ff 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -413,6 +413,7 @@ static void __init zylonite_init(void)
 MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
+	.isa_dma_size	= SZ_64M,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-realview/include/mach/memory.h
b/arch/arm/mach-realview/include/mach/memory.h
index 2417bbc..6f0dcae 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -35,8 +35,6 @@ extern void realview_adjust_zones(int node, unsigned
long *size,
 #define arch_adjust_zones(node, size, hole) \
 	realview_adjust_zones(node, size, hole)

-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)
 #endif

 #ifdef CONFIG_SPARSEMEM
diff --git a/arch/arm/mach-realview/realview_eb.c
b/arch/arm/mach-realview/realview_eb.c
index 422ccd7..88ff55f 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -460,6 +460,7 @@ MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	.phys_io	= REALVIEW_EB_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_EB_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.isa_dma_size	= SZ_256M,
 	.fixup		= realview_fixup,
 	.map_io		= realview_eb_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pb1176.c
b/arch/arm/mach-realview/realview_pb1176.c
index 96568eb..e8f197c 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -354,6 +354,7 @@ MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	.phys_io	= REALVIEW_PB1176_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB1176_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.isa_dma_size	= SZ_256M,
 	.fixup		= realview_pb1176_fixup,
 	.map_io		= realview_pb1176_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c
b/arch/arm/mach-realview/realview_pb11mp.c
index 7fbefbb..ee05e2b 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -376,6 +376,7 @@ MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	.phys_io	= REALVIEW_PB11MP_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB11MP_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.isa_dma_size	= SZ_256M,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pb11mp_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pba8.c
b/arch/arm/mach-realview/realview_pba8.c
index d3c113b..133c3fc 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -326,6 +326,7 @@ MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	.phys_io	= REALVIEW_PBA8_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBA8_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.isa_dma_size	= SZ_256M,
 	.fixup		= realview_fixup,
 	.map_io		= realview_pba8_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-realview/realview_pbx.c
b/arch/arm/mach-realview/realview_pbx.c
index a235ba3..eff8722 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -412,6 +412,7 @@ MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	.phys_io	= REALVIEW_PBX_UART0_BASE,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBX_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.isa_dma_size	= SZ_256M,
 	.fixup		= realview_pbx_fixup,
 	.map_io		= realview_pbx_map_io,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 169e5b8..a16ae38 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -450,6 +450,9 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 	.phys_io	= 0x80000000,
 	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
+#ifdef CONFIG_SA1111
+	.isa_dma_size	= SZ_1M,
+#endif
 	.fixup		= fixup_assabet,
 	.map_io		= assabet_map_io,
 	.init_irq	= sa1100_init_irq,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 259cb2c..15bd5b9 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -305,6 +305,9 @@ MACHINE_START(BADGE4, "Hewlett-Packard
Laboratories BadgePAD 4")
 	.phys_io	= 0x80000000,
 	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
+#ifdef CONFIG_SA1111
+	.isa_dma_size	= SZ_1M,
+#endif
 	.map_io		= badge4_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h
b/arch/arm/mach-sa1100/include/mach/memory.h
index d5277f9..95558b4 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -22,9 +22,6 @@ void sa1111_adjust_zones(int node, unsigned long
*size, unsigned long *holes);
 #define arch_adjust_zones(node, size, holes) \
 	sa1111_adjust_zones(node, size, holes)

-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_1M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_1M)
-
 #endif
 #endif

diff --git a/arch/arm/mach-sa1100/jornada720.c
b/arch/arm/mach-sa1100/jornada720.c
index d3ec620..829bd1e 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -367,6 +367,9 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 	.phys_io	= 0x80000000,
 	.io_pg_offst	= ((0xf8000000) >> 18) & 0xfffc,
 	.boot_params	= 0xc0000100,
+#ifdef CONFIG_SA1111
+	.isa_dma_size	= SZ_1M,
+#endif
 	.map_io		= jornada720_map_io,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index 358d875..7fc348c 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -155,6 +155,7 @@ MACHINE_START(SHARK, "Shark")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= ((0xe0000000) >> 18) & 0xfffc,
 	.boot_params	= 0x08003000,
+	.isa_dma_size	= SZ_4M,
 	.map_io		= shark_map_io,
 	.init_irq	= shark_init_irq,
 	.timer		= &shark_timer,
diff --git a/arch/arm/mach-shark/include/mach/memory.h
b/arch/arm/mach-shark/include/mach/memory.h
index 3053e5b..dd690f3 100644
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ b/arch/arm/mach-shark/include/mach/memory.h
@@ -33,9 +33,6 @@ static inline void __arch_adjust_zones(int node,
unsigned long *zone_size, unsig
 #define arch_adjust_zones(node, size, holes) \
 	__arch_adjust_zones(node, size, holes)

-#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_4M - 1)
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_4M)
-
 #endif

 /*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 13fa536..e42f873 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -33,6 +33,18 @@
 #define CONSISTENT_PTE_INDEX(x) (((unsigned long)(x) -
CONSISTENT_BASE) >> PGDIR_SHIFT)
 #define NUM_CONSISTENT_PTES (CONSISTENT_DMA_SIZE >> PGDIR_SHIFT)

+unsigned long ISA_DMA_THRESHOLD = 0xffffffffUL;
+EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
+
+unsigned long MAX_DMA_ADDRESS = 0xffffffffUL;
+EXPORT_SYMBOL(MAX_DMA_ADDRESS);
+
+void __init set_isa_dma_size(unsigned long size)
+{
+	ISA_DMA_THRESHOLD = PHYS_OFFSET + size - 1;
+	MAX_DMA_ADDRESS = PAGE_OFFSET + size;
+}
+
 static u64 get_coherent_dma_mask(struct device *dev)
 {
 	u64 mask = ISA_DMA_THRESHOLD;
