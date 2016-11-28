From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 28 Nov 2016 15:39:10 +0100
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
Message-ID: <485a747c-47e3-bc0e-093a-4ec9ab719987@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/16 14:28, Sebastian Frias wrote:
> On 28/11/16 12:44, Adrian Hunter wrote:
>> On 28/11/16 13:20, Sebastian Frias wrote:
>>> Hi Adrian,
>>>
>>> On 28/11/16 11:30, Adrian Hunter wrote:
>>>> On 28/11/16 09:32, Michal Simek wrote:
>>>>> +Sai for Xilinx perspective.
>>>>>
>>>>> On 25.11.2016 16:24, Sebastian Frias wrote:
>>>>>> Hi,
>>>>>>
>>>>>> When using the Arasan SDHCI HW IP, there is a set of parameters called
>>>>>> "Hardware initialized registers"
>>>>>>
>>>>>> (Table 7, Section "Pin Signals", page 56 of Arasan "SD3.0/SDIO3.0/eMMC4.4
>>>>>> AHB Host Controller", revision 6.0 document)
>>>>>>
>>>>>> In some platforms those signals are connected to registers that need to
>>>>>> be programmed at some point for proper driver/HW initialisation.
>>>>>>
>>>>>> I found that the 'struct sdhci_ops' contains a '.platform_init' callback
>>>>>> that is called from within 'sdhci_pltfm_init', and that seems a good
>>>>>> candidate for a place to program those registers (*).
>>>>>>
>>>>>> Do you agree?
>>>>
>>>> We already killed .platform_init
>>>
>>> I just saw that, yet it was the perfect place for the HW initialisation I'm
>>> talking about.
>>> Any way we can restore it?
>>
>> It doesn't serve any purpose I am aware of.
> 
> It would serve (for me) if it was there :-)
> 
>>
>>>
>>>>
>>>> What is wrong with sdhci_arasan_probe()?
>>>
>>> Well, in 4.7 sdhci_arasan_probe() did not call of_match_device(), so I had
>>> put a call to it just before sdhci_pltfm_init(), something like:
>>>
>>> +static const struct of_device_id sdhci_arasan_of_match[] = {
>>> +       {
>>> +               .compatible = "arasan,sdhci-8.9a",
>>> +               .data = &sdhci_arasan_ops,
>>> +       },
>>> +       {
>>> +               .compatible = "arasan,sdhci-5.1",
>>> +               .data = &sdhci_arasan_ops,
>>> +       },
>>> +       {
>>> +               .compatible = "arasan,sdhci-4.9a",
>>> +               .data = &sdhci_arasan_ops,
>>> +       },
>>> +       {
>>> +               .compatible = "sigma,smp8734-sdio",
>>> +               .data = &sdhci_arasan_tango4_ops,
>>> +       },
>>> +       { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
>>>
>>> ...
>>>
>>> +       const struct of_device_id *match;
>>> +
>>> +       match = of_match_device(sdhci_arasan_of_match, &pdev->dev);
>>> +       if (match)
>>> +               sdhci_arasan_pdata.ops = match->data;
>>>
>>> where 'sdhci_arasan_tango4_ops' contained a pointer to a .platform_init
>>> callback.
>>>
>>> However, as I stated earlier, an upstream commit:
>>>
>>> commit 3ea4666e8d429223fbb39c1dccee7599ef7657d5
>>> Author: Douglas Anderson <dianders@chromium.org>
>>> Date:   Mon Jun 20 10:56:47 2016 -0700
>>>
>>>     mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
>>>
>>> changed struct 'sdhci_arasan_of_match' to convey different data, which
>>> means that instead of having a generic way of accessing such data (such
>>> as 'of_match_device()' and ".data" field), one must also check for
>>> specific "compatible" strings to make sense of the ".data" field, such as
>>> "rockchip,rk3399-sdhci-5.1"
>>>
>>> With the current code:
>>> - there's no 'of_match_device()' before 'sdhci_pltfm_init()'
>>> - the sdhci_pltfm_init() call is made with a static 'sdhci_arasan_pdata'
>>> struct (so it cannot be made dependent on the "compatible" string).
>>> - since 'sdhci_arasan_pdata' is the same for all compatible devices, even
>>> for those that require special handling, more "compatible" matching code is
>>> required
>>> - leading to spread "compatible" matching code; IMHO it would be cleaner if
>>> the 'sdhci_arasan_probe()' code was generic, with just a generic "compatible"
>>> matching, which then proceeded with specific initialisation and generic
>>> initialisation.
>>>
>>> In a nutshell, IMHO it would be better if adding support for more SoCs only
>>> involved changing just 'sdhci_arasan_of_match' without the need to change
>>> 'sdhci_arasan_probe()'.
>>> That would clearly separate the generic and "SoC"-specific code, thus allowing
>>> better maintenance.
>>>
>>> Does that makes sense to you guys?
>>
>> If you want to do that, then why not define your match data with your own
>> callbacks. e.g. something like
>>
>> struct sdhci_arasan_of_data {
>> 	struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>> 	void (*platform_init)(struct sdhci_arasan_data *sdhci_arasan);
>> };
>>
>> 	struct sdhci_arasan_of_data *data;
>>
>> 	data = match->data;
>> 	sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
>> 	if (data->platform_init)
>> 		platform_init(sdhci_arasan);
> 
> Well, that adds a level in the hierarchy, but here is what it would look like:
> 
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 410a55b..1cb3861 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -382,22 +382,6 @@ static int sdhci_arasan_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>  			 sdhci_arasan_resume);
>  
> -static const struct of_device_id sdhci_arasan_of_match[] = {
> -	/* SoC-specific compatible strings w/ soc_ctl_map */
> -	{
> -		.compatible = "rockchip,rk3399-sdhci-5.1",
> -		.data = &rk3399_soc_ctl_map,
> -	},
> -
> -	/* Generic compatible below here */
> -	{ .compatible = "arasan,sdhci-8.9a" },
> -	{ .compatible = "arasan,sdhci-5.1" },
> -	{ .compatible = "arasan,sdhci-4.9a" },
> -
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> -
>  /**
>   * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
>   *
> @@ -578,6 +562,53 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>  	of_clk_del_provider(dev->of_node);
>  }
>  
> +static void sdhci_tango4_platform_init(struct sdhci_host *host)
> +{
> +	printk("%s\n", __func__);
> +
> +	/*
> +	  pad_mode[2:0]=0    must be 0
> +	  sel_sdio[3]=1      must be 1 for SDIO
> +	  inv_sdwp_pol[4]=0  if set inverts the SD write protect polarity
> +	  inv_sdcd_pol[5]=0  if set inverts the SD card present polarity
> +	*/
> +	sdhci_writel(host, 0x00000008, 0x100 + 0x0);
> +}
> +
> +struct sdhci_arasan_chip_specific_data {
> +	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +	void (*platform_init)(struct sdhci_host *host);
> +};
> +
> +static const struct sdhci_arasan_chip_specific_data sdhci_arasan_rockchip = {
> +	.soc_ctl_map = &rk3399_soc_ctl_map,
> +};
> +
> +static const struct sdhci_arasan_chip_specific_data sdhci_arasan_sigma = {
> +	.platform_init = sdhci_tango4_platform_init,
> +};
> +
> +static const struct of_device_id sdhci_arasan_of_match[] = {
> +	/* SoC-specific compatible strings w/ soc_ctl_map */
> +	{
> +		.compatible = "rockchip,rk3399-sdhci-5.1",
> +		.data = &sdhci_arasan_rockchip,
> +	},
> +	{
> +		.compatible = "sigma,sdio-v1",
> +		.data = &sdhci_arasan_sigma,
> +	},
> +
> +	/* Generic compatible below here */
> +	{ .compatible = "arasan,sdhci-8.9a" },
> +	{ .compatible = "arasan,sdhci-5.1" },
> +	{ .compatible = "arasan,sdhci-4.9a" },
> +
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> +
> +
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -587,6 +618,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_arasan_data *sdhci_arasan;
> +	struct sdhci_arasan_chip_specific_data *sdhci_arasan_chip_specific;
>  	struct device_node *np = pdev->dev.of_node;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
> @@ -599,7 +631,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	sdhci_arasan->host = host;
>  
>  	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> -	sdhci_arasan->soc_ctl_map = match->data;
> +	sdhci_arasan_chip_specific = (struct sdhci_arasan_chip_specific_data *)match;
> +	if (sdhci_arasan_chip_specific->soc_ctl_map)
> +		sdhci_arasan->soc_ctl_map = sdhci_arasan_chip_specific->soc_ctl_map;
> +	if (sdhci_arasan_chip_specific->platform_init)
> +		sdhci_arasan_chip_specific->platform_init(host);
>  
>  	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
>  	if (node) {
> 
> 
> I will try to send another patch with what a different approach
> 

Here's a different approach (I just tested that it built, because I don't have the
rk3399 platform):

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 410a55b..5be6e67 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -382,22 +382,6 @@ static int sdhci_arasan_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
 			 sdhci_arasan_resume);
 
-static const struct of_device_id sdhci_arasan_of_match[] = {
-	/* SoC-specific compatible strings w/ soc_ctl_map */
-	{
-		.compatible = "rockchip,rk3399-sdhci-5.1",
-		.data = &rk3399_soc_ctl_map,
-	},
-
-	/* Generic compatible below here */
-	{ .compatible = "arasan,sdhci-8.9a" },
-	{ .compatible = "arasan,sdhci-5.1" },
-	{ .compatible = "arasan,sdhci-4.9a" },
-
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
-
 /**
  * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
  *
@@ -578,28 +562,18 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 	of_clk_del_provider(dev->of_node);
 }
 
-static int sdhci_arasan_probe(struct platform_device *pdev)
+static int sdhci_rockchip_platform_init(struct sdhci_host *host,
+					struct platform_device *pdev)
 {
 	int ret;
-	const struct of_device_id *match;
 	struct device_node *node;
-	struct clk *clk_xin;
-	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
-	struct device_node *np = pdev->dev.of_node;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
-				sizeof(*sdhci_arasan));
-	if (IS_ERR(host))
-		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
 	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
-	sdhci_arasan->host = host;
 
-	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
-	sdhci_arasan->soc_ctl_map = match->data;
+	sdhci_arasan->soc_ctl_map = &rk3399_soc_ctl_map;
 
 	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
 	if (node) {
@@ -611,10 +585,107 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			if (ret != -EPROBE_DEFER)
 				dev_err(&pdev->dev, "Can't get syscon: %d\n",
 					ret);
-			goto err_pltfm_free;
+			return -1;
 		}
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "xlnx,fails-without-test-cd"))
+		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
+
+	return 0;
+}
+
+static int sdhci_rockchip_clock_init(struct sdhci_host *host,
+					struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_arasan_data *sdhci_arasan;
+
+	pltfm_host = sdhci_priv(host);
+	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "rockchip,rk3399-sdhci-5.1"))
+		sdhci_arasan_update_clockmultiplier(host, 0x0);
+
+	sdhci_arasan_update_baseclkfreq(host);
+
+	return sdhci_arasan_register_sdclk(sdhci_arasan, pltfm_host->clk, &pdev->dev);
+}
+
+static int sdhci_tango_platform_init(struct sdhci_host *host,
+				     struct platform_device *pdev)
+{
+	return 0;
+}
+
+/* Chip-specific ops */
+struct sdhci_arasan_cs_ops {
+	int (*platform_init)(struct sdhci_host *host,
+			     struct platform_device *pdev);
+	int (*clock_init)(struct sdhci_host *host,
+			  struct platform_device *pdev);
+};
+
+static const struct sdhci_arasan_cs_ops sdhci_rockchip_cs_ops = {
+	.platform_init = sdhci_rockchip_platform_init,
+	.clock_init = sdhci_rockchip_clock_init,
+};
+
+static const struct sdhci_arasan_cs_ops sdhci_tango_cs_ops = {
+	.platform_init = sdhci_tango_platform_init,
+};
+
+static const struct of_device_id sdhci_arasan_of_match[] = {
+	/* SoC-specific compatible strings */
+	{
+		.compatible = "rockchip,rk3399-sdhci-5.1",
+		.data = &sdhci_rockchip_cs_ops,
+	},
+	{
+		.compatible = "sigma,sdio-v1",
+		.data = &sdhci_tango_cs_ops,
+	},
+
+	/* Generic compatible below here */
+	{ .compatible = "arasan,sdhci-8.9a" },
+	{ .compatible = "arasan,sdhci-5.1" },
+	{ .compatible = "arasan,sdhci-4.9a" },
+
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
+
+static int sdhci_arasan_probe(struct platform_device *pdev)
+{
+	int ret;
+	const struct of_device_id *match;
+	struct clk *clk_xin;
+	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_arasan_data *sdhci_arasan;
+	const struct sdhci_arasan_cs_ops *cs_ops;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
+				sizeof(*sdhci_arasan));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	sdhci_arasan->host = host;
+
+	match = of_match_device(sdhci_arasan_of_match, &pdev->dev);
+	if (match)
+		cs_ops = match->data;
+
+	/* SoC-specific platform init */
+	if (cs_ops && cs_ops->platform_init) {
+		ret = cs_ops->platform_init(host, pdev);
+		if (ret)
+			goto err_pltfm_free;
+	}
+
 	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
 		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
@@ -642,21 +713,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
-
-	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
-		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
-
 	pltfm_host->clk = clk_xin;
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "rockchip,rk3399-sdhci-5.1"))
-		sdhci_arasan_update_clockmultiplier(host, 0x0);
-
-	sdhci_arasan_update_baseclkfreq(host);
-
-	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
-	if (ret)
-		goto clk_disable_all;
+	/* SoC-specific clock init */
+	if (cs_ops && cs_ops->clock_init) {
+		ret = cs_ops->clock_init(host, pdev);
+		if (ret)
+			goto clk_disable_all;
+	}
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {


If you are ok with it I can clean it up to submit it properly.
