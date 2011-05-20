From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2011 12:50:29 +0200
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
Message-ID: <201105201250.29972.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2011 12:04:48 Linus Walleij wrote:
> Now I get thes questions about I/O accessors from all over the
> place where I'm working. It seems some public clarification is needed...
> 
> My current understanding:
> 
> __raw_writel(a, reg1);
> __raw_writel(b, reg2);
> 
> This does not guarantee that the write of b into reg2 is even done
> after writing a into reg1 due to instruction reeordering.

There are a lot of things that this does not guarantee, but it does
guarantee the order in which the instructions are executed on the
CPU (because of the volatile). For example, it does not guarantee
that the write is atomic, ordering with regard to spinlocks, or the
endianess of the access.
What exactly goes on there is highly architecture specific, so
even if something specific happens on ARM, the result may be something
completely different on another architecture.

Just don't use them.

> writel_relaxed(a, reg1);
> writel_relaxed(b, reg2);
> 
> This will insert a barrier() so we know that the CPU will execute the
> write of a before the write of b. However it does not mandate that
> reg2 is written with b before reg1 is written with a at the hardware
> register level.

I don't see a barrier in the definition of writel_relaxed, but
the instructions on the CPU are in order because of the volatile
access. On all sane hardware, this means that they also arrive
in the registers in order, as long as they are for the same
device. However, writing into a PCI device (reg1) first and then
writing into a local SoC register (reg2) will typically mean
they arrive in a different order.

> writel(a, reg1);
> writel(b, reg2);
> 
> This actually pushes the value all the way through so that you know
> that the values has landed in the hardware after each statement.

You know that the first write has made it to the bus before the second
one, because each writel flushes the previous write accesses.
Whether that means that it has made it to the device depends on
what bus reg1 is on.

The write to reg2 may still be in flight for an indefinite amount
of time after the second writel, unless you do a bus synchronizing
instruction, e.g. a readl(reg2).

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
> 
> The second case (writel_relaxed() to the same register) would
> make sure that the writes actually happens in sequence,
> but after the last statement it may take a while before the
> actual hardware write happens.

You are probably confusing this with the page flags. If the memory
is in write-combining mode, all six writes may be combined into
a single bus access, if it's not write-combining, they get sent
to the bus as separate operations, and then it depends on the bus.

The writel_relaxed will also do a byte swap on big-endian architectures,
which the __raw_writel never does.

In theory, writel_relaxed should ensure that the access is done
atomically as a 32 bit write and cannot be replaced with four byte
accesses, but currently we allow the compiler to do either. Most
of the time, it chooses to do 32 bit writes for both __raw_writel
and for writel_relaxed.

> And what about this:
> 
> writel_relaxed(a, reg1);
> writel_relaxed(b, reg1);
> writel(c, reg1);
> 
> I *think* this means that the writes will be done in sequence,
> and after the last statement you know all writes have commenced.

No, even writel() is still posted, it may not have arrived at
the device when you do the next instruction. The difference between
writel_relaxed and writel is that prior accesses to other data have
completed before the writel becomes visible on the bus.

What you need to do in order to be sure that the writel has made
it to the device depends on the specific bus. Originally, writel
was intended for PCI buses and similar things where you have to
readl from the same device in order to actually flush it all the
way down.

This is the main difference to PIO accessors (outl) that operate
on a special non-posted memory range that is only visible to
a few bus types like PCI or PCMCIA.

	Arnd
