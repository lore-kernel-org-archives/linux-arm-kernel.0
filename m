From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Jun 2017 14:18:02 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <20170605195812.GH20170@codeaurora.org>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
 <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
 <20170605195812.GH20170@codeaurora.org>
Message-ID: <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 5, 2017 at 9:58 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/05, Linus Walleij wrote:
>> On Thu, Jun 1, 2017 at 9:02 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>
>> >> +CLK_OF_DECLARE_DRIVER(gemini_cc, "cortina,gemini-syscon", gemini_cc_init);
>> >
>> > Is there a reason why this isn't a platform driver?
>>
>> I can't get the platform to boot if I try, I guess because the console
>> UART needs the clock like super-early.
>>
>> I fixed all the other issues, resending soon.
>>
>
> Does the console uart driver support probe defer?

It's the 8250_of.c driver.

It's such a big driver that I don't dare to say, I guess I would
have to go in and debug and patch around in the 8250 driver
if you insist.

But I'm not even sure that is the problem actually, I'd have to
analyze.

I think the timer may be more of an issue...

It is using CLOCKSOURCE_OF_DECLARE(), at least last time
I checked there was no such thing as clocksources retrying their
calls, and that cannot be regular probes because of, yeah device
core is using the timer, I think.

Yeah I looked in:
drivers/clocksource/clksrc-probe.c

It will just fail if it can't initialize the clocksource.

I don't understand what platforms can actually get their timers
up at all without the clock framework? Those hardcoding the
clock frequency in the device tree, or things like the ARM
TWD which has it encoded in hardware perhaps?

Yours,
Linus Walleij
