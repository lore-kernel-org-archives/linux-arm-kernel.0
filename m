From: hechtb@gmail.com (Bastian Hecht)
Date: Tue, 26 Mar 2013 12:03:55 +0100
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7740: Migrate from INTC to GIC
In-Reply-To: <87zjxrhukr.wl%kuninori.morimoto.gx@renesas.com>
References: <1364219503-7738-1-git-send-email-hechtb+renesas@gmail.com>
 <1364219503-7738-2-git-send-email-hechtb+renesas@gmail.com>
 <87zjxrhukr.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CABYn4szP7QSh2vEax1PeuZvc5nkFmQX80a7tLMgwHYkMFp6K6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/26 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Bastian
>
>> With the added capabilty of the intc_irqpin driver to handle shared
>> external IRQs, all prerequisites are fulfilled and we are ready to
>> migrate completely to GIC. This includes the following steps:
>>
>> - Kconfig:    select ARM_GIC and RENESAS_INTC_IRQPIN
>> - intc-r8a7740: Throw out all legacy INTC code and init the GIC. We need
>>               to mask out all shared IRQs as it is needed by the
>>               shared intc_irqpin driver.
>> - setup-r8a7740: Add 4 irqpin devices to handle external IRQs and update
>>               all IRQ numbers to point to the GIC SPI.
>> - board-armadillo: Update all IRQ numbers to point to the GIC SPI.
>> - pfc-r8a7740:        Update all IRQ numbers of the GPIOs to point to the GIC
>>               SPI.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
> (snip)
>> @@ -548,14 +673,14 @@ static struct resource r8a7740_dmae2_resources[] = {
>>       },
>>       {
>>               .name   = "error_irq",
>> -             .start  = evt2irq(0x22c0),
>> -             .end    = evt2irq(0x22c0),
>> +             .start  = gic_spi(42),
>> +             .end    = gic_spi(47),
>>               .flags  = IORESOURCE_IRQ,
>>       },
>>       {
>>               /* IRQ for channels 0-5 */
>> -             .start  = evt2irq(0x2200),
>> -             .end    = evt2irq(0x22a0),
>> +             .start  = gic_spi(48),
>> +             .end    = gic_spi(48),
>>               .flags  = IORESOURCE_IRQ,
>>       },
>>  };
>
> I guess, this is type ?
> error gic is 48, and channels 0-5 are 42 - 47 :) ?
>

The eyes of a hawk...

Corrected in v3, thanks, Morimoto-san!

> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
