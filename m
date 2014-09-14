From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sun, 14 Sep 2014 12:53:10 +0100
Subject: [PATCH v3 5/5] irqchip: gic: Add support for IPI FIQ
In-Reply-To: <540EB930.6010404@linaro.org>
References: <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-6-git-send-email-daniel.thompson@linaro.org>
 <20140908162316.GC12361@n2100.arm.linux.org.uk> <540EB930.6010404@linaro.org>
Message-ID: <541581A6.6090803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/14 09:24, Daniel Thompson wrote:
> On 08/09/14 17:23, Russell King - ARM Linux wrote:
>> On Mon, Sep 08, 2014 at 04:28:35PM +0100, Daniel Thompson wrote:
>>> @@ -604,8 +731,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>>  {
>>>  	int cpu;
>>>  	unsigned long flags, map = 0;
>>> +	unsigned long softint;
>>>  
>>> -	raw_spin_lock_irqsave(&irq_controller_lock, flags);
>>> +	/*
>>> +	 * The locking in this function ensures we don't use stale cpu mappings
>>> +	 * and thus we never route an IPI to the wrong physical core during a
>>> +	 * big.LITTLE switch. The switch code takes both of these locks meaning
>>> +	 * we can choose whichever lock is safe to use from our current calling
>>> +	 * context.
>>> +	 */
>>> +	if (in_nmi())
>>> +		raw_spin_lock(&fiq_safe_migration_lock);
>>> +	else
>>> +		raw_spin_lock_irqsave(&irq_controller_lock, flags);
>>
>> Firstly, why would gic_raise_softirq() be called in FIQ context?
> 
> Oops.
> 
> This code should have been removed. It *is* required for kgdb (which
> needs to send FIQ to other processors via IPI and may itself be running
> from FIQ) but it not needed for the currently targeted use case.

I'm afraid I was wrong about this. gic_raise_softitq() is called during
console unlocking inside wake_up_klogd(). This means it is required even
to support arch_trigger_all_cpu_backtrace.

I'm trying to get a (tested) refresh of the FIQ + trigger_backtrace out
today. Thus for now I plan to reinstate the code above (which I believe
to be safe because FIQ is disabled throughout a b.L switch).

Nevertheless I won't ignore this comment! I think a using a r/w lock
here can be made FIQ-safe without having to rely on in_nmi() based
conditional branches.


Daniel.


>> Secondly,
>> this doesn't save you.  If you were in the middle of gic_migrate_target()
>> when the FIQ happened that (for some reason prompted you to call this),
>> you would immediately deadlock trying to that this IRQ.
> 
> This cannot happen because gic_migrate_target() runs with FIQ disabled.
> 
> 
>> I suggest not even trying to solve this "race" which I don't think is
>> one which needs to even be considered (due to the first point.)
> 
> As mentioned above I believe it eventually needs to be addressed by some
> means but it certainly doesn't belong in the current patchset.
> 
> I will remove it.
> 
