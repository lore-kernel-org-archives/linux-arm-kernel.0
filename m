From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Feb 2015 11:37:38 +0800
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150216113738.281f226a@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, 13 Feb 2015 08:42:54 -0800
Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Hi,
> 
> Marvell Berlin SoCs have a chip control register set providing several
> individual registers dealing with various controllers (pinctrl, reset,
> clk). This chip controller is described by a single DT node since the
> individual registers are spread among the chip control register bank.
> 
> Marvell Berlin also have a system control register set providing several
> individual registers for pinctrl or adc.

There's no chip control IP. The HW just put some HW registers into the so
called "chip control" address space, the registers in this space are mostly used for
"control" purpose, but some are not. Take the clk as an example, some clocks'
registers are put into the system control register space, some clocks' are
not.

So far, there are five type of clocks in Berlin (from the driver programmer's point
of view):

1. gate clocks. The clocks may share register. The clocks can only be gated or ungated.

2. individual clocks. The clock doesn't share registers with each other.
The gate/ungate, clock source selection, clock divider etc. bits of each clock are
put into one individual register. one register per clock.

3. group clocks. The gate/ungate bits of these clocks are grouped into one register,
the clock source selection, clock divider bits of these clocks are grouped into another
one or two register.

4. plls. The pll doesn't share registers with each other. For example, syspll,
cpupll etc. one or two register per pll

5. fixed clock. the oscillator used for reference clock.

In newer chips, there are no group clocks any more. So the driver code can be more
simpler and clean.

So I think we'd better to implement drivers without the "chip control" concept in
mind. The previous clock patches reflect what the HW really does.

https://lkml.org/lkml/2014/3/21/413

https://lkml.org/lkml/2014/4/24/624


The above is just my humble opinions and the current berlin clk driver is different
with the previous one I dunno how can we handle this situation now. I really need
help!

Thanks,
Jisheng
