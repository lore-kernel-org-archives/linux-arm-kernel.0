From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 17:09:13 +0000
Subject: [PATCH 1/2 v3] V4L: atmel-isi: add code to enable/disable
 ISI_MCK clock
In-Reply-To: <Pine.LNX.4.64.1201051752220.23644@axis700.grange>
References: <4EEA034C.9020800@atmel.com>
 <CAOesGMiEg-8LA9-yUXRrDwGLGfVeFn7Xax9jhkDr+fZ5GU06QA@mail.gmail.com>
 <4EEB73DD.3070505@atmel.com>
 <CAOesGMjC8tOY52LV=E9=KX_FbcC-eMoNHJ4E87vOrqk44=zJnA@mail.gmail.com>
 <Pine.LNX.4.64.1112171928380.13817@axis700.grange>
 <CAOesGMi6-iPPBSP_TgKHf_agGSOrQeoB1CU=xhj8wuM2dQvf0A@mail.gmail.com>
 <Pine.LNX.4.64.1112180103220.13817@axis700.grange>
 <CAOesGMiWH--=_fu1ufztb6jZLTDO8_EboDd+hEd=TN-AnRJ3Yw@mail.gmail.com>
 <Pine.LNX.4.64.1201051752220.23644@axis700.grange>
Message-ID: <20120105170913.GC11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare/clk_unprepare?

On Thu, Jan 05, 2012 at 05:55:17PM +0100, Guennadi Liakhovetski wrote:
> From: Josh Wu <josh.wu@atmel.com>
> 
> This patch
> - add ISI_MCK clock enable/disable code.
> - change field name in isi_platform_data structure
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> [g.liakhovetski at gmx.de: fix label names]
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
> ---
> 
> Arnd, please, pull this patch via your tree to avoid having to wait for 
> the V4L tree, Mauro has acked it.
> 
>  drivers/media/video/atmel-isi.c |   31 +++++++++++++++++++++++++++++--
>  include/media/atmel-isi.h       |    4 +++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/video/atmel-isi.c b/drivers/media/video/atmel-isi.c
> index b25bd7b..9fe4519 100644
> --- a/drivers/media/video/atmel-isi.c
> +++ b/drivers/media/video/atmel-isi.c
> @@ -90,7 +90,10 @@ struct atmel_isi {
>  	struct isi_dma_desc		dma_desc[MAX_BUFFER_NUM];
>  
>  	struct completion		complete;
> +	/* ISI peripherial clock */
>  	struct clk			*pclk;
> +	/* ISI_MCK, feed to camera sensor to generate pixel clock */
> +	struct clk			*mck;
>  	unsigned int			irq;
>  
>  	struct isi_platform_data	*pdata;
> @@ -766,6 +769,12 @@ static int isi_camera_add_device(struct soc_camera_device *icd)
>  	if (ret)
>  		return ret;
>  
> +	ret = clk_enable(isi->mck);
> +	if (ret) {
> +		clk_disable(isi->pclk);
> +		return ret;
> +	}
> +
>  	isi->icd = icd;
>  	dev_dbg(icd->parent, "Atmel ISI Camera driver attached to camera %d\n",
>  		 icd->devnum);
> @@ -779,6 +788,7 @@ static void isi_camera_remove_device(struct soc_camera_device *icd)
>  
>  	BUG_ON(icd != isi->icd);
>  
> +	clk_disable(isi->mck);
>  	clk_disable(isi->pclk);
>  	isi->icd = NULL;
>  
> @@ -874,7 +884,7 @@ static int isi_camera_set_bus_param(struct soc_camera_device *icd)
>  
>  	if (isi->pdata->has_emb_sync)
>  		cfg1 |= ISI_CFG1_EMB_SYNC;
> -	if (isi->pdata->isi_full_mode)
> +	if (isi->pdata->full_mode)
>  		cfg1 |= ISI_CFG1_FULL_MODE;
>  
>  	isi_writel(isi, ISI_CTRL, ISI_CTRL_DIS);
> @@ -912,6 +922,7 @@ static int __devexit atmel_isi_remove(struct platform_device *pdev)
>  			isi->fb_descriptors_phys);
>  
>  	iounmap(isi->regs);
> +	clk_put(isi->mck);
>  	clk_put(isi->pclk);
>  	kfree(isi);
>  
> @@ -930,7 +941,7 @@ static int __devinit atmel_isi_probe(struct platform_device *pdev)
>  	struct isi_platform_data *pdata;
>  
>  	pdata = dev->platform_data;
> -	if (!pdata || !pdata->data_width_flags) {
> +	if (!pdata || !pdata->data_width_flags || !pdata->mck_hz) {
>  		dev_err(&pdev->dev,
>  			"No config available for Atmel ISI\n");
>  		return -EINVAL;
> @@ -959,6 +970,19 @@ static int __devinit atmel_isi_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&isi->video_buffer_list);
>  	INIT_LIST_HEAD(&isi->dma_desc_head);
>  
> +	/* Get ISI_MCK, provided by programmable clock or external clock */
> +	isi->mck = clk_get(dev, "isi_mck");
> +	if (IS_ERR(isi->mck)) {
> +		dev_err(dev, "Failed to get isi_mck\n");
> +		ret = PTR_ERR(isi->mck);
> +		goto err_clk_get;
> +	}
> +
> +	/* Set ISI_MCK's frequency, it should be faster than pixel clock */
> +	ret = clk_set_rate(isi->mck, pdata->mck_hz);
> +	if (ret < 0)
> +		goto err_set_mck_rate;
> +
>  	isi->p_fb_descriptors = dma_alloc_coherent(&pdev->dev,
>  				sizeof(struct fbd) * MAX_BUFFER_NUM,
>  				&isi->fb_descriptors_phys,
> @@ -1034,6 +1058,9 @@ err_alloc_ctx:
>  			isi->p_fb_descriptors,
>  			isi->fb_descriptors_phys);
>  err_alloc_descriptors:
> +err_set_mck_rate:
> +	clk_put(isi->mck);
> +err_clk_get:
>  	kfree(isi);
>  err_alloc_isi:
>  	clk_put(pclk);
> diff --git a/include/media/atmel-isi.h b/include/media/atmel-isi.h
> index 26cece5..6568230 100644
> --- a/include/media/atmel-isi.h
> +++ b/include/media/atmel-isi.h
> @@ -110,10 +110,12 @@ struct isi_platform_data {
>  	u8 hsync_act_low;
>  	u8 vsync_act_low;
>  	u8 pclk_act_falling;
> -	u8 isi_full_mode;
> +	u8 full_mode;
>  	u32 data_width_flags;
>  	/* Using for ISI_CFG1 */
>  	u32 frate;
> +	/* Using for ISI_MCK */
> +	u32 mck_hz;
>  };
>  
>  #endif /* __ATMEL_ISI_H__ */
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
