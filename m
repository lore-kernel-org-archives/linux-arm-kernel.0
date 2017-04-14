From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 14 Apr 2017 08:19:44 -0700
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <20170414034005.GG14915@dragon>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <20170414034005.GG14915@dragon>
Message-ID: <CAHQ1cqGYs2h1ZFBC4WBYbyAMsctURwOzQmQB+B6nz=wmR0fYoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 8:40 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 06:32:38AM -0700, Andrey Smirnov wrote:
>> Add node for GPC and specify as a parent interrupt controller for SoC bus.
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
>>  arch/arm/boot/dts/imx7s.dtsi | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
>> index 8fee299..1a7058f 100644
>> --- a/arch/arm/boot/dts/imx7s.dtsi
>> +++ b/arch/arm/boot/dts/imx7s.dtsi
>> @@ -42,6 +42,7 @@
>>   */
>>
>>  #include <dt-bindings/clock/imx7d-clock.h>
>> +#include <dt-bindings/power/imx7-power.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> @@ -119,7 +120,7 @@
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>>               compatible = "simple-bus";
>> -             interrupt-parent = <&intc>;
>> +             interrupt-parent = <&gpc>;
>>               ranges;
>>
>>               funnel at 30041000 {
>> @@ -301,6 +302,7 @@
>>                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>                       #interrupt-cells = <3>;
>>                       interrupt-controller;
>> +                     interrupt-parent = <&intc>;
>>                       reg = <0x31001000 0x1000>,
>>                             <0x31002000 0x2000>,
>>                             <0x31004000 0x2000>,
>> @@ -309,6 +311,7 @@
>>
>>               timer {
>>                       compatible = "arm,armv7-timer";
>> +                     interrupt-parent = <&intc>;
>>                       interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>                                    <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>                                    <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> @@ -564,6 +567,28 @@
>>                               interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>>                               #reset-cells = <1>;
>>                       };
>> +
>> +                     gpc: gpc at 303a0000 {
>> +                             compatible = "fsl,imx7d-gpc";
>> +                             reg = <0x303a0000 0x10000>;
>> +                             interrupt-controller;
>> +                             interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>> +                             #interrupt-cells = <3>;
>> +                             interrupt-parent = <&intc>;
>> +                             #power-domain-cells = <1>;
>> +
>> +                             pgc {
>> +                                     #address-cells = <1>;
>> +                                     #size-cells = <0>;
>> +
>> +                                     pgc_pcie_phy: pgc-pcie-phy-domain {
>
> The node name should be something generic and has a unit-address when
> there is a 'reg' property in the node.
>

I'll change it to pgc-power-domain at 0, let me know if you want
something different.

>> +                                             #power-domain-cells = <0>;
>> +
>
> Drop this newline.
>

OK. Will do in v2.
