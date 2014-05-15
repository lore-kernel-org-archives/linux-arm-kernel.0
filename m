From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 May 2014 10:09:21 +0200
Subject: [PATCH v2 06/10] clk: berlin: add core clock driver for BG2/BG2CD
In-Reply-To: <1400098522-14770-7-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400098522-14770-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400098522-14770-7-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140515080921.GQ29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/2014 at 22:15:17 +0200, Sebastian Hesselbarth wrote :
> +	/* clock divider cells */
> +	parent_names[1] = avpllb_names[CH4];
> +	parent_names[2] = avpllb_names[CH5];
> +	parent_names[3] = avpllb_names[CH6];
> +	parent_names[4] = avpllb_names[CH7];
> +
> +	parent_names[0] = refclk_names[SYSPLL];

It should actually be:

parent_names[0] = avpllb_names[CH4];
parent_names[1] = avpllb_names[CH5];
parent_names[2] = avpllb_names[CH6];
parent_names[3] = avpllb_names[CH7];
parent_names[4] = refclk_names[SYSPLL];

> +	data = &bg2_divs[CLKID_SYS];
> +	clks[CLKID_SYS] = berlin2_div_register(&data->map, base, data->name,
> +		       data->div_flags, parent_names, 5, data->flags, &lock);
> +
> +	parent_names[0] = refclk_names[CPUPLL];
> +	parent_names[5] = refclk_names[MEMPLL];

The only valid choice here should be (remember, we are not adding 1 to
the index anymore):
parent_names[4] = refclk_names[MEMPLL];

> +	data = &bg2_divs[CLKID_CPU];
> +	clks[CLKID_CPU] = berlin2_div_register(&data->map, base, data->name,
> +			 data->div_flags, parent_names, 6, data->flags, &lock);
> +

This is where it gets tricky, now we should have:
parent_names[0] = avpllb_names[CH4];
parent_names[1] = avplla_names[CH5];
parent_names[2] = avpllb_names[CH6];
parent_names[3] = avpllb_names[CH7];
parent_names[4] = refclk_names[SYSPLL];

> +	parent_names[0] = refclk_names[SYSPLL];
> +	for (n = CLKID_DRMFIGO; n <= CLKID_APP; n++) {
> +		data = &bg2_divs[n];
> +		clks[n] = berlin2_div_register(&data->map, base, data->name,
> +			 data->div_flags, parent_names, 5, data->flags, &lock);
> +	}
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
