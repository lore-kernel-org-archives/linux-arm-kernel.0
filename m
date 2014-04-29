From: george.cherian@ti.com (George Cherian)
Date: Tue, 29 Apr 2014 13:28:29 +0530
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <CAGm1_kvHtSLNEfkJ24xZGGzsqAjHDTM1XztnX-QGs4iM5voMUw@mail.gmail.com>
Message-ID: <535F5BA5.6000903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/29/2014 11:49 AM, Yegor Yefremov wrote:
> On Thu, Apr 24, 2014 at 11:11 PM, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>> The DMA controller is needed for the USB controller to be correctly
>> registered. Therefore, if the DMA node is located at the end an unecessary
>> probe deferral is produced systematically.
>>
>> This is easily fixed by moving the node at the beggining of the child list,
>> so it's probed first.
This will give issues on module removal.
Since we use device_for_each_child in remove patch, it will try to 
remove cppi dma controller, while the channel
is still in use by musb node.
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
>
>> --
>> v1->v2:
>>    * Added a comment to prevent a future clean-up based on the memory offset.
>>
>>   arch/arm/boot/dts/am33xx.dtsi | 34 ++++++++++++++++++++--------------
>>   1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index 9770e35..02e1eb6 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -453,6 +453,26 @@
>>                          ti,hwmods = "usb_otg_hs";
>>                          status = "disabled";
>>
>> +                       /*
>> +                        * The probe order matches the child ordering so the
>> +                        * dma-controller node must be the first one to prevent
>> +                        * spurious probe deferrals.
>> +                        */
>> +                       cppi41dma: dma-controller at 47402000 {
>> +                               compatible = "ti,am3359-cppi41";
>> +                               reg =  <0x47400000 0x1000
>> +                                       0x47402000 0x1000
>> +                                       0x47403000 0x1000
>> +                                       0x47404000 0x4000>;
>> +                               reg-names = "glue", "controller", "scheduler", "queuemgr";
>> +                               interrupts = <17>;
>> +                               interrupt-names = "glue";
>> +                               #dma-cells = <2>;
>> +                               #dma-channels = <30>;
>> +                               #dma-requests = <256>;
>> +                               status = "disabled";
>> +                       };
>> +
>>                          usb_ctrl_mod: control at 44e10620 {
>>                                  compatible = "ti,am335x-usb-ctrl-module";
>>                                  reg = <0x44e10620 0x10
>> @@ -556,20 +576,6 @@
>>                                          "tx14", "tx15";
>>                          };
>>
>> -                       cppi41dma: dma-controller at 47402000 {
>> -                               compatible = "ti,am3359-cppi41";
>> -                               reg =  <0x47400000 0x1000
>> -                                       0x47402000 0x1000
>> -                                       0x47403000 0x1000
>> -                                       0x47404000 0x4000>;
>> -                               reg-names = "glue", "controller", "scheduler", "queuemgr";
>> -                               interrupts = <17>;
>> -                               interrupt-names = "glue";
>> -                               #dma-cells = <2>;
>> -                               #dma-channels = <30>;
>> -                               #dma-requests = <256>;
>> -                               status = "disabled";
>> -                       };
>>                  };
>>
>>                  epwmss0: epwmss at 48300000 {
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
-George
