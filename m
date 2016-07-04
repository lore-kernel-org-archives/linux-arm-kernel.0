From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 04 Jul 2016 12:31:29 +0900
Subject: [PATCH v2 1/1] devfreq: exynos-bus: add missing of_node_put after
 calling of_parse_phandle
In-Reply-To: <1467600466-13667-1-git-send-email-peter.chen@nxp.com>
References: <CGME20160704025548epcas1p2869c5b59279f7a997b0dc0425d6a9d88@epcas1p2.samsung.com>
 <1467600466-13667-1-git-send-email-peter.chen@nxp.com>
Message-ID: <5779D891.30405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 07? 04? 11:47, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
> 
> Changes at v2:
> - It should define node as pointer, kbuild test robot reports it
> 
> 
>  drivers/devfreq/exynos-bus.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 2363d0a..4b4c63c 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -383,7 +383,7 @@ err_clk:
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
> +	struct device_node *node, *np = dev->of_node;
>  	struct devfreq_dev_profile *profile;
>  	struct devfreq_simple_ondemand_data *ondemand_data;
>  	struct devfreq_passive_data *passive_data;
> @@ -415,10 +415,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	if (of_parse_phandle(dev->of_node, "devfreq", 0))
> +	node = of_parse_phandle(dev->of_node, "devfreq", 0);
> +	if (node) {
> +		of_node_put(node);
>  		goto passive;
> -	else
> +	} else {
>  		ret = exynos_bus_parent_parse_of(np, bus);
> +	}
>  
>  	if (ret < 0)
>  		goto err;
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
