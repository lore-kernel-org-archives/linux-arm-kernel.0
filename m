From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 29 Sep 2015 18:14:37 +0800
Subject: [PATCH] drm/rockchip: vop: Correct enabled clocks during setup
In-Reply-To: <1443518893-28142-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1443518893-28142-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <560A648D.1060504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd
     We double check this problem, yes, board will hang if aclk is disabled
when setting vop register.

     Acked-by: Mark Yao <mark.yao@rock-chips.com>

Thanks for this fix.

On 2015?09?29? 17:28, Sjoerd Simons wrote:
> When doing the initial setup both the hclk and the aclk need to be
> enabled otherwise the board will simply hang. This only occurs when
> building the vop driver as a module, when its built-in the initial setup
> happens to run before the clock framework shuts of unused clocks
> (including the aclk).
>
> While there also switch to doing prepare and enable in one step rather
> then separate steps to reduce the amount of code required.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>
> ---
>
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 36 +++++++++++------------------
>   1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 5d8ae5e..48719df 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1575,32 +1575,25 @@ static int vop_initial(struct vop *vop)
>   		return PTR_ERR(vop->dclk);
>   	}
>   
> -	ret = clk_prepare(vop->hclk);
> -	if (ret < 0) {
> -		dev_err(vop->dev, "failed to prepare hclk\n");
> -		return ret;
> -	}
> -
>   	ret = clk_prepare(vop->dclk);
>   	if (ret < 0) {
>   		dev_err(vop->dev, "failed to prepare dclk\n");
> -		goto err_unprepare_hclk;
> +		return ret;
>   	}
>   
> -	ret = clk_prepare(vop->aclk);
> +	/* Enable both the hclk and aclk to setup the vop */
> +	ret = clk_prepare_enable(vop->hclk);
>   	if (ret < 0) {
> -		dev_err(vop->dev, "failed to prepare aclk\n");
> +		dev_err(vop->dev, "failed to prepare/enable hclk\n");
>   		goto err_unprepare_dclk;
>   	}
>   
> -	/*
> -	 * enable hclk, so that we can config vop register.
> -	 */
> -	ret = clk_enable(vop->hclk);
> +	ret = clk_prepare_enable(vop->aclk);
>   	if (ret < 0) {
> -		dev_err(vop->dev, "failed to prepare aclk\n");
> -		goto err_unprepare_aclk;
> +		dev_err(vop->dev, "failed to prepare/enable aclk\n");
> +		goto err_disable_hclk;
>   	}
> +
>   	/*
>   	 * do hclk_reset, reset all vop registers.
>   	 */
> @@ -1608,7 +1601,7 @@ static int vop_initial(struct vop *vop)
>   	if (IS_ERR(ahb_rst)) {
>   		dev_err(vop->dev, "failed to get ahb reset\n");
>   		ret = PTR_ERR(ahb_rst);
> -		goto err_disable_hclk;
> +		goto err_disable_aclk;
>   	}
>   	reset_control_assert(ahb_rst);
>   	usleep_range(10, 20);
> @@ -1634,26 +1627,25 @@ static int vop_initial(struct vop *vop)
>   	if (IS_ERR(vop->dclk_rst)) {
>   		dev_err(vop->dev, "failed to get dclk reset\n");
>   		ret = PTR_ERR(vop->dclk_rst);
> -		goto err_unprepare_aclk;
> +		goto err_disable_aclk;
>   	}
>   	reset_control_assert(vop->dclk_rst);
>   	usleep_range(10, 20);
>   	reset_control_deassert(vop->dclk_rst);
>   
>   	clk_disable(vop->hclk);
> +	clk_disable(vop->aclk);
>   
>   	vop->is_enabled = false;
>   
>   	return 0;
>   
> +err_disable_aclk:
> +	clk_disable_unprepare(vop->aclk);
>   err_disable_hclk:
> -	clk_disable(vop->hclk);
> -err_unprepare_aclk:
> -	clk_unprepare(vop->aclk);
> +	clk_disable_unprepare(vop->hclk);
>   err_unprepare_dclk:
>   	clk_unprepare(vop->dclk);
> -err_unprepare_hclk:
> -	clk_unprepare(vop->hclk);
>   	return ret;
>   }
>   


-- 
?ark Yao
