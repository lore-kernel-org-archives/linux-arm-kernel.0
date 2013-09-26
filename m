From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 11:55:28 +0100
Subject: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
In-Reply-To: <524411B8.4070000@ti.com>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk> <524411B8.4070000@ti.com>
Message-ID: <20130926105528.GY25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 04:21:36PM +0530, Archit Taneja wrote:
> Hi,
>
> On Friday 20 September 2013 04:41 AM, Russell King wrote:
>> The correct way for a driver to specify the coherent DMA mask is
>> not to directly access the field in the struct device, but to use
>> dma_set_coherent_mask().  Only arch and bus code should access this
>> member directly.
>>
>> Convert all direct write accesses to using the correct API.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>   drivers/ata/pata_ixp4xx_cf.c             |    5 ++++-
>>   drivers/gpu/drm/exynos/exynos_drm_drv.c  |    6 +++++-
>>   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |    5 +++--
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
>> index 1ec53f8..ddf470c 100644
>> --- a/drivers/ata/pata_ixp4xx_cf.c
>> +++ b/drivers/ata/pata_ixp4xx_cf.c
>> @@ -144,6 +144,7 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
>>   	struct ata_host *host;
>>   	struct ata_port *ap;
>>   	struct ixp4xx_pata_data *data = dev_get_platdata(&pdev->dev);
>> +	int ret;
>>
>>   	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> @@ -157,7 +158,9 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>
>>   	/* acquire resources and fill host */
>> -	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ret;
>>
>>   	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
>>   	data->cs1 = devm_ioremap(&pdev->dev, cs1->start, 0x1000);
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> index bb82ef7..81192d0 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> @@ -286,7 +286,11 @@ static struct drm_driver exynos_drm_driver = {
>>
>>   static int exynos_drm_platform_probe(struct platform_device *pdev)
>>   {
>> -	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +	int ret;
>> +
>> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ret;
>>
>>   	return drm_platform_init(&exynos_drm_driver, pdev);
>>   }
>> diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> index acf6678..701c4c1 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
>> @@ -664,8 +664,9 @@ static int omap_dmm_probe(struct platform_device *dev)
>>   	}
>>
>>   	/* set dma mask for device */
>> -	/* NOTE: this is a workaround for the hwmod not initializing properly */
>> -	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +	ret = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		goto fail;
>
> Tested with omapdrm on omap4 panda es board.

Just wish to make sure - that's code for:

Tested-by: Archit Taneja <archit@ti.com>

to be added?

Thanks.
