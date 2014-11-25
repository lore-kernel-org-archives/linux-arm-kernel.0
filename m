From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 25 Nov 2014 13:19:05 +0100
Subject: [RFC 2/2] clk: samsung: Fix clock disable failure because domain
 being gated
In-Reply-To: <CA+Ln22FTJ8AwNOq+jrA6dK=4ziGFwFT+Ofjr2zE4z=8B4f3QJw@mail.gmail.com>
References: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
 <1416842312-4405-3-git-send-email-k.kozlowski@samsung.com>
 <CA+Ln22FTJ8AwNOq+jrA6dK=4ziGFwFT+Ofjr2zE4z=8B4f3QJw@mail.gmail.com>
Message-ID: <1416917945.29431.6.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-11-25 at 20:35 +0900, Tomasz Figa wrote:
> Hi Krzysztof,
> 
> Please see my comments inline.
> 
> 2014-11-25 0:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> > +static int audss_clk_gate_enable(struct clk_hw *hw)
> > +{
> > +       int ret;
> > +
> > +       if (!IS_ERR(pll_in))
> > +               clk_prepare_enable(pll_in);
> 
> Calling clk_prepare_enable() from enable() callback doesn't look like
> a good idea, because enabling is not supposed to sleep, while
> preparing might do so.

Right.

> I guess you have to pre-prepare this clock in probe and then only call
> enable here.

Yes, the prepare won't have any negative effect on energy usage anyway.

> 
> > +       ret = clk_gate_ops.enable(hw);
> > +       if (!IS_ERR(pll_in))
> > +               clk_disable_unprepare(pll_in);
> > +
> > +       return ret;
> > +}
> 
> [snip]
> 
> > +/* TODO: Also mux and div */
> > +const struct clk_ops audss_clk_gate_ops = {
> 
> nit: static const probably?

Yes.

> 
> > +       .enable = audss_clk_gate_enable,
> > +       .disable = audss_clk_gate_disable,
> > +       .is_enabled = audss_clk_gate_is_enabled,
> > +};
> 
> As for the approach itself, maybe you should simply register fully
> custom clocks with clk_register(), without altering
> clk_register_gate() at all and simply calling gate ops whenever
> necessary? I don't know, just a loose idea.

Initially that seemed to me the simplest way to encapsulate gate_ops
calls. However in that approach I should also change clk_register_mux
and clk_register_divider... which complicates this patch and maybe your
idea will be simpler overall.

> By the way, this issue could be probably solved by integrating generic
> clocks with regmap API, since regmap-mmio can automatically control a
> clock.

Indeed but this looks like much bigger task.

Anyway thanks for feedback. I'll prepare another version.

Best regards,
Krzysztof
