From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Jun 2017 10:55:40 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <CACRpkdaZJbzC0-xg_go=-o+0cQ-JOY3mUe27HUnwQ+DnZYbyMA@mail.gmail.com>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
 <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
 <20170605195812.GH20170@codeaurora.org>
 <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
 <CACRpkdapAgHix2vw-woDFi4sh+H3_EX7w-5q=opBGMyegFrXbA@mail.gmail.com>
 <20170612210248.GP20170@codeaurora.org>
 <CACRpkdaZJbzC0-xg_go=-o+0cQ-JOY3mUe27HUnwQ+DnZYbyMA@mail.gmail.com>
Message-ID: <CAMuHMdXdYNTLCUfQ9rdj8Fffff5G6fGREcHs5-E5LbwPU9yyLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liinus,

On Thu, Jun 15, 2017 at 9:16 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 12, 2017 at 11:02 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> So can the certain clks that are required to get the timer
>> going be put into CLK_OF_DECLARE_DRIVER() and then have a regular
>> platform driver for the rest of the clks that aren't required for
>> early boot? We've been doing this sort of hybrid design lately,
>> so hopefully that works here too.
>
> So I tried this hybrid approach.
>
> It works and it doesn't work, it is very annoying actually... we get
> a conflict of interest between the clock driver, the reset driver and
> the device tree bindings and how Linux uses device tree.
>
> The reason is that no less than three devices probe from the same
> device tree node, essentially this is the problem:
>
> syscon: syscon at 40000000 {
>       compatible = "cortina,gemini-syscon", "syscon";
>       reg = <0x40000000 0x1000>;
>       #clock-cells = <1>;
>       #reset-cells = <1>;
> };
>
> This has already a driver in drivers/reset/reset-gemini.c
> binding and probing from "cortina,gemini-syscon".
>
> That works fine, because CLK_OF_DECLARE_DRIVER() does not
> bind to the device using the device core, and syscon will always probe
> itself when the first user tries to access it.
>
> If we make the clocks bind to the platform device, the reset
> controller will not probe, regressing the boot in another way, because
> some drivers need their reset lines.

If clocks and resets are provided by the same hardware module, you can
have a single (platform) driver registering both the clock and reset
controllers.
Cfr. drivers/clk/renesas/renesas-cpg-mssr.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
