From: david@lechnology.com (David Lechner)
Date: Thu, 18 Jan 2018 12:49:08 -0600
Subject: [PATCH v5 21/44] clk: davinci: New driver for TI DA8XX USB PHY
 clocks
In-Reply-To: <493e4809-6b77-7772-70c7-ad0fa04e9033@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-22-git-send-email-david@lechnology.com>
 <493e4809-6b77-7772-70c7-ad0fa04e9033@ti.com>
Message-ID: <8821ac95-ee3f-b53b-9a8a-598b69d1b35e@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2018 07:05 AM, Sekhar Nori wrote:
> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
> 
>> +static int da8xx_usb1_phy_clk_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	struct da8xx_usb1_phy_clk *clk = to_da8xx_usb1_phy_clk(hw);
>> +	unsigned int mask, val;
>> +
>> +	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
>> +	mask = CFGCHIP2_USB1PHYCLKMUX;
>> +	switch (index) {
>> +	case DA8XX_USB1_PHY_CLK_PARENT_USB_REFCLKIN:
>> +		val = CFGCHIP2_USB1PHYCLKMUX;
>> +		break;
>> +	case DA8XX_USB1_PHY_CLK_PARENT_USB0_PHY_PLL:
>> +		val = 0;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	regmap_write_bits(clk->regmap, CFGCHIP(2), mask, val);
> 
> This function can be simplified quite a bit if you use a shift.
> 
> #define CFGCHIP2_USB1PHYCLKMUX_SHIFT	12
> 
> static int da8xx_usb1_phy_clk_set_parent(struct clk_hw *hw, u8 index)
> {
> 	struct da8xx_usb1_phy_clk *clk = to_da8xx_usb1_phy_clk(hw);
> 
> 	regmap_write_bits(clk->regmap, CFGCHIP(2),
> 			  CFGCHIP2_USB1PHYCLKMUX,
> 			  index << CFGCHIP2_USB1PHYCLKMUX_SHIFT);
> }
> 
> Same thing for da8xx_usb0_phy_clk_set_parent() as well.
> 

or to avoid defining a new macro?


> 	regmap_write_bits(clk->regmap, CFGCHIP(2),
> 			  CFGCHIP2_USB1PHYCLKMUX,
> 			  index ? CFGCHIP2_USB1PHYCLKMUX : 0);
