From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 7 Jan 2015 10:04:11 +0100
Subject: [PATCH] irqchip: atmel-aic-common: prevent clobbering of priority
 when changing IRQ type
In-Reply-To: <20150107030922.GF24989@titan.lakedaemon.net>
References: <1420598843-8409-1-git-send-email-gavinli@thegavinli.com>
 <20150107030922.GF24989@titan.lakedaemon.net>
Message-ID: <54ACF68B.2040000@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/01/2015 04:09, Jason Cooper a ?crit :
> atmel maintainers,
> 
> On Tue, Jan 06, 2015 at 06:47:23PM -0800, gavinli at thegavinli.com wrote:
>> From: Gavin Li <git@thegavinli.com>
>>
>> This patch makes the bitmask for AIC_SRCTYPE consistent
>> with that of its valid values, and prevents the priority
>> field at bits 2:0 from being clobbered by an incorrect
>> AND with the AIC_SRCTYPE mask.
>>
>> Signed-off-by: Gavin Li <gavinli@thegavinli.com>
>> ---
>>  drivers/irqchip/irq-atmel-aic-common.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Please give an Acked-by if this looks good to you.  I'd like to get it
> pushed fairly soon.

Hi Jason,

After a private message with Boris, here is our:
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

It is indeed a pretty important fix.

(I added the linux-arm-kernel mailing-list for the record).

Moreover, can you please add a stable tag like:
Cc: <stable@vger.kernel.org> # 3.17+

Thanks a lot Gavin Li for having spotted this bug!

Bye,

>> diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
>> index cc4f9d8..fa22e5b 100644
>> --- a/drivers/irqchip/irq-atmel-aic-common.c
>> +++ b/drivers/irqchip/irq-atmel-aic-common.c
>> @@ -28,7 +28,7 @@
>>  #define AT91_AIC_IRQ_MIN_PRIORITY	0
>>  #define AT91_AIC_IRQ_MAX_PRIORITY	7
>>  
>> -#define AT91_AIC_SRCTYPE		GENMASK(7, 6)
>> +#define AT91_AIC_SRCTYPE		GENMASK(6, 5)
>>  #define AT91_AIC_SRCTYPE_LOW		(0 << 5)
>>  #define AT91_AIC_SRCTYPE_FALLING	(1 << 5)
>>  #define AT91_AIC_SRCTYPE_HIGH		(2 << 5)
>> @@ -74,7 +74,7 @@ int aic_common_set_type(struct irq_data *d, unsigned type, unsigned *val)
>>  		return -EINVAL;
>>  	}
>>  
>> -	*val &= AT91_AIC_SRCTYPE;
>> +	*val &= ~AT91_AIC_SRCTYPE;
>>  	*val |= aic_type;
>>  
>>  	return 0;
>> -- 
>> 2.2.1
>>
> 


-- 
Nicolas Ferre
