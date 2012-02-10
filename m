From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 Feb 2012 19:47:12 +0900
Subject: [GIT PULL] regarding PL330 driver for rmk or arm-soc, and slave-dma
Message-ID: <010601cce7e1$5850a600$08f1f200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As you know, previous regarding PL330 dma branch which is including merge of
PL330 driver into drivers/dma/ and samsung stuff update missed during last
merge window and I got the request from Olof to rebase it based on v3.3-rcX.

So I rebased it.

Russell (rmk tree) or Arnd, Olof (arm-soc), and Vinod (slave-dma tree),
please pull following into your rmk(or arm-soc) and slave-dma tree. I think
it should be sent to both for minimal conflicts.

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-for-vkoul

As a note, it will be happened conflicts with rmk's 'use common amba device
initializers' which is in arm-soc/depends/rmk/for-armsoc, you can find my
preferred resolution at below.

If any problems, please kindly let me know.

commit e6aab84006857b5f5ab989de4e3a6037bcc79b96
Merge: a5f17d1 edd7ff8
Author: Kukjin Kim <kgene.kim@samsung.com>
Date:   Fri Feb 10 19:00:47 2012 +0900

    Merge branch 'v3.4-for-vkoul' into arm-soc/depends/rmk/for-armsoc
    
    Conflicts:
    	arch/arm/mach-exynos/dma.c

diff --cc arch/arm/mach-exynos/dma.c
index 91370de,ce645ba..e3dc115
--- a/arch/arm/mach-exynos/dma.c
+++ b/arch/arm/mach-exynos/dma.c
@@@ -69,15 -70,60 +70,47 @@@ u8 exynos4210_pdma0_peri[] = 
  	DMACH_AC97_PCMOUT,
  };
  
