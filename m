From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 13 Jul 2011 17:47:25 +0900
Subject: [PATCH V2 00/12] To use DMA generic APIs for Samsung DMA
Message-ID: <1310546857-6304-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following is diagram of this changes

+---------------------------------------------------------------------+
| Each drivers which uses DMA                                         |
+---------------------------------------------------------------------+
| S3C DMA API (such as s3c2410_dma_xxxx)                              |
+-------------------------------+-------------------------------------+
| DMA driver for S3C24XX        | S3C PL330 DMA API driver            |
| PL080 DMA driver for S3C64XX  | (arch/arm/plat-samsung/s3c-pl330.c) |
|                               +-------------------------------------+
| (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver              |
| (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c)           |
+-------------------------------+-------------------------------------+
                               ||
                (removing S3C DMA API for PL330)
                               ||
                               \/
+---------------------------------------------------------------------+
| Each drivers which uses DMA                                         |
+-------------------------------+-------------------------------------+
| S3C DMA API(s3c2410_dma_xxx)  | DMA generic API for PL330           |
+-------------------------------+-------------------------------------+
| DMA driver for S3C24XX        | PL330 DMA API driver                |
| PL080 DMA driver for S3C64XX  | (drivers/dma/pl330.c)               |
|                               +-------------------------------------+
| (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver              |
| (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c)           |
+-------------------------------+-------------------------------------+

Changes since V1:
- removed s3c-pl330 dma driver
- to support multiple platform
- to support this dma on s5p64x0, s5pc100 and s5pv210 as well as exynos4
- addressed comments from Russell King, Grant Likely, Jassi Brar,
  Mark Brown and many developrs...Thanks all.

[PATCH V2 01/12] DMA: PL330: Add support runtime PM for PL330 DMAC
[PATCH V2 02/12] DMA: PL330: Update PL330 DMA API driver
[PATCH V2 03/12] DMA: PL330: Add DMA capabilities
[PATCH V2 04/12] ARM: SAMSUNG: Update to use PL330-DMA driver
[PATCH V2 05/12] ARM: SAMSUNG: Add common DMA operations
[PATCH V2 06/12] ARM: EXYNOS4: Use generic DMA PL330 driver
[PATCH V2 07/12] ARM: S5PV210: Use generic DMA PL330 driver
[PATCH V2 08/12] ARM: S5PC100: Use generic DMA PL330 driver
[PATCH V2 09/12] ARM: S5P64X0: Use generic DMA PL330 driver
[PATCH V2 10/12] ARM: SAMSUNG: Remove S3C-PL330-DMA driver
[PATCH V2 11/12] spi/s3c64xx: Add support DMA engine API
[PATCH V2 12/12] ASoC: Samsung: Update DMA interface
