From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Mon, 4 Oct 2010 14:44:28 +0530
Subject: [PATCH v4 1/4] omap: dma: Fix buffering disable bit setting for
	omap24xx
In-Reply-To: <1286180294-32618-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
	<1286180294-32618-2-git-send-email-peter.ujfalusi@nokia.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA39@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Monday, October 04, 2010 1:48 PM
> To: Tony Lindgren
> Cc: linux-omap at vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel at lists.infradead.org
> Subject: [PATCH v4 1/4] omap: dma: Fix buffering disable bit 
> setting for omap24xx
> 
> From: ext Jarkko Nikula <jhnikula@gmail.com>
> 
> An errata workaround for omap24xx is not setting the 
> buffering disable bit
> 25 what is the purpose but channel enable bit 7 instead.

...

> diff --git a/arch/arm/plat-omap/dma.c 
> b/arch/arm/plat-omap/dma.c index ec7eddf..6914ccf 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -999,8 +999,9 @@ void omap_start_dma(int lch)
>  	 * Errata: On ES2.0 BUFFERING disable must be set.
>  	 * This will always fail on ES1.0
>  	 */

Sorry, I didn't catch this with earlier patch.

Looks like wrong comment. only on 2430ES1.0 and for all omap2420, 
buffer disable should be set. 
I feel below description will be useful to the reader:
"Errata: Inter Frame DMA buffering issue(All OMAP2420 and OMAP2430ES1.0):
DMA will wrongly buffer elements if packing and bursting is enabled.
This might result in data gets stalled in FIFO at the end of the block.
Workaround: DMA channels must have BUFFERING_DISABLED bit set to guarantee
no data will stay in the DMA FIFO in case inter frame buffering occurs.


-Manjunath
