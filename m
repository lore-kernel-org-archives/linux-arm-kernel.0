From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Jan 2014 09:24:38 +0100
Subject: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
In-Reply-To: <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
Message-ID: <20140120082438.GH16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:50AM +0100, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/ata/ahci_platform.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 3bc2dab..0676d72 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/libata.h>
>  #include <linux/ahci_platform.h>
> @@ -87,6 +88,30 @@ static struct scsi_host_template ahci_platform_sht = {
>  	AHCI_SHT("ahci_platform"),
>  };
>  
> +static const struct of_device_id ahci_of_match[] = {
> +	{ .compatible = "snps,spear-ahci", },
> +	{ .compatible = "snps,exynos5440-ahci", },
> +	{ .compatible = "ibm,476gtr-ahci", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
> +static const struct ahci_platform_data *ahci_get_pdata(struct device *dev)
> +{
> +	struct ahci_platform_data *pdata;
> +	const struct of_device_id *of_id;
> +
> +	pdata = dev_get_platdata(dev);
> +	if (pdata)
> +		return pdata;
> +
> +	of_id = of_match_device(ahci_of_match, dev);
> +	if (of_id)
> +		return of_id->data;

I don't think it's a good idea to force of_id->data to be of type struct
struct ahci_platform_data *. With this we don't have a place to store
SoC specific data anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
