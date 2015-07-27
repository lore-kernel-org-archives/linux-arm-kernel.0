From: monstr@monstr.eu (Michal Simek)
Date: Mon, 27 Jul 2015 10:23:50 +0200
Subject: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
In-Reply-To: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
References: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <55B5EA96.6020604@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 10:04 AM, Shawn Lin wrote:
> This patch adds the interface to get quirks from dts, and
> there is no need to assign different quirks by condition statement
> of arasan IP version.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index ef5a7d2..db07788 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
>  	int ret;
> +	u32 quirktab[2];
>  	struct clk *clk_xin;
>  	struct sdhci_host *host;
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto clk_disable_all;
>  	}
>  
> +	if (of_property_read_u32_array(pdev->dev.of_node,
> +				       "arasan,quirks", &quirktab[0], 2)) {

This is not documented anywhere that's why you should send binding to DT
mailing list and get ACK for it.

> +		host->quirks |= quirktab[0];
> +		host->quirks2 |= quirktab[1];
> +	}
> +
>  	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>  		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>  		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> 

Also is there any binding which is done in this way?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/777dda76/attachment.sig>
