From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 May 2011 11:55:54 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
Message-ID: <BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On 20 May 2011 11:04, Linus Walleij <linus.walleij@linaro.org> wrote:
> Now I get thes questions about I/O accessors from all over the
> place where I'm working. It seems some public clarification is needed...

There's not a simple answer as other architectures do something else.
For ARM I can answer below.

> My current understanding:
>
> __raw_writel(a, reg1);
> __raw_writel(b, reg2);
>
> This does not guarantee that the write of b into reg2 is even done
> after writing a into reg1 due to instruction reeordering.

The compile should not reorder them as they are volatile accesses.

On ARM it is guaranteed that the writes are issued in program order
and they arrive to the same device in program order (the definition of
the device is still debatable). Arriving at different devices in
program order is not guaranteed (depends on the bus configuration).
They also don't do any endianess conversions.

On other architectures like PPC I think they are completely out of order.

> writel_relaxed(a, reg1);
> writel_relaxed(b, reg2);
>
> This will insert a barrier() so we know that the CPU will execute the
> write of a before the write of b. However it does not mandate that
> reg2 is written with b before reg1 is written with a at the hardware
> register level.

These are as the __raw_* variants, only that they do endianess
conversion (to/from little endian).

> writel(a, reg1);
> writel(b, reg2);
>
> This actually pushes the value all the way through so that you know
> that the values has landed in the hardware after each statement.

writel_relaxed() with barrier before (DSB + outer cache sync). This is
to ensure ordering with accesses to coherent DMA buffers (Normal
Non-cacheable memory). For accesses to the same device we don't
actually need any barriers on ARM as this is guaranteed by the
architecture.

> What we would like to know is the effect of things like this:
>
> __raw_writel(a, reg1);
> __raw_writel(b, reg1);
> __raw_writel(c, reg1);
>
> writel_relaxed(a, reg1);
> writel_relaxed(b, reg1);
> writel_relaxed(c, reg1);
>
> My *guess* is that in the first case the pipeline may even remove
> the write if a and b to reg1 since it's only caring about the end
> result (insert the volatile story in
> Documentation/volatile_considered_harmful.txt here)

I think it should be ok with a well-behaved compiler.

But I would like is to convert the __raw_* accessors to inline asm but
Russell objected in the past. There are other reasons for this - the
current volatile access can generate post-indexed accesses which are
more expensive to emulate by a hypervisor (on Cortex-A15).

> The second case (writel_relaxed() to the same register) would
> make sure that the writes actually happens in sequence,
> but after the last statement it may take a while before the
> actual hardware write happens.

No difference from the __raw_* ones.

With all of them, even writel(), you don't know when the actual
hardware write happens. You can issue a DSB after to ensure write
completion (I think defined as the device begins to change its state
as a result of the write) but you can't tell whether the device
finished changing its state. For that you would need other means like
reading back from the device.

> And what about this:
>
> writel_relaxed(a, reg1);
> writel_relaxed(b, reg1);
> writel(c, reg1);
>
> I *think* this means that the writes will be done in sequence,
> and after the last statement you know all writes have commenced.

Here, because we use a DSB at the beginning of writel(), you now that
the previous writel_relaxed() calls completed but not the final
writel(). And anyway, the DSB in that was meant for DMA buffer
accesses and not previous I/O accesses.

-- 
Catalin
