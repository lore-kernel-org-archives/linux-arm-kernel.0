From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 25 Nov 2016 20:08:49 +0800
Subject: [RFC v2: PATCH 1/2] dt-bindings: Document the hi3660 reset
 bindings
In-Reply-To: <1480071241.4058.23.camel@pengutronix.de>
References: <Arnd Bergmann <arnd@arndb.de>
 <1479888476-13138-1-git-send-email-zhangfei.gao@linaro.org>
 <1479888476-13138-2-git-send-email-zhangfei.gao@linaro.org>
 <1479979605.2472.4.camel@pengutronix.de>
 <ac3c8e65-e4f2-3a9d-452c-f270d245cf9d@linaro.org>
 <1479981017.2472.14.camel@pengutronix.de>
 <8328a235-faeb-2218-4c49-a3f282599e95@linaro.org>
 <1480069523.4058.17.camel@pengutronix.de>
 <e71cfe28-cd31-828f-8c7f-b4faeed5d27f@linaro.org>
 <1480071241.4058.23.camel@pengutronix.de>
Message-ID: <bec21998-b30c-4076-62bf-6b24c9dd1dd6@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?11?25? 18:54, Philipp Zabel wrote:
> Am Freitag, den 25.11.2016, 18:42 +0800 schrieb zhangfei:
>> On 2016?11?25? 18:25, Philipp Zabel wrote:
>>> Am Donnerstag, den 24.11.2016, 18:20 +0800 schrieb zhangfei:
>>>> On 2016?11?24? 17:50, Philipp Zabel wrote:
>>>>> Am Donnerstag, den 24.11.2016, 17:40 +0800 schrieb zhangfei:
>>>>>> On 2016?11?24? 17:26, Philipp Zabel wrote:
>>>>>>> Am Mittwoch, den 23.11.2016, 16:07 +0800 schrieb Zhangfei Gao:
>>>>>>>> Add DT bindings documentation for hi3660 SoC reset controller.
>>>>>>>>
>>>>>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>>>>>> ---
>>>>>>>>      .../bindings/reset/hisilicon,hi3660-reset.txt      | 51 ++++++++++++++++++++++
>>>>>>>>      1 file changed, 51 insertions(+)
>>>>>>>>      create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..250daf2
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>>>>>>>> @@ -0,0 +1,51 @@
>>>>>>>> +Hisilicon System Reset Controller
>>>>>>>> +======================================
>>>>>>>> +
>>>>>>>> +Please also refer to reset.txt in this directory for common reset
>>>>>>>> +controller binding usage.
>>>>>>>> +
>>>>>>>> +The reset controller registers are part of the system-ctl block on
>>>>>>>> +hi3660 SoC.
>>>>>>>> +
>>>>>>>> +Required properties:
>>>>>>>> +- compatible: should be
>>>>>>>> +		 "hisilicon,hi3660-reset"
>>>>>>>> +- #reset-cells: 1, see below
>>>>>>>> +- hisi,rst-syscon: phandle of the reset's syscon.
>>>>>>>> +- hisi,reset-bits: Contains the reset control register information
>>>>>>>> +		  Should contain 2 cells for each reset exposed to
>>>>>>>> +		  consumers, defined as:
>>>>>>>> +			Cell #1 : offset from the syscon register base
>>>>>>>> +			Cell #2 : bits position of the control register
>>>>>>>> +
>>>>>>>> +Example:
>>>>>>>> +	iomcu: iomcu at ffd7e000 {
>>>>>>>> +		compatible = "hisilicon,hi3660-iomcu", "syscon";
>>>>>>>> +		reg = <0x0 0xffd7e000 0x0 0x1000>;
>>>>>>>> +	};
>>>>>>>> +
>>>>>>>> +	iomcu_rst: iomcu_rst_controller {
>>>>>>> This should be
>>>>>>> 	iomcu_rst: reset-controller {
>>>>>>>
>>>>>>>> +		compatible = "hisilicon,hi3660-reset";
>>>>>>>> +		#reset-cells = <1>;
>>>>>>>> +		hisi,rst-syscon = <&iomcu>;
>>>>>>>> +		hisi,reset-bits = <0x20 0x8		/* 0: i2c0 */
>>>>>>>> +				   0x20 0x10		/* 1: i2c1 */
>>>>>>>> +				   0x20 0x20		/* 2: i2c2 */
>>>>>>>> +				   0x20 0x8000000>;	/* 3: i2c6 */
>>>>>>>> +	};
>>>>>>> The reset lines are controlled through iomcu bits, is there a reason not
>>>>>>> to put the iomcu_rst node inside the iomcu node? That way the
>>>>>>> hisi,rst-syscon property could be removed and the syscon could be
>>>>>>> retrieved via the reset-controller parent node.
>>>>>> iomcu is common registers, controls clock and reset, etc.
>>>>>> So we use syscon, without mapping the registers everywhere.
>>>>>> It is common case in hisilicon, same in hi6220.
>>>>>>
>>>>>> Also the #clock-cells and #reset-cells can not be put in the same node,
>>>>>> if they are both using probe, since reset_probe will not be called.
>>>>>>
>>>>>> So we use hisi,rst-syscon as a general solution.
>>>>> What I meant is this:
>>>>>
>>>>> 	iomcu: iomcu at ffd7e000 {
>>>>> 		compatible = "hisilicon,hi3660-iomcu", "syscon", "simple-mfd";
>>>>> 		reg = <0x0 0xffd7e000 0x0 0x1000>;
>>>> #clock-cells = <1>;
>>>>
>>>> In my test, if there add #clock-cells = <1>, reset_probe will not be
>>>> called any more.
>>>> Since clk_probe is called first.
>>>> No matter iomcu_rst is child node or not.
>>> I don't understand this, does the clock driver bind to the iomcu node
>>> using CLK_OF_DECLARE_DRIVER(..., "hisilicon,hi3660-iomcu", ...)?
>> This method:CLK_OF_DECLARE_DRIVER is not prefered in clock,
>> and we have to use probe instead, to make all driver build as modules as
>> possible.
>>
>> For example hi3660.
>> static struct platform_driver hi3660_clk_driver = {
>>           .probe          = hi3660_clk_probe,
>>           .driver         = {
>>                   .name   = "hi3660-clk",
>>                   .of_match_table = hi3660_clk_match_table,
>>           },
>> };
> hi3660_clk_match_table contains the "hisilicon,hi3660-iomcu" compatible?
> If so, you could call
> 	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> from hi3660_clk_probe instead of using "simple-mfd" to probe the iomcu
> node's children.

Not using simple-mfd:

Like
static const struct of_device_id hi3660_clk_match_table[] = {
         { .compatible = "hisilicon,hi3660-iomcu", },
         { }
};
MODULE_DEVICE_TABLE(of, hi3660_clk_match_table);

static int hi3660_clk_probe(struct platform_device *pdev)
{
         struct device *dev = &pdev->dev;
         struct device_node *np = pdev->dev.of_node;
         const struct of_device_id *of_id;
         enum hi3660_clk_type type;

         of_id = of_match_device(hi3660_clk_match_table, dev);
         if (!of_id)
                 return -EINVAL;
~
}

If put iomcu_rst as child node, and set #clock-cells = <1> to iomcu,
then hi3660_clk_probe is called, hi3660_reset_probe will not be called.
So using "hisi,rst-syscon" as pointer does not have the issue.

Thanks
