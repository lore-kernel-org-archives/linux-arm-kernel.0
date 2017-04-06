From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 6 Apr 2017 11:35:42 +0200
Subject: [PATCH] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <20170405223233.GJ7065@codeaurora.org>
References: <1489569810-24350-1-git-send-email-gabriel.fernandez@st.com>
 <20170405223233.GJ7065@codeaurora.org>
Message-ID: <bd680d0a-0b2f-91fc-a940-b2fef4300ca3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


On 04/06/2017 12:32 AM, Stephen Boyd wrote:
> On 03/15, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch enables clocks for STM32H743 boards.
> Like what clocks exactly? All of them?
>
Yes all of them, it's new IP


>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>> new file mode 100644
>> index 0000000..9d4b587
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>> @@ -0,0 +1,152 @@
>> +STMicroelectronics STM32H7 Reset and Clock Controller
>> +=====================================================
>> +
>> +The RCC IP is both a reset and a clock controller.
>> +
>> +Please refer to clock-bindings.txt for common clock controller binding usage.
>> +Please also refer to reset.txt for common reset controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be:
>> +  "st,stm32h743-rcc"
>> +
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +
>> +- #reset-cells: 1, see below
>> +
>> +- #clock-cells : from common clock binding; shall be set to 1
>> +
>> +- clocks: External oscillator clock phandle
>> +  - high speed external clock signal (HSE)
>> +  - low speed external clock signal (LSE)
>> +  - external I2S clock (I2S_CKIN)
>> +
>> +- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
>> +  write protection (RTC clock).
>> +
>> +- pll x node: Allow to register a pll with specific parameters.
>> +  Please see PLL section below.
>> +
>> +Example:
>> +
>> +	rcc: rcc at 58024400 {
>> +		#reset-cells = <1>;
>> +		#clock-cells = <2>
>> +		compatible = "st,stm32h743-rcc", "st,stm32-rcc";
>> +		reg = <0x58024400 0x400>;
>> +		clocks = <&clk_hse>, <&clk_lse>, <&clk_i2s_ckin>;
>> +
>> +		st,syscfg = <&pwrcfg>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		vco1 at 58024430 {
>> +			#clock-cells = <0>;
>> +			compatible = "stm32,pll";
>> +			reg = <0>;
> reg is super confusing and doesn't match unit address.
ok i fixed it in the v2

>
>> +		};
> Why? Shouldn't we know this from the compatible string how many
> PLLs there are and where they're located? Export the PLLs through
> rcc node's clock-cells?
>
Because i need to offer the possibility to change the PLL VCO 
frequencies at the start-up of this driver clock.
The VCO algorithm needs a division factor, a multiplication factor and a 
fractional factor.
Lot's of solution are possible for one frequency and it's nightmare to 
satisfy the 3 output dividers of the PLL.


>> +
>> +		vco2 at 58024438 {
>> +			#clock-cells = <0>;
>> +			compatible = "stm32,pll";
>> +			reg = <1>;
> reg is super confusing and doesn't match unit address.
>
>> +			st,clock-div = <2>;
>> +			st,clock-mult = <40>;
>> +			st,frac-status = <0>;
>> +			st,frac = <0>;
>> +			st,vcosel = <1>;
>> +			st,pllrge = <2>;
> Does this stuff change on a per-board basis? I hope none of these
> properties need to be in DT.
These properties are optionals.
I absolute need it to custumize VCO  frequencies of a pll without the 
boot loader..

i suppressed  "st,frac-status" and  "st,pllrge" in the v2
>
>> +		};
>> +	};
>> +
>> +
>> +STM32H7 PLL
>> +-----------
>> +
> [...]
>> +
>> +Specifying softreset control of devices
>> +=======================================
>> +
>> +Device nodes should specify the reset channel required in their "resets"
>> +property, containing a phandle to the reset device node and an index specifying
>> +which channel to use.
>> +The index is the bit number within the RCC registers bank, starting from RCC
>> +base address.
>> +It is calculated as: index = register_offset / 4 * 32 + bit_offset.
>> +Where bit_offset is the bit offset within the register.
>> +
>> +For example, for CRC reset:
>> +  crc = AHB4RSTR_offset / 4 * 32 + CRCRST_bit_offset = 0x88 / 4 * 32 + 19 = 1107
>> +
>> +All available preprocessor macros for reset are defined dt-bindings//mfd/stm32h7-rcc.h
> One too many slashes?
ok i will fix it

