From: bruherrera@gmail.com (Bruno Herrera)
Date: Thu, 27 Oct 2016 08:43:45 -0200
Subject: [PATCH] ARM: DT: stm32: move dma translation to board files
In-Reply-To: <404315f0-fc9e-93e2-54df-f85e484d9389@st.com>
References: <CAF3+Tqd2MGmz+8XhLXhaZiEc78QOwHSpVrQA65-p1AcfT+_xgg@mail.gmail.com>
 <404315f0-fc9e-93e2-54df-f85e484d9389@st.com>
Message-ID: <CAF3+TqdzESUNbkmAVv42pNv13wuyuPgGgksK3pJbORYw2a8ZFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Wed, Oct 26, 2016 at 7:09 AM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Hi Bruno,
>
> On 10/25/2016 11:06 PM, Bruno Herrera wrote:
>>
>> Hi Alexandre,
>>
>>>
>>> stm32f469-disco and stm32f429-eval boards use SDRAM start address
>>> remapping
>>> (to @0) to boost performances. A DMA translation through "dma-ranges"
>>> property was needed for other masters than the M4 CPU.
>>> stm32f429-disco doesn't use remapping so doesn't need this DMA
>>> translation.
>>> This patches moves this DMA translation definition from stm32f429 soc
>>> file
>>> to board files.
>>>
>>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>>
>>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts
>>> b/arch/arm/boot/dts/stm32429i-eval.dts
>>> index 13c7cd2..a763c15 100644
>>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>>> @@ -82,6 +82,10 @@
>>>                 };
>>>         };
>>>
>>> +       soc {
>>> +               dma-ranges = <0xc0000000 0x0 0x10000000>;
>>> +       };
>>> +
>>>         usbotg_hs_phy: usbphy {
>>>                 #phy-cells = <0>;
>>>                 compatible = "usb-nop-xceiv";
>>
>>
>> Shouldn't also the peripheral dma-ranges property move to board specific
>> too?
>> I  had this patch for while but I didn't had the time to submit:
>
>
> Well spot I forgot it. Actually, discussing with Arnd ysterday on IIRC,
> empty dma-ranges is not needed. Can you test on your side by removing
> dma-ranges in usb node please ?
Unfortunately will take a time for me to set up this environment on
the STM32F4-EVAL board.
And on the discovery boards we dont have this scenario. That was the
main reason I did not submit the patch right away.
My conclusion and I might be wrong but is based on the my tests with
SDIO device at STM32F469I-DISCO board.

I started this issue as discussion at ST Forum but Maxime gave me the hint.

https://my.st.com/public/STe2ecommunities/mcu/Lists/cortex_mx_stm32/Flat.aspx?RootFolder=https%3a%2f%2fmy%2est%2ecom%2fpublic%2fSTe2ecommunities%2fmcu%2fLists%2fcortex_mx_stm32%2fDMA2%20and%20SYSCFG_MEMRMP%20relationship&FolderCTID=0x01200200770978C69A1141439FE559EB459D7580009C4E14902C3CDE46A77F0FFD06506F5B&currentviews=44

> I will push a v2 by removing empty dma-ranges if tests are ok in your side.

>From my understating/conclusion is: when empty property(dma-ranges) is
the device node, the mapping will be taken in consideration when using
DMA otherwise the mapping is ignored.
And in the SDIO case it is needed for DEV->MEM(SDRAM) and
MEM(SDRAM)->DEV. If it is not the case for the devices in question so
I suppose it can work without the property.

>
> Thanks in advance
> Alex
>
>
>>
>> Author: Bruno Herrera <bruherrera@gmail.com>
>> Date:   Sun Oct 16 14:50:00 2016 -0200
>>
>>     ARM: DT: STM32: Use dma-ranges property per board not at dtsi file
>>
>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts
>> b/arch/arm/boot/dts/stm32429i-eval.dts
>> index 6bfc595..2a22a82 100644
>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>> @@ -52,6 +52,10 @@
>>         model = "STMicroelectronics STM32429i-EVAL board";
>>         compatible = "st,stm32429i-eval", "st,stm32f429";
>>
>> +       soc {
>> +               dma-ranges = <0xC0000000 0x0 0x10000000>;
>> +       };
>> +
>>         chosen {
>>                 bootargs = "root=/dev/ram rdinit=/linuxrc";
>>                 stdout-path = "serial0:115200n8";
>> @@ -96,6 +100,7 @@
>>
>>  &ethernet0 {
>>         status = "okay";
>> +       dma-ranges;
>>         pinctrl-0       = <&ethernet0_mii>;
>>         pinctrl-names   = "default";
>>         phy-mode        = "mii-id";
>> @@ -116,6 +121,7 @@
>>  };
>>
>>  &usbotg_hs {
>> +       dma-ranges;
>>         dr_mode = "host";
>>         phys = <&usbotg_hs_phy>;
>>         phy-names = "usb2-phy";
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>> b/arch/arm/boot/dts/stm32f429.dtsi
>> index 7d624a2..697a133 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -59,7 +59,6 @@
>>         };
>>
>>         soc {
>> -               dma-ranges = <0xc0000000 0x0 0x10000000>;
>>
>>                 timer2: timer at 40000000 {
>>                         compatible = "st,stm32-timer";
>> @@ -472,13 +471,11 @@
>>                         st,syscon = <&syscfg 0x4>;
>>                         snps,pbl = <8>;
>>                         snps,mixed-burst;
>> -                       dma-ranges;
>>                         status = "disabled";
>>                 };
>>
>>                 usbotg_hs: usb at 40040000 {
>>                         compatible = "snps,dwc2";
>> -                       dma-ranges;
>>                         reg = <0x40040000 0x40000>;
>>                         interrupts = <77>;
>>                         clocks = <&rcc 0 29>;
>>
>>
>>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>>> b/arch/arm/boot/dts/stm32f429.dtsi
>>> index 0596d60..3a1cfdd 100644
>>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>>> @@ -59,8 +59,6 @@
>>>         };
>>>
>>>         soc {
>>> -               dma-ranges = <0xc0000000 0x0 0x10000000>;
>>> -
>>>                 timer2: timer at 40000000 {
>>>                         compatible = "st,stm32-timer";
>>>                         reg = <0x40000000 0x400>;
>>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
>>> b/arch/arm/boot/dts/stm32f469-disco.dts
>>> index 9e73656..c2213c0 100644
>>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>>> @@ -64,6 +64,10 @@
>>>         aliases {
>>>                 serial0 = &usart3;
>>>         };
>>> +
>>> +       soc {
>>> +               dma-ranges = <0xc0000000 0x0 0x10000000>;
>>> +       };
>>>  };
>>>
>>>  &clk_hse {
>>> --
>>
>>
>>
>> Br.,
>> Bruno
>>
>
