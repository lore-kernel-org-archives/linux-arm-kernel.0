From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 25 Jan 2018 10:47:05 +0800
Subject: [RFC/RFT usb-next v1 1/6] usb: mtu3: remove custom USB PHY
 handling
In-Reply-To: <20180125001639.14681-2-martin.blumenstingl@googlemail.com>
References: <20180125001639.14681-1-martin.blumenstingl@googlemail.com>
 <20180125001639.14681-2-martin.blumenstingl@googlemail.com>
Message-ID: <1516848425.3717.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2018-01-25 at 01:16 +0100, Martin Blumenstingl wrote:
> The new PHY wrapper is now wired up in the core HCD code. This means
> that PHYs are now controlled (initialized, enabled, disabled, exited)
> without requiring any host-driver specific code.
> Remove the custom USB PHY handling from the mtu3 driver as the core HCD
> code now handles this.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/usb/mtu3/mtu3_plat.c | 101 -------------------------------------------
>  1 file changed, 101 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 628d5ce356ca..a894ddf25bcd 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -44,62 +44,6 @@ int ssusb_check_clocks(struct ssusb_mtk *ssusb, u32 ex_clks)
>  	return 0;
>  }
>  
> -static int ssusb_phy_init(struct ssusb_mtk *ssusb)
> -{
> -	int i;
> -	int ret;
> -
> -	for (i = 0; i < ssusb->num_phys; i++) {
> -		ret = phy_init(ssusb->phys[i]);
> -		if (ret)
> -			goto exit_phy;
> -	}
> -	return 0;
> -
> -exit_phy:
> -	for (; i > 0; i--)
> -		phy_exit(ssusb->phys[i - 1]);
> -
> -	return ret;
> -}
> -
> -static int ssusb_phy_exit(struct ssusb_mtk *ssusb)
> -{
> -	int i;
> -
> -	for (i = 0; i < ssusb->num_phys; i++)
> -		phy_exit(ssusb->phys[i]);
> -
> -	return 0;
> -}
> -
> -static int ssusb_phy_power_on(struct ssusb_mtk *ssusb)
> -{
> -	int i;
> -	int ret;
> -
> -	for (i = 0; i < ssusb->num_phys; i++) {
> -		ret = phy_power_on(ssusb->phys[i]);
> -		if (ret)
> -			goto power_off_phy;
> -	}
> -	return 0;
> -
> -power_off_phy:
> -	for (; i > 0; i--)
> -		phy_power_off(ssusb->phys[i - 1]);
> -
> -	return ret;
> -}
> -
> -static void ssusb_phy_power_off(struct ssusb_mtk *ssusb)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < ssusb->num_phys; i++)
> -		phy_power_off(ssusb->phys[i]);
> -}
> -
>  static int ssusb_clks_enable(struct ssusb_mtk *ssusb)
>  {
>  	int ret;
> @@ -162,24 +106,8 @@ static int ssusb_rscs_init(struct ssusb_mtk *ssusb)
>  	if (ret)
>  		goto clks_err;
>  
> -	ret = ssusb_phy_init(ssusb);
> -	if (ret) {
> -		dev_err(ssusb->dev, "failed to init phy\n");
> -		goto phy_init_err;
> -	}
> -
> -	ret = ssusb_phy_power_on(ssusb);
> -	if (ret) {
> -		dev_err(ssusb->dev, "failed to power on phy\n");
> -		goto phy_err;
> -	}
> -
>  	return 0;
>  
> -phy_err:
> -	ssusb_phy_exit(ssusb);
> -phy_init_err:
> -	ssusb_clks_disable(ssusb);
>  clks_err:
>  	regulator_disable(ssusb->vusb33);
>  vusb33_err:
> @@ -190,8 +118,6 @@ static void ssusb_rscs_exit(struct ssusb_mtk *ssusb)
>  {
>  	ssusb_clks_disable(ssusb);
>  	regulator_disable(ssusb->vusb33);
> -	ssusb_phy_power_off(ssusb);
> -	ssusb_phy_exit(ssusb);
>  }
>  
>  static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
> @@ -222,7 +148,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
>  	struct device *dev = &pdev->dev;
>  	struct regulator *vbus;
>  	struct resource *res;
> -	int i;
>  	int ret;
>  
>  	ssusb->vusb33 = devm_regulator_get(&pdev->dev, "vusb33");
> @@ -249,25 +174,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
>  	if (IS_ERR(ssusb->dma_clk))
>  		return PTR_ERR(ssusb->dma_clk);
>  
> -	ssusb->num_phys = of_count_phandle_with_args(node,
> -			"phys", "#phy-cells");
> -	if (ssusb->num_phys > 0) {
> -		ssusb->phys = devm_kcalloc(dev, ssusb->num_phys,
> -					sizeof(*ssusb->phys), GFP_KERNEL);
> -		if (!ssusb->phys)
> -			return -ENOMEM;
> -	} else {
> -		ssusb->num_phys = 0;
> -	}
> -
> -	for (i = 0; i < ssusb->num_phys; i++) {
> -		ssusb->phys[i] = devm_of_phy_get_by_index(dev, node, i);
> -		if (IS_ERR(ssusb->phys[i])) {
> -			dev_err(dev, "failed to get phy-%d\n", i);
> -			return PTR_ERR(ssusb->phys[i]);
> -		}
> -	}
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ippc");
>  	ssusb->ippc_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(ssusb->ippc_base))
> @@ -457,7 +363,6 @@ static int __maybe_unused mtu3_suspend(struct device *dev)
>  		return 0;
>  
>  	ssusb_host_disable(ssusb, true);
> -	ssusb_phy_power_off(ssusb);
>  	ssusb_clks_disable(ssusb);
>  	ssusb_wakeup_set(ssusb, true);
>  
> @@ -480,16 +385,10 @@ static int __maybe_unused mtu3_resume(struct device *dev)
>  	if (ret)
>  		goto clks_err;
>  
> -	ret = ssusb_phy_power_on(ssusb);
> -	if (ret)
> -		goto phy_err;
> -
>  	ssusb_host_enable(ssusb);
>  
>  	return 0;
>  
> -phy_err:
> -	ssusb_clks_disable(ssusb);
>  clks_err:
>  	return ret;
>  }
This patch will affect device function when works as device only mode.
Please abandon it, and I will modify it if need after the patch series
of "initialize (multiple) PHYs for a HCD" are picked up.

Thanks a lot
