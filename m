From: joel@jms.id.au (Joel Stanley)
Date: Wed, 8 Nov 2017 14:20:23 +1030
Subject: [PATCH v5 0/5] clk: Add Aspeed clock driver
In-Reply-To: <20171030060250.701-1-joel@jms.id.au>
References: <20171030060250.701-1-joel@jms.id.au>
Message-ID: <CACPK8Xd22yji6cLAmq1B=6gLPh2y2_sc63RH8J+H+FDHyupR6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen (and other maintainers),

Have you had a chance to review this series?

I've done a lot of testing and they are looking good on hardware.

On Mon, Oct 30, 2017 at 4:32 PM, Joel Stanley <joel@jms.id.au> wrote:
> This driver supports the ast2500, ast2400 (and derivative) BMC SoCs from
> Aspeed.
>
> This is v5. See patches for detailed changelogs.
>
> v5: Address review from Andrew
> v4: Address review from Andrew and Stephen.
> v3: Address review from Andrew and has seen more testing on hardware
> v2: split the driver out into a series of patches to make them easier to
> review.
>
> All of the important clocks are supported, with most non-essential ones
> also implemented where information is available. I am working with
> Aspeed to clear up some of the missing information, including the
> missing parent-sibling relationships.
>
> We need to know the rate of the apb clock in order to correctly program
> the clocksource driver, so the apb and it's parents are created in the
> CLK_OF_DECLARE_DRIVER callback.
>
> The rest of the clocks are created at normal driver probe time. I
> followed the Gemini driver's lead with using the regmap where I could,
> but also having a pointer to the base address for use with the common
> clock callbacks.
>
> The driver borrows from the clk_gate common clock infrastructure, but modifies
> it in order to support the clock gate and reset pair that most of the clocks
> have. This pair must be reset-ungated-released, with appropriate delays,
> according to the datasheet.
>
> The first patch introduces the core clock registration parts, and describes
> the clocks. The second creates the core clocks, giving the system enough to
> boot (but without uart). Next come the non-core clocks, and finally the reset
> controller that is used for the few cocks that don't have a gate to go with their
> reset pair.
>
> Please review!
>
> Cheers,
>
> Joel
>
>
> Joel Stanley (5):
>   clk: Add clock driver for ASPEED BMC SoCs
>   clk: aspeed: Register core clocks
>   clk: aspeed: Add platform driver and register PLLs
>   clk: aspeed: Register gated clocks
>   clk: aspeed: Add reset controller
>
>  drivers/clk/Kconfig                      |  12 +
>  drivers/clk/Makefile                     |   1 +
>  drivers/clk/clk-aspeed.c                 | 666 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/aspeed-clock.h |  52 +++
>  4 files changed, 731 insertions(+)
>  create mode 100644 drivers/clk/clk-aspeed.c
>  create mode 100644 include/dt-bindings/clock/aspeed-clock.h
>
> --
> 2.14.1
>
