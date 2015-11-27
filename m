From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 Nov 2015 21:10:08 +0100
Subject: [PATCH 2/3] clk: add Dove PLL divider support for GPU, VMeta and
 AXI clocks
In-Reply-To: <E1a24wo-0004j2-Vd@rmk-PC.arm.linux.org.uk>
References: <E1a24wo-0004j2-Vd@rmk-PC.arm.linux.org.uk>
Message-ID: <20151127201008.GD14645@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

> +static int dove_calc_divider(const struct dove_clk *dc, unsigned long rate,
> +			     unsigned long parent_rate, bool set)
> +{
> +	unsigned int divider, max;
> +
> +	divider = DIV_ROUND_CLOSEST(parent_rate, rate);
> +
> +	if (dc->divider_table) {
> +		unsigned int i;
> +
> +		for (i = 0; dc->divider_table[i]; i++)
> +			if (divider == dc->divider_table[i]) {
> +				divider = i;
> +				break;
> +			}
> +
> +		if (dc->divider_table[i])
> +			return -EINVAL;

Is this condition correct? If we have reached the 0 at the end of the
table, -EINVAL makes sense. But that would need a !

       Andrew
