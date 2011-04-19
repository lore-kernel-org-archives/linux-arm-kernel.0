From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Apr 2011 03:23:11 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikSfdUXmME8ao4GYtwgZNuZX9RLZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
>
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.

Great initiative!

I'm thinking about how to unify this with the bits I have in kernel/tcm.c.

For TCM memory (cacheless, inside CPU core, controlled by CP15
registers to recap) we can compile plain C into that memory too, which
seems like a lot of these SRAM drivers actually want to do, but fail at
and instead write some assembler and copy it there.

The remainder of the TCM memory is put into an allocation pool
of uneven size, maybe that should reuse this mechanism instead
of rolling its own atleast.

On the odd PB11MPCore the TCM memories are NUMA, so one
on each CPU not reachable from other cores (like Magnus Damm
mentioned for SH-ARM) and I have no idea on how to handle that,
neither for an allocator nor for compiling code directly into it.
Suggestions welcome.

Linus Walleij
