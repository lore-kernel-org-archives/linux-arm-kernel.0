From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 18 Sep 2014 14:20:48 -0700
Subject: [PATCH 3.17-rc4 v7 4/6] irqchip: gic: Add support for IPI FIQ
In-Reply-To: <20140918081739.GA5182@n2100.arm.linux.org.uk>
References: <1410970218-28847-1-git-send-email-daniel.thompson@linaro.org>
 <1410970218-28847-5-git-send-email-daniel.thompson@linaro.org>
 <20140918081739.GA5182@n2100.arm.linux.org.uk>
Message-ID: <541B4CB0.8040705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/14 01:17, Russell King - ARM Linux wrote:
> On Wed, Sep 17, 2014 at 09:10:16AM -0700, Daniel Thompson wrote:
>> @@ -604,8 +731,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>  {
>>  	int cpu;
>>  	unsigned long flags, map = 0;
>> +	unsigned long softint;
>>  
>> -	raw_spin_lock_irqsave(&irq_controller_lock, flags);
>> +	/*
>> +	 * The locking in this function ensures we don't use stale cpu mappings
>> +	 * and thus we never route an IPI to the wrong physical core during a
>> +	 * big.LITTLE switch. The switch code takes both of these locks meaning
>> +	 * we can choose whichever lock is safe to use from our current calling
>> +	 * context.
>> +	 */
>> +	if (in_nmi())
>> +		raw_spin_lock(&fiq_safe_migration_lock);
>> +	else
>> +		raw_spin_lock_irqsave(&irq_controller_lock, flags);
> 
> BTW, I see this code is still here...

Quite so.

I'm afraid I haven't yet re-written it to use r/w locks (as proposed in
mails from the weekend) but I had to respin the default FIQ handler
patch to fix the CONFIG_FIQ build problem I introduced.
