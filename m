From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 14:50:14 -0700
Subject: [PATCHv3 2/4] clk: socfpga: add a clock driver for the Arria
 10 platform
In-Reply-To: <555B64FE.40104@opensource.altera.com>
References: <1431011523-10049-1-git-send-email-dinguyen@opensource.altera.com>
 <1431011523-10049-3-git-send-email-dinguyen@opensource.altera.com>
 <20150516005235.GP31753@codeaurora.org>
 <555B64FE.40104@opensource.altera.com>
Message-ID: <555BB016.8000506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/15 09:29, Dinh Nguyen wrote:
>
> On 5/15/15 7:52 PM, Stephen Boyd wrote:
>> On 05/07, dinguyen at opensource.altera.com wrote:
>>> +
>>> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
>>> +{
>>> +	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
>>> +	struct regmap *sys_mgr_base_addr;
>>> +	int i;
>>> +	u32 hs_timing;
>>> +	u32 clk_phase[2];
>>> +
>>> +	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
>>> +		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
>>> +		if (IS_ERR(sys_mgr_base_addr)) {
>> Is there a reason the syscon is grabbed lazily in prepare? Why
>> not get it before registering this clock?
> This syscon node is only associated with clocks that have a clk-phase
> property, which on the SoCFPGA platform, is the SD/MMC clocks. The way
> to implement this went through quite a few rounds of discussion for the
> Cyclone5/Arria5 platform before settling to this method.
>
> The reason why syscon is grabbed here is that the setting of the clock
> phase must be done before enabling of the clock, so it seem that prepare
> was a good place. Should this be move moved to the socfpga_gate_init()
> instead?

I was expecting the regmap to be found before the clock is registered
and stored away into the  socfpga_gate_clk structure. Getting the regmap
during prepare is akin to ioremapping a register region during prepare,
which doesn't sound right at all. Maybe there's some good reason in the
earlier discussions? Any hints?

>>> +			switch (socfpgaclk->clk_phase[i]) {
>>> +			case 0:
>>> +				clk_phase[i] = 0;
>>> +				break;
>>> +			case 45:
>>> +				clk_phase[i] = 1;
>>> +				break;
>>> +			case 90:
>>> +				clk_phase[i] = 2;
>>> +				break;
>>> +			case 135:
>>> +				clk_phase[i] = 3;
>>> +				break;
>>> +			case 180:
>>> +				clk_phase[i] = 4;
>>> +				break;
>>> +			case 225:
>>> +				clk_phase[i] = 5;
>>> +				break;
>>> +			case 270:
>>> +				clk_phase[i] = 6;
>>> +				break;
>>> +			case 315:
>>> +				clk_phase[i] = 7;
>>> +				break;
>>> +			default:
>>> +				clk_phase[i] = 0;
>>> +				break;
>>> +			}
>>> +		}
>>> +
>>> +		hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
>>> +		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
>>> +			     hs_timing);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static struct clk_ops gateclk_ops = {
>> const?
>>
> I cannot make this a const as I am assigning the .enable/.disable to use
> the common clk_gate_ops.
>
>

Hm.. ok. Maybe we should export those functions to modules.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
