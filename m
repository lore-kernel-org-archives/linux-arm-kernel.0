From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 5 Apr 2015 10:55:06 +0200
Subject: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
In-Reply-To: <20150403170407.GA13898@n2100.arm.linux.org.uk>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
 <20150403125727.GT10964@mwanda>
 <20150403170407.GA13898@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdWmuh5f9QAaJdp_W2oVpGgJM1TX3AUntYtkTkVJnhFg5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Apr 3, 2015 at 7:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 03, 2015 at 03:57:27PM +0300, Dan Carpenter wrote:
>> On Fri, Apr 03, 2015 at 02:42:02PM +0200, Geert Uytterhoeven wrote:
>> > +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
>> > +{
>> > +   struct clk *clk;
>> > +   int error;
>> > +
>> > +   pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
>> > +            bsc->con_id, bsc->dev_id);
>> > +   clk = clk_get(NULL, bsc->clk);
>> > +   if (IS_ERR(clk)) {
>> > +           error = PTR_ERR(clk);
>> > +           pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
>> > +           return error;
>> > +   }
>> > +
>> > +   error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
>> > +   if (error)
>> > +           pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
>> > +           return error;
>>
>> Missing curly braces.  Also it's weird that don't we need a clk_put()
>> on the error patch as well as the success path?
>
> What's also concerning is that this is an abuse of this.
>
> clk_register_clkdev() is supposed to be used with clocks created with
> the CCF functions, it's not for creating aliases.
>
> We have clk_add_alias() which does *everything* that this function does,
> only in a less buggy way.

Thanks, I didn't know about clk_add_alias(). I had based the above on long gone
code under arch/arm/mach-shmobile to use platform devices with CCF.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
