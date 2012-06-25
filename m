From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 25 Jun 2012 11:00:13 +0530
Subject: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
In-Reply-To: <alpine.DEB.2.00.1206221312400.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-7-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1206221312400.10198@utopia.booyaka.com>
Message-ID: <4FE7F765.40405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 June 2012 12:47 AM, Paul Walmsley wrote:
> Hi
>
> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>
>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>> for omap gpio debounce clock.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> ---
>>   drivers/gpio/gpio-omap.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index c4ed172..6a73b01 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -893,6 +893,8 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
>>   		bank->dbck = clk_get(bank->dev, "dbclk");
>>   		if (IS_ERR(bank->dbck))
>>   			dev_err(bank->dev, "Could not get gpio dbck\n");
>> +		else
>> +			clk_prepare(bank->dbck);
>>   	}
>>
>>   	spin_lock_irqsave(&bank->lock, flags);
>
> What code unprepares this clock?
>
> Put differently, doesn't this driver need at least a platform_driver
> .remove function pointer, that would call clk_unprepare() and clk_put()?

Maybe because this driver can never be built as a module. It gets
complied in with CONFIG_ARCH_OMAP=y.

Adding Tarun and Santosh who can comment further.

>
> Also, it looks to me that the bank->dbck init should be in
> omap_gpio_chip_init(), not gpio_debounce()?

Tarun, can you comment on why the dbck init is in gpio_debounce
and not in omap_gpio_chip_init()?

>
>
> - Paul
