From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 21 Mar 2018 11:04:13 +0800
Subject: [PATCH -next] phy: phy-mtk-tphy: fix missing
 clk_disable_unprepare() on error in mtk_phy_init()
In-Reply-To: <1521551999-154546-1-git-send-email-weiyongjun1@huawei.com>
References: <1521551999-154546-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <1521601453.3717.117.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-20 at 13:19 +0000, Wei Yongjun wrote:
> Fix the missing clk_disable_unprepare() before return
> from mtk_phy_init() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/phy/mediatek/phy-mtk-tphy.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 38c281b..3ff9020 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -841,7 +841,7 @@ static int mtk_phy_init(struct phy *phy)
>  	ret = clk_prepare_enable(instance->ref_clk);
>  	if (ret) {
>  		dev_err(tphy->dev, "failed to enable ref_clk\n");
> -		return ret;
> +		goto disable_u3phya_ref;
@u3phya_ref and @ref_clk clocks are mutually exclusive, that means one
of them must be NULL; so if failed to enable @ref_clk, then @u3phya_ref
should be NULL, and no need to disable it in fact.
But it's also no problem to disable it.
>  	}


>  
>  	switch (instance->type) {
> @@ -859,10 +859,17 @@ static int mtk_phy_init(struct phy *phy)
>  		break;
>  	default:
>  		dev_err(tphy->dev, "incompatible PHY type\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto disable_ref_clk;
mtk_phy_xlate() has already checked supported type,so usually doesn't
comes here, otherwise there will be a serious problem about system.

Anyway, it's better to disable these clocks when fail.
>  	}
>  
>  	return 0;
> +
> +disable_ref_clk:
> +	clk_disable_unprepare(instance->ref_clk);
> +disable_u3phya_ref:
> +	clk_disable_unprepare(tphy->u3phya_ref);
> +	return ret;
>  }
>  
>  static int mtk_phy_power_on(struct phy *phy)
> 
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot
> 
> 
