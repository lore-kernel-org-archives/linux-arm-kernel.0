From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 03 Nov 2009 22:23:07 +0100
Subject: [PATCH] IXP4xx: Ensure index is positive
In-Reply-To: <4AF0922B.3030701@hiramoto.org> (Karl Hiramoto's message of "Tue,
	03 Nov 2009 21:27:23 +0100")
References: <4AF08014.4000704@gmail.com> <4AF0922B.3030701@hiramoto.org>
Message-ID: <m3eiofl2v8.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Karl Hiramoto <karl@hiramoto.org> writes:

>> +++ b/arch/arm/mach-ixp4xx/common.c
>> @@ -119,7 +119,7 @@ EXPORT_SYMBOL(gpio_to_irq);
>>   int irq_to_gpio(int irq)
>>  {
>> -	int gpio = (irq < 32) ? irq2gpio[irq] : -EINVAL;
>> +	int gpio = (irq < 32 && irq >= 0) ? irq2gpio[irq] : -EINVAL;
>>   	if (gpio == -1)
>>  		return -EINVAL;

>> +++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
>> @@ -667,7 +667,7 @@ err:
>>   struct npe *npe_request(int id)
>>  {
>> -	if (id < NPE_COUNT)
>> +	if (id >= 0 && id < NPE_COUNT)

> changing npe_request() to unsigned would probably be better and  not
> add to bloat.   If your calling these functions with negative
> arguments, your code is buggy then.

Right. Both files in fact.

Even the id < NPE_COUNT test is probably not needed but I can imagine
someone lowering NPE_COUNT. Negative values are unreasonable (though
unsigned type make this unrelevant, of course).
-- 
Krzysztof Halasa
