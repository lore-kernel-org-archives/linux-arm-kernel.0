From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 2 Jan 2017 21:12:02 +0200
Subject: [PATCH] DTS: MCCMON6: IMX: Provide support for iMX6Q based
 Liebherr mccmon6 board
In-Reply-To: <20170102154437.63406b95@jawa>
References: <1482794396-16153-1-git-send-email-l.majewski@majess.pl>
 <610d3784-ee2e-c213-2a8c-6db6d7af578b@mentor.com>
 <20170102154437.63406b95@jawa>
Message-ID: <cfe2bb88-833e-4e9f-26c5-4ebf764f19e2@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

please find some comments below as usual.

On 01/02/2017 04:44 PM, Lukasz Majewski wrote:
> Hi Vladimir,
> 
> Thank you for review. Comments without my remarks have been applied
> already.
> 
>> Hello Lukasz,
>>
>> On 12/27/2016 01:19 AM, Lukasz Majewski wrote:
>>> Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
>>
>> please add a commit message with a short description of the change.
>>
>> Also change subject line to "ARM: dts: imx6q: Add mccmon6 board
>> support".
>>
>>> ---

[snip]

>>> +/ {
>>> +	model = "Monitor6 i.MX6 Quad Board";
>>
>> Missing hardware vendor name.
>>
>>> +	compatible = "mccmon6", "fsl,imx6q";
>>
>> Missing hardware vendor prefix before "mccmon6".
> 
> "lwn,mccmon6" ?
> 

Something like that, but please ensure that you add "lwn" vendor in a separate
preceding change to Documentation/devicetree/bindings/vendor-prefixes.txt

>>
>>> +
>>> +	memory {
>>> +		reg = <0x10000000 0x80000000>;
>>> +	};
>>> +
>>> +	ethernet0 {
>>> +		status = "okay";
>>> +	};
>>
>> It looks like a useless device node, you have a description of &fec
>> already.
>>
>>> +
>>> +	backlight_lvds: backlight {
>>> +		compatible = "pwm-backlight";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_display>;
>>
>> I would recommend to rename "pinctrl_display" to "pinctrl_backlight".
>>
>>> +		pwms = <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;
>>
>> This should work when extension to the i.MX PWM driver is merged.
> 
> Yes. The PWM -> apply is an ongoing work. But without the PMW patch the
> board is also fully operational (with reversed PWM :-) )
> 

Right, I believe that the current PWM driver igonores the value passed
in the third cell, so it should be okay.

>>
>>> +		brightness-levels = <  0   1   2   3   4   5   6
>>> 7   8   9
>>> +				      10  11  12  13  14  15  16
>>> 17  18  19
>>> +				      20  21  22  23  24  25  26
>>> 27  28  29
>>> +				      30  31  32  33  34  35  36
>>> 37  38  39
>>> +				      40  41  42  43  44  45  46
>>> 47  48  49
>>> +				      50  51  52  53  54  55  56
>>> 57  58  59
>>> +				      60  61  62  63  64  65  66
>>> 67  68  69
>>> +				      70  71  72  73  74  75  76
>>> 77  78  79
>>> +				      80  81  82  83  84  85  86
>>> 87  88  89
>>> +				      90  91  92  93  94  95  96
>>> 97  98  99
>>> +				     100 101 102 103 104 105 106
>>> 107 108 109
>>> +				     110 111 112 113 114 115 116
>>> 117 118 119
>>> +				     120 121 122 123 124 125 126
>>> 127 128 129
>>> +				     130 131 132 133 134 135 136
>>> 137 138 139
>>> +				     140 141 142 143 144 145 146
>>> 147 148 149
>>> +				     150 151 152 153 154 155 156
>>> 157 158 159
>>> +				     160 161 162 163 164 165 166
>>> 167 168 169
>>> +				     170 171 172 173 174 175 176
>>> 177 178 179
>>> +				     180 181 182 183 184 185 186
>>> 187 188 189
>>> +				     190 191 192 193 194 195 196
>>> 197 198 199
>>> +				     200 201 202 203 204 205 206
>>> 207 208 209
>>> +				     210 211 212 213 214 215 216
>>> 217 218 219
>>> +				     220 221 222 223 224 225 226
>>> 227 228 229
>>> +				     230 231 232 233 234 235 236
>>> 237 238 239
>>> +				     240 241 242 243 244 245 246
>>> 247 248 249
>>> +				     250 251 252 253 254 255>;
>>
>> I'm not sure that actually need such a long list of brightness levels.
> 
> Such brightness-level property is so verbose on purpose - in this board
> we need fine brightness adjustment (harsh environment operation).

Okay.

>>
>>> +		default-brightness-level = <50>;
>>> +		enable-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
>>> +	};
>>> +

[snip]

>>> +		pinctrl_display: dispgrp {
>>> +			fsl,pins = <
>>> +				/* BLEN_OUT */
>>> +				MX6QDL_PAD_GPIO_2__GPIO1_IO02
>>> 0x1b0b0
>>> +				/* LVDS_PPEN_OUT */
>>> +				MX6QDL_PAD_SD1_DAT2__GPIO1_IO19
>>> 0x1b0b0
>>
>> This GPIO should be moved to a pinctrl group of regulator-lvds device
>> node.
> 
> You mean to provide separate:
> 
> pinctrl_reg_lvds: req_lvds_grp {
> 		fsl,pins = <
> 		/* LVDS_PPEN_OUT */
> 		MX6QDL_PAD_SD1_DAT2__GPIO1_IO19
> 		>;
> 
> and then
> 
> 	reg_lvds: regulator-lvds {
> 		compatible = "regulator-fixed";
> 		regulator-name = "lvds_ppen";
> 		regulator-min-microvolt = <3300000>;
> 		regulator-max-microvolt = <3300000>;
> 		regulator-boot-on;
> 
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&pinctrl_reg_lvds>;
> 
> 		gpio = <&gpio1 19 GPIO_ACTIVE_HIGH>;
> 		enable-active-high;
> 	};
> 

This looks correct.

[snip]

>>> +
>>> +&uart1 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pinctrl_uart1>;
>>
>> Should you add "uart-has-rtscts" property?
> 
> This is a simple "console" uart without rts/cts, so this property is
> not needed.
> 

You are right, my review comment is valid for UART4 only.

[snip]

--
With best wishes,
Vladimir
