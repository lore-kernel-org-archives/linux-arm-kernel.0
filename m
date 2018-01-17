From: david@lechnology.com (David Lechner)
Date: Wed, 17 Jan 2018 13:08:34 -0600
Subject: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
In-Reply-To: <bb1f446e-5900-7e73-c1b7-955662a9541b@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com>
 <8d09dba6-9b1d-e06e-8730-256b8a4320db@ti.com>
 <b6baa17e-1239-c209-9eca-52e5da73e921@lechnology.com>
 <bb1f446e-5900-7e73-c1b7-955662a9541b@ti.com>
Message-ID: <7b33c9a1-468c-15e6-2899-be334b4f3807@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2018 05:57 AM, Sekhar Nori wrote:
> On Tuesday 16 January 2018 10:51 PM, David Lechner wrote:
>> On 01/16/2018 08:00 AM, Sekhar Nori wrote:
>>> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>>>> +void __init da850_psc_clk_init(void __iomem *psc0, void __iomem *psc1)
>>>> +{
>>>> +??? struct clk_onecell_data *clk_data;
>>>> +
>>>> +??? clk_data = davinci_psc_register_clocks(psc0, da850_psc0_info, 16);
>>>> +??? if (!clk_data)
>>>> +??????? return;
>>>> +
>>>> +??? clk_register_clkdev(clk_data->clks[3], NULL, "ti-aemif");
>>>> +??? clk_register_clkdev(clk_data->clks[3], "aemif", "davinci-nand.0");
>>>> +??? clk_register_clkdev(clk_data->clks[4], NULL, "spi_davinci.0");
>>>> +??? clk_register_clkdev(clk_data->clks[5], NULL, "da830-mmc.0");
>>>> +??? clk_register_clkdev(clk_data->clks[9], NULL, "serial8250.0");
>>>> +??? clk_register_clkdev(clk_data->clks[14], "arm", NULL);
>>>> +??? clk_register_clkdev(clk_data->clks[15], NULL, "davinci-rproc.0");
>>>> +
>>>> +??? clk_free_onecell_data(clk_data);
>>>> +
>>>> +??? clk_data = davinci_psc_register_clocks(psc1, da850_psc1_info, 32);
>>>> +??? if (!clk_data)
>>>> +??????? return;
>>>> +
>>>> +??? clk_register_clkdev(clk_data->clks[1], "usb20_psc_clk", NULL);
>>>
>>> Is this con_id really needed now? Searching for "usb20_psc_clk" in your
>>> tree results in only this one hit.
>>
>> Yes, this is left over from previous attempts.
>>
>>>
>>>> +??? clk_register_clkdev(clk_data->clks[1], NULL, "musb-da8xx");
>>>> +??? clk_register_clkdev(clk_data->clks[1], NULL, "cppi41-dmaengine");
>>>
>>> I guess multiple dev_id matches like these are another hurdle in moving
>>> them to davinci_psc_clk_info[] table? If its too cumbersome to keep
>>> multiple entries in the table, they can be handled as an exception at
>>> the end of processing the table? Still they are not the norm so I hope
>>> the normal case will still benefit.
>>
>> Right, as I mentioned in the reply to the previous patch, instead of
>> assigning a con_id and dev_id to each clock, we would need to assign
>> an array with a list of clocks. I think that would work better than
>> trying to handle the extras as an exception since there, on average,
>> about 5 per SoC.
> 
> Okay, are you going to try this to see how it looks?

It is looking like this:


static const struct davinci_psc_clkdev_info emfia_clkdev[] __initconst = {
	LPSC_CLKDEV(NULL,	"ti-aemif"),
	LPSC_CLKDEV("aemif",	"davinci-nand.0"),
	{ }
};

static const struct davinci_psc_clkdev_info spi0_clkdev[] __initconst = {
	LPSC_CLKDEV(NULL,	"spi_davinci.0"),
	{ }
};

static const struct davinci_psc_clkdev_info mmcsd0_clkdev[] __initconst = {
	LPSC_CLKDEV(NULL,	"da830-mmc.0"),
	{ }
};

static const struct davinci_psc_clkdev_info uart0_clkdev[] __initconst = {
	LPSC_CLKDEV(NULL,	"serial8250.0"),
	{ }
};

static const struct davinci_psc_clkdev_info arm_clkdev[] __initconst = {
	/*
	 * REVISIT: cpufreq-davinci should be modified to use dev_id and drop
	 * use of con_id.
	 */
	LPSC_CLKDEV("arm",	NULL),
	{ }
};

static const struct davinci_psc_clkdev_info dsp_clkdev[] __initconst = {
	LPSC_CLKDEV(NULL,	"davinci-rproc.0"),
	{ }
};

static const struct davinci_psc_clk_info da850_psc0_info[] __initconst = {
	LPSC(0,  0, tpcc0,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
	LPSC(1,  0, tptc0,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
	LPSC(2,  0, tptc1,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
	LPSC(3,  0, emifa,   async1,       emfia_clkdev,  0),
	LPSC(4,  0, spi0,    pll0_sysclk2, spi0_clkdev,   0),
	LPSC(5,  0, mmcsd0,  pll0_sysclk2, mmcsd0_clkdev, 0),
	LPSC(6,  0, aintc,   pll0_sysclk4, NULL,          LPSC_ALWAYS_ENABLED),
	LPSC(7,  0, arm_rom, pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
	LPSC(9,  0, uart0,   pll0_sysclk2, uart0_clkdev,  0),
	LPSC(13, 0, pruss,   pll0_sysclk2, NULL,          0),
	LPSC(14, 0, arm,     pll0_sysclk6, arm_clkdev,    LPSC_ALWAYS_ENABLED |
							  LPSC_ARM_RATE),
	LPSC(15, 1, dsp,     pll0_sysclk1, dsp_clkdev,    LPSC_FORCE |
							  LPSC_LOCAL_RESET),
	{ }
};
