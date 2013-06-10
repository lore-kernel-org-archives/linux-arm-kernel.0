From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 10 Jun 2013 17:17:53 +0100
Subject: [PATCH v2 07/11] ARM:stixxxx: Add STiH416 SOC support
In-Reply-To: <3733079.FxbR14kFrs@wuerfel>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com>
 <3733079.FxbR14kFrs@wuerfel>
Message-ID: <51B5FC31.5050208@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thankyou for your comments.
On 10/06/13 14:52, Arnd Bergmann wrote:
> On Monday 10 June 2013 10:27:05 Srinivas KANDAGATLA wrote:
> 
>> +	soc {
>> +		pin-controller-sbc {
>> +			#address-cells	= <1>;
>> +			#size-cells	= <1>;
>> +			compatible	= "st,stih416-pinctrl", "simple-bus";
> 
> Why is this both its own device with a compatible string and a
> "simple-bus" at the same time? Wouldn't it be simpler to just
> scan the child device nodes from the "st,stih416-pinctrl"
> driver instead of having a separate platform_driver for them?
Am happy to get rid of gpio platform_driver, But looking at the existing
pinctrl drivers like at91, they do it exactly like this.

Also having a gpio platform driver ties the resources to driver in a
neat way.

> 
>> +			st,retime-in-delay	= <0 300 500 750 1000 1250 1500 1750 2000 2250 2500 2750 3000 3250>;
>> +			st,retime-out-delay	= <0 300 500 750 1000 1250 1500 1750 2000 2250 2500 2750 3000 3250>;
>> +			st,syscfg		= <&syscfg_sbc>;
>> +			st,syscfg-offsets	= <0 40 50 60 100>;
>> +			ranges;
>> +			PIO0: pinctrl at fe610000 {
>> +				#gpio-cells = <1>;
>> +				compatible = "st,stixxxx-gpio";
>> +				gpio-controller;
>> +				reg = <0xfe610000 0x100>;
>> +				st,bank-name  = "PIO0";
>> +				st,retime-pin-mask = <0xff>;
>> +			};
>> +			PIO1: pinctrl at fe611000 {
>> +				#gpio-cells	= <1>;
>> +				compatible	= "st,stixxxx-gpio";
>> +				gpio-controller;
>> +				reg = <0xfe611000 0x100>;
>> +				st,bank-name  = "PIO1";
>> +				st,retime-pin-mask = <0xff>;
>> +			};
> 
> What is in the ranges between these registers? It seems you have
> 256 bytes for each pinctrl node, with 4kb spacing. I wonder if
> it would make sense to declare the entire range to belong to a single
> pinctrl device. At least since all of the registers are in a single
> range, you could add a property like
> 
> 	ranges = <0 0xfe610000 0x10000>;
> 
> and use relative addresses in the sub-nodes.
> 
OK, I will change to use ranges.
> Please don't use identifiers with 'xxx' in them. Instead use numbers
> of actual chips, ideally using the first one that this is compatible
> with.

Ok, I will change st,stixxxx-gpio to st,stih415-gpio.

> 
>> +		syscfg_sbc:syscfg at fe600000{
>> +			compatible	= "st,stih416-syscfg";
>> +			reg		= <0xfe600000 0x1000>;
>> +			syscfg-range	= <0 999>;
>> +			syscfg-name	= "SYSCFG_SBC";
>> +		};
>> +		syscfg_front:syscfg at fee10000{
>> +			compatible	= "st,stih416-syscfg";
>> +			reg		= <0xfee10000 0x1000>;
>> +			syscfg-range	= <1000 999>;
>> +			syscfg-name	= "SYSCFG_FRONT";
>> +		};
> 
> Did you mean to declare ranges excluding 1000 and 2000 here?
> Normally I would expect inclusive ranges like syscfg-range=<0 1000>;
> 
These numbers are from data sheet so I used it as it is.

> What is the idea of the 'syscfg-name'? If the nodes are all different,
The idea of having syscfg-name is to lookup any sysconf bank(regmap)
from code which do not have reference to phandle from device trees.

> I would expect them to have distinct "compatible" values and not
> need them.
Yes, If we have distinct compatible we would not need them, but there
will be 5-10 compatibility list for each SOC.
It looks like its going to be much neater Am going to try this change
and see how it looks like.
> 
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
