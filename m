From: keyuan.liu@gmail.com (Kevin Liu)
Date: Wed, 12 Dec 2012 19:39:05 +0800
Subject: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save
 power
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD138@SC-VEXCH1.marvell.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD138@SC-VEXCH1.marvell.com>
Message-ID: <CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-owner at vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Wednesday, December 12, 2012 2:54 PM
> To: Russell King - ARM Linux; Ulf Hansson
> Cc: linux-mmc at vger.kernel.org; Chris Ball; linux-arm-kernel at lists.infradead.org; Ulf Hansson
> Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
>
> On Tue, Dec 11, 2012 at 3:52 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> The amba bus is already performing same actions but for the apb_pclk.
>>> So here we just make sure the clock to card is gated as well to save
>>> more power. At runtime resume we will thus restore the clock again.
>>
>> And how exactly do you ensure the requirement that a certain number of
>> clocks is supplied to the card after the last command before you cut
>> the clock?
>
> Oh, that's gonna be a problem.
>
> So I can see a quite straight-forward way to do this actually:
>
> 1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
> which means that the ios will be called with f=0 whenever
> the card is unused, taking into account the required number
> of clocks to the card.
>
> 2) Implement handling of f=0 from the ios in the ios callback.
> Then clk_disable(host->clk). I did a hack at this some months
> back but never got around to finish it, sorry for not doing
> that even though this clock gating was invented for the MMCI
> in the first place :-(
>
> 3) In the suspend() callback, sleep until the clock indicates
> that the card is declocked with something like:
> while (clk_is_enabled(host->clk)) { sleep(1) }
> However the clk framework does not have clk_is_enabled()
> so you'd either have to add that or use a local atomic
> variable host_clk_enabled set in (2).
>
> Should work, I think?
>

Since we use pm runtime with delay setting to 50ms, so there is no such problem?

Thanks
Kevin
