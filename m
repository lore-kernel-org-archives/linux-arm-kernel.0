From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 5 Jul 2016 09:47:43 +0200
Subject: [PATCH] clocksource: timer-atmel-pit: enable mck
In-Reply-To: <20160704222404.5132c3d3@bbrezillon>
References: <1467648009-24269-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160704222404.5132c3d3@bbrezillon>
Message-ID: <577B661F.5090703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/07/2016 22:24, Boris Brezillon a ?crit :
> On Mon,  4 Jul 2016 18:00:09 +0200
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
>> mck is needed to get the PIT working. Explicitly prepare_enable it instead
>> of assuming it is enabled.
>>
>> This solves an issue were the system is freezing when the ETM/ETB drivers
> 
> 			^ where
> 
>> are enabled.
>>
>> Reported-by: Olivier Schonken <olivier.schonken@gmail.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

>> ---
>>  drivers/clocksource/timer-atmel-pit.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
>> index d911c5dca8f1..fcc97711cd79 100644
>> --- a/drivers/clocksource/timer-atmel-pit.c
>> +++ b/drivers/clocksource/timer-atmel-pit.c
>> @@ -248,6 +248,9 @@ static void __init at91sam926x_pit_dt_init(struct device_node *node)
>>  	if (IS_ERR(data->mck))
>>  		panic(pr_fmt("Unable to get mck clk\n"));
>>  
>> +	if (clk_prepare_enable(data->mck))
>> +		panic(pr_fmt("Unable to enable mck\n"));
>> +
>>  	/* Get the interrupts property */
>>  	data->irq = irq_of_parse_and_map(node, 0);
>>  	if (!data->irq)
> 
> 


-- 
Nicolas Ferre
