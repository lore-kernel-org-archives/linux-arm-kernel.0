From: dianders@chromium.org (Doug Anderson)
Date: Mon, 18 Jun 2018 14:52:34 -0700
Subject: [PATCH 1/2] arm64: dts: sdm845: Add rpmh-rsc node
In-Reply-To: <20180618212414.GI21724@codeaurora.org>
References: <20180618205616.102750-1-dianders@chromium.org>
 <20180618212414.GI21724@codeaurora.org>
Message-ID: <CAD=FV=WNfBjOHU=LHP5o9DEeLzCv0JChnsbqWQAW6FW69d5P2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 18, 2018 at 2:24 PM, Lina Iyer <ilina@codeaurora.org> wrote:
> On Mon, Jun 18 2018 at 14:56 -0600, Douglas Anderson wrote:
>>
>> This adds the rpmh-rsc node to sdm845 based on the examples in the
>> bindings.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index cd308b84bed7..19b006293d3b 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -7,6 +7,7 @@
>>
>> #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>> #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>
>> / {
>>         interrupt-parent = <&intc>;
>> @@ -984,6 +985,24 @@
>>                         #mbox-cells = <1>;
>>                 };
>>
>> +               apps_rsc: rsc at 179c0000 {
>> +                       label = "apps_rsc";
>> +                       compatible = "qcom,rpmh-rsc";
>> +                       reg = <0x179c0000 0x10000>,
>> +                             <0x179d0000 0x10000>,
>> +                             <0x179e0000 0x10000>;
>> +                       reg-names = "drv-0", "drv-1", "drv-2";
>> +                       interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +                       qcom,tcs-offset = <0xd00>;
>> +                       qcom,drv-id = <2>;
>> +                       qcom,tcs-config = <SLEEP_TCS   3>,
>> +                                         <WAKE_TCS    3>,
>> +                                         <ACTIVE_TCS  2>,
>> +                                         <CONTROL_TCS 1>;
>
> Sorry, my example had this incorrect order and I just noticed this. We
> will need to fix the example as well.
>
> The first TCS should be ACTIVE_TCS, then followed by SLEEP_TCS and
> WAKE_TCS. This order is important and should match what is set in the
> firmware.
>
> qcom,tcs-config = <ACTIVE_TCS  2>,
>                   <SLEEP_TCS   3>,
>                    <WAKE_TCS    3>,
>                    <CONTROL_TCS 1>;
>
> While the above configuration would work for now, it would fail, when we
> enable system low power modes, which would use TCSes 2-7 for sleep and
> wake set transitions from the firmware.

Since I'm not expecting lots more feedback, I've gone ahead and sent
v2 with this fix.

-Doug
