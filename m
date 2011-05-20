From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 May 2011 12:04:48 +0200
Subject: On __raw_readl readl_relaxed and readl nocheinmal
Message-ID: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now I get thes questions about I/O accessors from all over the
place where I'm working. It seems some public clarification is needed...

My current understanding:

__raw_writel(a, reg1);
__raw_writel(b, reg2);

This does not guarantee that the write of b into reg2 is even done
after writing a into reg1 due to instruction reeordering.

writel_relaxed(a, reg1);
writel_relaxed(b, reg2);

This will insert a barrier() so we know that the CPU will execute the
write of a before the write of b. However it does not mandate that
reg2 is written with b before reg1 is written with a at the hardware
register level.

writel(a, reg1);
writel(b, reg2);

This actually pushes the value all the way through so that you know
that the values has landed in the hardware after each statement.

What we would like to know is the effect of things like this:

__raw_writel(a, reg1);
__raw_writel(b, reg1);
__raw_writel(c, reg1);

writel_relaxed(a, reg1);
writel_relaxed(b, reg1);
writel_relaxed(c, reg1);

My *guess* is that in the first case the pipeline may even remove
the write if a and b to reg1 since it's only caring about the end
result (insert the volatile story in
Documentation/volatile_considered_harmful.txt here)

The second case (writel_relaxed() to the same register) would
make sure that the writes actually happens in sequence,
but after the last statement it may take a while before the
actual hardware write happens.

And what about this:

writel_relaxed(a, reg1);
writel_relaxed(b, reg1);
writel(c, reg1);

I *think* this means that the writes will be done in sequence,
and after the last statement you know all writes have commenced.

So beat me up now.

Yours,
Linus Walleij
