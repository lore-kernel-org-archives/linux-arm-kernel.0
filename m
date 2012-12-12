From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 19:49:42 +0100
Subject: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save
 power
In-Reply-To: <CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD138@SC-VEXCH1.marvell.com>
 <CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
Message-ID: <CACRpkdYVkxVxv_RwK_-r=g9nSW6+ay7e9Ydr+Pv9ShwooDhB2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 12:39 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:

>> 3) In the suspend() callback, sleep until the clock indicates
>> that the card is declocked with something like:
>> while (clk_is_enabled(host->clk)) { sleep(1) }
>> However the clk framework does not have clk_is_enabled()
>> so you'd either have to add that or use a local atomic
>> variable host_clk_enabled set in (2).
>>
>> Should work, I think?
>
> Since we use pm runtime with delay setting to 50ms, so there is no such problem?

Depends on the clock to the card I guess?

The MMCI is default-clocked at 515633 Hz, so period
time T = 1/515633 and for 8 clock cycles on the card clock
it needs 8/515633 ~ 0.01 ms so it's pretty sufficient :-)

OK I'm in on using runtime PM then.

Yours,
Linus Walleij
