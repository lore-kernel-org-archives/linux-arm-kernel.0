From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 28 Jul 2011 19:34:31 +0200
Subject: [PATCH 4/4] dt: i2c-omap: Convert i2c driver to use device tree
In-Reply-To: <CACxGe6vG9BKUDvthOKFtx3u=Vq0EfBaZakxVqx8AYfRe_ruNdg@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-5-git-send-email-manjugk@ti.com>
	<CACxGe6vG9BKUDvthOKFtx3u=Vq0EfBaZakxVqx8AYfRe_ruNdg@mail.gmail.com>
Message-ID: <4E319DA7.5050608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 7/14/2011 1:20 AM, Grant Likely wrote:
> On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah<manjugk@ti.com>  wrote:
>>
>> The i2c-omap driver is converted for supporting both
>> dt and non dt builds and driver is modified to use dt
>> data partially.

[...]

>>         /* NOTE: driver uses the static register mapping */
>>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>         if (!mem) {
>> @@ -1011,11 +1026,25 @@ omap_i2c_probe(struct platform_device *pdev)
>>         if (pdata != NULL) {
>>                 speed = pdata->clkrate;
>>                 dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
>> +#if defined(CONFIG_OF)
>> +       } else if (pdev->dev.of_node) {
>> +               u32 prop;
>> +               if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> +&prop))
>> +                       speed = prop/100;
>> +               else
>> +                       speed = 100;

Do we have to modify every drivers in order to take advantage of the DT bus?
Cannot we init the already existing pdata during device creation and let 
the driver untouched?

I think it is a pity to add all that #ifdefry in the driver to be able 
to support two kinds of bus.

Cannot we have an intermediate phase that will deal only with the device 
creation with DT?
That will allow us to clean the omap_device creation from hwmod we have 
today spread everywhere in plat-omap and mach-omap2.

Regards
Benoit
