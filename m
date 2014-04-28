From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 28 Apr 2014 22:06:25 +0200
Subject: [PATCH RESEND 3/3] irqchip: orion: reverse irq handling priority
In-Reply-To: <alpine.DEB.2.02.1404282137240.6261@ionos.tec.linutronix.de>
References: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398540855-27367-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.DEB.2.02.1404282137240.6261@ionos.tec.linutronix.de>
Message-ID: <535EB4C1.9090603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 09:39 PM, Thomas Gleixner wrote:
> On Sat, 26 Apr 2014, Sebastian Hesselbarth wrote:
> 
>> Non-DT irq handlers were working through irq causes from most-significant
>> to least-significant bit, while DT irqchip driver does it the other way
>> round. This revealed some more HW issues on Kirkwood peripheral IP, where
>> spurious sdio irqs can happen although IP's irq enable registers are all
>> zero. Although, not directly related with the described issue, reverse
>> irq bit handling back to original order by replacing ffs() with fls().
> 
> So why are we reverting to the original order?
> 
> The explanation above is just confusing.

Actually, I first wanted to reply "The original order worked for
years, so get back to it." But then I thought about finding a better
answer and remembered some comment of Russell a while ago.

I disassembled the generated binary and the original order saves two
instructions for each bit count using clz.

With this patch:
  60:   e3a07001        mov     r7, #1
  64:   e16f3f14        clz     r3, r4
  68:   e263301f        rsb     r3, r3, #31
  6c:   e1c44317        bic     r4, r4, r7, lsl r3
  70:   e5951004        ldr     r1, [r5, #4]

Without this patch:
  60:   e3a06001        mov     r6, #1
  64:   e2643000        rsb     r3, r4, #0
  68:   e0033004        and     r3, r3, r4
  6c:   e16f3f13        clz     r3, r3
  70:   e263301f        rsb     r3, r3, #31
  74:   e1c44316        bic     r4, r4, r6, lsl r3
  78:   e5971004        ldr     r1, [r7, #4]

You want me to reword the commit message accordingly?

Sebastian

>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>> ---
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>  drivers/irqchip/irq-orion.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
>> index e25f246cd2fb..34d18b48bb78 100644
>> --- a/drivers/irqchip/irq-orion.c
>> +++ b/drivers/irqchip/irq-orion.c
>> @@ -42,7 +42,7 @@ __exception_irq_entry orion_handle_irq(struct pt_regs *regs)
>>  		u32 stat = readl_relaxed(gc->reg_base + ORION_IRQ_CAUSE) &
>>  			gc->mask_cache;
>>  		while (stat) {
>> -			u32 hwirq = ffs(stat) - 1;
>> +			u32 hwirq = __fls(stat);
>>  			u32 irq = irq_find_mapping(orion_irq_domain,
>>  						   gc->irq_base + hwirq);
>>  			handle_IRQ(irq, regs);
>> @@ -117,7 +117,7 @@ static void orion_bridge_irq_handler(unsigned int irq, struct irq_desc *desc)
>>  		   gc->mask_cache;
>>  
>>  	while (stat) {
>> -		u32 hwirq = ffs(stat) - 1;
>> +		u32 hwirq = __fls(stat);
>>  
>>  		generic_handle_irq(irq_find_mapping(d, gc->irq_base + hwirq));
>>  		stat &= ~(1 << hwirq);
>> -- 
>> 1.9.1
>>
>>
