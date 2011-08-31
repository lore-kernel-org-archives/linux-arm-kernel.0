From: eric.miao@linaro.org (Eric Miao)
Date: Wed, 31 Aug 2011 16:28:58 +0800
Subject: [PATCH V7 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <1314762635-3923-3-git-send-email-richard.zhu@linaro.org>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-3-git-send-email-richard.zhu@linaro.org>
Message-ID: <CAMPhdO9Tvp9HeXYe=C8hHavAKSm2wO7ObKbv5n9PTeC4gQPJBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 11:50 AM, Richard Zhu <richard.zhu@linaro.org> wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
>
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> Acked-by: Eric Miao <eric.miao@linaro.org>
> ---
> ?drivers/ata/ahci_platform.c | ? 44 +++++++++++++++++++++++++++++++++++++-----
> ?1 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 6fef1fa..c03277d 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -23,6 +23,41 @@
> ?#include <linux/ahci_platform.h>
> ?#include "ahci.h"
>
> +enum ahci_type {
> + ? ? ? AHCI, ? ? ? ? ? /* standard platform ahci */
> + ? ? ? IMX53_AHCI, ? ? /* ahci on i.mx53 */
> +};
> +
> +static struct platform_device_id ahci_devtype[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name = "ahci",
> + ? ? ? ? ? ? ? .driver_data = AHCI,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name = "imx53-ahci",
> + ? ? ? ? ? ? ? .driver_data = IMX53_AHCI,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? /* sentinel */
> + ? ? ? }
> +};
> +MODULE_DEVICE_TABLE(platform, ahci_devtype);
> +

I still prefer this way as this is most flexible. We'll see how we can better
organize this along with newly added ahci controllers.

Jeff,

Can you take this patch through? Or if you are good with this, we can
also push this one along with the other  patches to go through sascha's
imx tree.

> +
> +static const struct ata_port_info ahci_port_info[] = {
> + ? ? ? /* by features */
> + ? ? ? [AHCI] = {
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= AHCI_FLAG_COMMON,
> + ? ? ? ? ? ? ? .pio_mask ? ? ? = ATA_PIO4,
> + ? ? ? ? ? ? ? .udma_mask ? ? ?= ATA_UDMA6,
> + ? ? ? ? ? ? ? .port_ops ? ? ? = &ahci_ops,
> + ? ? ? },
> + ? ? ? [IMX53_AHCI] = {
> + ? ? ? ? ? ? ? .flags ? ? ? ? ?= AHCI_FLAG_COMMON,
> + ? ? ? ? ? ? ? .pio_mask ? ? ? = ATA_PIO4,
> + ? ? ? ? ? ? ? .udma_mask ? ? ?= ATA_UDMA6,
> + ? ? ? ? ? ? ? .port_ops ? ? ? = &ahci_pmp_retry_srst_ops,
> + ? ? ? },
> +};
> +
> ?static struct scsi_host_template ahci_platform_sht = {
> ? ? ? ?AHCI_SHT("ahci_platform"),
> ?};
> @@ -31,12 +66,8 @@ static int __init ahci_probe(struct platform_device *pdev)
> ?{
> ? ? ? ?struct device *dev = &pdev->dev;
> ? ? ? ?struct ahci_platform_data *pdata = dev->platform_data;
> - ? ? ? struct ata_port_info pi = {
> - ? ? ? ? ? ? ? .flags ? ? ? ? ?= AHCI_FLAG_COMMON,
> - ? ? ? ? ? ? ? .pio_mask ? ? ? = ATA_PIO4,
> - ? ? ? ? ? ? ? .udma_mask ? ? ?= ATA_UDMA6,
> - ? ? ? ? ? ? ? .port_ops ? ? ? = &ahci_ops,
> - ? ? ? };
> + ? ? ? const struct platform_device_id *id = platform_get_device_id(pdev);
> + ? ? ? struct ata_port_info pi = ahci_port_info[id->driver_data];
> ? ? ? ?const struct ata_port_info *ppi[] = { &pi, NULL };
> ? ? ? ?struct ahci_host_priv *hpriv;
> ? ? ? ?struct ata_host *host;
> @@ -177,6 +208,7 @@ static struct platform_driver ahci_driver = {
> ? ? ? ? ? ? ? ?.name = "ahci",
> ? ? ? ? ? ? ? ?.owner = THIS_MODULE,
> ? ? ? ?},
> + ? ? ? .id_table ? ? ? = ahci_devtype,
> ?};
>
> ?static int __init ahci_init(void)
> --
> 1.7.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
