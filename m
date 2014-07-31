From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 31 Jul 2014 14:54:00 +0200
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <53DA3613.9010305@ti.com>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <53DA3613.9010305@ti.com>
Message-ID: <53DA3C68.3020406@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2014 14:26, Peter Ujfalusi wrote:
> On 07/30/2014 05:02 PM, Stefan Assmann wrote:
>> Adding a clock driver for the TI TWL6030. The driver prepares the
>> CLK32KG clock, which is required for the wireless LAN.
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  .../devicetree/bindings/clock/ti/twl6030.txt       |   4 +
>>  drivers/clk/Kconfig                                |   7 +
>>  drivers/clk/ti/Makefile                            |   1 +
>>  drivers/clk/ti/clk-6030.c                          | 141 +++++++++++++++++++++
>>  drivers/mfd/twl-core.c                             |   3 +
>>  5 files changed, 156 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/ti/twl6030.txt
>>  create mode 100644 drivers/clk/ti/clk-6030.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti/twl6030.txt b/Documentation/devicetree/bindings/clock/ti/twl6030.txt
>> new file mode 100644
>> index 0000000..d290ad4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti/twl6030.txt
>> @@ -0,0 +1,4 @@
>> +Binding for TI TWL6030.
>> +
>> +Required properties:
>> +- compatible: "ti,twl6030-clk32kg"
> 
> 
> This is not really helping out. Where would you put this compatible? How it is
> related to twl6030?

Just making a start, I'll see if I can make it more useful.

> 
>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>> index 9f9c5ae..4e89e8b 100644
>> --- a/drivers/clk/Kconfig
>> +++ b/drivers/clk/Kconfig
>> @@ -65,6 +65,13 @@ config COMMON_CLK_S2MPS11
>>  	  clock. These multi-function devices have two (S2MPS14) or three
>>  	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>>  
>> +config CLK_TWL6030
>> +	tristate "Clock driver for twl6030"
>> +	depends on TWL4030_CORE
>> +	---help---
>> +	  Enable the TWL6030 clock CLK32KG which is disabled by default.
>> +	  Needed on the Pandaboard for the wireless LAN.
> 
> This is not relevant information. I'm sure the CLK32KG from twl6030 can be or
> is used for other purposes on other boards.

I'll remove it.

>> +static int twl6030_clk32kg_prepare(struct clk_hw *hw)
>> +{
>> +	struct twl6030_desc *desc = to_twl6030_desc(hw);
>> +	int ret;
>> +
>> +	ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
>> +			       TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
>> +			       TWL6030_CFG_STATE_ON,
>> +			       TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
> 
> What is going to happen if someone ask for this clock before the twl-core is
> initialized?

Originally in of_twl6030_clk32kg_probe() clk_get() would be called and
that would only succeed after of_clk_init() got called in twl_probe().
Tero already pointed out that it should not be done that way.

>> +static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct clk *clk;
>> +	int ret = 0;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	clk = clk_get(&pdev->dev, "clk32kg");
>> +	if (IS_ERR(clk))
>> +		ret = -EPROBE_DEFER;
>> +	else
>> +		clk_prepare(clk);
> 
> Why would you do this? The point of a clock provider is that you can
> enable/disable the clock on demand. Here you enable the clock and leave it
> enabled for the rest of the time...
> 
> clk-dra7-atl deals with similar issue

The idea is to enable the clock by default to get the wifi working.
Sorry if I got it wrong.

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static struct of_device_id of_twl6030_clk32kg_match_tbl[] = {
>> +	{ .compatible = "ti,twl6030-clk32kg", },
> 
> Hrm, not sure if this is correct. you have "ti,twl6030-clk32kg" as compatible
> for the platform driver _and_ you have the same "ti,twl6030-clk32kg"
> compatible for the declared clock.
> This does not seams right.
> 
> I think you should not have compatible for the platform driver at all, rather
> you need to create the needed platform device in the twl-core to probe the
> driver, then look up for the clock node.
> 
> I think in terms of HW setup the Palmas clock is the closest to twl6030's 32K
> clocks. It might worth taking a look at that for hints. It is not using
> CLK_OF_DECLARE() since it is external chip, but it does the job.

Thanks for the hint I'll look at that driver for improvements.

>> @@ -1012,6 +1013,8 @@ static void clocks_init(struct device *dev,
>>  	u32 rate;
>>  	u8 ctrl = HFCLK_FREQ_26_MHZ;
>>  
>> +	of_clk_init(NULL);
>> +
> 
> I don't think this is in the right place. twl-core should not call a generic
> clk init function.

Tero pointed that out already. Problem is that the clock doesn't show up
otherwise. An experimental patch from Tero might help, he offered to
post it.

Thanks for the comments Peter.

  Stefan
