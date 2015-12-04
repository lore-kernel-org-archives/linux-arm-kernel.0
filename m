From: james.morse@arm.com (James Morse)
Date: Fri, 04 Dec 2015 14:39:44 +0000
Subject: [PATCH v8 4/4] arm64: switch to irq_stack during softirq
In-Reply-To: <20151204140119.GL10123@e104818-lin.cambridge.arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-5-git-send-email-james.morse@arm.com>
 <20151204140119.GL10123@e104818-lin.cambridge.arm.com>
Message-ID: <5661A5B0.3080504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 04/12/15 14:01, Catalin Marinas wrote:
> On Fri, Dec 04, 2015 at 11:02:28AM +0000, James Morse wrote:
>> +ENTRY(__do_softirq_on_irqstack)
>> +	push	x19, lr
>> +	push	x25, x26
>> +
>> +	irq_stack_entry lr
>> +
>> +	/* irq_stack_entry leaves irq_count in x25 */
>> +	ldr	x1, [x25]
>> +	add	x1, x1, #1
>> +	str	x1, [x25]
>> +
>> +	bl	__do_softirq
>> +
>> +	ldr	x1, [x25]
>> +	sub	x1, x1, #1
>> +	str	x1, [x25]
>> +
>> +	irq_stack_exit
>> +
>> +	pop x25, x26
>> +	pop x19, lr
>> +	ret
>> +ENDPROC(__do_softirq_on_irqstack)
> 
> I was thinking of doing do_softirq_own_stack() entirely in assembly
> without the need to check for on_irq_stack() check in C, just a test of
> the irq_count value.

I tried that, but couldn't get it to work - maybe I'm missing a trick:

There are at least two ways into do_softirq_own_stack():
el1_irq() -> __irq_exit() -> do_softirq_own_stack(),
as well as:
cpu_switch_to(ksoftirqd) -> do_softirq_own_stack()

In both cases irq_count == 0 because do_softirq_own_stack() is where we
update irq_count [0]. I can only see two ways to tell them apart,
increment irq_count in el1_irq(), (which we don't like), or have that
bounds checking.


(We could increase hardirq_count() in el?_irq(), which would mean
in_irq()/in_interrupt() always returns true when on the irq_stack, which
would stop softirqs being processed here... but that is a fairly
significant change in behaviour.)


Thanks,

James

[0] http://article.gmane.org/gmane.linux.kernel/2041877
