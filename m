From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 26 Jul 2016 23:00:52 +0200
Subject: [PATCH 1/4] ARM: dts: sun8i: Extend Orange Pi PC dt to also
 handle the PC Plus
In-Reply-To: <20160725064033.GA7419@lukather>
References: <1468095718-18515-1-git-send-email-hdegoede@redhat.com>
 <20160713084505.GE4761@lukather>
 <bce2b340-a930-8771-4560-dc61bf5828d5@redhat.com>
 <20160725064033.GA7419@lukather>
Message-ID: <785086e6-c50c-ed1c-6de1-13a2234c3f58@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/25/2016 08:40 AM, Maxime Ripard wrote:
> Hi,
>
> On Wed, Jul 13, 2016 at 12:01:41PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 13-07-16 10:45, Maxime Ripard wrote:
>>> On Sat, Jul 09, 2016 at 10:21:55PM +0200, Hans de Goede wrote:
>>>> There is a new Orange Pi PC Plus available now, rather then adding
>>>> yet another dts file for this variant, extend the existing
>>>> Orange Pi PC to support the sdio wifi and emmc found on this variant.
>>>>
>>>> Downside of this approach is the following messages in dmesg when run
>>>> on the non Plus Orange Pi PC:
>>>>
>>>> sunxi-mmc 1c10000.mmc: fatal err update clk timeout
>>>> sunxi-mmc 1c11000.mmc: smc 2 err, cmd 8, RTO !!
>>>> sunxi-mmc 1c11000.mmc: smc 2 err, cmd 55, RTO !!
>>>> sunxi-mmc 1c11000.mmc: smc 2 err, cmd 55, RTO !!
>>>> sunxi-mmc 1c11000.mmc: smc 2 err, cmd 55, RTO !!
>>>> sunxi-mmc 1c11000.mmc: smc 2 err, cmd 55, RTO !!
>>>> sunxi-mmc 1c11000.mmc: smc 2 err, cmd 1, RTO !!
>>>>
>>>> Note these are completely harmless and there is no adverse effect
>>>> to the functioning of the non Plus Orange Pi PC.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>> arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 40 +++++++++++++++++++++++++++++-
>>>> 1 file changed, 39 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>>> index b8340f7..f9bf260 100644
>>>> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>>> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>>>> @@ -49,11 +49,13 @@
>>>> #include <dt-bindings/pinctrl/sun4i-a10.h>
>>>>
>>>> / {
>>>> -	model = "Xunlong Orange Pi PC";
>>>> +	model = "Xunlong Orange Pi PC / PC Plus";
>>>> 	compatible = "xunlong,orangepi-pc", "allwinner,sun8i-h3";
>>>>
>>>> 	aliases {
>>>> 		serial0 = &uart0;
>>>> +		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
>>>> +		ethernet1 = &rtl8189ftv;
>>>> 	};
>>>>
>>>> 	chosen {
>>>> @@ -118,6 +120,42 @@
>>>> 	status = "okay";
>>>> };
>>>>
>>>> +/* Note only present on orangepi pc *plus* */
>>>> +&mmc1 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&mmc1_pins_a>;
>>>> +	vmmc-supply = <&reg_vcc3v3>;
>>>> +	bus-width = <4>;
>>>> +	non-removable;
>>>> +	status = "okay";
>>>> +
>>>> +	/*
>>>> +	 * Explicitly define the sdio device, so that we can add an ethernet
>>>> +	 * alias for it (which e.g. makes u-boot set a mac-address).
>>>> +	 */
>>>> +	rtl8189ftv: sdio_wifi at 1 {
>>>> +		reg = <1>;
>>>> +	};
>>>> +};
>>>
>>> Nothing prevents you from including the orange pi pc dts, from the
>>> orange pi plus dts.
>>>
>>> It prevents the duplication you were trying to avoid, and it doesn't
>>> create all those spurious errors and devices.
>>
>> That would solve the copy paste problem on the kernel side, but that
>> would still mean adding a new u-boot defconfig for this, which means that
>> all the distro's which ship with prebuild u-boot binaries need to build
>> for yet another board, something which I would like to avoid.
>
> Still, registering devices that are not present on the board is not an
> option.

Ok, I'll send a new patch which adds a separate dts file for the Orange Pi
PC Plus.

Regards,

Hans
