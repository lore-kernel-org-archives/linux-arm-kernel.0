From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Nov 2011 14:46:41 +0000
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <CAN1soZxhZUDhyTde2=PEzzZzar7EowHd=YSfXMXXjtjGQbqO1w@mail.gmail.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <CACRpkdawJNP4h3gvZ4FfHYkYwzoKdcPRpQt94dieuU3gdZNESQ@mail.gmail.com>
 <CAN1soZxhZUDhyTde2=PEzzZzar7EowHd=YSfXMXXjtjGQbqO1w@mail.gmail.com>
Message-ID: <201111291446.41815.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 November 2011, Haojian Zhuang wrote:
> 
> How about define cpu_is_pxa3xx() in both arch-pxa and arch-mmp? Maybe
> it could be simpler. Since we have similar issue in gpio driver too.

That would work, but I think the solution that Linus suggested is cleaner.

My preferred solution would be to make the detection data driven instead
of coded into the probe function. What I mean with this is to have
the four versions use a fixed data structure like this:

static const struct pxa3xx_pinmux_info pxa300_pinmux = {
       .cpuid = PINMUX_PXA300,
       .grp = pxa300_pin_groups,
       .func = pxa300_pmx_functions,
       .num_grps = ARRAY_SIZE(pxa300_pin_groups),
       .num_funcs = ARRAY_SIZE(pxa300_pmx_functions),
       .desc = &pxa300_pctrl_desc,
       .range = pxa300_gpio_ranges,
       .range_num = ARRAY_SIZE(pxa300_gpio_ranges),
};

static const struct pxa3xx_pinmux_info pxa310_pinmux = {
       .cpuid = PINMUX_PXA320,
       .grp = pxa310_pin_groups,
       .func = pxa310_pmx_functions,
       .num_grps = ARRAY_SIZE(pxa310_pin_groups),
       .num_funcs = ARRAY_SIZE(pxa310_pmx_functions),
       .desc = &pxa310_pctrl_desc,
       .range = pxa310_gpio_ranges,
       .range_num = ARRAY_SIZE(pxa310_gpio_ranges),
};

static const struct pxa3xx_pinmux_info pxa320_pinmux = {
	...
};

static struct platform_device_id pxa3xx_pinmux_ids = {
	{ .name = "pxa300-pinmux", .id = (unsigned long)&pxa300_pinmux, },
	{ .name = "pxa310-pinmux", .id = (unsigned long)&pxa310_pinmux, },
	{ .name = "pxa320-pinmux", .id = (unsigned long)&pxa320_pinmux, },
	{ .name = "pxa910-pinmux", .id = (unsigned long)&pxa910_pinmux, },
};

static struct platform_driver pxa3xx_pinmux_driver = {
       .driver = {
               .owner = THIS_MODULE,
       },
       .id_entry = pxa3xx_pinmux_ids,
       .probe = pxa3xx_pinmux_probe,
       .remove = __devexit_p(pxa3xx_pinmux_remove),
};

Then you can look at the pxa3xx_pinmux_info pointer in the probe function
and do whatever else is necessary.

Another entirely different approach would be to split the driver into
multiple files, one for each soc plus one for the common parts, so you
just build the parts you need for the configuration.

	Arnd
