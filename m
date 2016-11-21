From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 21 Nov 2016 10:58:24 +0800
Subject: [PATCH] reset: hisilicon: add a polarity cell for reset line
 specifier
In-Reply-To: <db839cba-a105-fa8e-8633-c98999cd7316@hisilicon.com>
References: <1479193794-18350-1-git-send-email-xuejiancheng@hisilicon.com>
 <1479206594.2456.24.camel@pengutronix.de>
 <db839cba-a105-fa8e-8633-c98999cd7316@hisilicon.com>
Message-ID: <03bb74da-6b24-ee4c-307d-3b3f10ac2f7a@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 2016/11/16 11:17, Jiancheng Xue wrote:
> Hi Philipp,
> 
> On 2016/11/15 18:43, Philipp Zabel wrote:
>> Hi Jiancheng,
>>
>> Am Dienstag, den 15.11.2016, 15:09 +0800 schrieb Jiancheng Xue:
>>> Add a polarity cell for reset line specifier. If the reset line
>>> is asserted when the register bit is 1, the polarity is
>>> normal. Otherwise, it is inverted.
>>>
>>> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>>> ---
> Thank you very much for replying so soon.
> 
> Please allow me to decribe the reason why this patch exists first.
> All bits in the reset controller were designed to be active-high.
> But in a recent chip only one bit was implemented to be active-low :(
> 
>>>  .../devicetree/bindings/clock/hisi-crg.txt         | 11 ++++---
>>>  arch/arm/boot/dts/hi3519.dtsi                      |  2 +-
>>>  drivers/clk/hisilicon/reset.c                      | 36 ++++++++++++++++------
>>>  3 files changed, 33 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>> index e3919b6..fcbb4f3 100644
>>> --- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>> +++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>> @@ -25,19 +25,20 @@ to specify the clock which they consume.
>>>  
>>>  All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
>>>  
>>> -- #reset-cells: should be 2.
>>> +- #reset-cells: should be 3.
>>>  
>>>  A reset signal can be controlled by writing a bit register in the CRG module.
>>> -The reset specifier consists of two cells. The first cell represents the
>>> +The reset specifier consists of three cells. The first cell represents the
>>>  register offset relative to the base address. The second cell represents the
>>> -bit index in the register.
>>> +bit index in the register. The third cell represents the polarity of the reset
>>> +line (0 for normal, 1 for inverted).
>>
#reset-cells: Should be 2 if compatilbe string is "hisilicon,hi3519-crg". Should be 3 otherwise.
	      A reset signal can be controlled by writing a bit register in the CRG module.
	      The reset specifier consists of two or three cells. The first cell represents the
	      register offset relative to the base address. The second cell represents the
	      bit index in the register.The third cell represents the polarity of the reset
	      line (0 for active-high, 1 for active-low).

If I change the binding like this, can it be accepted?

Regards,
Jiancheng

>> What is normal and what is inverted? Please specify which is active-high
>> and which is active-low.
>>
> OK. I'll use active-high and active-low instead.
> 
>>>  
>>>  Example: CRG nodes
>>>  CRG: clock-reset-controller at 12010000 {
>>>  	compatible = "hisilicon,hi3519-crg";
>>>  	reg = <0x12010000 0x10000>;
>>>  	#clock-cells = <1>;
>>> -	#reset-cells = <2>;
>>> +	#reset-cells = <3>;
>>>  };
>>>  
>>>  Example: consumer nodes
>>> @@ -45,5 +46,5 @@ i2c0: i2c at 12110000 {
>>>  	compatible = "hisilicon,hi3519-i2c";
>>>  	reg = <0x12110000 0x1000>;
>>>  	clocks = <&CRG HI3519_I2C0_RST>;
>>> -	resets = <&CRG 0xe4 0>;
>>> +	resets = <&CRG 0xe4 0 0>;
>>>  };
>>> diff --git a/arch/arm/boot/dts/hi3519.dtsi b/arch/arm/boot/dts/hi3519.dtsi
>>> index 5729ecf..b7cb182 100644
>>> --- a/arch/arm/boot/dts/hi3519.dtsi
>>> +++ b/arch/arm/boot/dts/hi3519.dtsi
>>> @@ -50,7 +50,7 @@
>>>  	crg: clock-reset-controller at 12010000 {
>>>  		compatible = "hisilicon,hi3519-crg";
>>>  		#clock-cells = <1>;
>>> -		#reset-cells = <2>;
>>> +		#reset-cells = <3>;
>>
>> That is a backwards incompatible change. Which I think in this case
>> could be tolerated, because there are no users yet of the reset
>> controller. Or are there any hi3519 based device trees that use the
>> resets out in the wild? If there are, the driver must continue to
>> support old device trees with two reset-cells. Which would not be
>> trivial because currently the core checks in reset_control_get that
>> rcdev->of_n_reset_cells is equal to the #reset-cells value from DT.
> 
