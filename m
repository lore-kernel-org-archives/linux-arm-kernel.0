From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 28 Nov 2014 09:21:44 +0000
Subject: [PATCH 3.18-rc4 v11 3/6] irqchip: gic: Make gic_raise_softirq
 FIQ-safe
In-Reply-To: <alpine.DEB.2.11.1411272238190.3961@nanos>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1417119024-22844-1-git-send-email-daniel.thompson@linaro.org>
 <1417119024-22844-4-git-send-email-daniel.thompson@linaro.org>
 <alpine.DEB.2.11.1411272238190.3961@nanos>
Message-ID: <54783EA8.9080409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/14 21:45, Thomas Gleixner wrote:
> On Thu, 27 Nov 2014, Daniel Thompson wrote:
>> It is currently possible for FIQ handlers to re-enter gic_raise_softirq()
>> and lock up.
>>
>>     	gic_raise_softirq()
>> 	   lock(x);
>> -~-> FIQ
>>         handle_fiq()
>> 	   gic_raise_softirq()
>> 	      lock(x);		<-- Lockup
>>
>> Calling printk() from a FIQ handler can trigger this problem because
>> printk() raises an IPI when it needs to wake_up_klogd(). More generally,
>> IPIs are the only means for FIQ handlers to safely defer work to less
>> restrictive calling context so the function to raise them really needs
>> to be FIQ-safe.
> 
> That's not really true. irq_work can be used from FIQ/NMI context and
> it was specifically designed for that purpose.

Actually we cannot currently issue irq_work used from FIQ context;
that's exactly what this patch fixes and is why wake_up_klogd()
currently locks up. ARM implements arch_irq_work_raise() using IPIs (at
least on SMP).

I'll fix the wording to make this more explicit.


> Now printk is a different issue, but there is work in progress to make
> printk safe from FIQ/NMI context as well. This is not an ARM specific
> issue. Any architecture which has NMI like facilities has the problem
> of doing printk from that context. Steven is working on a mitigation
> for that. https://lkml.org/lkml/2014/11/18/1146

Thanks. I'll watch that with interest.

In that case I'll drop the printk() rationale entirely. The rationale
above shoudl be enough motivation because the only other thing likely to
printk() from interrupt is the hard lockup detector and, because that
uses perf events, it requires irq_work be be free from lockups way
before it ever thinks about calling printk().
