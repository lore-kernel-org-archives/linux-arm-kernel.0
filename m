From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 14 Dec 2010 16:40:42 -0800
Subject: [PATCH v1 7/9] OMAP1: DMA: Implement in platform device model
In-Reply-To: <1291434246-30716-8-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Sat, 4 Dec 2010 09:14:04 +0530")
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<1291434246-30716-8-git-send-email-manjugk@ti.com>
Message-ID: <87d3p3q35h.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manjunath,

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Implement OMAP1 DMA as platform device and add support for
> registering through platform device layer using resource
> structures.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Using a memory-to-memory DMA test which exercises all available
channels, this hangs on OMAP1 (OMAP5912/OSK.)

The root cause is that the interrupt numbers used here are very
different from those of the original code it is replacing.  Details
below...

> ---
>  arch/arm/mach-omap1/dma.c |  179 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 179 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/dma.c
>
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> new file mode 100644
> index 0000000..b56ee21
> --- /dev/null
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -0,0 +1,179 @@
> +/*
> + * OMAP1/OMAP7xx - specific DMA driver
> + *
> + * Copyright (C) 2003 - 2008 Nokia Corporation
> + * Author: Juha Yrj?l? <juha.yrjola@nokia.com>
> + * DMA channel linking for 1610 by Samuel Ortiz <samuel.ortiz@nokia.com>
> + * Graphics DMA and LCD DMA graphics tranformations
> + * by Imre Deak <imre.deak@nokia.com>
> + * OMAP2/3 support Copyright (C) 2004-2007 Texas Instruments, Inc.
> + * Some functions based on earlier dma-omap.c Copyright (C) 2001 RidgeRun, Inc.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> + * Converted DMA library into platform driver
> + *                   - G, Manjunath Kondaiah <manjugk@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +
> +#include <plat/dma.h>
> +#include <plat/tc.h>
> +#include <plat/irqs.h>
> +
> +#define OMAP1_DMA_BASE			(0xfffed800)
> +
> +static struct resource res[] __initdata = {
> +	[0] = {
> +		.start	= OMAP1_DMA_BASE,
> +		.end	= OMAP1_DMA_BASE + SZ_2K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.name   = "0",
> +		.start  = INT_DMA_CH0_6,
> +		.flags  = IORESOURCE_IRQ,
> +	},

Minor nit: to keep the index numbers and the 'name' fields aligned, and
less confusing, you could move the memory resource to the end.  Either
that, or just drop the hard-coded index values.

> +	[2] = {
> +		.name   = "1",
> +		.start  = INT_DMA_CH1_7,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[3] = {
> +		.name   = "2",
> +		.start  = INT_DMA_CH2_8,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[4] = {
> +		.name   = "3",
> +		.start  = INT_DMA_CH3,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[5] = {
> +		.name   = "4",
> +		.start  = INT_DMA_CH4,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[6] = {
> +		.name   = "5",
> +		.start  = INT_DMA_CH5,
> +		.flags  = IORESOURCE_IRQ,
> +	},

Here's the array of interrupt numbers from the original code (which you
remove in PATCH 9/9)

static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
	INT_1610_DMA_CH11, INT_1610_DMA_CH12, INT_1610_DMA_CH13,
	INT_1610_DMA_CH14, INT_1610_DMA_CH15, INT_DMA_LCD
};

Up until this point in the patch, the interrupt numbers match up
with the previous code.

> +	[7] = {
> +		.name   = "6",
> +		.start  = INT_DMA_LCD,
> +		.flags  = IORESOURCE_IRQ,
> +	},

Starting here though, you use INT_DMA_LCD for LCH 6, where previous code
uses INT_1610_DMA_CH6.

> +	/* irq's for omap16xx and omap7xx */
> +	[8] = {
> +		.name   = "7",
> +		.start  = 53 + IH2_BASE,
> +		.flags  = IORESOURCE_IRQ,
> +	},

