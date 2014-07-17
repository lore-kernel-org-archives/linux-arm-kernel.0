From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 17 Jul 2014 13:09:35 -0300
Subject: [PATCH 02/14] clk: sunxi: factors: Implement clock min and max
 frequencies
In-Reply-To: <1405588134-2396-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <1405588134-2396-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53C7F53F.9000902@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 17/07/14 06:08, Maxime Ripard escribi?:
> In the A13, the out of reset frequency for the PLL6 is too high to be actually
> working.
>
> Hence, we need to be able to lower down its frequency whenever we need to use
> the clock to some acceptable frequency.
>
> This patch adds two new properties in the clock-nodes, clk-min-frequency and
> clk-max-frequency, to specify acceptable boundaries for proper clock
> operations.

This paragraph looks out of place

>
> It also adds supports in the sunxi factor clocks driver to use these
> boundaries, enforce them at prepare time to make sure that the drivers will
> have a decent frequency, even though it never called set_rate, but also make
> sure we never cross these boundaries.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
(...)
>
> @@ -123,6 +147,9 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
>
>   	factors->get_factors((u32 *)&rate, (u32)parent_rate, &n, &k, &m, &p);
>
> +	if ((rate > factors->max_rate) || (rate < factors->min_rate))
> +		return -EINVAL;

Printing an error message here may come in handy in the future, what do 
you think?

Thanks for working on this!

Emilio
