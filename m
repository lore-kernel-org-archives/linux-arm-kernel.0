From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Oct 2017 12:20:58 +0100
Subject: [PATCH 4/5] firmware: arm_scpi: make freeing mbox channels
 device-managed
In-Reply-To: <2626ebba-5145-cd06-7d7f-ff9fbc96d7f1@gmail.com>
References: <c245d2fa-2aa0-fa40-21a7-318e8db3b763@gmail.com>
 <2626ebba-5145-cd06-7d7f-ff9fbc96d7f1@gmail.com>
Message-ID: <4e1827b6-a6f0-8d98-ad19-e203069b9f9e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/09/17 22:44, Heiner Kallweit wrote:
> Make freeing the mbox channels device-managed, thus further simplifying
> scpi_remove and and one further step to get rid of scpi_remove.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/firmware/arm_scpi.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index fd79adb5..c91f3241 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -902,16 +902,13 @@ static struct attribute *versions_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(versions);
>  
> -static void
> -scpi_free_channels(struct device *dev, struct scpi_chan *pchan, int count)
> +static void scpi_free_channels(void *data)
>  {
> +	struct scpi_drvinfo *info = data;
>  	int i;
>  
> -	for (i = 0; i < count && pchan->chan; i++, pchan++) {
> -		mbox_free_channel(pchan->chan);
> -		devm_kfree(dev, pchan->xfers);
> -		devm_iounmap(dev, pchan->rx_payload);
> -	}
> +	for (i = 0; i < info->num_chans; i++)
> +		mbox_free_channel(info->channels[i].chan);
>  }
>  
>  static int scpi_remove(struct platform_device *pdev)
> @@ -920,7 +917,6 @@ static int scpi_remove(struct platform_device *pdev)
>  
>  	of_platform_depopulate(dev);
>  	sysfs_remove_groups(&dev->kobj, versions_groups);
> -	scpi_free_channels(dev, scpi_info->channels, scpi_info->num_chans);
>  
>  	return 0;
>  }
> @@ -953,7 +949,6 @@ static int scpi_probe(struct platform_device *pdev)
>  {
>  	int count, idx, ret;
>  	struct resource res;
> -	struct scpi_chan *scpi_chan;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  
> @@ -970,13 +965,19 @@ static int scpi_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	scpi_chan = devm_kcalloc(dev, count, sizeof(*scpi_chan), GFP_KERNEL);
> -	if (!scpi_chan)
> +	scpi_info->channels = devm_kcalloc(dev, count, sizeof(struct scpi_chan),
> +					   GFP_KERNEL);
> +	if (!scpi_info->channels)
>  		return -ENOMEM;
>  
> -	for (idx = 0; idx < count; idx++) {
> +	ret = devm_add_action(dev, scpi_free_channels, scpi_info);

Neat, I wasn't aware of such API before.

-- 
-- 
Regards,
Sudeep
