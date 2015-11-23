From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 23 Nov 2015 09:12:18 +0100
Subject: [PATCH 2/2] arm64: dts: berlin4ct: enable all i2c nodes for the
 STB board
In-Reply-To: <20151123104958.09420cee@xhacker>
References: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
 <1448012821-7413-3-git-send-email-jszhang@marvell.com>
 <564F8E64.7020606@gmail.com> <20151123104958.09420cee@xhacker>
Message-ID: <5652CA62.50602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.11.2015 03:49, Jisheng Zhang wrote:
> On Fri, 20 Nov 2015 22:19:32 +0100
> Sebastian Hesselbarth wrote:
>> On 20.11.2015 10:47, Jisheng Zhang wrote:
>>> Enable all i2c nodes for the Marvell berlin BG4CT STB board.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>> ---
>>>   arch/arm64/boot/dts/marvell/berlin4ct-stb.dts | 50 +++++++++++++++++++++++++++
>>>   1 file changed, 50 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
>>> index 348c37e..9e8e2e0 100644
>>> --- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
>>> +++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
>>> @@ -61,6 +61,56 @@
>>>   	};
>>>   };
>>>
>>> +&avio_pinctrl {
>>> +	twsi1_pmux: twsi1-pmux {
>>> +		groups = "TX_EDDC_SCL", "TX_EDDC_SDA";
>>> +		function = "tx_eddc";
>>> +	};
>>
>> Please keep the pinmux sub-nodes in the SoC dtsi as long
>> as they are not strictly board specific, i.e. gpios.
>
> Hmm, seems all boards configure this pin for EDDC usage, so it's fine
> to move to soc
>
>>
>>> +};
>>> +
>>> +&i2c0 {
>>> +	status = "okay";
>>> +	pinctrl-0 = <&twsi0_pmux>;
>>> +	pinctrl-names = "default";
>>
>> If there is only one (or a default) pinctrl-0 option for i2c0,
>> you can also move it to the SoC dtsi.
>
> Some board may not use i2c0, i2c2, i2c3 host and use the pin as gpio for other
> purpose. Considering the above twsi1_pmux usage, what's the better solution?
> move twsi1_pmux to soc's dtsi and leave i2c0, i2c2, i2c3 pinctrl in board dts?

If some boards don't use i2cN, they do not enable the node in their
board dts. That is sufficient to not configure the pinmux as it will
only be set if a driver is loaded for that node.

If there is only one or two different pinmux settings for a specific
function _always_ move the pinmux setting into SoC dtsi. If there is
a well known default out of two or more possible settings, we may also
have that pinmux as a default in the i2c node and only overwrite it
when we have a board that uses a different setting.

So, for i2c: Move all pinctrl/pinctrl-names properties to the SoC
dtsi.

Sebastian
