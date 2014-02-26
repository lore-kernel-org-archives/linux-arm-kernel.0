From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Feb 2014 10:06:06 +0100
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <20140226085921.GD7720@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUy6uj5vJ125Edp8g5NNxcWbG5wmD-j_gp=GgzXYAUAEw@mail.gmail.com>
 <20140226085921.GD7720@verge.net.au>
Message-ID: <CAMuHMdXFVoL4pyygzys4VyYBN42KDPdohVQz6JcZn9WvuEOFEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 9:59 AM, Simon Horman <horms@verge.net.au> wrote:
>> > +/*
>> > + *             MD1 = 1                 MD1 = 0
>> > + *             (PLLA = 1500)           (PLLA = 1600)
>> > + *             (MHz)                   (MHz)
>> > + *------------------------------------------------+--------------------
>> > + * clkz                1000   (2/3)            800   (1/2)
>> > + * clkzs        250   (1/6)            200   (1/8)
>> > + * clki                 750   (1/2)            800   (1/2)
>> > + * clks                 250   (1/6)            200   (1/8)
>> > + * clks1        125   (1/12)           100   (1/16)
>> > + * clks3        187.5 (1/8)            200   (1/8)
>> > + * clks4         93.7 (1/16)           100   (1/16)
>> > + * clkp                  62.5 (1/24)            50   (1/32)
>> > + * clkg                  62.5 (1/24)            66.6 (1/24)
>> > + * clkb, CLKOUT
>> > + * (MD2 = 0)     62.5 (1/24)            66.6 (1/24)
>> > + * (MD2 = 1)     41.6 (1/36)            50   (1/32)
>> > + */
>> > +
>> > +#define CPG_CLK_CONFIG_INDEX(md)       (((md) & (BIT(1)|BIT(2))) >> 1)
>> > +
>> > +struct cpg_clk_config {
>> > +       unsigned int z_mult;
>> > +       unsigned int z_div;
>> > +       unsigned int zs_and_s_div;
>> > +       unsigned int s1_div;
>> > +       unsigned int p_div;
>> > +       unsigned int out_div;
>> > +};
>> > +
>> > +static const struct cpg_clk_config cpg_clk_configs[4] __initconst = {
>> > +       { 1, 2, 8, 16, 32, 24 },
>> > +       { 1, 2, 8, 16, 32, 24 },
>> > +       { 2, 3, 6, 12, 24, 36 },
>> > +       { 2, 3, 6, 12, 24, 32 },
>> > +};
>>
>> Shouldn't this be
>>
>> +static const struct cpg_clk_config cpg_clk_configs[4] __initconst = {
>> +       { 1, 2, 8, 16, 32, 24 },
>> +       { 2, 3, 6, 12, 24, 24 },
>> +       { 1, 2, 8, 16, 32, 32 },
>> +       { 2, 3, 6, 12, 24, 36 },
>> +};
>>
>> ?
>>
>> I think you got confused by writing the bitmask as "BIT(1)|BIT(2)" instead
>> of "BIT(2)|BIT(1)".
>
> Probably, thanks for noticing.

Note that I based my review on the table above, not on the actual datasheet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
