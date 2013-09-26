From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 26 Sep 2013 16:00:28 +0200
Subject: [PATCH 2/3] clk: samsung: Add clock driver for s5pc100
In-Reply-To: <CAKew6eUgpnqvZUCsWGpqwDXtp6ARmhd-Nw-BXiod8=MK-k0fUA@mail.gmail.com>
References: <1380041605-15736-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1380041605-15736-2-git-send-email-m.krawczuk@partner.samsung.com>
 <CAKew6eUgpnqvZUCsWGpqwDXtp6ARmhd-Nw-BXiod8=MK-k0fUA@mail.gmail.com>
Message-ID: <3392871.UAAWoO4asY@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yadwinder,

I haven't reviewed this series yet, but let me clarify some things from
your comments.

On Thursday 26 of September 2013 17:38:58 Yadwinder Singh Brar wrote:
> > +
> > +/* Helper macros to define clock arrays. */
> > +#define FIXED_RATE_CLOCKS(name)        \
> > +               static struct samsung_fixed_rate_clock name[]
> > +#define MUX_CLOCKS(name)       \
> > +               static struct samsung_mux_clock name[]
> > +#define DIV_CLOCKS(name)       \
> > +               static struct samsung_div_clock name[]
> > +#define GATE_CLOCKS(name)      \
> > +               static struct samsung_gate_clock name[]
> > +
> 
> These macros seems little bit odd in our common practice,
> perhaps these are making code harder to read below.
> 

They allow array declaration to fit into single line. I agree that it is
not particularly easy to read at first sight, but shouldn't really be
much of nuisance. In addition, most of this driver is based on macros
like this, e.g. GATE(), MUX(), PNAME(), etc.

> > +PNAME(mout_i2s_2_p) = {
> > +       "fout_epll",
> > +       "i2scdclk0",
> > +       "dout_audio0",
> > +       "none"
> > +};
> > +
> 
> Using one line per parent isn't increasing length of file unnecessarily?

I believe this improves readability. Do we really care about size of
source code that much, over readability?

> > +       ALIAS(SCLK_AUDIO0, "soc-audio.0", "sclk_audio"),
> > +       ALIAS(SCLK_AUDIO1, "soc-audio.1", "sclk_audio"),
> > +       ALIAS(SCLK_AUDIO2, "soc-audio.2", "sclk_audio"),
> > +       ALIAS(KEYIF, NULL, "keypad"),
> > +
> > +       ALIAS(MFC, "s5p-mfc", "sclk_mfc"),
> > +       ALIAS(G2D, "s5p-g2d", "fimg2d"),
> > +
> > +};
> > +
> 
> Any reason/hidden advantage for using a separate of ALIAS,
> instead of using MUX_A/GATE_A ?

Yes, not even hidden. Alias is not a property of clock. One clock can
have multiple aliases, e.g. the same clock being input to multiple
devices.

In addition, as soon as we fully move s5pv210 to device tree, the whole
array of aliases will be dropped, without the need to touch the main
clock arrays at all.

Best regards,
Tomasz
