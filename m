From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Thu, 8 Sep 2011 16:41:30 +0100
Subject: [alsa-devel] [PATCH] ASoC: omap: convert per-board modules to
	platform drivers
In-Reply-To: <4E68DBF7.1030009@metafoo.de>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
	<4E68DBF7.1030009@metafoo.de>
Message-ID: <CAG5Tg6XxGP1YhQ0zW3f=1EkZfAmb9vj3pBemeSazpH1_CZ3OzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2011 16:15, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/08/2011 05:05 PM, Mans Rullgard wrote:
>> This converts the per-board modules to platform drivers for a
>> device created by in main platform setup. ?These drivers call
>> snd_soc_register_card() directly instead of going via a "soc-audio"
>> device and the corresponding driver in soc-core.
>>
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>> index 5b8ca68..7cb93d9 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -299,6 +299,11 @@ static struct platform_device omap_pcm = {
>> ? ? ? .id ? ? = -1,
>> ?};
>>
>> +static struct platform_device omap_soc_audio = {
>> + ? ? .name ? = "omap-soc-audio",
>> + ? ? .id ? ? = -1,
>> +};
>> +
>> ?/*
>> ? * OMAP2420 has 2 McBSP ports
>> ? * OMAP2430 has 5 McBSP ports
>> @@ -323,6 +328,7 @@ static void omap_init_audio(void)
>> ? ? ? ? ? ? ? platform_device_register(&omap_mcbsp5);
>>
>> ? ? ? platform_device_register(&omap_pcm);
>> + ? ? platform_device_register(&omap_soc_audio);
>> ?}
>>
>> ?#else
>> diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
>> index 73dde4a..fcd18af 100644
>> --- a/sound/soc/omap/am3517evm.c
>> +++ b/sound/soc/omap/am3517evm.c
>> @@ -151,45 +151,60 @@ static struct snd_soc_card snd_soc_am3517evm = {
>> ? ? ? .num_links = 1,
>> ?};
>>
>> [...]
>> +static struct platform_driver am3517evm_driver = {
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = "omap-soc-audio",
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? },
>>
>> - ? ? return ret;
>> + ? ? .probe = am3517evm_soc_probe,
>> + ? ? .remove = __devexit_p(am3517evm_soc_remove),
>> +};
>> +[...]
>> +
>> +static struct platform_driver igep2_driver = {
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = "omap-soc-audio",
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? },
>> +
>> + ? ? .probe = igep2_soc_probe,
>> + ? ? .remove = __devexit_p(igep2_soc_remove),
>> +};
>> [...]
>>
>> +static struct platform_driver n810_driver = {
>> + ? ? .driver = {
>> + ? ? ? ? ? ? .name = "omap-soc-audio",
>> + ? ? ? ? ? ? .owner = THIS_MODULE,
>> + ? ? },
>> +
>> + ? ? .probe = n810_soc_probe,
>> + ? ? .remove = __devexit_p(n810_soc_remove),
>> +};
>> [...]
>
> This isn't really any better then using the soc-core device, since all your
> drivers are still named the same. udev still wouldn't know which one to load.
> Use different device driver names for different drivers.

I guess this worked by accident on my system.

Are there any other changes needed?

-- 
Mans Rullgard
Multimedia
mans.rullgard at linaro.org
