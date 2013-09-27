From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Fri, 27 Sep 2013 18:37:56 +0530
Subject: [PATCH 2/3] clk: samsung: Add clock driver for s5pc100
In-Reply-To: <3392871.UAAWoO4asY@amdc1227>
References: <1380041605-15736-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1380041605-15736-2-git-send-email-m.krawczuk@partner.samsung.com>
 <CAKew6eUgpnqvZUCsWGpqwDXtp6ARmhd-Nw-BXiod8=MK-k0fUA@mail.gmail.com>
 <3392871.UAAWoO4asY@amdc1227>
Message-ID: <CAKew6eXvXZ==auq8E9bYnHsrrVgqKsK7A9ad12ERBPR++cQUHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Thu, Sep 26, 2013 at 7:30 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Yadwinder,
>
> I haven't reviewed this series yet, but let me clarify some things from
> your comments.
>
> On Thursday 26 of September 2013 17:38:58 Yadwinder Singh Brar wrote:
>> > +
>> > +/* Helper macros to define clock arrays. */
>> > +#define FIXED_RATE_CLOCKS(name)        \
>> > +               static struct samsung_fixed_rate_clock name[]
>> > +#define MUX_CLOCKS(name)       \
>> > +               static struct samsung_mux_clock name[]
>> > +#define DIV_CLOCKS(name)       \
>> > +               static struct samsung_div_clock name[]
>> > +#define GATE_CLOCKS(name)      \
>> > +               static struct samsung_gate_clock name[]
>> > +
>>
>> These macros seems little bit odd in our common practice,
>> perhaps these are making code harder to read below.
>>
>
> They allow array declaration to fit into single line. I agree that it is
> not particularly easy to read at first sight, but shouldn't really be
> much of nuisance.

Defining a macro just to use once/twice, especially hiding the
definition of some array, doesn't looks justified.

>In addition, most of this driver is based on macros
> like this, e.g. GATE(), MUX(), PNAME(), etc.
>
>> > +PNAME(mout_i2s_2_p) = {
>> > +       "fout_epll",
>> > +       "i2scdclk0",
>> > +       "dout_audio0",
>> > +       "none"
>> > +};
>> > +
>>
>> Using one line per parent isn't increasing length of file unnecessarily?
>
> I believe this improves readability. Do we really care about size of
> source code that much, over readability?
>

yes, its looks little bit clean but in this case I felt, its making
the traversability in file difficult due to length of file.

>> > +       ALIAS(SCLK_AUDIO0, "soc-audio.0", "sclk_audio"),
>> > +       ALIAS(SCLK_AUDIO1, "soc-audio.1", "sclk_audio"),
>> > +       ALIAS(SCLK_AUDIO2, "soc-audio.2", "sclk_audio"),
>> > +       ALIAS(KEYIF, NULL, "keypad"),
>> > +
>> > +       ALIAS(MFC, "s5p-mfc", "sclk_mfc"),
>> > +       ALIAS(G2D, "s5p-g2d", "fimg2d"),
>> > +
>> > +};
>> > +
>>
>> Any reason/hidden advantage for using a separate of ALIAS,
>> instead of using MUX_A/GATE_A ?
>
> Yes, not even hidden. Alias is not a property of clock. One clock can
> have multiple aliases, e.g. the same clock being input to multiple
> devices.
>

Yes, its required if same clk has different alias for different devices,
but while using same alias for different(all, in this case) devices,
doesn't seems advantageous.

Regards,
Yadwinder
