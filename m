From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 28 Feb 2014 10:06:25 -0500
Subject: [PATCH v2 5/7] ARM: of: introduce common routine for DMA
 configuration
In-Reply-To: <9618080.kpE3Kl6X8p@wuerfel>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <1393535872-20915-6-git-send-email-santosh.shilimkar@ti.com>
 <9618080.kpE3Kl6X8p@wuerfel>
Message-ID: <5310A5F1.9070901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 05:00 AM, Arnd Bergmann wrote:
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> > index 404d1da..97d5533 100644
>> > --- a/drivers/of/platform.c
>> > +++ b/drivers/of/platform.c
>> > @@ -213,10 +213,13 @@ static struct platform_device *of_platform_device_create_pdata(
>> >  
>> >  #if defined(CONFIG_MICROBLAZE)
>> >  	dev->archdata.dma_mask = 0xffffffffUL;
>> > -#endif
>> > +#elif defined(CONFIG_ARM_LPAE)
>> > +	arm_dt_dma_configure(&dev->dev);
>> > +#else
>> >  	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> >  	if (!dev->dev.dma_mask)
>> >  		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>> > +#endif
> The dependency on CONFIG_ARM_LPAE is not correct the general case,
> that would be a special case on keystone. I'd suggest using
> CONFIG_ARM here, and finding a different way to return false
> for dma_is_coherent() on keystone with LPAE disabled.
> 
I made that LPAE specific assuming the 32 machines anyway are
happy with default as they are today. We can keep CONFIG_ARM
and handle the special case in machine platform notifier.

Regards,
Santosh
