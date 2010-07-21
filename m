From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Wed, 21 Jul 2010 11:08:31 +0200
Subject: [PATCH 1/3] i.MX51: handle IRQ for gpio 16..31
In-Reply-To: <1279703092.5412.47.camel@ra7055-laptop>
References: <1279610174-6025-1-git-send-email-eric@eukrea.com>
	<1279703092.5412.47.camel@ra7055-laptop>
Message-ID: <4C46B90F.9070200@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Le 21/07/2010 11:04, Rob Herring a ?crit :
> On Tue, 2010-07-20 at 09:16 +0200, Eric B?nard wrote:
>> The i.MX51 generates 2 IRQ for each GPIO bank : one for gpio 0 to 15
>> and one for gpio 16 to 31.
>> Actually only the lower IRQ is registered so register the second one.
>>
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>> ---
>>   arch/arm/plat-mxc/gpio.c |    6 ++++++
>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
>> index 71437c6..7e64bba 100644
>> --- a/arch/arm/plat-mxc/gpio.c
>> +++ b/arch/arm/plat-mxc/gpio.c
>> @@ -293,6 +293,12 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>>   			set_irq_chained_handler(port[i].irq, mx3_gpio_irq_handler);
>>   			set_irq_data(port[i].irq,&port[i]);
>>   		}
>> +		if (cpu_is_mx51()) {
>> +			/* setup handler for GPIO 16 to 31 */
>> +			set_irq_chained_handler(port[i].irq + 1,
>> +					mx3_gpio_irq_handler);
>> +			set_irq_data(port[i].irq + 1,&port[i]);
>
> This is making an assumption that the high irq line is 1 more than low
> one. There is no guarantee this will always be true. This will also then
> require change when adding MX53 support and other new chips in the
> pipeline.
>
> Adding irq_high field to struct mxc_gpio_port and setting up the handler
> when it is non-zero will avoid a cpu_is_x.
>
OK, I'll update the patch this way.
Thanks,
Eric
