From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Fri, 22 May 2015 17:44:04 -0700
Subject: Aw: [PATCH v2] ARM: dts: nitrogen6x: add CAN support
In-Reply-To: <trinity-1dc833e7-79e4-4fe4-9e8b-cff88a35a0d9-1432323019162@3capp-gmx-bs48>
References: <1432230303-3414-1-git-send-email-ps.report@gmx.net>,
 <1432292734.3929.64.camel@pengutronix.de>
 <trinity-1dc833e7-79e4-4fe4-9e8b-cff88a35a0d9-1432323019162@3capp-gmx-bs48>
Message-ID: <555FCD54.3080306@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On 05/22/2015 12:30 PM, Peter Seiderer wrote:
> Hello Philipp,
> 
>> Gesendet: Freitag, 22. Mai 2015 um 13:05 Uhr
>> Von: "Philipp Zabel" <p.zabel@pengutronix.de>
>> Am Donnerstag, den 21.05.2015, 19:45 +0200 schrieb Peter Seiderer:
>>>
>>> <snip>
>>>
>>> +
>>> +		reg_can_xcvr: regulator at 3 {
>>> +			compatible = "regulator-fixed";
>>> +			reg = <3>;
>>> +			regulator-name = "CAN XCVR";
>>> +			regulator-min-microvolt = <3300000>;
>>> +			regulator-max-microvolt = <3300000>;
>>> +			pinctrl-names = "default";
>>> +			pinctrl-0 = <&pinctrl_can_xcvr>;
>>> +			gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>>
>> According to
>> Documentation/devicetree/bindings/regulator/fixed-regulator.txt
>> this should have:
>> 			enable-active-high;
>>
>> instead of the gpio phandle flag (which is ignored). Otherwise an active
>> low GPIO is assumed.
>>
> 
> Thanks for review...
> 
> I was a bit confused from the original:
> 
> imx6qdl-tx6.dtsi:103:           reg_can_xcvr: regulator at 3 {
> imx6qdl-tx6.dtsi-104-                   compatible = "regulator-fixed";
> imx6qdl-tx6.dtsi-105-                   reg = <3>;
> imx6qdl-tx6.dtsi-106-                   regulator-name = "CAN XCVR";
> imx6qdl-tx6.dtsi-107-                   regulator-min-microvolt = <3300000>;
> imx6qdl-tx6.dtsi-108-                   regulator-max-microvolt = <3300000>;
> imx6qdl-tx6.dtsi-109-                   pinctrl-names = "default";
> imx6qdl-tx6.dtsi:110:                   pinctrl-0 = <&pinctrl_flexcan_xcvr>;
> imx6qdl-tx6.dtsi-111-                   gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> imx6qdl-tx6.dtsi-112-                   enable-active-low;
> imx6qdl-tx6.dtsi-113-           };
> 
> ...and removed the default 'enable-active-low'...
> 
> Maybe GPIO_ACTIVE_LOW is the right thing?
> 

No. The flags aren't read from the device tree and enable-active-low
is the default.
	https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/regulator/fixed.c#n81

> From the other files:
> 

So if this board really wants an "active high" enable pin, it's likely
not operating properly:

> imx28-tx28.dts:90:              reg_can_xcvr: regulator at 4 {
> imx28-tx28.dts-91-                      compatible = "regulator-fixed";
> imx28-tx28.dts-92-                      reg = <4>;
> imx28-tx28.dts-93-                      regulator-name = "CAN XCVR";
> imx28-tx28.dts-94-                      regulator-min-microvolt = <3300000>;
> imx28-tx28.dts-95-                      regulator-max-microvolt = <3300000>;
> imx28-tx28.dts-96-                      gpio = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> imx28-tx28.dts-97-                      pinctrl-names = "default";
> imx28-tx28.dts:98:                      pinctrl-0 = <&tx28_flexcan_xcvr_pins>;
> imx28-tx28.dts-99-              };
> 
> <snip>
> 
> Any further advice from your side which solution is the right one?
> 
>  - GPIO_ACTIVE_HIGH/enable-active-high
>  - GPIO_ACTIVE_LOW
> 

The pad is active low on the TJA1040 transceiver on the Nitrogen6x,
so you don't want "enable-active-high" and could be more explicit with
GPIO_ACTIVE_LOW in the gpio reference, but it won't be parsed or
acted upon.

i.e.
	reg_can_xcvr: regulator at 3 {
		compatible = "regulator-fixed";
		reg = <3>;
		regulator-name = "CAN XCVR";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_can_xcvr>;
		gpio = <&gpio1 2 0>;
	}

Regards,


Eric
