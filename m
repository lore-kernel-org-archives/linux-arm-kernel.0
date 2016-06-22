From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 22 Jun 2016 12:16:03 +0800
Subject: [PATCH v3 2/8] mfd: ac100: Add device tree bindings for X-Powers
 AC100 codec/RTC combo IC
In-Reply-To: <20160621131443.GA29350@rob-hp-laptop>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-3-git-send-email-wens@csie.org>
 <20160621131443.GA29350@rob-hp-laptop>
Message-ID: <CAGb2v64TYTi0_thF7Z8cdBE9dkbPUq9xAhmhegqH8efVx1oCFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 9:14 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jun 20, 2016 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>> Changes since v2:
>>
>>   - Fix interrupt line for ac100_codec in provided example.
>>
>> ---
>>  Documentation/devicetree/bindings/mfd/ac100.txt | 42 +++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
>> new file mode 100644
>> index 000000000000..a793954bb952
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
>> @@ -0,0 +1,42 @@
>> +X-Powers AC100 Codec/RTC IC device tree bindings
>> +
>> +AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
>> +separated, including power supplies and interrupt lines, but share
>> +a common register address space and host interface.
>> +
>> +Required properties:
>> +- compatible: "x-powers,ac100"
>> +- reg: The I2C slave address or RSB hardware address for the chip
>> +- sub-nodes:
>> +  - codec
>> +    - compatible: "x-powers,ac100-codec"
>> +    - interrupt-parent: The parent interrupt controller
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO pin
>> +  - rtc
>> +    - compatible: "x-powers,ac100-rtc"
>> +    - interrupt-parent: The parent interrupt controller
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
>> +    - #clock-cells: shall be 1
>> +    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
>> +    - see clock/clock-bindings.txt for common clock bindings
>> +
>> +Example:
>> +
>> +ac100: codec at e89 {
>> +     compatible = "x-powers,ac100";
>> +     reg = <0xe89>;
>> +
>> +     ac100_codec {
>
> Use generic node names and no underscores:
>
> codec {

Right. I intended to add them as labels, not change the node names.

Thanks
ChenYu

>
>> +             compatible = "x-powers,ac100-codec";
>> +             interrupt-parent = <&r_pio>;
>> +             interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
>> +     };
>> +
>> +     ac100_rtc {
>
> rtc {
>
>> +             compatible = "x-powers,ac100-rtc";
>> +             interrupt-parent = <&nmi_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +             #clock-cells = <1>;
>> +             clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
>> +     };
>> +};
>> --
>> 2.8.1
>>
