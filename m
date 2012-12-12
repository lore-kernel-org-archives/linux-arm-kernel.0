From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 07:53:37 +0100
Subject: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
In-Reply-To: <20121211145243.GQ14363@n2100.arm.linux.org.uk>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
 <20121211145243.GQ14363@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbZSFQ1HvXZ3Op093CediAm9rPHwHX38h_sxwE9ARSe5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 3:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> The amba bus is already performing same actions but for the apb_pclk.
>> So here we just make sure the clock to card is gated as well to save
>> more power. At runtime resume we will thus restore the clock again.
>
> And how exactly do you ensure the requirement that a certain number of
> clocks is supplied to the card after the last command before you cut
> the clock?

Oh, that's gonna be a problem.

So I can see a quite straight-forward way to do this actually:

1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
which means that the ios will be called with f=0 whenever
the card is unused, taking into account the required number
of clocks to the card.

2) Implement handling of f=0 from the ios in the ios callback.
Then clk_disable(host->clk). I did a hack at this some months
back but never got around to finish it, sorry for not doing
that even though this clock gating was invented for the MMCI
in the first place :-(

3) In the suspend() callback, sleep until the clock indicates
that the card is declocked with something like:
while (clk_is_enabled(host->clk)) { sleep(1) }
However the clk framework does not have clk_is_enabled()
so you'd either have to add that or use a local atomic
variable host_clk_enabled set in (2).

Should work, I think?

Yours,
Linus Walleij
