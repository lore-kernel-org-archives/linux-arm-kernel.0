From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 12 Jul 2018 10:47:12 +0800
Subject: [PATCH v2 1/3] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <20180711194346.GA32414@rob-hp-laptop>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
 <20180710163658.6175-2-yixun.lan@amlogic.com>
 <20180711194346.GA32414@rob-hp-laptop>
Message-ID: <f2eb8632-1113-3bb8-506f-ac0d4e838fd4@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

see my comments

On 07/12/18 03:43, Rob Herring wrote:
> On Tue, Jul 10, 2018 at 04:36:56PM +0000, Yixun Lan wrote:
>> Document the MMC sub clock controller driver, the potential consumer
>> of this driver is MMC or NAND.
> 
> So you all have decided to properly model this now?
> 
Yes, ;-)

>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  .../bindings/clock/amlogic,mmc-clkc.txt       | 31 +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> new file mode 100644
>> index 000000000000..ff6b4bf3ecf9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> @@ -0,0 +1,31 @@
>> +* Amlogic MMC Sub Clock Controller Driver
>> +
>> +The Amlogic MMC clock controller generates and supplies clock to support
>> +MMC and NAND controller
>> +
>> +Required Properties:
>> +
>> +- compatible: should be:
>> +		"amlogic,meson-gx-mmc-clkc"
>> +		"amlogic,meson-axg-mmc-clkc"
>> +
>> +- #clock-cells: should be 1.
>> +- clocks: phandles to clocks corresponding to the clock-names property
>> +- clock-names: list of parent clock names
>> +	- "clkin0", "clkin1"
>> +
>> +Parent node should have the following properties :
>> +- compatible: "syscon", "simple-mfd, and "amlogic,meson-axg-mmc-clkc"
> 
> You don't need "simple-mfd" and probably not syscon either. The order is 
> wrong too. Most specific first.
> 
Ok, I will drop "simple-mfd"..

but the syscon is a must, since this mmc clock model access registers
via the regmap interface

I will fix the order, thanks for pointing this out

>> +- reg: base address and size of the MMC control register space.
>> +
>> +Example: Clock controller node:
>> +
>> +sd_mmc_c_clkc: clock-controller at 7000 {
>> +	compatible = "amlogic,mmc-clkc", "syscon", "simple-mfd";
> 
> Doesn't match the binding...
> 
oops, I will update this

>> +	reg = <0x0 0x7000 0x0 0x4>;
>> +	#clock-cells = <1>;
>> +
>> +	clock-names = "clkin0", "clkin1";
>> +	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
>> +			<&clkc CLKID_FCLK_DIV2>;
>> +};
>> -- 
>> 2.18.0
>>
> 
> .
> 
