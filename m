From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 09:07:25 -0800
Subject: [PATCH v5 10/14] OMAP: DMA: Use DMA device attributes
In-Reply-To: <1290603110-14119-11-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<1290603110-14119-11-git-send-email-manjugk@ti.com>
Message-ID: <20101202170724.GQ17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [101124 04:43]:
> Existing DMA API's are using cpu_*is_* checks for differentiating
> omap1 and omap2+ code and handle cpu_*is_* checks with DMA device
> attributes.
> 
> Also, move OMAP1 and OMAP2+ specific API's into respective mach-omap
> dma driver files.

This patch is unreadable and needs to be split.

Also, why are you making duplicate copies of the same generic
functions?

Now you've copied these into mach-omap1/dma.c: 

> +set_src_params(int lch, unsigned long src_start, int src_ei, int src_fi)
> +{
> +	dma_write(src_start, CSSA, lch);
> +
> +	dma_write(src_ei, CSEI, lch);
> +	dma_write(src_fi, CSFI, lch);
> +}
> +
> +static void set_dest_params(int lch, unsigned long dest_start, int dst_ei,
> +								int dst_fi)
> +{
> +	dma_write(dest_start, CDSA, lch);
> +
> +	dma_write(dst_ei, CDEI, lch);
> +	dma_write(dst_fi, CDFI, lch);
> +}
...

And then again the same functions in mach-omap2/dma.c:

> +static void omap2_set_src_params(int lch, unsigned long src_start, int src_ei,
> +								int src_fi)
> +{
> +	dma_write(src_start, CSSA, lch);
> +
> +	dma_write(src_ei, CSEI, lch);
> +	dma_write(src_fi, CSFI, lch);
> +}
> +
> +static void omap2_set_dest_params(int lch, unsigned long dest_start, int dst_ei,
> +								int dst_fi)
> +{
> +	dma_write(dest_start, CDSA, lch);
> +
> +	dma_write(dst_ei, CDEI, lch);
> +	dma_write(dst_fi, CDFI, lch);
> +}
...

All the common functions should stay in plat-omap/dma.c.

Rgards,

Tony
