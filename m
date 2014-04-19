From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 19 Apr 2014 11:09:20 +0200
Subject: [PATCH 14/29] ARM: orion: switch to a per-platform handle_irq()
 function
In-Reply-To: <20140419092708.78eb9274@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-15-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BBB30.5090602@gmail.com> <20140419092708.78eb9274@skate>
Message-ID: <53523D40.4080703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2014 09:27 AM, Thomas Petazzoni wrote:
> Dear Sebastian Hesselbarth,
> 
> On Mon, 14 Apr 2014 12:40:48 +0200, Sebastian Hesselbarth wrote:
> 
>>> +static asmlinkage void
>>> +__exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
>>> +{
>>> +	u32 stat;
>>> +
>>> +	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_LOW_OFF);
>>> +	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_LOW_OFF);
>>> +	if (stat) {
>>> +		unsigned int hwirq = __fls(stat);
>>> +		handle_IRQ(hwirq, regs);
>>> +		return;
>>> +	}
>>
>> I remember we talked about it already, but IMHO copying the multi-irq
>> handler to mach-{kirkwood,dove} isn't necessary. The only situation we
>> need this is when you compile _one_ mach-{kirkwood,dove,orion5x} with
>> both DT and non-DT.
>>
>> So, I think it is fine to just add
>>
>> #if !defined(CONFIG_MACH_ORION5X)
>>> +	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_HIGH_OFF);
>>> +	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_HIGH_OFF);
>>> +	if (stat) {
>>> +		unsigned int hwirq = 32 + __fls(stat);
>>> +		handle_IRQ(hwirq, regs);
>>> +		return;
>>> +	}
>> #endif
>>
>> in the original handler?
> 
> Nope, it doesn't work, because mach-orion5x doesn't define
> IRQ_VIRT_BASE, IRQ_CAUSE_LOW_OFF and IRQ_MASK_LOW_OFF, so the common
> handler does not build, even after compiling-out the part you mention
> here.
> 
> Of course, Orion5x code can be changed to define those values, but I
> found it was not worth the effort, and Arnd Bergmann during an IRC
> discussion, also suggested to move the handle_irq() function to each
> individual mach-<foo> directory. And it actually makes sense, because
> it's only the same between Kirkwood and Dove: Orion5x and mv78xx0 need
> different implementations.
> 
> Also, this approach goes towards the goal of reducing plat-orion/ code.
> Having the code closer to each SoC is going to make it easier to
> progressively get rid of it I believe.

Ok, I agree. But IIRC the multi-irq handler is only needed, if you
compile both DT and non-DT in one kernel, right?

Dove DT just left mach-dove, so there is no way you can compile both.
For the sake of simplicity, I'd even agree on adding it now and
remove it later again. But at least for Dove, the move is bogus.

Sebastian