Here, there are a couple problems.

First, exising #defines for interrupt numbers are no longer used used,
and second, this is the wrong value.  Looking at plat/irqs.h:

#define INT_1610_DMA_CH6	(53 + IH2_BASE)
#define INT_1610_DMA_CH7	(54 + IH2_BASE)
[...]
#define INT_1610_DMA_CH15	(62 + IH2_BASE)

You can see that the IRQ value for LCH 7 in this patch is actually the
value for LCH 6.  The same "one off" problem exists for the rest of the
channels below up through LCH 15.

> +	[9] = {
> +		.name   = "8",
> +		.start  = 54 + IH2_BASE,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +	[10] = {
> +		.name  = "9",
> +		.start = 55 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[11] = {
> +		.name  = "10",
> +		.start = 56 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[12] = {
> +		.name  = "11",
> +		.start = 57 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[13] = {
> +		.name  = "12",
> +		.start = 58 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[14] = {
> +		.name  = "13",
> +		.start = 59 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[15] = {
> +		.name  = "14",
> +		.start = 60 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[16] = {
> +		.name  = "15",
> +		.start = 61 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +	[17] = {
> +		.name  = "16",
> +		.start = 62 + IH2_BASE,
> +		.flags = IORESOURCE_IRQ,
> +	},

And based on the original code, this last one should be INT_LCD_DMA.

Using the patch below which fixes up the interrupt numbers to match the
original code, the memory-to-memory test is now working on OSK.

Kevin

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 17814e0..d855934 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -121,58 +121,58 @@ static struct resource res[] __initdata = {
 	/* Handled in lcd_dma.c */
 	[7] = {
 		.name   = "6",
-		.start  = INT_DMA_LCD,
+		.start  = INT_1610_DMA_CH6,
 		.flags  = IORESOURCE_IRQ,
 	},
 	/* irq's for omap16xx and omap7xx */
 	[8] = {
 		.name   = "7",
-		.start  = 53 + IH2_BASE,
+		.start  = INT_1610_DMA_CH7,
 		.flags  = IORESOURCE_IRQ,
 	},
 	[9] = {
 		.name   = "8",
-		.start  = 54 + IH2_BASE,
+		.start  = INT_1610_DMA_CH8,
 		.flags  = IORESOURCE_IRQ,
 	},
 	[10] = {
 		.name  = "9",
-		.start = 55 + IH2_BASE,
+		.start = INT_1610_DMA_CH9,
 		.flags = IORESOURCE_IRQ,
 	},
 	[11] = {
 		.name  = "10",
-		.start = 56 + IH2_BASE,
+		.start = INT_1610_DMA_CH10,
 		.flags = IORESOURCE_IRQ,
 	},
 	[12] = {
 		.name  = "11",
-		.start = 57 + IH2_BASE,
+		.start = INT_1610_DMA_CH11,
 		.flags = IORESOURCE_IRQ,
 	},
 	[13] = {
 		.name  = "12",
-		.start = 58 + IH2_BASE,
+		.start = INT_1610_DMA_CH12,
 		.flags = IORESOURCE_IRQ,
 	},
 	[14] = {
 		.name  = "13",
-		.start = 59 + IH2_BASE,
+		.start = INT_1610_DMA_CH13,
 		.flags = IORESOURCE_IRQ,
 	},
 	[15] = {
 		.name  = "14",
-		.start = 60 + IH2_BASE,
+		.start = INT_1610_DMA_CH14,
 		.flags = IORESOURCE_IRQ,
 	},
 	[16] = {
 		.name  = "15",
-		.start = 61 + IH2_BASE,
+		.start = INT_1610_DMA_CH15,
 		.flags = IORESOURCE_IRQ,
 	},
 	[17] = {
 		.name  = "16",
-		.start = 62 + IH2_BASE,
+		.start = INT_DMA_LCD,
 		.flags = IORESOURCE_IRQ,
 	},
 };