- struct dma_pl330_platdata exynos4_pdma0_pdata = {
- 	.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
- 	.peri_id = pdma0_peri,
+ u8 exynos4212_pdma0_peri[] = {
+ 	DMACH_PCM0_RX,
+ 	DMACH_PCM0_TX,
+ 	DMACH_PCM2_RX,
+ 	DMACH_PCM2_TX,
+ 	DMACH_MIPI_HSI0,
+ 	DMACH_MIPI_HSI1,
+ 	DMACH_SPI0_RX,
+ 	DMACH_SPI0_TX,
+ 	DMACH_SPI2_RX,
+ 	DMACH_SPI2_TX,
+ 	DMACH_I2S0S_TX,
+ 	DMACH_I2S0_RX,
+ 	DMACH_I2S0_TX,
+ 	DMACH_I2S2_RX,
+ 	DMACH_I2S2_TX,
+ 	DMACH_UART0_RX,
+ 	DMACH_UART0_TX,
+ 	DMACH_UART2_RX,
+ 	DMACH_UART2_TX,
+ 	DMACH_UART4_RX,
+ 	DMACH_UART4_TX,
+ 	DMACH_SLIMBUS0_RX,
+ 	DMACH_SLIMBUS0_TX,
+ 	DMACH_SLIMBUS2_RX,
+ 	DMACH_SLIMBUS2_TX,
+ 	DMACH_SLIMBUS4_RX,
+ 	DMACH_SLIMBUS4_TX,
+ 	DMACH_AC97_MICIN,
+ 	DMACH_AC97_PCMIN,
+ 	DMACH_AC97_PCMOUT,
+ 	DMACH_MIPI_HSI4,
+ 	DMACH_MIPI_HSI5,
  };
  
+ struct dma_pl330_platdata exynos4_pdma0_pdata;
+ 
 -struct amba_device exynos4_device_pdma0 = {
 -	.dev = {
 -		.init_name = "dma-pl330.0",
 -		.dma_mask = &dma_dmamask,
 -		.coherent_dma_mask = DMA_BIT_MASK(32),
 -		.platform_data = &exynos4_pdma0_pdata,
 -	},
 -	.res = {
 -		.start = EXYNOS4_PA_PDMA0,
 -		.end = EXYNOS4_PA_PDMA0 + SZ_4K,
 -		.flags = IORESOURCE_MEM,
 -	},
 -	.irq = {IRQ_PDMA0, NO_IRQ},
 -	.periphid = 0x00041330,
 -};
 +AMBA_AHB_DEVICE(exynos4_pdma0, "dma-pl330.0", 0x00041330,
EXYNOS4_PA_PDMA0,
 +	{IRQ_PDMA0}, &exynos4_pdma0_pdata);
  
- u8 pdma1_peri[] = {
+ u8 exynos4210_pdma1_peri[] = {
  	DMACH_PCM0_RX,
  	DMACH_PCM0_TX,
  	DMACH_PCM1_RX,
@@@ -105,27 -151,121 +138,95 @@@
  	DMACH_SLIMBUS5_TX,
  };
  
- struct dma_pl330_platdata exynos4_pdma1_pdata = {
- 	.nr_valid_peri = ARRAY_SIZE(pdma1_peri),
- 	.peri_id = pdma1_peri,
+ u8 exynos4212_pdma1_peri[] = {
+ 	DMACH_PCM0_RX,
+ 	DMACH_PCM0_TX,
+ 	DMACH_PCM1_RX,
+ 	DMACH_PCM1_TX,
+ 	DMACH_MIPI_HSI2,
+ 	DMACH_MIPI_HSI3,
+ 	DMACH_SPI1_RX,
+ 	DMACH_SPI1_TX,
+ 	DMACH_I2S0S_TX,
+ 	DMACH_I2S0_RX,
+ 	DMACH_I2S0_TX,
+ 	DMACH_I2S1_RX,
+ 	DMACH_I2S1_TX,
+ 	DMACH_UART0_RX,
+ 	DMACH_UART0_TX,
+ 	DMACH_UART1_RX,
+ 	DMACH_UART1_TX,
+ 	DMACH_UART3_RX,
+ 	DMACH_UART3_TX,
+ 	DMACH_SLIMBUS1_RX,
+ 	DMACH_SLIMBUS1_TX,
+ 	DMACH_SLIMBUS3_RX,
+ 	DMACH_SLIMBUS3_TX,
+ 	DMACH_SLIMBUS5_RX,
+ 	DMACH_SLIMBUS5_TX,
+ 	DMACH_SLIMBUS0AUX_RX,
+ 	DMACH_SLIMBUS0AUX_TX,
+ 	DMACH_SPDIF,
+ 	DMACH_MIPI_HSI6,
+ 	DMACH_MIPI_HSI7,
  };
  
+ struct dma_pl330_platdata exynos4_pdma1_pdata;
+ 
 -struct amba_device exynos4_device_pdma1 = {
 -	.dev = {
 -		.init_name = "dma-pl330.1",
 -		.dma_mask = &dma_dmamask,
 -		.coherent_dma_mask = DMA_BIT_MASK(32),
 -		.platform_data = &exynos4_pdma1_pdata,
 -	},
 -	.res = {
 -		.start = EXYNOS4_PA_PDMA1,
 -		.end = EXYNOS4_PA_PDMA1 + SZ_4K,
 -		.flags = IORESOURCE_MEM,
 -	},
 -	.irq = {IRQ_PDMA1, NO_IRQ},
 -	.periphid = 0x00041330,
 -};
 +AMBA_AHB_DEVICE(exynos4_pdma1,  "dma-pl330.1", 0x00041330,
EXYNOS4_PA_PDMA1,
 +	{IRQ_PDMA1}, &exynos4_pdma1_pdata);
  
+ u8 mdma_peri[] = {
+ 	DMACH_MTOM_0,
+ 	DMACH_MTOM_1,
+ 	DMACH_MTOM_2,
+ 	DMACH_MTOM_3,
+ 	DMACH_MTOM_4,
+ 	DMACH_MTOM_5,
+ 	DMACH_MTOM_6,
+ 	DMACH_MTOM_7,
+ };
+ 
+ struct dma_pl330_platdata exynos4_mdma_pdata = {
+ 	.nr_valid_peri = ARRAY_SIZE(mdma_peri),
+ 	.peri_id = mdma_peri,
+ };
+ 
 -struct amba_device exynos4_device_mdma = {
 -	.dev = {
 -		.init_name = "dma-pl330.2",
 -		.dma_mask = &dma_dmamask,
 -		.coherent_dma_mask = DMA_BIT_MASK(32),
 -		.platform_data = &exynos4_mdma_pdata,
 -	},
 -	.res = {
 -		.start = EXYNOS4_PA_MDMA1,
 -		.end = EXYNOS4_PA_MDMA1 + SZ_4K,
 -		.flags = IORESOURCE_MEM,
 -	},
 -	.irq = {IRQ_MDMA1, NO_IRQ},
 -	.periphid = 0x00041330,
 -};
++AMBA_AHB_DEVICE(exynos4_mdma,  "dma-pl330.2", 0x00041330,
EXYNOS4_PA_MDMA1,
++	{IRQ_MDMA1}, &exynos4_mdma_pdata);
+ 
  static int __init exynos4_dma_init(void)
  {
  	if (of_have_populated_dt())
  		return 0;
  
+ 	if (soc_is_exynos4210()) {
+ 		exynos4_pdma0_pdata.nr_valid_peri =
+ 			ARRAY_SIZE(exynos4210_pdma0_peri);
+ 		exynos4_pdma0_pdata.peri_id = exynos4210_pdma0_peri;
+ 		exynos4_pdma1_pdata.nr_valid_peri =
+ 			ARRAY_SIZE(exynos4210_pdma1_peri);
+ 		exynos4_pdma1_pdata.peri_id = exynos4210_pdma1_peri;
+ 	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
+ 		exynos4_pdma0_pdata.nr_valid_peri =
+ 			ARRAY_SIZE(exynos4212_pdma0_peri);
+ 		exynos4_pdma0_pdata.peri_id = exynos4212_pdma0_peri;
+ 		exynos4_pdma1_pdata.nr_valid_peri =
+ 			ARRAY_SIZE(exynos4212_pdma1_peri);
+ 		exynos4_pdma1_pdata.peri_id = exynos4212_pdma1_peri;
+ 	}
+ 
  	dma_cap_set(DMA_SLAVE, exynos4_pdma0_pdata.cap_mask);
  	dma_cap_set(DMA_CYCLIC, exynos4_pdma0_pdata.cap_mask);
 -	amba_device_register(&exynos4_device_pdma0, &iomem_resource);
 +	amba_device_register(&exynos4_pdma0_device, &iomem_resource);
  
  	dma_cap_set(DMA_SLAVE, exynos4_pdma1_pdata.cap_mask);
  	dma_cap_set(DMA_CYCLIC, exynos4_pdma1_pdata.cap_mask);
 -	amba_device_register(&exynos4_device_pdma1, &iomem_resource);
 +	amba_device_register(&exynos4_pdma1_device, &iomem_resource);
  
+ 	dma_cap_set(DMA_MEMCPY, exynos4_mdma_pdata.cap_mask);
 -	amba_device_register(&exynos4_device_mdma, &iomem_resource);
++	amba_device_register(&exynos4_mdma_device, &iomem_resource);
+ 
  	return 0;
  }
  arch_initcall(exynos4_dma_init);

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.4-for-vkoul

Boojin Kim (5):
      DMA: PL330: Merge PL330 driver into drivers/dma/
      DMA: PL330: Removes useless function
      DMA: PL330: Support MEMTOMEM transmit w/o RMB, WMB
      ARM: EXYNOS: Enable MDMA driver
      ARM: EXYNOS: Support DMA for EXYNOS4X12 SoCs

Tushar Behera (1):
      ARM: EXYNOS: Add apb_pclk clkdev entry for mdma1

 arch/arm/common/Kconfig                        |    3 -
 arch/arm/common/Makefile                       |    1 -
 arch/arm/common/pl330.c                        | 1959
------------------------
 arch/arm/include/asm/hardware/pl330.h          |  338 +++--
 arch/arm/mach-exynos/Kconfig                   |    3 +
 arch/arm/mach-exynos/clock.c                   |    9 +
 arch/arm/mach-exynos/dma.c                     |  130 ++-
 arch/arm/mach-exynos/include/mach/irqs.h       |    2 +
 arch/arm/mach-exynos/include/mach/map.h        |    3 +-
 arch/arm/plat-samsung/include/plat/dma-pl330.h |   16 +
 drivers/dma/Kconfig                            |    1 -
 drivers/dma/pl330.c                            | 1856
++++++++++++++++++++++
 12 files changed, 2197 insertions(+), 2124 deletions(-)
 delete mode 100644 arch/arm/common/pl330.c
