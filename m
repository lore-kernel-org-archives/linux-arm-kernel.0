From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 2 Feb 2011 12:13:39 +0100
Subject: [PATCH] OMAP1: Fix non-working LCD on OMAP310
In-Reply-To: <1296645144-19457-1-git-send-email-marek.vasut@gmail.com>
References: <1296645144-19457-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201102021213.39785.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 February 2011 12:12:24 Marek Vasut wrote:
> This patch fixes bug introduced in revision:
> 
> f8e9e98454606e43b728269de21db349f57861c7
> omap1: DMA: move LCD related code from plat-omap to mach-omap1
> 
> The code introduced by this patch didn't consider any other CPUs but
> OMAP1510, which rendered OMAP310 -- which has the same LCD controller --
> non-working. Use cpu_is_omap15xx() instead of cpu_is_omap1510() to squash
> this issue.
> 
> Bug found on Palm Zire 71 hardware.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

CCing also linux-arm-kenrel, sorry for the noise, I promise to fix my bash 
history ;-)

> ---
>  arch/arm/mach-omap1/lcd_dma.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/lcd_dma.c b/arch/arm/mach-omap1/lcd_dma.c
> index c9088d8..4538093 100644
> --- a/arch/arm/mach-omap1/lcd_dma.c
> +++ b/arch/arm/mach-omap1/lcd_dma.c
> @@ -37,7 +37,7 @@ int omap_lcd_dma_running(void)
>  	 * On OMAP1510, internal LCD controller will start the transfer
>  	 * when it gets enabled, so assume DMA running if LCD enabled.
>  	 */
> -	if (cpu_is_omap1510())
> +	if (cpu_is_omap15xx())
>  		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
>  			return 1;
> 
> @@ -95,7 +95,7 @@ EXPORT_SYMBOL(omap_set_lcd_dma_single_transfer);
> 
>  void omap_set_lcd_dma_b1_rotation(int rotate)
>  {
> -	if (cpu_is_omap1510()) {
> +	if (cpu_is_omap15xx()) {
>  		printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
>  		BUG();
>  		return;
> @@ -106,7 +106,7 @@ EXPORT_SYMBOL(omap_set_lcd_dma_b1_rotation);
> 
>  void omap_set_lcd_dma_b1_mirror(int mirror)
>  {
> -	if (cpu_is_omap1510()) {
> +	if (cpu_is_omap15xx()) {
>  		printk(KERN_ERR "DMA mirror is not supported in 1510 mode\n");
>  		BUG();
>  	}
> @@ -116,7 +116,7 @@ EXPORT_SYMBOL(omap_set_lcd_dma_b1_mirror);
> 
>  void omap_set_lcd_dma_b1_vxres(unsigned long vxres)
>  {
> -	if (cpu_is_omap1510()) {
> +	if (cpu_is_omap15xx()) {
>  		printk(KERN_ERR "DMA virtual resulotion is not supported "
>  				"in 1510 mode\n");
>  		BUG();
> @@ -127,7 +127,7 @@ EXPORT_SYMBOL(omap_set_lcd_dma_b1_vxres);
> 
>  void omap_set_lcd_dma_b1_scale(unsigned int xscale, unsigned int yscale)
>  {
> -	if (cpu_is_omap1510()) {
> +	if (cpu_is_omap15xx()) {
>  		printk(KERN_ERR "DMA scale is not supported in 1510 mode\n");
>  		BUG();
>  	}
> @@ -177,7 +177,7 @@ static void set_b1_regs(void)
>  			bottom = PIXADDR(lcd_dma.xres - 1, lcd_dma.yres - 1);
>  			/* 1510 DMA requires the bottom address to be 2 more
>  			 * than the actual last memory access location. */
> -			if (cpu_is_omap1510() &&
> +			if (cpu_is_omap15xx() &&
>  				lcd_dma.data_type == OMAP_DMA_DATA_TYPE_S32)
>  					bottom += 2;
>  			ei = PIXSTEP(0, 0, 1, 0);
> @@ -241,7 +241,7 @@ static void set_b1_regs(void)
>  		return;	/* Suppress warning about uninitialized vars */
>  	}
> 
> -	if (cpu_is_omap1510()) {
> +	if (cpu_is_omap15xx()) {
>  		omap_writew(top >> 16, OMAP1510_DMA_LCD_TOP_F1_U);
>  		omap_writew(top, OMAP1510_DMA_LCD_TOP_F1_L);
>  		omap_writew(bottom >> 16, OMAP1510_DMA_LCD_BOT_F1_U);
> @@ -343,7 +343,7 @@ void omap_free_lcd_dma(void)
>  		BUG();
>  		return;
>  	}
> -	if (!cpu_is_omap1510())
> +	if (!cpu_is_omap15xx())
>  		omap_writew(omap_readw(OMAP1610_DMA_LCD_CCR) & ~1,
>  			    OMAP1610_DMA_LCD_CCR);
>  	lcd_dma.reserved = 0;
> @@ -360,7 +360,7 @@ void omap_enable_lcd_dma(void)
>  	 * connected. Otherwise the OMAP internal controller will
>  	 * start the transfer when it gets enabled.
>  	 */
> -	if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
> +	if (cpu_is_omap15xx() || !lcd_dma.ext_ctrl)
>  		return;
> 
>  	w = omap_readw(OMAP1610_DMA_LCD_CTRL);
> @@ -378,14 +378,14 @@ EXPORT_SYMBOL(omap_enable_lcd_dma);
>  void omap_setup_lcd_dma(void)
>  {
>  	BUG_ON(lcd_dma.active);
> -	if (!cpu_is_omap1510()) {
> +	if (!cpu_is_omap15xx()) {
>  		/* Set some reasonable defaults */
>  		omap_writew(0x5440, OMAP1610_DMA_LCD_CCR);
>  		omap_writew(0x9102, OMAP1610_DMA_LCD_CSDP);
>  		omap_writew(0x0004, OMAP1610_DMA_LCD_LCH_CTRL);
>  	}
>  	set_b1_regs();
> -	if (!cpu_is_omap1510()) {
> +	if (!cpu_is_omap15xx()) {
>  		u16 w;
> 
>  		w = omap_readw(OMAP1610_DMA_LCD_CCR);
> @@ -407,7 +407,7 @@ void omap_stop_lcd_dma(void)
>  	u16 w;
> 
>  	lcd_dma.active = 0;
> -	if (cpu_is_omap1510() || !lcd_dma.ext_ctrl)
> +	if (cpu_is_omap15xx() || !lcd_dma.ext_ctrl)
>  		return;
> 
>  	w = omap_readw(OMAP1610_DMA_LCD_CCR);
