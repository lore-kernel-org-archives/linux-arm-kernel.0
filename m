From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 15:13:55 -0700
Subject: [PATCH 1/2] ARM: DT: tegra: Add Colibri T20 512MB COM
In-Reply-To: <1358458144.18489.14.camel@tellur>
References: <1358423961-24318-1-git-send-email-dev@lynxeye.de>
 <50F86533.9010000@wwwdotorg.org> <1358458144.18489.14.camel@tellur>
Message-ID: <50F877A3.5030107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 02:29 PM, Lucas Stach wrote:
> Am Donnerstag, den 17.01.2013, 13:55 -0700 schrieb Stephen Warren:
>> On 01/17/2013 04:59 AM, Lucas Stach wrote:
>>> This adds the device tree include file for the Toradex Colibri T20
>>> Computer on Module (COM). It's only valid for the 512MB RAM version of
>>> the module, as the 256MB version needs different EMC tables and flash
>>> configuration. To make this clear the suffix -512 was added to the board
>>> compatible string.
>>>
>>> The Colibri T20 uses a Tegra2 SoC and has onboard USB Ethernet and AC97
>>> sound.
>>>
>>> Still some things like onboard NAND support missing, but should be a
>>> good base for further development.
>>
>>> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
>>
>>> +		temperature-sensor at 4c {
>>> +			compatible = "national,lm95245";
>>
>> You should probably add that compatible value to
>> Documentation/devicetree/bindings/i2c/trivial-devices.txt.
>>
> Yep, will send a separate patch for this.
> 
>>> +	i2c at 7000c000 {
>>> +		clock-frequency = <400000>;
>>> +	};
>>> +
>>> +	i2c_ddc: i2c at 7000c400 {
>>> +		clock-frequency = <100000>;
>>> +	};
>>> +
>>> +	i2c at 7000c500 {
>>> +		clock-frequency = <400000>;
>>> +	};
>>
>>> +	serial at 70006000 {
>>> +		clock-frequency = <216000000>;
>>> +	};
>>> +
>>> +	serial at 70006300 {
>>> +		clock-frequency = <216000000>;
>>> +	};
>>> +
>>> +	usb at c5000000 {
>>> +		dr_mode = "otg";
>>> +	};
>>> +
>>> +	usb at c5004000 {
>>> +		status = "okay";
>>> +		nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
>>> +	};
>>> +
>>> +	sdhci at c8000600 {
>>> +		cd-gpios = <&gpio 23 0>; /* gpio PC7 */
>>> +		vmmc-supply = <&ldo5_reg>;
>>> +		vqmmc-supply = <&vcc_sd_reg>;
>>> +	};
>>
>> I assume that all of those nodes are meant to have status="okay"?
>>
>> Oh, I see those are in the top-level board .dts file. You may as well
>> put all the properties there; stuff like the GPIOs and regulators at
>> least would be purely specific to the individual board, and not the COM.
>
> I would like to keep everything that is defined by the COM to reside in
> the COM dtsi. You are right that the regulator in this case is board
> specific and should be moved to the board file, I missed this while
> splitting things out. But at least the GPIO is defined by the fixed COM
> pinout.

If these are really defined by the COM itself, it does indeed make sense
for the COM .dtsi file to define those properties. But, I have a hard
time understanding how the COM design can force the carrier module into
using a particular GPIO for the SD controller CD functionality; couldn't
the carrier use any GPIO passed through the COM<->carrier connector for
any purpose?

>>> +	com_regulators {
>>
>> I think just call that "regulators"; the final board .dts file can
>> easily add more sub-nodes to this node, so there's no need to try and
>> avoid any naming conflict here. See Cardhu as an example.
>
> I don't really see the benefit of merging those nodes. They are separate
> regulators, some are located on the COM, others on the carrier board. So
> I would like to keep them in separate nodes, unless you have strong
> feelings to change this.

The issue here is that if we don't do this, we end up with wierd node
names; plain "regulators" is a fairly canonical name for what the name
contains, and purely indicates the type of the node. "com_regulators" is
unusual, and starts to encode identity into the node name itself, which
is something not usually done in the node name (differentiation between
identities is usually done using the unit address; "@nnn"),
