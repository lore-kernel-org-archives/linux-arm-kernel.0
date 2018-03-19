From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 19 Mar 2018 01:48:17 +0000
Subject: [PATCH -next] ASoC: mediatek: mt2701: drop unnessary
 snd_soc_unregister_component()
In-Reply-To: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
References: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <87lgeou9bo.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Wei

> It's not necessary to unregister a component registered
> with devm_snd_soc_register_component().
> 
> Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to componen")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> index f7e0702..43837a3 100644
> --- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> +++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> @@ -1561,8 +1561,6 @@ static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
>  	if (!pm_runtime_status_suspended(&pdev->dev))
>  		mt2701_afe_runtime_suspend(&pdev->dev);
>  
> -	snd_soc_unregister_component(&pdev->dev);
> -
>  	return 0;
>  }

I guess, below patch is using normal snd_soc_add_component() not devm_ version,
and above unregister is for it ?
And I think f1b5bf07365d patch is not related to youur patch
(It is "platform" replace patch, your one is for "component" patch).

	dc2a17f4f074c434757e2cef5026d4747fe22955
	("ASoC: mediatek: fix double free in mt2701_afe_pcm_dev_probe()")

static int mt2701_afe_add_component(struct mtk_base_afe *afe)
{
        struct snd_soc_component *component;

        component = kzalloc(sizeof(*component), GFP_KERNEL);
        if (!component)
                return -ENOMEM;

        component->regmap = afe->regmap;

        return snd_soc_add_component(afe->dev, component,
                                     &mt2701_afe_pcm_dai_component,
                                     mt2701_afe_pcm_dais,
                                     ARRAY_SIZE(mt2701_afe_pcm_dais));
}

    
