From: khilman@ti.com (Kevin Hilman)
Date: Fri, 05 Aug 2011 07:57:54 -0700
Subject: [PATCH 6/6] OMAP: McBSP: use existing macros for converting
	between devices
In-Reply-To: <20110805090244.f6e5f65a6829138d929bd4a9@gmail.com> (Jarkko
	Nikula's message of "Fri, 5 Aug 2011 09:02:44 +0300")
References: <1312472710-31758-1-git-send-email-khilman@ti.com>
	<1312472710-31758-7-git-send-email-khilman@ti.com>
	<20110805090244.f6e5f65a6829138d929bd4a9@gmail.com>
Message-ID: <87mxfnucr1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jarkko Nikula <jhnikula@gmail.com> writes:

> Hi Kevin
>
> On Thu,  4 Aug 2011 08:45:10 -0700
> Kevin Hilman <khilman@ti.com> wrote:
>
>> For converting from struct device to platform_device, and from
>> platform_device to struct omap_device, there are existing macros.  Use
>> them instead of manual use of container_of().
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/plat-omap/mcbsp.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
>> index 3c1fbdc..47016f7 100644
>> --- a/arch/arm/plat-omap/mcbsp.c
>> +++ b/arch/arm/plat-omap/mcbsp.c
>> @@ -260,9 +260,9 @@ EXPORT_SYMBOL(omap_mcbsp_dma_reg_params);
>>  #ifdef CONFIG_ARCH_OMAP3
>>  static struct omap_device *find_omap_device_by_dev(struct device *dev)
>>  {
>> -	struct platform_device *pdev = container_of(dev,
>> -					struct platform_device, dev);
>> -	return container_of(pdev, struct omap_device, pdev);
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +
>> +	return to_omap_device(pdev);
>>  }
>>  
> I have a better alternative (that removes these unused lines) here:
>
> http://marc.info/?l=linux-omap&m=130951039226392&w=2

Indeed, that's a much better alternative.  I didn't bother to check if
th resulting omap_device pointer was actually used.

> I'm fine if you need to take my patch if there's urgent need to modify
> these lines or otherwise I can carry it when sending an updated version
> of my earlier McBSP cleanup set.

Yeah, yours is a better patch and we should take that one.  Feel free to
add 

Acked-by: Kevin Hilman <khilman@ti.com>

I'll include it in my series for reference also (because I need it due
to modifying how platform_device is contained within an omap_device) but
yours will probably make it upstream first since I'm about to go offline
for ~2 weeks.

Thanks,

Kevin
