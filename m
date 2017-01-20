From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 20 Jan 2017 18:07:20 +0100
Subject: [PATCH v3 2/9] ARM64: dts: meson-gxbb-p200: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170120162138.GE25907@lunn.ch>
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-3-martin.blumenstingl@googlemail.com>
 <20170120162138.GE25907@lunn.ch>
Message-ID: <CAFBinCA47Nng_jjxKrWrV_YBHr0bg+7xPaJrVswt_WnZ6wtyjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Jan 20, 2017 at 5:21 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Jan 20, 2017 at 04:22:25PM +0100, Martin Blumenstingl wrote:
>> This resets the ethernet PHY during boot to get the PHY into a "clean"
>> state.
>> While here also specify the phy-handle of the ethmac node to make the
>> PHY configuration similar to the one we have on GXL devices. This will
>> allow us to specify OF-properties for the PHY itself.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> index 03e3d76626dd..fa0f84cfeaa9 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> @@ -51,6 +51,30 @@
>>       model = "Amlogic Meson GXBB P200 Development Board";
>>  };
>>
>> +&ethmac {
>> +     status = "okay";
>> +     pinctrl-0 = <&eth_rgmii_pins>;
>> +     pinctrl-names = "default";
>> +     phy-handle = <&eth_phy0>;
>> +     phy-mode = "rgmii";
>> +
>> +     snps,reset-gpio = <&gpio GPIOZ_14 0>;
>> +     snps,reset-delays-us = <0 10000 1000000>;
>> +     snps,reset-active-low;
>> +
>> +     mdio {
>> +             compatible = "snps,dwmac-mdio";
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             eth_phy0: ethernet-phy at 0 {
>> +                     compatible = "ethernet-phy-id0022.1620",
>
> Hi Martin
>
> You don't need to specify the PHY ID. You really only need this when
> the PHY is reporting no ID, or a wrong ID. In fact, if a new revision
> of the board is made, with a different PHY, you might have a problem,
> the wrong PHY driver is loaded.
>
>    Andrew
I though that this is good practice - the documentation doesn't say
that it should only be added in specific cases: [0]
my intention behind adding the PHY ID was to make it easier to see
which devices uses which PHY. this is especially useful for devices
with RTL8211F PHY (basically all devices with RGMII PHY except the
P200) as these may need similar fixes than [1]

regarding your other mail: you're absolutely right that ethernet-phy at 0
should be ethernet-phy at 3.


[0] http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/phy.txt
[1] https://patchwork.kernel.org/patch/9528915/
