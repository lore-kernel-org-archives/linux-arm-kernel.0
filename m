From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:31:28 +0000
Subject: [PATCH 01/17] ARM: sa11x0: convert to use DEFINE_RES_xxx macros
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOr2-0001BZ-9O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert StrongARM-11x0 platforms and core SoC code to use the
DEFINE_RES_xxx macros.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c        |   11 +---
 arch/arm/mach-sa1100/badge4.c         |   19 ++-----
 arch/arm/mach-sa1100/cerf.c           |   13 +----
 arch/arm/mach-sa1100/collie.c         |   24 ++-------
 arch/arm/mach-sa1100/generic.c        |   93 ++++++---------------------------
 arch/arm/mach-sa1100/h3xxx.c          |   13 +----
 arch/arm/mach-sa1100/hackkit.c        |    7 +--
 arch/arm/mach-sa1100/irq.c            |    7 +--
 arch/arm/mach-sa1100/jornada720.c     |   31 ++---------
 arch/arm/mach-sa1100/nanoengine.c     |   11 +---
 arch/arm/mach-sa1100/neponset.c       |   39 +++-----------
 arch/arm/mach-sa1100/pci-nanoengine.c |    8 +--
 arch/arm/mach-sa1100/pleb.c           |   24 ++-------
 arch/arm/mach-sa1100/shannon.c        |    7 +--
 arch/arm/mach-sa1100/simpad.c         |   11 +---
 15 files changed, 61 insertions(+), 257 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 0c4b76a..642f3b3 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -152,15 +152,8 @@ static struct flash_platform_data assabet_flash_data = {
 };
 
 static struct resource assabet_flash_resources[] = {
-	{
-		.start	= SA1100_CS0_PHYS,
-		.end	= SA1100_CS0_PHYS + SZ_32M - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= SA1100_CS1_PHYS,
-		.end	= SA1100_CS1_PHYS + SZ_32M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M),
+	DEFINE_RES_MEM(SA1100_CS1_PHYS, SZ_32M),
 };
 
 
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index b07a2c0..ce2dbdf 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -39,16 +39,8 @@
 #include "generic.h"
 
 static struct resource sa1111_resources[] = {
-	[0] = {
-		.start		= BADGE4_SA1111_BASE,
-		.end		= BADGE4_SA1111_BASE + 0x00001fff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= BADGE4_IRQ_GPIO_SA1111,
-		.end		= BADGE4_IRQ_GPIO_SA1111,
-		.flags		= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(BADGE4_SA1111_BASE, 0x2000),
+	[1] = DEFINE_RES_IRQ(BADGE4_IRQ_GPIO_SA1111),
 };
 
 static struct sa1111_platform_data sa1111_info = {
@@ -121,11 +113,8 @@ static struct flash_platform_data badge4_flash_data = {
 	.nr_parts	= ARRAY_SIZE(badge4_partitions),
 };
 
-static struct resource badge4_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_64M - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource badge4_flash_resource =
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_64M);
 
 static int five_v_on __initdata = 0;
 
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 11bb6d0..c2f9ba3 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -33,11 +33,7 @@
 #include "generic.h"
 
 static struct resource cerfuart2_resources[] = {
-	[0] = {
-		.start	= 0x80030000,
-		.end	= 0x8003ffff,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(0x80030000, SZ_64K),
 };
 
 static struct platform_device cerfuart2_device = {
@@ -87,11 +83,8 @@ static struct flash_platform_data cerf_flash_data = {
 	.nr_parts	= ARRAY_SIZE(cerf_partitions),
 };
 
-static struct resource cerf_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource cerf_flash_resource =
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M);
 
 static void __init cerf_init_irq(void)
 {
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index fd56521..dbe5cf7 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -48,11 +48,7 @@
 #include "generic.h"
 
 static struct resource collie_scoop_resources[] = {
-	[0] = {
-		.start		= 0x40800000,
-		.end		= 0x40800fff,
-		.flags		= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(0x40800000, SZ_4K),
 };
 
 static struct scoop_config collie_scoop_setup = {
@@ -221,16 +217,8 @@ device_initcall(collie_uart_init);
 
 
 static struct resource locomo_resources[] = {
-	[0] = {
-		.start		= 0x40000000,
-		.end		= 0x40001fff,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= IRQ_GPIO25,
-		.end		= IRQ_GPIO25,
-		.flags		= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
+	[1] = DEFINE_RES_IRQ(IRQ_GPIO25),
 };
 
 static struct locomo_platform_data locomo_info = {
@@ -303,11 +291,7 @@ static struct flash_platform_data collie_flash_data = {
 };
 
 static struct resource collie_flash_resources[] = {
-	{
-		.start	= SA1100_CS0_PHYS,
-		.end	= SA1100_CS0_PHYS + SZ_32M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M),
 };
 
 static void __init collie_init(void)
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 0e356bb..2b33b45 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -149,16 +149,8 @@ static void sa11x0_register_device(struct platform_device *dev, void *data)
 
 
 static struct resource sa11x0udc_resources[] = {
-	[0] = {
-		.start	= __PREG(Ser0UDCCR),
-		.end	= __PREG(Ser0UDCCR) + 0xffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_Ser0UDC,
-		.end	= IRQ_Ser0UDC,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(__PREG(Ser0UDCCR), SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_Ser0UDC),
 };
 
 static u64 sa11x0udc_dma_mask = 0xffffffffUL;
@@ -175,16 +167,8 @@ static struct platform_device sa11x0udc_device = {
 };
 
 static struct resource sa11x0uart1_resources[] = {
-	[0] = {
-		.start	= __PREG(Ser1UTCR0),
-		.end	= __PREG(Ser1UTCR0) + 0xffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_Ser1UART,
-		.end	= IRQ_Ser1UART,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(__PREG(Ser1UTCR0), SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_Ser1UART),
 };
 
 static struct platform_device sa11x0uart1_device = {
@@ -195,16 +179,8 @@ static struct platform_device sa11x0uart1_device = {
 };
 
 static struct resource sa11x0uart3_resources[] = {
-	[0] = {
-		.start	= __PREG(Ser3UTCR0),
-		.end	= __PREG(Ser3UTCR0) + 0xffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_Ser3UART,
-		.end	= IRQ_Ser3UART,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(__PREG(Ser3UTCR0), SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_Ser3UART),
 };
 
 static struct platform_device sa11x0uart3_device = {
@@ -215,16 +191,8 @@ static struct platform_device sa11x0uart3_device = {
 };
 
 static struct resource sa11x0mcp_resources[] = {
-	[0] = {
-		.start	= __PREG(Ser4MCCR0),
-		.end	= __PREG(Ser4MCCR0) + 0xffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_Ser4MCP,
-		.end	= IRQ_Ser4MCP,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(__PREG(Ser4MCCR0), SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_Ser4MCP),
 };
 
 static u64 sa11x0mcp_dma_mask = 0xffffffffUL;
@@ -246,16 +214,8 @@ void sa11x0_register_mcp(struct mcp_plat_data *data)
 }
 
 static struct resource sa11x0ssp_resources[] = {
-	[0] = {
-		.start	= 0x80070000,
-		.end	= 0x8007ffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_Ser4SSP,
-		.end	= IRQ_Ser4SSP,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(0x80070000, SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_Ser4SSP),
 };
 
 static u64 sa11x0ssp_dma_mask = 0xffffffffUL;
@@ -272,16 +232,8 @@ static struct platform_device sa11x0ssp_device = {
 };
 
 static struct resource sa11x0fb_resources[] = {
-	[0] = {
-		.start	= 0xb0100000,
-		.end	= 0xb010ffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_LCD,
-		.end	= IRQ_LCD,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(0xb0100000, SZ_64K),
+	[1] = DEFINE_RES_IRQ(IRQ_LCD),
 };
 
 static struct platform_device sa11x0fb_device = {
@@ -314,23 +266,10 @@ void sa11x0_register_mtd(struct flash_platform_data *flash,
 }
 
 static struct resource sa11x0ir_resources[] = {
-	{
-		.start	= __PREG(Ser2UTCR0),
-		.end	= __PREG(Ser2UTCR0) + 0x24 - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= __PREG(Ser2HSCR0),
-		.end	= __PREG(Ser2HSCR0) + 0x1c - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= __PREG(Ser2HSCR2),
-		.end	= __PREG(Ser2HSCR2) + 0x04 - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_Ser2ICP,
-		.end	= IRQ_Ser2ICP,
-		.flags	= IORESOURCE_IRQ,
-	}
+	DEFINE_RES_MEM(__PREG(Ser2UTCR0), 0x24),
+	DEFINE_RES_MEM(__PREG(Ser2HSCR0), 0x1c),
+	DEFINE_RES_MEM(__PREG(Ser2HSCR2), 0x04),
+	DEFINE_RES_IRQ(IRQ_Ser2ICP),
 };
 
 static struct platform_device sa11x0ir_device = {
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index b0784c9..63150e1 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -109,11 +109,8 @@ static struct flash_platform_data h3xxx_flash_data = {
 	.nr_parts	= ARRAY_SIZE(h3xxx_partitions),
 };
 
-static struct resource h3xxx_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource h3xxx_flash_resource =
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M);
 
 
 /*
@@ -186,11 +183,7 @@ static struct sa1100_port_fns h3xxx_port_fns __initdata = {
  */
 
 static struct resource egpio_resources[] = {
-	[0] = {
-		.start	= H3600_EGPIO_PHYS,
-		.end	= H3600_EGPIO_PHYS + 0x4 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(H3600_EGPIO_PHYS, 0x4),
 };
 
 static struct htc_egpio_chip egpio_chips[] = {
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 9092b3a..37d381a 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -179,11 +179,8 @@ static struct flash_platform_data hackkit_flash_data = {
 	.nr_parts	= ARRAY_SIZE(hackkit_partitions),
 };
 
-static struct resource hackkit_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource hackkit_flash_resource =
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M);
 
 static void __init hackkit_init(void)
 {
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index dfbf824..5d12a30 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -221,11 +221,8 @@ static struct irq_chip sa1100_normal_chip = {
 	.irq_set_wake	= sa1100_set_wake,
 };
 
-static struct resource irq_resource = {
-	.name	= "irqs",
-	.start	= 0x90050000,
-	.end	= 0x9005ffff,
-};
+static struct resource irq_resource =
+	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
 static struct sa1100irq_state {
 	unsigned int	saved;
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 5393b06..8512cfc 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -174,16 +174,8 @@ static struct s1d13xxxfb_pdata s1d13xxxfb_data = {
 };
 
 static struct resource s1d13xxxfb_resources[] = {
-	[0] = {
-		.start	= EPSONFBSTART,
-		.end	= EPSONFBSTART + EPSONFBLEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= EPSONREGSTART,
-		.end	= EPSONREGSTART + EPSONREGLEN - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(EPSONFBSTART, EPSONFBLEN),
+	[1] = DEFINE_RES_MEM(EPSONREGSTART, EPSONREGLEN),
 };
 
 static struct platform_device s1d13xxxfb_device = {
@@ -197,16 +189,8 @@ static struct platform_device s1d13xxxfb_device = {
 };
 
 static struct resource sa1111_resources[] = {
-	[0] = {
-		.start		= SA1111REGSTART,
-		.end		= SA1111REGSTART + SA1111REGLEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= IRQ_GPIO1,
-		.end		= IRQ_GPIO1,
-		.flags		= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(SA1111REGSTART, SA1111REGLEN),
+	[1] = DEFINE_RES_IRQ(IRQ_GPIO1),
 };
 
 static struct sa1111_platform_data sa1111_info = {
@@ -352,11 +336,8 @@ static struct flash_platform_data jornada720_flash_data = {
 	.nr_parts	= ARRAY_SIZE(jornada720_partitions),
 };
 
-static struct resource jornada720_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_32M - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource jornada720_flash_resource =
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M);
 
 static void __init jornada720_mach_init(void)
 {
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 85f6ee6..3923911 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -58,15 +58,8 @@ static struct flash_platform_data nanoengine_flash_data = {
 };
 
 static struct resource nanoengine_flash_resources[] = {
-	{
-		.start	= SA1100_CS0_PHYS,
-		.end	= SA1100_CS0_PHYS + SZ_32M - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= SA1100_CS1_PHYS,
-		.end	= SA1100_CS1_PHYS + SZ_32M - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_32M),
+	DEFINE_RES_MEM(SA1100_CS1_PHYS, SZ_32M),
 };
 
 static struct map_desc nanoengine_io_desc[] __initdata = {
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index b4fa53a..abbe859 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -213,11 +213,7 @@ static struct platform_driver neponset_device_driver = {
 };
 
 static struct resource neponset_resources[] = {
-	[0] = {
-		.start	= 0x10000000,
-		.end	= 0x17ffffff,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(0x10000000, 0x08000000),
 };
 
 static struct platform_device neponset_device = {
@@ -228,16 +224,8 @@ static struct platform_device neponset_device = {
 };
 
 static struct resource sa1111_resources[] = {
-	[0] = {
-		.start	= 0x40000000,
-		.end	= 0x40001fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_NEPONSET_SA1111,
-		.end	= IRQ_NEPONSET_SA1111,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
+	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SA1111),
 };
 
 static struct sa1111_platform_data sa1111_info = {
@@ -259,23 +247,10 @@ static struct platform_device sa1111_device = {
 };
 
 static struct resource smc91x_resources[] = {
-	[0] = {
-		.name	= "smc91x-regs",
-		.start	= SA1100_CS3_PHYS,
-		.end	= SA1100_CS3_PHYS + 0x01ffffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_NEPONSET_SMC9196,
-		.end	= IRQ_NEPONSET_SMC9196,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.name	= "smc91x-attrib",
-		.start	= SA1100_CS3_PHYS + 0x02000000,
-		.end	= SA1100_CS3_PHYS + 0x03ffffff,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS, 0x02000000, "smc91x-regs"),
+	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SMC9196),
+	[2] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS + 0x02000000,
+			0x02000000, "smc91x-attrib"),
 };
 
 static struct platform_device smc91x_device = {
diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
index 0d01ca7..41bb018 100644
--- a/arch/arm/mach-sa1100/pci-nanoengine.c
+++ b/arch/arm/mach-sa1100/pci-nanoengine.c
@@ -135,12 +135,8 @@ struct pci_bus * __init pci_nanoengine_scan_bus(int nr, struct pci_sys_data *sys
 				 &sys->resources);
 }
 
-static struct resource pci_io_ports = {
-	.name	= "PCI IO",
-	.start	= 0x400,
-	.end	= 0x7FF,
-	.flags	= IORESOURCE_IO,
-};
+static struct resource pci_io_ports =
+	DEFINE_RES_IO_NAMED(0x400, 0x400, "PCI IO");
 
 static struct resource pci_non_prefetchable_memory = {
 	.name	= "PCI non-prefetchable",
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 9307df0..ca5d33b 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -37,17 +37,9 @@
 #define IRQ_GPIO_ETH0_IRQ	IRQ_GPIO21
 
 static struct resource smc91x_resources[] = {
-	[0] = {
-		.start	= PLEB_ETH0_P,
-		.end	= PLEB_ETH0_P | 0x03ffffff,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM(PLEB_ETH0_P, 0x04000000),
 #if 0 /* Autoprobe instead, to get rising/falling edge characteristic right */
-	[1] = {
-		.start	= IRQ_GPIO_ETH0_IRQ,
-		.end	= IRQ_GPIO_ETH0_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[1] = DEFINE_RES_IRQ(IRQ_GPIO_ETH0_IRQ),
 #endif
 };
 
@@ -70,16 +62,8 @@ static struct platform_device *devices[] __initdata = {
  * the two SA1100 lowest chip select outputs.
  */
 static struct resource pleb_flash_resources[] = {
-	[0] = {
-		.start = SA1100_CS0_PHYS,
-		.end   = SA1100_CS0_PHYS + SZ_8M - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = SA1100_CS1_PHYS,
-		.end   = SA1100_CS1_PHYS + SZ_8M - 1,
-		.flags = IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_8M),
+	[1] = DEFINE_RES_MEM(SA1100_CS1_PHYS, SZ_8M),
 };
 
 
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 318b2b7..5fd6156 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -46,11 +46,8 @@ static struct flash_platform_data shannon_flash_data = {
 	.nr_parts	= ARRAY_SIZE(shannon_partitions),
 };
 
-static struct resource shannon_flash_resource = {
-	.start		= SA1100_CS0_PHYS,
-	.end		= SA1100_CS0_PHYS + SZ_4M - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource shannon_flash_resource =
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_4M);
 
 static struct mcp_plat_data shannon_mcp_data = {
 	.mccr0		= MCCR0_ADM,
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index e17c04d..cdb9d19 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -176,15 +176,8 @@ static struct flash_platform_data simpad_flash_data = {
 
 
 static struct resource simpad_flash_resources [] = {
-	{
-		.start     = SA1100_CS0_PHYS,
-		.end       = SA1100_CS0_PHYS + SZ_16M -1,
-		.flags     = IORESOURCE_MEM,
-	}, {
-		.start     = SA1100_CS1_PHYS,
-		.end       = SA1100_CS1_PHYS + SZ_16M -1,
-		.flags     = IORESOURCE_MEM,
-	}
+	DEFINE_RES_MEM(SA1100_CS0_PHYS, SZ_16M),
+	DEFINE_RES_MEM(SA1100_CS1_PHYS, SZ_16M),
 };
 
 static struct mcp_plat_data simpad_mcp_data = {
-- 
1.7.4.4
