From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Mon, 25 Jun 2018 20:03:29 +0200
Subject: [PATCH 04/11] ASoC: qdsp6: q6adm: use
 of_platform_populate/depopulate()
In-Reply-To: <20180625143115.8346-5-srinivas.kandagatla@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-5-srinivas.kandagatla@linaro.org>
Message-ID: <20180625180329.GG10876@centauri.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 03:31:08PM +0100, Srinivas Kandagatla wrote:
> Now that the child nodes have there own compatible strings,
> Use of_platform_populate/depopulate() instead of less common
> of_platform_device_create()/destroy().
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6adm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
> index 9983c665a941..dfd5bc3ddd52 100644
> --- a/sound/soc/qcom/qdsp6/q6adm.c
> +++ b/sound/soc/qcom/qdsp6/q6adm.c
> @@ -588,7 +588,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
>  static int q6adm_probe(struct apr_device *adev)
>  {
>  	struct device *dev = &adev->dev;
> -	struct device_node *dais_np;
>  	struct q6adm *adm;
>  
>  	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
> @@ -605,22 +604,12 @@ static int q6adm_probe(struct apr_device *adev)
>  	INIT_LIST_HEAD(&adm->copps_list);
>  	spin_lock_init(&adm->copps_list_lock);
>  
> -	dais_np = of_get_child_by_name(dev->of_node, "routing");
> -	if (dais_np) {
> -		adm->pdev_routing = of_platform_device_create(dais_np,
> -							   "q6routing", dev);
> -		of_node_put(dais_np);
> -	}
> -
> -	return 0;
> +	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
>  static int q6adm_remove(struct apr_device *adev)
>  {
> -	struct q6adm *adm = dev_get_drvdata(&adev->dev);
> -
> -	if (adm->pdev_routing)
> -		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
> +	of_platform_depopulate(&adev->dev);

You can remove pdev_routing from struct q6adm,
since it is no longer in use.

>  
>  	return 0;
>  }
> -- 
> 2.16.2
> 

Since adding the compatible is a prerequisite for using
of_platform_populate()/of_platform_depopulate(),
I think that the patches that make use of
of_platform_populate()/of_platform_depopulate() should
come after the patches that adds the of_table entries.