>
>> +header and can be used in device tree sources.
>> +
>> +example:
>> +
>> +	timer2 {
>> +		resets	= <&rcc STM32H7_APB1L_RESET(TIM2)>;
>> +	};
>> diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
>> new file mode 100644
>> index 0000000..c8eb729
>> --- /dev/null
>> +++ b/drivers/clk/clk-stm32h7.c
>> @@ -0,0 +1,1586 @@
>> +/*
>> + * Copyright (C) Gabriel Fernandez 2017
>> + * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
>> + *
>> + * License terms: GPL V2.0.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/clk.h>
> Is this used?
No i will suppress it

>
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/stm32h7-clks.h>
>> +
>> +/* Reset Clock Control Registers */
>> +#define RCC_CR		0x00
>> +#define RCC_CFGR	0x10
>> +#define RCC_D1CFGR	0x18
>> +#define RCC_D2CFGR	0x1C
>> +#define RCC_D3CFGR	0x20
>> +#define RCC_PLLCKSELR	0x28
>> +#define RCC_PLLCFGR	0x2C
>> +#define RCC_PLL1DIVR	0x30
>> +#define RCC_PLL1FRACR	0x34
>> +#define RCC_PLL2DIVR	0x38
>> +#define RCC_PLL2FRACR	0x3C
>> +#define RCC_PLL3DIVR	0x40
>> +#define RCC_PLL3FRACR	0x44
>> +#define RCC_D1CCIPR	0x4C
>> +#define RCC_D2CCIP1R	0x50
>> +#define RCC_D2CCIP2R	0x54
>> +#define RCC_D3CCIPR	0x58
>> +#define RCC_BDCR	0x70
>> +#define RCC_CSR		0x74
>> +#define RCC_AHB3ENR	0xD4
>> +#define RCC_AHB1ENR	0xD8
>> +#define RCC_AHB2ENR	0xDC
>> +#define RCC_AHB4ENR	0xE0
>> +#define RCC_APB3ENR	0xE4
>> +#define RCC_APB1LENR	0xE8
>> +#define RCC_APB1HENR	0xEC
>> +#define RCC_APB2ENR	0xF0
>> +#define RCC_APB4ENR	0xF4
>> +
>> +static DEFINE_SPINLOCK(rlock);
> This is super generic and will make lockdep debugging sad.
> Perhaps stm32rcc_lock?
ok

>
>> +
>> +static void __iomem *base;
>> +static struct regmap *pdrm;
>> +static struct clk_hw **hws;
>> +
>> +/* System clock parent */
>> +static const char * const sys_src[] = {
>> +	"hsi_ck", "csi_ck", "hse_ck", "pll1_p" };
>> +
>> +static const char * const tracein_src[] = {
>> +	"hsi_ck", "csi_ck", "hse_ck", "pll1_r" };
> [...]
>> +
>> +static unsigned long pll_fd_recalc_rate(struct clk_hw *hw,
>> +		unsigned long parent_rate)
>> +{
>> +	struct stm32_pll_obj *clk_elem = to_pll(hw);
>> +	struct stm32_fractional_divider *fd = &clk_elem->div;
>> +	unsigned long m, n;
>> +	u32 val, mask;
>> +	u64 rate, rate1 = 0;
>> +
>> +	val = clk_readl(fd->mreg);
> Please don't use clk_readl() unless you need it for some reason.
ok

>
>> +	mask = (GENMASK(fd->mwidth - 1, 0) << fd->mshift);
>> +	m = (val & mask) >> fd->mshift;
>> +
>> +	val = clk_readl(fd->nreg);
>> +	mask = (GENMASK(fd->nwidth - 1, 0) << fd->nshift);
> Useless parentheses. And isn't GENMASK supposed to take the
> actual bit positions? Then we avoid overflow issues?
ok il will fix it.

>> +	n = ((val & mask) >> fd->nshift) + 1;
>> +
>> +	if (!n || !m)
>> +		return parent_rate;
>> +
>> +	rate = (u64)parent_rate * n;
>> +	do_div(rate, m);
>> +
>> +	if (pll_frac_is_enabled(hw)) {
>> +		val = pll_read_frac(hw);
>> +		rate1 = (u64) parent_rate * (u64) val;
>> +		do_div(rate1, (m * 8191));
>> +	}
>> +
>> +	return rate + rate1;
>> +}
>> +
> [...]
>> +
>> +	/* Micro-controller clocks */
>> +	for (n = 0; n < ARRAY_SIZE(mco_clk); n++) {
>> +		get_cfg_composite_div(&mco_clk_cfg, &mco_clk[n], &c_cfg,
>> +				&rlock);
>> +
>> +		hws[MCO_BANK + n] = clk_hw_register_composite(NULL,
>> +				mco_clk[n].name,
>> +				mco_clk[n].parent_name,
>> +				mco_clk[n].num_parents,
>> +				c_cfg.mux_hw, c_cfg.mux_ops,
>> +				c_cfg.div_hw, c_cfg.div_ops,
>> +				c_cfg.gate_hw, c_cfg.gate_ops,
>> +				mco_clk[n].flags);
>> +	}
>> +
>> +	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
>> +
>> +	return;
>> +
>> +err_free_clks:
>> +	kfree(clk_data);
>> +}
>> +CLK_OF_DECLARE_DRIVER(stm32h7_rcc, "st,stm32h743-rcc", stm32h7_rcc_init);
> Is there another driver that uses the same register space?
> Nothing showing up in -next right now. Perhaps a comment should
> be added to indicate the other driver.
Yes the reset controler.
ok il will add a comment.


BR
Gabriel
