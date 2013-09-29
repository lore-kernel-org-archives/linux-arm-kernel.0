From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 29 Sep 2013 03:37:53 +0200
Subject: [PATCH 2/3] clk: samsung: Add clock driver for s5pc100
In-Reply-To: <CAKew6eXvXZ==auq8E9bYnHsrrVgqKsK7A9ad12ERBPR++cQUHg@mail.gmail.com>
References: <1380041605-15736-1-git-send-email-m.krawczuk@partner.samsung.com>
 <3392871.UAAWoO4asY@amdc1227>
 <CAKew6eXvXZ==auq8E9bYnHsrrVgqKsK7A9ad12ERBPR++cQUHg@mail.gmail.com>
Message-ID: <3513015.7YVkGL6tMp@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 of September 2013 18:37:56 Yadwinder Singh Brar wrote:
> Hi Tomasz,
> 
> On Thu, Sep 26, 2013 at 7:30 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Hi Yadwinder,
> > 
> > I haven't reviewed this series yet, but let me clarify some things
> > from
> > your comments.
> > 
> > On Thursday 26 of September 2013 17:38:58 Yadwinder Singh Brar wrote:
> >> > +
> >> > +/* Helper macros to define clock arrays. */
> >> > +#define FIXED_RATE_CLOCKS(name)        \
> >> > +               static struct samsung_fixed_rate_clock name[]
> >> > +#define MUX_CLOCKS(name)       \
> >> > +               static struct samsung_mux_clock name[]
> >> > +#define DIV_CLOCKS(name)       \
> >> > +               static struct samsung_div_clock name[]
> >> > +#define GATE_CLOCKS(name)      \
> >> > +               static struct samsung_gate_clock name[]
> >> > +
> >> 
> >> These macros seems little bit odd in our common practice,
> >> perhaps these are making code harder to read below.
> > 
> > They allow array declaration to fit into single line. I agree that it
> > is not particularly easy to read at first sight, but shouldn't really
> > be much of nuisance.
> 
> Defining a macro just to use once/twice, especially hiding the
> definition of some array, doesn't looks justified.

If it makes the code look better, then I believe it's justified. If this 
really looks that scary for you then I won't insist to keep it, though ;).

> >In addition, most of this driver is based on macros
> >
> > like this, e.g. GATE(), MUX(), PNAME(), etc.
> > 
> >> > +PNAME(mout_i2s_2_p) = {
> >> > +       "fout_epll",
> >> > +       "i2scdclk0",
> >> > +       "dout_audio0",
> >> > +       "none"
> >> > +};
> >> > +
> >> 
> >> Using one line per parent isn't increasing length of file
> >> unnecessarily?> 
> > I believe this improves readability. Do we really care about size of
> > source code that much, over readability?
> 
> yes, its looks little bit clean but in this case I felt, its making
> the traversability in file difficult due to length of file.

Most modern editors (like vim or emacs) have symbol browsers, so I don't 
think this is an issue. Instead it's easy to look up which parent has 
which index and any further correction will not cause merge conflicts, due 
to having only one entry per line.

> >> > +       ALIAS(SCLK_AUDIO0, "soc-audio.0", "sclk_audio"),
> >> > +       ALIAS(SCLK_AUDIO1, "soc-audio.1", "sclk_audio"),
> >> > +       ALIAS(SCLK_AUDIO2, "soc-audio.2", "sclk_audio"),
> >> > +       ALIAS(KEYIF, NULL, "keypad"),
> >> > +
> >> > +       ALIAS(MFC, "s5p-mfc", "sclk_mfc"),
> >> > +       ALIAS(G2D, "s5p-g2d", "fimg2d"),
> >> > +
> >> > +};
> >> > +
> >> 
> >> Any reason/hidden advantage for using a separate of ALIAS,
> >> instead of using MUX_A/GATE_A ?
> > 
> > Yes, not even hidden. Alias is not a property of clock. One clock can
> > have multiple aliases, e.g. the same clock being input to multiple
> > devices.
> 
> Yes, its required if same clk has different alias for different devices,
> but while using same alias for different(all, in this case) devices,
> doesn't seems advantageous.

An alias (technically clkdev lookup) is an existence separate from a 
clock. It's a binding of controller's clock output and device's clock 
input. Even if sometimes there is a 1:1 mapping of clocks and devices, 
there is no reason to mix them together. Moreover, since there is a need 
to provide more than one alias per clock, there is even less reason to 
provide two different ways of defining them.

This way makes the code easier to read, because in clock tables you just 
have data internal to common clock framework and in alias tables you have 
data that belongs to clkdev.

Best regards,
Tomasz
