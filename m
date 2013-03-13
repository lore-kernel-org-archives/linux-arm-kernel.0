From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Mar 2013 10:21:06 +0100
Subject: [PATCH 3/4] ARM: at91: fix infinite loop in
 at91_irq_suspend/resume
In-Reply-To: <20130308155828.GC4590@game.jcrosoft.org>
References: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
 <1362755638-20092-4-git-send-email-ludovic.desroches@atmel.com>
 <20130308155828.GC4590@game.jcrosoft.org>
Message-ID: <51404502.3070702@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 04:58 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 16:13 Fri 08 Mar     , ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Fix an infinite loop when suspending or resuming a device with AIC5 i.e. SAMA5
>> devices.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

I think that we can queue this one for "fixes".

I integrated it in at91-3.9-fixes branch. It means that you can drop
this one from your patch series.

Thanks, best regards.

> 
> Best Regards,
> J.
>> ---
>>  arch/arm/mach-at91/irq.c | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
>> index 8e21026..e0ca591 100644
>> --- a/arch/arm/mach-at91/irq.c
>> +++ b/arch/arm/mach-at91/irq.c
>> @@ -92,23 +92,21 @@ static int at91_aic_set_wake(struct irq_data *d, unsigned value)
>>  
>>  void at91_irq_suspend(void)
>>  {
>> -	int i = 0, bit;
>> +	int bit = -1;
>>  
>>  	if (has_aic5()) {
>>  		/* disable enabled irqs */
>> -		while ((bit = find_next_bit(backups, n_irqs, i)) < n_irqs) {
>> +		while ((bit = find_next_bit(backups, n_irqs, bit + 1)) < n_irqs) {
>>  			at91_aic_write(AT91_AIC5_SSR,
>>  				       bit & AT91_AIC5_INTSEL_MSK);
>>  			at91_aic_write(AT91_AIC5_IDCR, 1);
>> -			i = bit;
>>  		}
>>  		/* enable wakeup irqs */
>> -		i = 0;
>> -		while ((bit = find_next_bit(wakeups, n_irqs, i)) < n_irqs) {
>> +		bit = -1;
>> +		while ((bit = find_next_bit(wakeups, n_irqs, bit + 1)) < n_irqs) {
>>  			at91_aic_write(AT91_AIC5_SSR,
>>  				       bit & AT91_AIC5_INTSEL_MSK);
>>  			at91_aic_write(AT91_AIC5_IECR, 1);
>> -			i = bit;
>>  		}
>>  	} else {
>>  		at91_aic_write(AT91_AIC_IDCR, *backups);
>> @@ -118,23 +116,21 @@ void at91_irq_suspend(void)
>>  
>>  void at91_irq_resume(void)
>>  {
>> -	int i = 0, bit;
>> +	int bit = -1;
>>  
>>  	if (has_aic5()) {
>>  		/* disable wakeup irqs */
>> -		while ((bit = find_next_bit(wakeups, n_irqs, i)) < n_irqs) {
>> +		while ((bit = find_next_bit(wakeups, n_irqs, bit + 1)) < n_irqs) {
>>  			at91_aic_write(AT91_AIC5_SSR,
>>  				       bit & AT91_AIC5_INTSEL_MSK);
>>  			at91_aic_write(AT91_AIC5_IDCR, 1);
>> -			i = bit;
>>  		}
>>  		/* enable irqs disabled for suspend */
>> -		i = 0;
>> -		while ((bit = find_next_bit(backups, n_irqs, i)) < n_irqs) {
>> +		bit = -1;
>> +		while ((bit = find_next_bit(backups, n_irqs, bit + 1)) < n_irqs) {
>>  			at91_aic_write(AT91_AIC5_SSR,
>>  				       bit & AT91_AIC5_INTSEL_MSK);
>>  			at91_aic_write(AT91_AIC5_IECR, 1);
>> -			i = bit;
>>  		}
>>  	} else {
>>  		at91_aic_write(AT91_AIC_IDCR, *wakeups);
>> -- 
>> 1.7.11.3
>>
> 
> 


-- 
Nicolas Ferre
