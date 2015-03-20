From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Mar 2015 22:46:44 -0600
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <20150319075836.GU3318@x1>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net> <20150318084255.GJ3318@x1>
 <87bnjqorpe.fsf@eliezer.anholt.net> <20150319075836.GU3318@x1>
Message-ID: <550BA634.9060005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 01:58 AM, Lee Jones wrote:
> On Wed, 18 Mar 2015, Eric Anholt wrote:
> 
>> Lee Jones <lee@kernel.org> writes:
>>
>>> On Thu, 12 Mar 2015, Eric Anholt wrote:
>>>
>>>> From: Lubomir Rintel <lkundrak@v3.sk>
>>>>
>>>> Implement BCM2835 mailbox support as a device registered with the
>>>> general purpose mailbox framework. Implementation based on commits by
>>>> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
>>>> implementation.
>>>>
>>>> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
>>>> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
>>>>
>>>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>>>> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>> Cc: Jassi Brar <jassisinghbrar@gmail.com>
>>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>> ---
>>>>
>>>>
>>>> v2: Squashed Craig's work for review, carried over to new version of
>>>>     Mailbox framework (changes by Lubomir)
>>>>
>>>> v3: Fix multi-line comment style.  Refer to the documentation by
>>>>     filename.  Only declare one MODULE_AUTHOR.  Alphabetize includes.
>>>>     Drop some excessive dev_dbg()s (changes by anholt).
>>>>
>>>> v4: Use the new bcm2835_peripheral_read_workaround(), drop the
>>>
>>> Can you explain to me why this is required (and don't just point me in
>>> the direction of the other patch ;) ).  You appear to be using the
>>> non-relaxed variants of readl and writel, which already do memory
>>> barriers, so I'm a little perplexed as to how the problem can arise.
>>
>> Hmm.
>>
>> A shorter restatement of the architecture requirement would be, I think,
>> "Don't let there be two outstanding reads of different peripherals on
>> the AXI bus, or the CPU might mis-assign the read results.  Use rmb() to
>> wait for the previous bus reads when you need to prevent this"
>>
>> arch/arm/include/asm/io.h's readl() does __iormb() after each
>> __raw_readl().  Imagine taking an interrupt for a new peripheral between
>> the driver's __raw_readl() and the following __iormb(): Now you've got
>> two __raw_readl()s in between iormb()s and you can theoretically get
>> unordered reads.
>>
>> We could hope that the architecture IRQ handler would happen to do an
>> incidental rmb(), resolving the need to protect from interrupt handling
>> inside of device drivers.  The interrupt controller's presence at
>> 0x7e00b200 sounds like it's an AXI peripheral, so it would need to be
>> ensuring ordering of reads.  However, it's doing readl_relaxed()s.  So
>> my rmb() at the start of my irq handler is silly -- if somebody got
>> interrupted between readl and rmb, we've already had a chance to get the
>> wrong result inside of the IRQ chip's status read.
>>
>> My new idea for handling this would be to:
>>
>> 1) Assume drivers don't exit with reads outstanding.  This means they
>> don't do a readl_relaxed() from an AXI peripheral at the end of a path
>> without doing something with the result.
>>
>> 2) Make bcm2835_handle_irq() do this rmb() at the top, with the big
>> explanation, to avoid a race against the interrupted code device being
>> inside a readl() before the __iormb().  We don't worry about the 1-2
>> readl_relaxed()s inside of bcm2835_handle_irq(), because their return
>> values get waited on before continuing on to calling the device driver,
>> so the device driver knows its IRQ handler is being entered with no AXI
>> reads outstanding.
> 
> That's a fantastic explanation.  Thanks for taking the time to
> write this out so diligently.
> 
> Doing this at a sub-arch level sounds a little wrong to me.  I don't
> think Broadcom are the only vendor who do not ensure correct read
> order,

It seems like quite a surprising bug to me, and AFAIK there's nothing
already upstream that requires a similar WAR.

> and writing <vendor>_peripheral_read_workarounds() all over the
> place sounds less than graceful. 

It sounds like Eric's latest plan is to put the one WAR into the
bcm2835-specific IRQ controller driver. Assuming we don't find any
unusual code elsewhere, we shouldn't need to put WARs all over the place.

> Granted, if there were a greater
> need and this can't be fixed another way we could knock off the
> <vendor>_ part and make the call generic, but is there no way we can
> deal with this at the architecture level?
> 
> The whole point of doing readl_relaxed()s is that you can be assured
> that the architecture guarantee ordering.  If that's not the case,
> then we need to be using readl()s in the IRQ handler instead. 

Doing a single dsb at the start of the IRQ handler should be enough,
assuming that the code consumes each read result in a control path
before issuing another readl_relaxed, there will never be multiple reads
outstanding.
