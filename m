From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 12 Jun 2014 10:54:25 +0100
Subject: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
In-Reply-To: <CACRpkdaQnpk5FQWOjWXGhhXrnWjNKJo0=mHf2c9YZcrxTGoEPA@mail.gmail.com>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>	<1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>	<1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
 <CACRpkdaQnpk5FQWOjWXGhhXrnWjNKJo0=mHf2c9YZcrxTGoEPA@mail.gmail.com>
Message-ID: <539978D1.4000902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/14 09:37, Linus Walleij wrote:
> On Thu, Jun 5, 2014 at 11:53 AM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> 
>> Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
>> virq into a FIQ virq. This is too inflexible for multi-platform kernels
>> and makes runtime error checking impossible.
>>
>> We solve this by introducing a flexible mapping that allows interrupt
>> controllers that support FIQ to register those mappings. This, in turn,
>> makes it much possible for drivers in DT kernels to gain access to
>> FIQ virqs.
> 
> I always had a big problem with the term "virq" which I take to mean
> "virtual IRQ".

So do I...

That said, I think of it as the virtual as in virtual memory rather the
virtual contained within virtualization.


> The distinction is:
> 
> - Hardware IRQ offsets/numbers - a number encoded in HW
>   specs which we usually call hwirqs
> 
> - Linux IRQ numbers - just some number
> 
> Sometimes, just sometimes, the Linux IRQ number matches the
> HW numbers, and then I guess the IRQ is regarded "non-virtual".
> The only real effect being that the numbers shown in
> /proc/interrupts are the same in both columns... the leftmost
> column with the Linux IRQ number and the one right next to
> the IRQ controller name which is the hwirq local offset.
> 
> But all Linux IRQ numbers are virtual by definition. It's just some
> number that the kernel use as a cookie to look up the irq_desc.
> And one day we may get rid of IRQ numbers altogether.
> 
> I would prefer just to s/virq/irq/g on this patch or if that is
> disturbing something more to the point like s/virq/linux_irq/g.
> 
> Maybe this is a pointless battle, but still...

I chose the term not because I have a personal attachement but because
that is how they are spelt in the C symbols within irqdomain.[ch] which
my patch relies upon heavily. The english documentation and comments is
(very nearly) strict about using "Linux IRQ" so I'll happily change all
the English text.

However...

I don't fancy s/virq/irq/ since this risks confusion between Linux irq
and ARM IRQ and I don't fancy s/virq/linux_irq/ because in the kernel
today virq is ~750x more frequenctly used than 'linux_irq' (git grep and
wc suggests its 1507 versus 2).

How strongly do you feel about this?
