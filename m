From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 09:36:37 +0100
Subject: [PATCH 0/2] clk: ux500: Add some more clk lookups for u8500
In-Reply-To: <20121105221759.GH28327@n2100.arm.linux.org.uk>
References: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZjLac9+dRwUm=ka7ZCouAx0bztNjEcjsPdsjZ=Ckz5rQ@mail.gmail.com>
 <20121105221759.GH28327@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZus48G8qi3rGnmo6QZ1Pppq6oEjc+OqmGWAyaM=i3g6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 11:17 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 05, 2012 at 12:40:20PM +0100, Linus Walleij wrote:

>> They have the right name and all, apb_pclk is
>> "AMBA peripheral bus, peripheral block clock"
>> so a clock for the silicon, right.
>>
>> ... then how it's supposed to be used, that's another
>> issue...
>
> Well, the apb pclk is the APB bus clock which times all transfers on
> the APB bus.  Without the APB bus clock running, you can't talk to any
> peripherals attached to that bus.
>
> If your SoC controls the APB bus clock to each peripheral individually
> (like, I seem to remember your Ux500 stuff does) and the peripheral is
> not being clocked, then although the bus master may be seeing a clock,
> and will manipulate the bus signals, the target will remain unresponsive
> due to lack of clock.

Yes .. for the PrimeCell derivates we are using the bus code in
drivers/amba/bus.c now, so pclk is taken care of at the bus level.
And I'm trying to move things that have PrimeCell ID registers
to that bus.

For platform devices we're not handling the pclk in the bus layer,
and when I talked to Kevin Hilman about it it turns out that
OMAP is doing all that in the PM domains, as is SH (-mobile)
and have the platform bus not intervene.

Both the above rely on drivers simply doing pm_runtime_get()
and friends so for drivers it looks the same.

And then some drivers have been grabbing the pclk directly.
This is probably not to be encouraged.

That's what I was referring to when saying I wasn't clear on
where it was to be handled. But I think I'm more on the
clear now.

Yours,
Linus Walleij
