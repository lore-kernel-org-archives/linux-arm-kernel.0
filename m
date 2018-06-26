From: niklas.cassel@linaro.org (Niklas Cassel)
Date: Tue, 26 Jun 2018 11:32:45 +0200
Subject: [PATCH v2 05/12] ASoC: qdsp6: q6asm: use
 of_platform_populate/depopulate()
In-Reply-To: <20180626092016.9296-6-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-6-srinivas.kandagatla@linaro.org>
Message-ID: <20180626093245.GC25217@centauri.ideon.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:09AM +0100, Srinivas Kandagatla wrote:
> Now that the child nodes have there own compatible strings,
> Use of_platform_populate/depopulate() instead of less common
> of_platform_device_create()/destroy().
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 530852385cad..c4fd28f168d5 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -177,7 +177,6 @@ struct q6asm {
>  	struct platform_device *pcmdev;
>  	spinlock_t slock;
>  	struct audio_client *session[MAX_SESSIONS + 1];
> -	struct platform_device *pdev_dais;
>  };
>  
>  struct audio_client {
> @@ -1344,7 +1343,6 @@ EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
>  static int q6asm_probe(struct apr_device *adev)
>  {
>  	struct device *dev = &adev->dev;
> -	struct device_node *dais_np;
>  	struct q6asm *q6asm;
>  
>  	q6asm = devm_kzalloc(dev, sizeof(*q6asm), GFP_KERNEL);
> @@ -1359,22 +1357,12 @@ static int q6asm_probe(struct apr_device *adev)
>  	spin_lock_init(&q6asm->slock);
>  	dev_set_drvdata(dev, q6asm);
>  
> -	dais_np = of_get_child_by_name(dev->of_node, "dais");
> -	if (dais_np) {
> -		q6asm->pdev_dais = of_platform_device_create(dais_np,
> -							   "q6asm-dai", dev);
> -		of_node_put(dais_np);
> -	}
> -
> -	return 0;
> +	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
>  static int q6asm_remove(struct apr_device *adev)
>  {
> -	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
> -
> -	if (q6asm->pdev_dais)
> -		of_platform_device_destroy(&q6asm->pdev_dais->dev, NULL);
> +	of_platform_depopulate(&adev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.16.2
> 
