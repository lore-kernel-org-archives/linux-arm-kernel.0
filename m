From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Jun 2017 09:16:14 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <20170612210248.GP20170@codeaurora.org>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
 <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
 <20170605195812.GH20170@codeaurora.org>
 <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
 <CACRpkdapAgHix2vw-woDFi4sh+H3_EX7w-5q=opBGMyegFrXbA@mail.gmail.com>
 <20170612210248.GP20170@codeaurora.org>
Message-ID: <CACRpkdaZJbzC0-xg_go=-o+0cQ-JOY3mUe27HUnwQ+DnZYbyMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 11:02 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> So can the certain clks that are required to get the timer
> going be put into CLK_OF_DECLARE_DRIVER() and then have a regular
> platform driver for the rest of the clks that aren't required for
> early boot? We've been doing this sort of hybrid design lately,
> so hopefully that works here too.

So I tried this hybrid approach.

It works and it doesn't work, it is very annoying actually... we get
a conflict of interest between the clock driver, the reset driver and
the device tree bindings and how Linux uses device tree.

The reason is that no less than three devices probe from the same
device tree node, essentially this is the problem:

syscon: syscon at 40000000 {
      compatible = "cortina,gemini-syscon", "syscon";
      reg = <0x40000000 0x1000>;
      #clock-cells = <1>;
      #reset-cells = <1>;
};

This has already a driver in drivers/reset/reset-gemini.c
binding and probing from "cortina,gemini-syscon".

That works fine, because CLK_OF_DECLARE_DRIVER() does not
bind to the device using the device core, and syscon will always probe
itself when the first user tries to access it.

If we make the clocks bind to the platform device, the reset
controller will not probe, regressing the boot in another way, because
some drivers need their reset lines.

The natural suggestion is then to make a subnode (and thus
subdevices) in the syscon, like in my original suggestion:
http://marc.info/?l=linux-arm-kernel&m=149306019417796&w=2

> +syscon: syscon at 40000000 {
> +     compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
> +     reg = <0x40000000 0x1000>;
> +
> +     clock-controller {
> +         compatible = "cortina,gemini-clock-controller";
> +         #clock-cells = <1>;
> +     };
> + };

But to that design Rob said:
http://marc.info/?l=linux-arm-kernel&m=149340388608747&w=2

>> +syscon: syscon at 40000000 {
>> +     compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
>> +     reg = <0x40000000 0x1000>;
>> +
>> +     clock-controller {
>> +         compatible = "cortina,gemini-clock-controller";
>> +         #clock-cells = <1>;
>
> There's not really much reason to have a child node here. The parent can
> be the clock provider.

And this approach worked as long as we were using
CLK_OF_DECLARE_DRIVER() to probe the clocks.

So that is why it looks as it looks.

I'm stuck between a rock and a hard place here.

Ways forward:

- We can go back to the older device tree bindings. These are
  ACKed and merged but we have patched worse things
  after the fact. We add back the subnode (also for the
  reset controller then, so it looks coherent). But I don't know how
  the DT maintainers would feel about that. It's not DT's fault that
  Linux can't bind more than one driver to a single DT node.

- We can stay with CLK_OF_DECLARE_DRIVER() and things
  JustWork(TM). I.e. just apply the v5 patch and be happy,
  concluding that Linux as a whole can't do anything better
  right now.

- I can vaguely think about ways of working around the Linux
  device driver model to spawn the child nodes from the system
  controller inside the kernel without subnodes. That would
  essentially duplicate the work that "simple-mfd" is doing on
  the system controller if we kept the device nodes, and
  introduce a new MFD driver to do just this.

Ideas? Stehen, Rob, Philipp? We need to work together to find the
best way out of this...

Yours,
Linus Walleij
