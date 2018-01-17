From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Jan 2018 17:48:36 +0530
Subject: [PATCH v5 11/44] clk: davinci: Add platform information for TI
 DA830 PSC
In-Reply-To: <4dd36ca7-e41d-58d8-ec8c-787978307943@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-12-git-send-email-david@lechnology.com>
 <91fe16dc-907e-6dbb-c8db-c27561132093@ti.com>
 <4dd36ca7-e41d-58d8-ec8c-787978307943@lechnology.com>
Message-ID: <86581de6-a982-7a7b-9a83-22c869417211@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 January 2018 10:46 PM, David Lechner wrote:

>>> +static const struct davinci_psc_clk_info da830_psc0_info[]
>>> __initconst = {
>>> +??? LPSC(0, 0, tpcc, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(1, 0, tptc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(2, 0, tptc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(3, 0, aemif, pll0_sysclk3, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(4, 0, spi0, pll0_sysclk2, 0),
>>> +??? LPSC(5, 0, mmcsd, pll0_sysclk2, 0),
>>> +??? LPSC(6, 0, aintc, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(7, 0, arm_rom, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(8, 0, secu_mgr, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(9, 0, uart0, pll0_sysclk2, 0),
>>> +??? LPSC(10, 0, scr0_ss, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(11, 0, scr1_ss, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(12, 0, scr2_ss, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>> +??? LPSC(13, 0, dmax, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>
>> pruss is better (I know the name is coming from existing code).
>>
>>> +??? LPSC(14, 0, arm, pll0_sysclk6, LPSC_ALWAYS_ENABLED),
>>
>> This is LPSC 15 which controls DSP too. But its missing from existing
>> code. Not sure why. Probably a note for future. For now okay with
>> ignoring it.
>>
>>> +??? { }
>>> +};
>>
>> Tables like these are much easier to parse if columns are spaced using a
>> tab.
>>
> 
> Tabs make the lines over 80 columns. How about spaces instead?

That works for me. I guess checkpatch will complain, but hopefully
maintainers will agree on the exception.

>>> +void __init da830_psc_clk_init(void __iomem *psc0, void __iomem *psc1)
>>> +{
>>> +??? struct clk_onecell_data *clk_data;
>>> +
>>> +??? clk_data = davinci_psc_register_clocks(psc0, da830_psc0_info, 16);
>>> +??? if (!clk_data)
>>> +??????? return;
>>> +
>>> +??? clk_register_clkdev(clk_data->clks[4], NULL, "spi_davinci.0");
>>> +??? clk_register_clkdev(clk_data->clks[5], NULL, "da830-mmc.0");
>>> +??? clk_register_clkdev(clk_data->clks[9], NULL, "serial8250.0");
>>> +??? clk_register_clkdev(clk_data->clks[14], "arm", NULL);
>>> +
>>> +??? clk_free_onecell_data(clk_data);
>>> +
>>> +??? clk_data = davinci_psc_register_clocks(psc1, da830_psc1_info, 32);
>>> +??? if (!clk_data)
>>> +??????? return;
>>> +
>>> +??? clk_register_clkdev(clk_data->clks[1], NULL, "musb-da8xx");
>>> +??? clk_register_clkdev(clk_data->clks[1], NULL, "cppi41-dmaengine");
>>> +??? clk_register_clkdev(clk_data->clks[2], NULL, "ohci-da8xx");
>>> +??? clk_register_clkdev(clk_data->clks[3], "gpio", NULL);
>>
>> This is pretty bad (and no fault of yours) - having a con_id but no
>> device name. Can you please make a pre-series which passes NULL con_id
>> in gpio-davinci.c?
> 
> I'll give it a try. This is complicated by the fact that the con_id has
> made it's way into the device tree bindings. However, I think we can
> safely deprecate clock-names = "gpio" in the device tree bindings since
> we can make the driver ignore that property to preserve backwards
> compatibility.

I don't think this breaks DT-backward compatibility. Passing a NULL
con_id in driver should find the clock for that device even if DT entry
has clock-names present. As far as I can read clk_find().

The less intrusive alternate is to add the GPIO device name in the table
here, while keeping the con_id and keeping the driver untouched. The
advantage of that is lesser number of dependent patches for this series
to go in.

Later once CCF conversion has been there in the kernel for one full
release and no regressions, these other clean-ups can be done.

Thanks,
Sekhar
