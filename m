From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 04 Mar 2014 13:04:11 +0100
Subject: [PATCH v7 08/15] ahci-imx: Port to library-ised ahci_platform
In-Reply-To: <1393084424-31099-9-git-send-email-hdegoede@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-9-git-send-email-hdegoede@redhat.com>
Message-ID: <24474993.UYuAZ7PBV1@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, February 22, 2014 04:53:37 PM Hans de Goede wrote:
> This avoids the ugliness of creating a nested platform device from probe.
> 
> While moving it around anyways, move the mk6q phy init code from probe
> to imx_sata_enable, as the phy needs to be re-initialized on resume too,
> otherwise the drive won't be recognized after resume.
> 
> Tested on a wandboard i.mx6 quad.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |   9 +-
>  drivers/ata/ahci_imx.c                             | 331 ++++++++-------------
>  2 files changed, 134 insertions(+), 206 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 499bfed..d86e854 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -5,8 +5,9 @@ Each SATA controller should have its own node.
>  
>  Required properties:
>  - compatible        : compatible list, one of "snps,spear-ahci",
> -                      "snps,exynos5440-ahci", "ibm,476gtr-ahci", or
> -                      "allwinner,sun4i-a10-ahci"
> +                      "snps,exynos5440-ahci", "ibm,476gtr-ahci",
> +                      "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci" or
> +                      "fsl,imx6q-ahci"
>  - interrupts        : <interrupt mapping for SATA IRQ>
>  - reg               : <registers mapping>
>  
> @@ -15,6 +16,10 @@ Optional properties:
>  - clocks            : a list of phandle + clock specifier pairs
>  - target-supply     : regulator for SATA target power
>  
> +"fsl,imx53-ahci", "fsl,imx6q-ahci" required properties:
> +- clocks            : must contain the sata, sata_ref and ahb clocks
> +- clock-names       : must contain "ahb" for the ahb clock
> +
>  Examples:
>          sata at ffe08000 {
>  		compatible = "snps,spear-ahci";
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index dd4d6f7..3cb5d69 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c

[...]

> +static void ahci_imx_host_stop(struct ata_host *host)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
>  
> -	ret = platform_device_add_resources(ahci_pdev, res, 2);
> -	if (ret)
> -		goto err_out;
> +	imx_sata_disable(hpriv);
> +}
>  
> -	ret = platform_device_add_data(ahci_pdev, pdata, sizeof(*pdata));
> -	if (ret)
> -		goto err_out;
> +static int imx_ahci_suspend(struct device *dev)
> +{
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int ret;
>  
> -	ret = platform_device_add(ahci_pdev);
> -	if (ret) {
> -err_out:
> -		platform_device_put(ahci_pdev);
> +	ret = ahci_platform_suspend_host(dev);
> +	if (ret)
>  		return ret;
> -	}
> +
> +	imx_sata_disable(hpriv);
>  
>  	return 0;
>  }
>  
> -static int imx_ahci_remove(struct platform_device *pdev)
> +static int imx_ahci_resume(struct device *dev)
>  {
> -	struct imx_ahci_priv *imxpriv = platform_get_drvdata(pdev);
> -	struct platform_device *ahci_pdev = imxpriv->ahci_pdev;
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	int ret;
>  
> -	platform_device_unregister(ahci_pdev);
> -	return 0;
> +	ret = imx_sata_enable(hpriv);
> +	if (ret)
> +		return ret;
> +
> +	return ahci_platform_resume_host(dev);
>  }

The code above introduces two new warnings for CONFIG_PM_SLEEP=n:

drivers/ata/ahci_imx.c:284:12: warning: ?imx_ahci_suspend? defined but not used [-Wunused-function]
drivers/ata/ahci_imx.c:299:12: warning: ?imx_ahci_resume? defined but not used [-Wunused-function]

[ There needs to be CONFIG_PM_SLEEP ifdef around imh_ahci_suspend()
  and imx_ahci_resume(). ]

All the rest looks good.

> +static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, imx_ahci_suspend, imx_ahci_resume);
> +
>  static struct platform_driver imx_ahci_driver = {
>  	.probe = imx_ahci_probe,
> -	.remove = imx_ahci_remove,
> +	.remove = ata_platform_remove_one,
>  	.driver = {
>  		.name = "ahci-imx",
>  		.owner = THIS_MODULE,
>  		.of_match_table = imx_ahci_of_match,
> +		.pm = &ahci_imx_pm_ops,
>  	},
>  };
>  module_platform_driver(imx_ahci_driver);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
