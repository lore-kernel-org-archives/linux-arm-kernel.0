From: dianders@chromium.org (Doug Anderson)
Date: Mon, 28 Nov 2016 09:46:59 -0800
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <485a747c-47e3-bc0e-093a-4ec9ab719987@laposte.net>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
 <485a747c-47e3-bc0e-093a-4ec9ab719987@laposte.net>
Message-ID: <CAD=FV=XrJHFbpbhsJZAEE-HLMe47Ov=BgvHw8ZtfCazzT75pKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 28, 2016 at 6:39 AM, Sebastian Frias <sf84@laposte.net> wrote:
>> I will try to send another patch with what a different approach
>>
>
> Here's a different approach (I just tested that it built, because I don't have the
> rk3399 platform):
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 410a55b..5be6e67 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -382,22 +382,6 @@ static int sdhci_arasan_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>                          sdhci_arasan_resume);
>
> -static const struct of_device_id sdhci_arasan_of_match[] = {
> -       /* SoC-specific compatible strings w/ soc_ctl_map */
> -       {
> -               .compatible = "rockchip,rk3399-sdhci-5.1",
> -               .data = &rk3399_soc_ctl_map,
> -       },
> -
> -       /* Generic compatible below here */
> -       { .compatible = "arasan,sdhci-8.9a" },
> -       { .compatible = "arasan,sdhci-5.1" },
> -       { .compatible = "arasan,sdhci-4.9a" },
> -
> -       { /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> -
>  /**
>   * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
>   *
> @@ -578,28 +562,18 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>         of_clk_del_provider(dev->of_node);
>  }
>
> -static int sdhci_arasan_probe(struct platform_device *pdev)
> +static int sdhci_rockchip_platform_init(struct sdhci_host *host,
> +                                       struct platform_device *pdev)
>  {
>         int ret;
> -       const struct of_device_id *match;
>         struct device_node *node;
> -       struct clk *clk_xin;
> -       struct sdhci_host *host;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_arasan_data *sdhci_arasan;
> -       struct device_node *np = pdev->dev.of_node;
> -
> -       host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
> -                               sizeof(*sdhci_arasan));
> -       if (IS_ERR(host))
> -               return PTR_ERR(host);
>
>         pltfm_host = sdhci_priv(host);
>         sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> -       sdhci_arasan->host = host;
>
> -       match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> -       sdhci_arasan->soc_ctl_map = match->data;
> +       sdhci_arasan->soc_ctl_map = &rk3399_soc_ctl_map;
>
>         node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
>         if (node) {
> @@ -611,10 +585,107 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                         if (ret != -EPROBE_DEFER)
>                                 dev_err(&pdev->dev, "Can't get syscon: %d\n",
>                                         ret);
> -                       goto err_pltfm_free;
> +                       return -1;
>                 }
>         }
>
> +       if (of_property_read_bool(pdev->dev.of_node, "xlnx,fails-without-test-cd"))
> +               sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
> +
> +       return 0;
> +}
> +
> +static int sdhci_rockchip_clock_init(struct sdhci_host *host,
> +                                       struct platform_device *pdev)
> +{
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_arasan_data *sdhci_arasan;
> +
> +       pltfm_host = sdhci_priv(host);
> +       sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +
> +       if (of_device_is_compatible(pdev->dev.of_node,
> +                                   "rockchip,rk3399-sdhci-5.1"))
> +               sdhci_arasan_update_clockmultiplier(host, 0x0);

This _does_ belong in a Rockchip-specific init function, for now.
Other platforms might want different values for
corecfg_clockmultiplier, I think.

If it becomes common to need to set this, it wouldn't be hard to make
it generic by putting it in the data matched by the device tree, then
generically call sdhci_arasan_update_clockmultiplier() in cases where
it is needed.  sdhci_arasan_update_clockmultiplier() itself should be
generic enough to handle it.


> +
> +       sdhci_arasan_update_baseclkfreq(host);

If you make soc_ctl_map always part of "struct sdhci_arasan_cs_ops"
then other platforms will be able to use it.

As argued in my original patch the field "corecfg_baseclkfreq" is
documented in the generic Arasan document
<https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf>
and thus is unlikely to be Rockchip specific.  It is entirely possible
that not everyone who integrates this IP block will need this register
set, but in that case they can set an offset as "-1" and they'll be
fine.

Said another way: the concept of whether or not to set "baseclkfreq"
doesn't need to be tired to whether or not we're on Rockchip.


> +
> +       return sdhci_arasan_register_sdclk(sdhci_arasan, pltfm_host->clk, &pdev->dev);

This is documented in "bindings/mmc/arasan,sdhci.txt" to be available
to all people using this driver, not just Rockchip.  You should do it
always.  If you don't specify "#clock-cells" in the device tree it
will be a no-op anyway.


> +}
> +
> +static int sdhci_tango_platform_init(struct sdhci_host *host,
> +                                    struct platform_device *pdev)
> +{
> +       return 0;

I'll comment in your other patch where you actually had an
implementation for this.


> +}
> +
> +/* Chip-specific ops */
> +struct sdhci_arasan_cs_ops {
> +       int (*platform_init)(struct sdhci_host *host,
> +                            struct platform_device *pdev);
> +       int (*clock_init)(struct sdhci_host *host,
> +                         struct platform_device *pdev);
> +};

I really think it's a good idea to add the "soc_ctl_map" into this structure.

If nothing else when the next Rockchip SoC comes out that uses this
then we won't have to do a second level of matching for Rockchip SoCs.
I'm also a firm believer that others will need "soc_ctl_map" at some
point in time, but obviously I can't predict the future.


> +
> +static const struct sdhci_arasan_cs_ops sdhci_rockchip_cs_ops = {
> +       .platform_init = sdhci_rockchip_platform_init,
> +       .clock_init = sdhci_rockchip_clock_init,
> +};
> +
> +static const struct sdhci_arasan_cs_ops sdhci_tango_cs_ops = {
> +       .platform_init = sdhci_tango_platform_init,
> +};
> +
> +static const struct of_device_id sdhci_arasan_of_match[] = {
> +       /* SoC-specific compatible strings */
> +       {
> +               .compatible = "rockchip,rk3399-sdhci-5.1",
> +               .data = &sdhci_rockchip_cs_ops,
> +       },
> +       {
> +               .compatible = "sigma,sdio-v1",
> +               .data = &sdhci_tango_cs_ops,
> +       },
> +
> +       /* Generic compatible below here */
> +       { .compatible = "arasan,sdhci-8.9a" },
> +       { .compatible = "arasan,sdhci-5.1" },
> +       { .compatible = "arasan,sdhci-4.9a" },
> +
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> +
> +static int sdhci_arasan_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       const struct of_device_id *match;
> +       struct clk *clk_xin;
> +       struct sdhci_host *host;
> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_arasan_data *sdhci_arasan;
> +       const struct sdhci_arasan_cs_ops *cs_ops;
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
> +                               sizeof(*sdhci_arasan));
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       pltfm_host = sdhci_priv(host);
> +       sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       sdhci_arasan->host = host;
> +
> +       match = of_match_device(sdhci_arasan_of_match, &pdev->dev);
> +       if (match)
> +               cs_ops = match->data;
> +
> +       /* SoC-specific platform init */
> +       if (cs_ops && cs_ops->platform_init) {
> +               ret = cs_ops->platform_init(host, pdev);
> +               if (ret)
> +                       goto err_pltfm_free;
> +       }
> +
>         sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
>         if (IS_ERR(sdhci_arasan->clk_ahb)) {
>                 dev_err(&pdev->dev, "clk_ahb clock not found.\n");
> @@ -642,21 +713,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         }
>
>         sdhci_get_of_property(pdev);
> -
> -       if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
> -               sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
> -
>         pltfm_host->clk = clk_xin;
>
> -       if (of_device_is_compatible(pdev->dev.of_node,
> -                                   "rockchip,rk3399-sdhci-5.1"))
> -               sdhci_arasan_update_clockmultiplier(host, 0x0);
> -
> -       sdhci_arasan_update_baseclkfreq(host);
> -
> -       ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
> -       if (ret)
> -               goto clk_disable_all;
> +       /* SoC-specific clock init */
> +       if (cs_ops && cs_ops->clock_init) {
> +               ret = cs_ops->clock_init(host, pdev);
> +               if (ret)
> +                       goto clk_disable_all;
> +       }
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
>
>
> If you are ok with it I can clean it up to submit it properly.
