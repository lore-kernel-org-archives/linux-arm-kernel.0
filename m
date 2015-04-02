From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 02 Apr 2015 08:50:50 -0600
Subject: [PATCH 3/3] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <21658630.CslVI5jns9@fb07-iapwap2>
References: <1422516022-27161-1-git-send-email-danindrey@mail.ru>
 <551AC153.7060103@mail.ru> <551C2AC0.9030304@wwwdotorg.org>
 <21658630.CslVI5jns9@fb07-iapwap2>
Message-ID: <551D574A.7060101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2015 03:37 AM, Marc Dietrich wrote:
>
> Am Mittwoch, 1. April 2015, 11:28:32 schrieb Stephen Warren:
>> On 03/31/2015 09:46 AM, Andrey Danin wrote:
>>> On 31.03.2015 17:09, Stephen Warren wrote:
>>>> On 03/31/2015 12:40 AM, Andrey Danin wrote:
>>>>> Hi,
>>>>>
>>>>> Thanks for the review.
>>>>>
>>>>> On 03.02.2015 0:20, Stephen Warren wrote:
>
> [ snipped old patch parts ]
>
>>>>>>> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
>>>>>>> b/arch/arm/boot/dts/tegra20-paz00.dts
>>>>>>>
>>>>>>> -    nvec at 7000c500 {
>>>>>>> -        compatible = "nvidia,nvec";
>>>>>>> -        reg = <0x7000c500 0x100>;
>>>>>>> -        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>> -        #address-cells = <1>;
>>>>>>> -        #size-cells = <0>;
>>>>>>> +    i2c at 7000c500 {
>>>>>>> +        status = "okay";
>>>>>>>
>>>>>>>            clock-frequency = <80000>;
>>>>>>>
>>>>>>> -        request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
>>>>>>> -        slave-addr = <138>;
>>>>>>> -        clocks = <&tegra_car TEGRA20_CLK_I2C3>,
>>>>>>> -                 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
>>>>>>> -        clock-names = "div-clk", "fast-clk";
>>>>>>> -        resets = <&tegra_car 67>;
>>>>>>> -        reset-names = "i2c";
>>>>>>> +
>>>>>>> +        nvec: nvec at 45 {
>>>>>>
>>>>>> This doesn't feel correct. There's nothing here to indicate that this
>>>>>> child device is a slave that is implemented by the host SoC rather than
>>>>>> something external attached to the I2C bus.
>>>>>>
>>>>>> Perhaps you can get away with this, since the driver for nvidia,nvec
>>>>>> only calls I2C APIs suitable for internal slaves rather than external
>>>>>> slaves? Even so though, I think the distinction needs to be clearly
>>>>>> marked in the DT so that any generic code outside the NVEC driver that
>>>>>> parses the DT can determine the difference.
>>>>>>
>>>>>> I would recommend the I2C controller having #address-cells=<2> with
>>>>>> cell
>>>>>> 0 being 0==master,1==slave, cell 1 being the I2C address. The I2C
>>>>>> driver
>>>>>> would need to support #address-cells=<1> for backwards-compatibility.
>
> Stephen, we haven't used your suggestion because Wolfram disliked the idea in
> e.g. http://lkml.iu.edu/hypermail/linux/kernel/1409.1/03446.html

As you said in the response you linked to, the objection is invalid 
since it won't break any DTs. The driver for a node is responsible for 
defining the meaning of its own reg properties. It should be pretty 
trivial to allow the Tegra I2C controller driver (or indeed any driver 
at all) to handle either #address-cells=<1> (the current setting) or 
#address-cells=<2> (a new value which enables adding a new flag cell) or 
even #address-cells=<1> with some of the upper bits of the reg value 
used as flags (which would default to 0 in all current DTs, so e.g. 
using the MSB==1 as a slave flag), all at run-time with complete 
backwards-compatibility.
