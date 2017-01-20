From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 20 Jan 2017 14:33:53 +0100
Subject: [PATCH v2 2/9] ARM64: dts: meson-gxbb-p201: add the ethernet
 PHY's reset GPIO
In-Reply-To: <8a0b6c29-38f0-8474-34a2-8e3df4a5a239@baylibre.com>
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120132650.9784-3-martin.blumenstingl@googlemail.com>
 <8a0b6c29-38f0-8474-34a2-8e3df4a5a239@baylibre.com>
Message-ID: <CAFBinCA1YABPzBUnprh_HprjQ8DqpEeF9OQeXKNtQ8Kp8Ou0bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 2:31 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 01/20/2017 02:26 PM, Martin Blumenstingl wrote:
>> This resets the ethernet PHY during boot to get the PHY into a "clean"
>> state.
>> While here also specify the phy-handle of the ethmac node to make the
>> PHY configuration similar to the one we have on GXL devices. This will
>> allow us to specify OF-properties for the PHY itself.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>> index 39bb037a3e47..5d2cd2ecfdc4 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>> @@ -50,3 +50,27 @@
>>       compatible = "amlogic,p201", "amlogic,meson-gxbb";
>>       model = "Amlogic Meson GXBB P201 Development Board";
>>  };
>> +
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
>> +                                  "ethernet-phy-ieee802.3-c22";
>> +                     reg = <3>;
>> +             };
>> +     };
>> +};
>>
>
> Hi Martin,
>
> It seems you mismatched the p200 and the p201, it's the p201 nobody has and uses a rmii link.
ouch, good catch.
I'll send a fix for that later - thanks for spotting!
