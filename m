From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 25 Nov 2014 20:35:25 +0900
Subject: [RFC 2/2] clk: samsung: Fix clock disable failure because domain
 being gated
In-Reply-To: <1416842312-4405-3-git-send-email-k.kozlowski@samsung.com>
References: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
 <1416842312-4405-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CA+Ln22FTJ8AwNOq+jrA6dK=4ziGFwFT+Ofjr2zE4z=8B4f3QJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Please see my comments inline.

2014-11-25 0:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> +static int audss_clk_gate_enable(struct clk_hw *hw)
> +{
> +       int ret;
> +
> +       if (!IS_ERR(pll_in))
> +               clk_prepare_enable(pll_in);

Calling clk_prepare_enable() from enable() callback doesn't look like
a good idea, because enabling is not supposed to sleep, while
preparing might do so.

I guess you have to pre-prepare this clock in probe and then only call
enable here.

> +       ret = clk_gate_ops.enable(hw);
> +       if (!IS_ERR(pll_in))
> +               clk_disable_unprepare(pll_in);
> +
> +       return ret;
> +}

[snip]

> +/* TODO: Also mux and div */
> +const struct clk_ops audss_clk_gate_ops = {

nit: static const probably?

> +       .enable = audss_clk_gate_enable,
> +       .disable = audss_clk_gate_disable,
> +       .is_enabled = audss_clk_gate_is_enabled,
> +};

As for the approach itself, maybe you should simply register fully
custom clocks with clk_register(), without altering
clk_register_gate() at all and simply calling gate ops whenever
necessary? I don't know, just a loose idea.

By the way, this issue could be probably solved by integrating generic
clocks with regmap API, since regmap-mmio can automatically control a
clock.

Best regards,
Tomasz
