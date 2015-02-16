From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Feb 2015 12:05:47 +0100
Subject: [PATCH 0/7] ARM: berlin: refactor the clock
In-Reply-To: <20150216113738.281f226a@xhacker>
References: <1423845781-7480-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150216113738.281f226a@xhacker>
Message-ID: <54E1CF0B.1030901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.02.2015 04:37, Jisheng Zhang wrote:
> On Fri, 13 Feb 2015 08:42:54 -0800
> Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
>> Marvell Berlin SoCs have a chip control register set providing several
>> individual registers dealing with various controllers (pinctrl, reset,
>> clk). This chip controller is described by a single DT node since the
>> individual registers are spread among the chip control register bank.
>>
>> Marvell Berlin also have a system control register set providing several
>> individual registers for pinctrl or adc.
>
> There's no chip control IP. The HW just put some HW registers into the so
> called "chip control" address space, the registers in this space are mostly used for
> "control" purpose, but some are not. Take the clk as an example, some clocks'
> registers are put into the system control register space, some clocks' are
> not.

Jisheng,

you are right, there is no specific IP for those registers. But as we
don't want these registers to be spread among our SoC nodes, we chose
to sum them all up into a single node.

Back when the clk driver was proposed, Mike requested to not expose
each of the clocks in DT - so we joined them basically into a single
node and let the driver do the rest.

Now, this patch set goes a little bit further and simply joins all of
the chip ctrl registers into a single node and just adds sub-nodes where
we need them (e.g. pinctrl).

[...]
> In newer chips, there are no group clocks any more. So the driver code can be more
> simpler and clean.
>
> So I think we'd better to implement drivers without the "chip control" concept in
> mind. The previous clock patches reflect what the HW really does.

I see no problem in what future SoCs do with register layout. It seems
that it will be fundamentally different anyway, so we might consider to
have a completely new driver for any SoC past BG2Q.

> The above is just my humble opinions and the current berlin clk driver is different
> with the previous one I dunno how can we handle this situation now. I really need
> help!

We appreciate you share your opinion!

How does having a single node  (and basically a single reg property
shared by regmap) block you from implementing support for your new SoC?

Also, you don't need to follow the chip-ctrl node concept for the new
SoC if it is too different. It is just that we kind of give up to chop
this register set into functional pieces in DT and think it will be
better dealt with in each of the drivers.

Sebastian
