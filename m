From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Fri, 28 Apr 2017 16:56:16 +0200
Subject: [PATCH] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <20170407195152.GH7065@codeaurora.org>
References: <1489569810-24350-1-git-send-email-gabriel.fernandez@st.com>
 <20170405223233.GJ7065@codeaurora.org>
 <bd680d0a-0b2f-91fc-a940-b2fef4300ca3@st.com>
 <20170407195152.GH7065@codeaurora.org>
Message-ID: <7a8082a9-e62c-0120-e680-bef63eb892ae@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen

Sorry for delay i was on sick live

On 04/07/2017 09:51 PM, Stephen Boyd wrote:
> On 04/06, Gabriel Fernandez wrote:
>> On 04/06/2017 12:32 AM, Stephen Boyd wrote:
>>> On 03/15, gabriel.fernandez at st.com wrote:
>>>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>>> new file mode 100644
>>>> index 0000000..9d4b587
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>>> @@ -0,0 +1,152 @@
>>>> +
>>>> +	rcc: rcc at 58024400 {
>>>> +		#reset-cells = <1>;
>>>> +		#clock-cells = <2>
>>>> +		compatible = "st,stm32h743-rcc", "st,stm32-rcc";
>>>> +		reg = <0x58024400 0x400>;
>>>> +		clocks = <&clk_hse>, <&clk_lse>, <&clk_i2s_ckin>;
>>>> +
>>>> +		st,syscfg = <&pwrcfg>;
>>>> +
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		vco1 at 58024430 {
>>>> +			#clock-cells = <0>;
>>>> +			compatible = "stm32,pll";
>>>> +			reg = <0>;
>>> reg is super confusing and doesn't match unit address.
>> ok i fixed it in the v2
>>
>>>> +		};
>>> Why? Shouldn't we know this from the compatible string how many
>>> PLLs there are and where they're located? Export the PLLs through
>>> rcc node's clock-cells?
>>>
>> Because i need to offer the possibility to change the PLL VCO
>> frequencies at the start-up of this driver clock.
>> The VCO algorithm needs a division factor, a multiplication factor
>> and a fractional factor.
>> Lot's of solution are possible for one frequency and it's nightmare
>> to satisfy the 3 output dividers of the PLL.
> Sure, but do we need to configure that on a per-board basis or a
> per-SoC basis? If it's just some configuration, I wonder why we
> don't put that into the driver and base it off some compatible
> string that includes the SoC the device is for.
>
I prefer to let in first, the responsibility of the boot loader to 
change VCO parameters.
Then i propose a new version without DT configuration of PLL's
are you ok for that ?

best regards

Gabriel



To simply
