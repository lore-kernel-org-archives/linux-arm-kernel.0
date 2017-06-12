From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Jun 2017 08:21:20 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
 <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
 <20170605195812.GH20170@codeaurora.org>
 <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
Message-ID: <CACRpkdapAgHix2vw-woDFi4sh+H3_EX7w-5q=opBGMyegFrXbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 2:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> I think the timer may be more of an issue...
>
> It is using CLOCKSOURCE_OF_DECLARE(), at least last time
> I checked there was no such thing as clocksources retrying their
> calls, and that cannot be regular probes because of, yeah device
> core is using the timer, I think.
>
> Yeah I looked in:
> drivers/clocksource/clksrc-probe.c
>
> It will just fail if it can't initialize the clocksource.
>
> I don't understand what platforms can actually get their timers
> up at all without the clock framework? Those hardcoding the
> clock frequency in the device tree, or things like the ARM
> TWD which has it encoded in hardware perhaps?

I just confirmed this to be the problem using a scratch patch for
a platform device init and some earlydebug prints:

Uncompressing Linux... done, booting the kernel.
 Booting Linux on physical CPU 0x0
start_kernel
(...)
 NR_IRQS:16 nr_irqs:16 16
 could not get PCLK
Failed to initialize '/soc/timer at 43000000': -517
 clocksource_probe: no matching clocksources found
 sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every
21474836475000000ns
 Console: colour dummy device 80x30
 Calibrating delay loop...

So the deferred clock makes the whole platform hang because the timer
needs it. Without a clocksource, the delay loop cannot be calibrated, so
it hangs there.

Yours,
Linus Walleij
