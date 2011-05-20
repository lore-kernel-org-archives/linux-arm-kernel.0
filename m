From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 May 2011 11:42:57 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
Message-ID: <20110520104257.GD7445@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 12:04:48PM +0200, Linus Walleij wrote:
> My current understanding:
> 
> __raw_writel(a, reg1);
> __raw_writel(b, reg2);
> 
> This does not guarantee that the write of b into reg2 is even done
> after writing a into reg1 due to instruction reeordering.

No.  It's not about instruction re-ordering.  The instruction stream will
show a write to reg1 followed by a write to reg2.

The writes are performed using the CPUs current endianness.  The CPU and
buses are free to re-order this if they so wish, and the CPU is free to
re-order them with respect to other types of access (iow, memory and
strongly ordered.)

> writel_relaxed(a, reg1);
> writel_relaxed(b, reg2);
> 
> This will insert a barrier() so we know that the CPU will execute the
> write of a before the write of b. However it does not mandate that
> reg2 is written with b before reg1 is written with a at the hardware
> register level.

These writes are performed using little endian byte order.  The CPU and
buses are free to re-order this if they so wish, and the CPU is free to
re-order them with respect to other types of access.

> writel(a, reg1);
> writel(b, reg2);
> 
> This actually pushes the value all the way through so that you know
> that the values has landed in the hardware after each statement.

These writes are again performed using little endian byte order.  We
insert barriers to ensure that the CPU does not re-order these with
respect to other accesses, including memory accesses.  However, downstream
bus hardware may still delay the writes, which may result in the write to
reg2 arriving before reg1, especially if they're on different buses.

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

No.  The compiler can't optimize the volatile accesses like that.  The
volatile document is written from the point of making driver writers
use the accessor functions.

In both cases, because the write is to the same register, and as I've
said above, they won't be re-ordered in the instruction stream, plus
if reg1 is _device_ memory, they will appear in-order on the destination
bus.

> make sure that the writes actually happens in sequence,
> but after the last statement it may take a while before the
> actual hardware write happens.
> 
> And what about this:
> 
> writel_relaxed(a, reg1);
> writel_relaxed(b, reg1);
> writel(c, reg1);

The same. But a and b may arrive at the device before previous writes to
memory have completed, whereas c will only arrive after all of a, b and
previous memory writes have completed.
