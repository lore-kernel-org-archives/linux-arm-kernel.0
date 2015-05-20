From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 20 May 2015 16:47:53 +0800
Subject: [PATCH 3/3] ARM64: dts: mt8173: Add PMIC wrapper device node
In-Reply-To: <CAGS+omD2cE9HyyXsV-2+m5Ugj0EC-dmBo1QRsROM3URu+7mhsA@mail.gmail.com>
References: <1432032824-7955-1-git-send-email-s.hauer@pengutronix.de>
 <1432032824-7955-4-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omD2cE9HyyXsV-2+m5Ugj0EC-dmBo1QRsROM3URu+7mhsA@mail.gmail.com>
Message-ID: <CAGS+omDY2eVC1WVXm2Jv5fS_BRfS_vV7RJj7qrddtj1OMzjxyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 4:44 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Tue, May 19, 2015 at 6:53 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> This adds the device node for the PMIC wrapper.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index cfdca03..16ec639 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -14,6 +14,7 @@
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include "mt8173-pinfunc.h"
>> +#include <dt-bindings/reset-controller/mt8173-resets.h>
>>  #include <dt-bindings/clock/mt8173-clk.h>
>>
>>  / {
>> @@ -154,6 +155,17 @@
>>                                                 <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>>                 };
>>
>> +               pwrap: pwrap at 1000D000 {
>> +                       compatible = "mediatek,mt8173-pwrap";
>> +                       reg = <0 0x1000D000 0 0x1000>;
>
> nit: Use lowercase for the hex value 'd' in reg and pwrap@<>.
>
> With that fixed, this one is:
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

FYI: the patches in this set no longer apply cleanly onto Matthias'
https://github.com/mbgg/linux-mediatek v4.1-next/arm64

Due to collisions with:

commit 6769b93c082afb7241708685f1c23cbaf5bf00eb
Author:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Commit:     Matthias Brugger <matthias.bgg@gmail.com>
    arm64: dts: mt8173: Fixup pinctrl nodes


>> +                       reg-names = "pwrap";
>> +                       interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>> +                       resets = <&infracfg MT8173_INFRA_PMIC_WRAP_RST>;
>> +                       reset-names = "pwrap";
>> +                       clocks = <&infracfg CLK_INFRA_PMICSPI>, <&infracfg CLK_INFRA_PMICWRAP>;
>> +                       clock-names = "spi", "wrap";
>> +               };
>> +
>>                 sysirq: intpol-controller at 10200620 {
>>                         compatible = "mediatek,mt8173-sysirq",
>>                                         "mediatek,mt6577-sysirq";
>> --
>> 2.1.4
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
