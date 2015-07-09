From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 9 Jul 2015 14:46:40 +0200
Subject: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <20150709120335.GW28632@lukather>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150709120335.GW28632@lukather>
Message-ID: <559E6D30.701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/07/2015 14:03, Maxime Ripard a ?crit :
> Hi,
> 
> On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
>> As since sama5d3, to reset the chip, we don't need to shutdown the ddr
>> controller.
>>
>> So add a new compatible string and new restart function for sama5d3 and
>> later chips. As we don't use sama5d3 ddr controller, so remove it as
>> well.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>
>>  drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
>> index 36dc52f..8944b63 100644
>> --- a/drivers/power/reset/at91-reset.c
>> +++ b/drivers/power/reset/at91-reset.c
>> @@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
>>  	return NOTIFY_DONE;
>>  }
>>  
>> +static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
>> +			void *cmd)
>> +{
>> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
>> +				at91_rstc_base);
>> +	return NOTIFY_DONE;
>> +}
>> +
>>  static void __init at91_reset_status(struct platform_device *pdev)
>>  {
>>  	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
>> @@ -155,13 +163,13 @@ static void __init at91_reset_status(struct platform_device *pdev)
>>  static const struct of_device_id at91_ramc_of_match[] = {
>>  	{ .compatible = "atmel,at91sam9260-sdramc", },
>>  	{ .compatible = "atmel,at91sam9g45-ddramc", },
>> -	{ .compatible = "atmel,sama5d3-ddramc", },
>>  	{ /* sentinel */ }
>>  };
>>  
>>  static const struct of_device_id at91_reset_of_match[] = {
>>  	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
>>  	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
>> +	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
>>  	{ /* sentinel */ }
>>  };
>>  
>> @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_device *pdev)
>>  		return -ENODEV;
>>  	}
>>  
>> -	for_each_matching_node(np, at91_ramc_of_match) {
>> -		at91_ramc_base[idx] = of_iomap(np, 0);
>> -		if (!at91_ramc_base[idx]) {
>> -			dev_err(&pdev->dev, "Could not map ram controller address\n");
>> -			return -ENODEV;
>> +	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
>> +	at91_restart_nb.notifier_call = match->data;
>> +
>> +	if (match->data != sama5d3_restart) {
> 
> Using of_device_is_compatible seems more appropriate.
> 
> Also, why are you changing the order of this loop and the notifier
> registration?

Well, it's because the sama5d3 onwards controllers don't need ramc
controller.
So, reverting the order seems needed. Doesn't it address your question,
or did I lost track?

Bye,
-- 
Nicolas Ferre
