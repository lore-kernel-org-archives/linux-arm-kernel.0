From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Aug 2010 19:44:10 +0200
Subject: [PATCH] pxa168fb: fix clear operation
In-Reply-To: <1283128337-4605-2-git-send-email-haojian.zhuang@marvell.com>
References: <1283128337-4605-1-git-send-email-haojian.zhuang@marvell.com>
	<1283128337-4605-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201008301944.10598.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 30. srpna 2010 02:32:17 Haojian Zhuang napsal(a):
> While fb isn't active, we should clear CFG_GRA_ENA bit. The existing code
> can't clear this bit.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/video/pxa168fb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index ec2ddb2..3f112c9 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -298,8 +298,8 @@ static void set_dma_control0(struct pxa168fb_info *fbi)
>  	 * Set bit to enable graphics DMA.
>  	 */
>  	x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
> -	x |= fbi->active ? 0x00000100 : 0;
> -	fbi->active = 0;
> +	x &= ~CFG_GRA_ENA_MASK;
> +	x |= CFG_GRA_ENA(!!fbi->active);
> 
>  	/*
>  	 * If we are in a pseudo-color mode, we need to enable

Acked-by: Marek Vasut <marek.vasut@gmail.com>
