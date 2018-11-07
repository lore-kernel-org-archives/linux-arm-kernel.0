From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Wed, 7 Nov 2018 14:54:17 +0000
Subject: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
In-Reply-To: <20181106210933.GU24212@piout.net>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
Message-ID: <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 06.11.2018 23:09, Alexandre Belloni wrote:
> Hi Claudiu,
> 
> On 05/11/2018 11:14:26+0000, Claudiu.Beznea at microchip.com wrote:
>>  static int __init at91_poweroff_probe(struct platform_device *pdev)
>> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
>>  	u32 ddr_type;
>>  	int ret;
>>  
>> +	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
>> +	if (!at91_shdwc)
>> +		return -ENOMEM;
>> +
> 
> Is there any real benefit that will offset the time lost for that
> allocation at boot time?

No, I haven't run benchmarks on this. I only wanted to have them grouped in
one structure. Please let me know if you have some tests in mind.

> 
> I understand you are then testing at91_shdwc to know whether the driver
> already probed once. But, the driver will never probe twice as there is
> only one shutdown controller on the SoC and anyway, If it was to probe
> twice, it will still work as expected.

I had in mind the scenario where the driver would be compiled as module. I
know insmod already does this checking. I'm ok to remove this checking. I
will do it in next version. With this I will also remove devm_kzalloc() of
at91_shdwc.

Thank you,
Claudiu Beznea

> 
> 
