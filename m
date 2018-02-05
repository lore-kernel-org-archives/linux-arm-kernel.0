From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Feb 2018 16:36:58 +0530
Subject: [PATCH v6 20/41] ARM: da830: add new clock init using common
 clock framework
In-Reply-To: <e5eb68e8-eb53-331d-5941-95df7d295074@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-21-git-send-email-david@lechnology.com>
 <4b2f45f5-7f0d-f0e6-6854-9992e19f45f2@ti.com>
 <e5eb68e8-eb53-331d-5941-95df7d295074@lechnology.com>
Message-ID: <4fc7b926-a21f-d49a-005e-44ad7f06e2e7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 February 2018 11:33 PM, David Lechner wrote:
> On 02/02/2018 08:12 AM, Sekhar Nori wrote:
>> On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
>>> ? void __init da830_init_time(void)
>>> ? {
>>> +#ifdef CONFIG_COMMON_CLK
>>> +??? void __iomem *pll0, *psc0, *psc1;
>>> +??? struct clk *clk;
>>> +
>>> +??? pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
>>> +??? psc0 = ioremap(DA8XX_PSC0_BASE, SZ_4K);
>>> +??? psc1 = ioremap(DA8XX_PSC1_BASE, SZ_4K);
>>> +
>>> +??? da8xx_register_cfgchip();
>>> +
>>> +??? clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
>>> +
>>> +??? da830_pll_clk_init(pll0);
>>> +
>>> +??? da830_psc_clk_init(psc0, psc1);
>>> +
>>
>>> +??? clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0,
>>> 1, 1);
>>> +??? clk_register_clkdev(clk, NULL, "i2c_davinci.1");
>>> +
>>> +??? clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk",
>>> 0, 1, 1);
>>> +??? clk_register_clkdev(clk, "timer0", NULL);
>>> +
>>> +??? clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk",
>>> 0, 1, 1);
>>> +??? clk_register_clkdev(clk, NULL, "davinci-wdt");
>>
>> Isn't this better done in da830_pll_clk_init() ? I think we can get rid
>> of the dummy fixed factor clock too and directly use the pll0_auxclk.
> 
> 
> I considered it, but I kind of like keeping the fixed factor clocks for
> debugging purposes. If you just have "pll0_auxclk" the enable count is
> not helpful because you don't know which driver did the enabling.

I think it is better to more or less reflect the hardware here. We would
not be doing this in the DT case, for example.

I see your point on debugging. Such code can perhaps be temporarily
introduced if really debugging such an issue. This will be the case with
any shared clock.

Thanks,
Sekhar
