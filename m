From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue, 20 Nov 2012 13:50:46 +0100
Subject: [PATCH v5 3/8] watchdog: orion_wdt: add timeout-sec property
 binding
In-Reply-To: <20121119160643.GI22106@titan.lakedaemon.net>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
 <1353334243-16703-4-git-send-email-fabio.porcedda@gmail.com>
 <20121119160643.GI22106@titan.lakedaemon.net>
Message-ID: <CAHkwnC-2MXtNODnqjOvFuHt7ToqvMqeDjnqdGyGfMacKBWzoLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 5:06 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Mon, Nov 19, 2012 at 03:10:38PM +0100, Fabio Porcedda wrote:
>> Only compile tested.
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> ---
>>  Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
>>  drivers/watchdog/orion_wdt.c                          | 8 +++-----
>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
>> index 0b2503a..5dc8d30 100644
>> --- a/Documentation/devicetree/bindings/watchdog/marvel.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
>> @@ -5,10 +5,15 @@ Required Properties:
>>  - Compatibility : "marvell,orion-wdt"
>>  - reg                : Address of the timer registers
>>
>> +Optional properties:
>> +
>> +- timeout-sec        : Contains the watchdog timeout in seconds
>> +
>>  Example:
>>
>>       wdt at 20300 {
>>               compatible = "marvell,orion-wdt";
>>               reg = <0x20300 0x28>;
>> +             timeout-sec = <10>;
>>               status = "okay";
>>       };
>> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
>> index c20f96b..446a3e9 100644
>> --- a/drivers/watchdog/orion_wdt.c
>> +++ b/drivers/watchdog/orion_wdt.c
>> @@ -162,12 +162,10 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
>>
>>       wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
>>
>> -     if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
>> -             heartbeat = wdt_max_duration;
>> -
>> -     orion_wdt.timeout = heartbeat;
>>       orion_wdt.min_timeout = 1;
>> +     orion_wdt.timeout = wdt_max_duration;
>>       orion_wdt.max_timeout = wdt_max_duration;
>> +     watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
>
> Hi Fabio,
>
> There are many boards using pdata, !CONFIG_OF.  Have you compile-tested
> this without CONFIG_OF?

Hi Jason,

I've tested with and without the CONFIG_OF define.

The first time I?ve used the kirkwood_defconfig without modifications,
the second time I?ve enabled only the CONFIG_MACH_SHEEVAPLUG and
disabled USE_OF.

In both cases the orion_wdt driver compile without any warning.

Thanks for the review.

Best regards

> thx,
>
> Jason.
>
>>
>>       watchdog_set_nowayout(&orion_wdt, nowayout);
>>       ret = watchdog_register_device(&orion_wdt);
>> @@ -177,7 +175,7 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
>>       }
>>
>>       pr_info("Initial timeout %d sec%s\n",
>> -             heartbeat, nowayout ? ", nowayout" : "");
>> +             orion_wdt.timeout, nowayout ? ", nowayout" : "");
>>       return 0;
>>  }
>>
>> --
>> 1.8.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--
Fabio Porcedda
