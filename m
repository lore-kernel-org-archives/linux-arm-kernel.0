From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 11 Aug 2010 21:47:42 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
Message-ID: <20100811184742.GA21778@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Wed, Aug 11, 2010 at 08:42:18PM +0200, ext DebBarma, Tarun Kanti wrote:
>> @@ -182,10 +186,84 @@ static struct wl1271_if_operations sdio_ops = {
>>  	.disable_irq	= wl1271_sdio_disable_interrupts
>>  };
>>
>> +static int wl1271_plat_probe(struct platform_device *pdev)
>> +{
>> +	struct wl12xx_platform_data *pdata;
>> +	struct platform_driver *pdriver;
>> +	struct wl12xx_plat_instance *pinstance;
>> +
>What about checking for pdev here before extracting pdata?

why ? if probe is called pdev is guaranteed to be valid, no ?

>> +	pdata = pdev->dev.platform_data;
>> +	if (!pdata) {
>> +		wl1271_error("no platform data");
>> +		return -ENODEV;
>> +	}
>> +
>> +	pdriver = container_of(pdev->dev.driver, struct platform_driver,
>> +								driver);

but you shouldn't fiddle with the driver structure here. What are you 
actually trying to achieve here ? What's pinstance supposed to do ? are 
you trying to handle cases where you might have several wl12xx chips on 
the same board ? If that's the case you should have several platform 
devices, one for each chip. They'll only have different ids.

-- 
balbi

DefectiveByDesign.org
