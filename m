From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 14 Apr 2017 08:32:06 -0700
Subject: [PATCH 6/8] ARM: dts: imx7d-sdb: Add GPIO expander node
In-Reply-To: <20170414034659.GH14915@dragon>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-7-andrew.smirnov@gmail.com>
 <20170414034659.GH14915@dragon>
Message-ID: <CAHQ1cqEJJRB-wYwj_947vPsVJWBKaVWYH-emga8R5_QdbJV1gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 8:47 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 06:32:40AM -0700, Andrey Smirnov wrote:
>> Add node for U38, a 74LV595PW serial-in shift register that acts as a
>> GPIO expander on the board.
>>
>> Cc: yurovsky at gmail.com
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx7d-sdb.dts | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
>> index 5be01a1..e0ff276 100644
>> --- a/arch/arm/boot/dts/imx7d-sdb.dts
>> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
>> @@ -52,6 +52,30 @@
>>               reg = <0x80000000 0x80000000>;
>>       };
>>
>> +     spi4 {
>> +             compatible = "spi-gpio";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinctrl_spi1>;
>> +             status = "okay";
>
> The 'status' is not needed in this case.
>

Missed that, will fix in v2.

>> +             gpio-sck = <&gpio1 13 0>;
>> +             gpio-mosi = <&gpio1 9 0>;
>> +             cs-gpios = <&gpio1 12 0>;
>> +             num-chipselects = <1>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             gpio_spi: gpio_spi at 0 {
>
> gpio-expander might be a better node name?
>

Yeah, I agree. I'll change it to extended_io: gpio-expander at 0
("Extended IO" is how this part is called out on the schematic)

>> +                     compatible = "fairchild,74hc595";
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +                     reg = <0>;
>> +                     registers-number = <1>;
>> +                      /* Enable PERI_3V3, SENSOR_RST_B and HDMI_RST*/
>> +                     registers-default = /bits/ 8 <0x74>;
>
> I do not see this property is documented or supported by kernel.

My bad, some downstream properties leakage. Will remove in v2.

Thanks,
Andrey Smirnov
