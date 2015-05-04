From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 4 May 2015 16:15:36 +0200
Subject: [PATCH v4 2/3] mmc: host: arasan: Add the support for
 sdhci-arasan4.9a in sdhci-of-arasan.c
In-Reply-To: <1430746792-32574-3-git-send-email-stripathi@apm.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <1430746792-32574-3-git-send-email-stripathi@apm.com>
Message-ID: <4d5ed92b-70c9-4210-bfe1-518b3954c69e@BN1BFFO11FD003.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2015 03:39 PM, Suman Tripathi wrote:
> This patch adds the quirks and compatible string in sdhci-of-arasan.c
> to support sdhci-arasan4.9a version of controller.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 981d66e..92a4222 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -20,6 +20,7 @@
>   */
> 
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include "sdhci-pltfm.h"
> 
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> @@ -169,6 +170,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto clk_disable_all;
>  	}
> 
> +	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
> +		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> +	}
> +
>  	sdhci_get_of_property(pdev);
>  	pltfm_host = sdhci_priv(host);
>  	pltfm_host->priv = sdhci_arasan;
> @@ -206,6 +212,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
> 
>  static const struct of_device_id sdhci_arasan_of_match[] = {
>  	{ .compatible = "arasan,sdhci-8.9a" },
> +	{ .compatible = "arasan,sdhci-4.9a" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> --
> 1.8.2.1
> 

You probably need just to add simple of.h but of_device.h should be also
fine.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
