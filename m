From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 20 Jul 2014 21:56:24 +0400
Subject: [PATCH v3+1 5/5] ARM: DT: STi: STiH416: Add DT node for MiPHY365x
In-Reply-To: <20140714075835.GJ2954@lee--X1>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <1404906074-31992-6-git-send-email-lee.jones@linaro.org>
 <20140711115406.GB2954@lee--X1> <53C0819E.4000202@cogentembedded.com>
 <20140714075835.GJ2954@lee--X1>
Message-ID: <53CC02C8.4010507@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/14/2014 11:58 AM, Lee Jones wrote:

>>> The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
>>> devices. It has 2 ports which it can use for either; both SATA, both
>>> PCIe or one of each in any configuration.

>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>> Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>

>>> diff --git a/arch/arm/boot/dts/stih416-b2020.dts b/arch/arm/boot/dts/stih416-b2020.dts
>>> index 4e2df66..c3c2ac6 100644
>>> --- a/arch/arm/boot/dts/stih416-b2020.dts
>>> +++ b/arch/arm/boot/dts/stih416-b2020.dts
>>> @@ -12,4 +12,16 @@
>>>   / {
>>>   	model = "STiH416 B2020";
>>>   	compatible = "st,stih416-b2020", "st,stih416";
>>> +
>>> +	soc {
>>> +		miphy365x_phy: miphy365x at fe382000 {
>>> +			phy_port0: port at fe382000 {

>>     I don't understand why are you creating the duplicate labels;
>> doesn't 'dtc' complain about them?

> I've never seen dtc complain about this:

>    DTC     arch/arm/boot/dts/dra72-evm.dtb
>    DTC     arch/arm/boot/dts/stih407-b2120.dtb
>    DTC     arch/arm/boot/dts/stih415-b2000.dtb
>    DTC     arch/arm/boot/dts/stih415-b2020.dtb
>    DTC     arch/arm/boot/dts/stih416-b2000.dtb
>    DTC     arch/arm/boot/dts/stih416-b2020.dtb
>    DTC     arch/arm/boot/dts/stih416-b2020e.dtb
>    DTC     arch/arm/boot/dts/armada-375-db.dtb

> Probably because they're not actually 'duplicate' per say.  Rather
> they are the same node split into different files.  I can remove the
> labels if required though.

    Yeah, I don't see why you need them if you don't refer to them anywhere.

>> You could instead refer to them
>> as:

>> &miphy365x_phy {
>> };

> I dislike this formatting.  I find it convolutes the hierarchical
> structure and makes DTS (and some DTSI) files hard to read i.e hides
> parenthood etc.

    Good point...

> [...]

>>> +		miphy365x_phy: miphy365x at fe382000 {

>>     The ePAPR standard [1] says:

>> The name of a node should be somewhat generic, reflecting the
>> function of the device and not its precise programming model.

> Good point.  Will change to 'phy'.

>>> +			compatible      = "st,miphy365x-phy";
>>> +			st,syscfg  	= <&syscfg_rear>;
>>> +			#address-cells	= <1>;
>>> +			#size-cells	= <1>;
>>> +			ranges;
>>> +
>>> +			phy_port0: port at fe382000 {
>>> +				#phy-cells = <1>;

>>     If these are PHY devices, they should be named "phy", not "port".

> Then what do you call the parent node?

    Oh, don't ask me, it wasn't my idea to have PHY subnodes. :-)

WBR, Sergei
