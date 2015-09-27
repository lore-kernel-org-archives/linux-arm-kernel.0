From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Sep 2015 15:05:42 +0200
Subject: [PATCH v7] arm64: dts: Add spi bus dts
In-Reply-To: <CANMq1KBhg4j15=ik7F2MwgmyAQZgSz3QYWLivOhd8ZFuDfjHGA@mail.gmail.com>
References: <1441028659-19068-1-git-send-email-leilk.liu@mediatek.com>
 <CANMq1KBhg4j15=ik7F2MwgmyAQZgSz3QYWLivOhd8ZFuDfjHGA@mail.gmail.com>
Message-ID: <5607E9A6.2080502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/09/15 10:59, Nicolas Boichat wrote:
> On Mon, Aug 31, 2015 at 9:44 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
>> This patch adds MT8173 spi bus controllers into device tree.
>
> The corresponding SPI driver has already been merged in
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git .
>
>> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
>
> Reviewed-and-Tested-by: Nicolas Boichat <drinkcat@chromium.org>

Applied, thanks.

>
>> ---
>> Change in this patch:
>> 1. fix spi clock flow usage error.
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++++++++++++++
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 13 +++++++++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> index 4be66ca..811cb76 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> @@ -387,6 +387,24 @@
>>          };
>>   };
>>
>> +&pio {
>> +       spi_pins_a: spi0 {
>> +               pins_spi {
>> +                       pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
>> +                               <MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
>> +                               <MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
>> +                               <MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
>> +               };
>> +       };
>> +};
>> +
>> +&spi {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&spi_pins_a>;
>> +       mediatek,pad-select = <0>;
>> +       status = "okay";
>> +};
>> +
>>   &uart0 {
>>          status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index d18ee42..fcb4860 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -365,6 +365,19 @@
>>                          status = "disabled";
>>                  };
>>
>> +               spi: spi at 1100a000 {
>> +                       compatible = "mediatek,mt8173-spi";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       reg = <0 0x1100a000 0 0x1000>;
>> +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
>> +                       clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
>> +                                <&topckgen CLK_TOP_SPI_SEL>,
>> +                                <&pericfg CLK_PERI_SPI0>;
>> +                       clock-names = "parent-clk", "sel-clk", "spi-clk";
>> +                       status = "disabled";
>> +               };
>> +
>>                  i2c3: i2c3 at 11010000 {
>>                          compatible = "mediatek,mt8173-i2c";
>>                          reg = <0 0x11010000 0 0x70>,
>> --
>> 1.8.1.1.dirty
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
