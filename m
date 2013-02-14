From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 14 Feb 2013 14:45:44 +0200
Subject: [PATCH v2 02/10] gpio: pxa: avoid to use global irq base
In-Reply-To: <CACRpkdazd+JyKz4rrptFkJ6RrP9+2S1oM=iPnqRdGj=m21PeGw@mail.gmail.com>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <1359886551-20950-3-git-send-email-haojian.zhuang@linaro.org>
 <511BA0AF.8040904@compulab.co.il>
 <CAD6h2NRO6N1pRfq_=ybj5TSwC7gieYOffcQmfTyUiP5R_3fWig@mail.gmail.com>
 <511CADE4.1000007@compulab.co.il>
 <CACRpkdazd+JyKz4rrptFkJ6RrP9+2S1oM=iPnqRdGj=m21PeGw@mail.gmail.com>
Message-ID: <511CDC78.2000400@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/13 14:19, Linus Walleij wrote:
> On Thu, Feb 14, 2013 at 10:27 AM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> 
>> It looks like I've figured this out...
>> For em-x270 as an example, if I move the IRQ resource assignment to runtime:
>>
>> diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
>> index 1b64114..178cc0b 100644
>> --- a/arch/arm/mach-pxa/em-x270.c
>> +++ b/arch/arm/mach-pxa/em-x270.c
>> @@ -210,8 +210,6 @@ static struct resource em_x270_dm9000_resource[] = {
>>                 .flags = IORESOURCE_MEM,
>>         },
>>         [2] = {
>> -               .start = EM_X270_ETHIRQ,
>> -               .end   = EM_X270_ETHIRQ,
>>                 .flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
>>         }
>>  };
>> @@ -232,6 +230,9 @@ static struct platform_device em_x270_dm9000 = {
>>
>>  static void __init em_x270_init_dm9000(void)
>>  {
>> +       em_x270_dm9000_resource[2].start = gpio_to_irq(GPIO41_ETHIRQ);
>> +       em_x270_dm9000_resource[2].end = gpio_to_irq(GPIO41_ETHIRQ);
>> +
>>         em_x270_dm9000_platdata.flags |= dm9000_flags;
>>         platform_device_register(&em_x270_dm9000);
>>  }
>>
>> The Ethernet is alive and NFS root works fine.
>>
>> So my conclusion, is that we still need to have some work done
>> before we can switch to using IRQ_DOMAIN.
>> As you can see from above patch, we at least must deal with the
>> PXA_GPIO_TO_IRQ macros and alike that have compile time assumptions
>> which obviously get broken once you switch to the IRQ_DOMAIN.
>>
>> What do you think?
> 
> I think it seems like you should review all the IRQ assignments in that
> former GPIO range. Statically encoding IRQ numbers for GPIO things
> is usually not a good idea, it's better to always use gpio_to_irq()
> on these and only keep hard-coded GPIO numbers around (atleast
> just *one* problem to worry about).

Well, it always worked like this...
Now it is clear that we cannot continue doing it
(at least not with current IRQ_DOMAIN).

In order to merge this patch, we need to either remove
the static PXA_GPIO_TO_IRQ macros and alike, or teach the IRQ_DOMAIN
somehow to know about these.
I don't know what from the above is easier to do, as I did not looked
deeper into this.

I might have some time to look into this in two weeks from now,
but I guess it will be too late as Haojian wants this patch set
to go into 3.9.


-- 
Regards,
Igor.
