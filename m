From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 3 Nov 2016 09:40:52 +0100
Subject: [PATCH] ARM: DT: stm32: move dma translation to board files
In-Reply-To: <CAF3+TqcAjzAJNfikRKfccmYX778FuxNSeVbT1dGU0hswxZWjjg@mail.gmail.com>
References: <CAF3+Tqd2MGmz+8XhLXhaZiEc78QOwHSpVrQA65-p1AcfT+_xgg@mail.gmail.com>
 <404315f0-fc9e-93e2-54df-f85e484d9389@st.com>
 <CAF3+TqdzESUNbkmAVv42pNv13wuyuPgGgksK3pJbORYw2a8ZFQ@mail.gmail.com>
 <65096fbe-3f06-c8db-fbe8-29f0be28cb61@st.com>
 <CAF3+TqcxVj9f7kcSQTKDercVfvDdLzAXGpUU1oAxeNBFZx73nQ@mail.gmail.com>
 <CAFvLkMQGVygLb9SQ8o+2Q=bg7vvRjpHypmSyjRyLkdcHypoFHw@mail.gmail.com>
 <CAF3+TqcFnXENmX4OpG9jzhPhuaq-EqNsRhhjKgFjHA96DLqK5g@mail.gmail.com>
 <CAFvLkMQ6YMg4sf2Ug8x4-YshwnjbLz3aVzm+JpKP6zG9r-WU4Q@mail.gmail.com>
 <CAF3+Tqdz+92yxuSwZHdQ01d-G-bBNtzayKyP2-_On2APvFyLNA@mail.gmail.com>
 <CAFvLkMTCkRcwbRc8GVNBoJFAvKWHYDjOPabueQPjTseZrucadA@mail.gmail.com>
 <3e854414-f51d-3e59-6cee-142106cef40f@st.com>
 <CAF3+TqeiPjtG7Fs1-cpbcHGxxtSS1UOGD=S=sggpaZahFLJhEQ@mail.gmail.com>
 <CAFvLkMSViXggGr0Set0qnQan_+bXUNzJx5WtZHP-Jyje=ZzDVw@mail.gmail.com>
 <CAF3+TqcAjzAJNfikRKfccmYX778FuxNSeVbT1dGU0hswxZWjjg@mail.gmail.com>
Message-ID: <5fade033-f85f-35ac-2661-ee5c96c1111b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bruno,

On 11/02/2016 07:23 PM, Bruno Herrera wrote:
> On Wed, Nov 2, 2016 at 4:05 PM, Rados?aw Pietrzyk
> <radoslaw.pietrzyk@gmail.com> wrote:
>> Have you tried with
>>
>> sdio {
>> ...
>> compatible = "arm,primecell";
>> arm,primecell-periphid = <id_to_define>;
>> ...
>> }
>>
>> This should register proper amba device and give it an ID you wish.
>
> I'm using this:
>
> sdio: sdio at 40012c00 {
> compatible = "arm,pl18x", "arm,primecell";
> arm,primecell-periphid = <0x00480181>;
> reg = <0x40012c00 0x400>;
> dmas =  <&dma2 6 4 0x10400 0x3>, /* Logical - DevToMem */
> <&dma2 3 4 0x10400 0x3>; /* Logical - MemToDev */
> dma-names = "rx", "tx";
> clocks = <&rcc 0 171>;
> clock-names = "apb_pclk";
> interrupts = <49>;
> status = "disabled";
> };
>
> And on the driver side I added this:
>
> /* STM32 variants */
>
> {
>
>         .id     = 0x00480181,
>
>         .mask   = 0xf0ffffff,
>
>         .data   = &variant_stm32f4x9,
>
> },
>
> My .id field is the .id from variant_ux500 plus one (and what I
> believe is not valid).
> And I cannot read the ID from STM32 IP because it always return zero.
> Maybe someone from ST(@Alex) can get the real ID. ;)

I will have a look on it soon.

regards
alex


>
>
>>
>> 2016-11-02 17:07 GMT+01:00 Bruno Herrera <bruherrera@gmail.com>:
>>>
>>> Hi
>>>
>>> On Wed, Nov 2, 2016 at 12:32 PM, Alexandre Torgue
>>> <alexandre.torgue@st.com> wrote:
>>>> Hi
>>>>
>>>> On 10/31/2016 07:58 PM, Rados?aw Pietrzyk wrote:
>>>>>
>>>>> I think wlcore driver searches dma-ranges in its parent that's why sdio
>>>>> node needs it.
>>>>
>>>>
>>>> Yes I agree. In this case it is needed as you have subnode in sdio node.
>>>> So IMO empty dma-ranges could be removed from ethernet and usb node, but
>>>> kept in future sdio subnode.
>>>
>>> Now it is clear.
>>>
>>>>
>>>> Bruno,
>>>> Do you plan to push sdio support ?
>>>
>>> Yes I do, but I'm not sure how long it will take. The I had to
>>> change(and hack) the mmci code because I could not get the ID from
>>> STM32 SDIO IP.
>>> My current WIP is at @
>>>
>>> https://github.com/mcoquelin-stm32/afboot-stm32/pull/4#issuecomment-247571615
>>> I know Andrea Merello is also working on that (and he probably has a
>>> more complete patch).
>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> 2016-10-31 17:41 GMT+01:00 Bruno Herrera <bruherrera@gmail.com
>>>>> <mailto:bruherrera@gmail.com>>:
>>>>>
>>>>>     On Mon, Oct 31, 2016 at 12:14 PM, Rados?aw Pietrzyk
>>>>>     <radoslaw.pietrzyk at gmail.com <mailto:radoslaw.pietrzyk@gmail.com>>
>>>>>     wrote:
>>>>>     > This is weird because dma ddresses are recalculated using
>>>>> parent's
>>>>>     > dma-ranges property and soc already has it so there should be
>>>>> absolutely no
>>>>>     > problem.
>>>>>
>>>>>     These are my DTS and DTSI file.
>>>>>     >
>>>>>     > 2016-10-31 11:27 GMT+01:00 Bruno Herrera <bruherrera@gmail.com
>>>>>     <mailto:bruherrera@gmail.com>>:
>>>>>     >>
>>>>>     >> On Fri, Oct 28, 2016 at 5:09 AM, Rados?aw Pietrzyk
>>>>>     >> <radoslaw.pietrzyk@gmail.com
>>>>>     <mailto:radoslaw.pietrzyk@gmail.com>> wrote:
>>>>>     >> > Have you defined your sdio node within soc node ?
>>>>>     >>
>>>>>     >> It is in the SOC node of the DSTI file.
>>>>>     >>
>>>>>     >> >
>>>>>     >> > 2016-10-27 14:57 GMT+02:00 Bruno Herrera <bruherrera@gmail.com
>>>>>     <mailto:bruherrera@gmail.com>>:
>>>>>     >> >>
>>>>>     >> >> Hi Alex,
>>>>>     >> >>
>>>>>     >> >> On Thu, Oct 27, 2016 at 10:21 AM, Alexandre Torgue
>>>>>     >> >> <alexandre.torgue at st.com <mailto:alexandre.torgue@st.com>>
>>>>> wrote:
>>>>>     >> >> > Hi Bruno,
>>>>>     >> >> >
>>>>>     >> >> >
>>>>>     >> >> > On 10/27/2016 12:43 PM, Bruno Herrera wrote:
>>>>>     >> >> >>
>>>>>     >> >> >> Hi Alex,
>>>>>     >> >> >>
>>>>>     >> >> >> On Wed, Oct 26, 2016 at 7:09 AM, Alexandre Torgue
>>>>>     >> >> >> <alexandre.torgue at st.com <mailto:alexandre.torgue@st.com>>
>>>>>     wrote:
>>>>>     >> >> >>>
>>>>>     >> >> >>> Hi Bruno,
>>>>>     >> >> >>>
>>>>>     >> >> >>> On 10/25/2016 11:06 PM, Bruno Herrera wrote:
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>> Hi Alexandre,
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>>
>>>>>     >> >> >>>>> stm32f469-disco and stm32f429-eval boards use SDRAM
>>>>>     start address
>>>>>     >> >> >>>>> remapping
>>>>>     >> >> >>>>> (to @0) to boost performances. A DMA translation
>>>>> through
>>>>>     >> >> >>>>> "dma-ranges"
>>>>>     >> >> >>>>> property was needed for other masters than the M4 CPU.
>>>>>     >> >> >>>>> stm32f429-disco doesn't use remapping so doesn't need
>>>>>     this DMA
>>>>>     >> >> >>>>> translation.
>>>>>     >> >> >>>>> This patches moves this DMA translation definition from
>>>>>     stm32f429
>>>>>     >> >> >>>>> soc
>>>>>     >> >> >>>>> file
>>>>>     >> >> >>>>> to board files.
>>>>>     >> >> >>>>>
>>>>>     >> >> >>>>> Signed-off-by: Alexandre TORGUE
>>>>> <alexandre.torgue@st.com
>>>>>     <mailto:alexandre.torgue@st.com>>
>>>>>
>>>>>     >> >> >>>>>
>>>>>     >> >> >>>>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>>> b/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>>> index 13c7cd2..a763c15 100644
>>>>>     >> >> >>>>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>>> @@ -82,6 +82,10 @@
>>>>>     >> >> >>>>>                 };
>>>>>     >> >> >>>>>         };
>>>>>     >> >> >>>>>
>>>>>     >> >> >>>>> +       soc {
>>>>>     >> >> >>>>> +               dma-ranges = <0xc0000000 0x0
>>>>> 0x10000000>;
>>>>>     >> >> >>>>> +       };
>>>>>     >> >> >>>>> +
>>>>>     >> >> >>>>>         usbotg_hs_phy: usbphy {
>>>>>     >> >> >>>>>                 #phy-cells = <0>;
>>>>>     >> >> >>>>>                 compatible = "usb-nop-xceiv";
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>> Shouldn't also the peripheral dma-ranges property move
>>>>> to
>>>>>     board
>>>>>     >> >> >>>> specific
>>>>>     >> >> >>>> too?
>>>>>     >> >> >>>> I  had this patch for while but I didn't had the time to
>>>>>     submit:
>>>>>     >> >> >>>
>>>>>     >> >> >>>
>>>>>     >> >> >>>
>>>>>     >> >> >>> Well spot I forgot it. Actually, discussing with Arnd
>>>>>     ysterday on
>>>>>     >> >> >>> IIRC,
>>>>>     >> >> >>> empty dma-ranges is not needed. Can you test on your side
>>>>> by
>>>>>     >> >> >>> removing
>>>>>     >> >> >>> dma-ranges in usb node please ?
>>>>>     >> >> >>
>>>>>     >> >> >> Unfortunately will take a time for me to set up this
>>>>>     environment on
>>>>>     >> >> >> the STM32F4-EVAL board.
>>>>>     >> >> >> And on the discovery boards we dont have this scenario.
>>>>>     That was the
>>>>>     >> >> >> main reason I did not submit the patch right away.
>>>>>     >> >> >> My conclusion and I might be wrong but is based on the my
>>>>>     tests with
>>>>>     >> >> >> SDIO device at STM32F469I-DISCO board.
>>>>>     >> >> >>
>>>>>     >> >> >> I started this issue as discussion at ST Forum but Maxime
>>>>>     gave me
>>>>>     >> >> >> the
>>>>>     >> >> >> hint.
>>>>>     >> >> >>
>>>>>     >> >> >>
>>>>>     >> >> >>
>>>>>     >> >> >>
>>>>>     >> >> >>
>>>>>
>>>>>
>>>>> https://my.st.com/public/STe2ecommunities/mcu/Lists/cortex_mx_stm32/Flat.aspx?RootFolder=https%3a%2f%2fmy%2est%2ecom%2fpublic%2fSTe2ecommunities%2fmcu%2fLists%2fcortex_mx_stm32%2fDMA2%20and%20SYSCFG_MEMRMP%20relationship&FolderCTID=0x01200200770978C69A1141439FE559EB459D7580009C4E14902C3CDE46A77F0FFD06506F5B&currentviews=44
>>>>>
>>>>>
>>>>> <https://my.st.com/public/STe2ecommunities/mcu/Lists/cortex_mx_stm32/Flat.aspx?RootFolder=https%3a%2f%2fmy%2est%2ecom%2fpublic%2fSTe2ecommunities%2fmcu%2fLists%2fcortex_mx_stm32%2fDMA2%20and%20SYSCFG_MEMRMP%20relationship&FolderCTID=0x01200200770978C69A1141439FE559EB459D7580009C4E14902C3CDE46A77F0FFD06506F5B&currentviews=44>
>>>>>     >> >> >>
>>>>>     >> >> >>> I will push a v2 by removing empty dma-ranges if tests
>>>>> are
>>>>>     ok in
>>>>>     >> >> >>> your
>>>>>     >> >> >>> side.
>>>>>     >> >> >>
>>>>>     >> >> >>
>>>>>     >> >> >> From my understating/conclusion is: when empty
>>>>>     property(dma-ranges)
>>>>>     >> >> >> is
>>>>>     >> >> >> the device node, the mapping will be taken in
>>>>> consideration
>>>>>     when
>>>>>     >> >> >> using
>>>>>     >> >> >> DMA otherwise the mapping is ignored.
>>>>>     >> >> >> And in the SDIO case it is needed for DEV->MEM(SDRAM) and
>>>>>     >> >> >> MEM(SDRAM)->DEV. If it is not the case for the devices in
>>>>>     question
>>>>>     >> >> >> so
>>>>>     >> >> >> I suppose it can work without the property.
>>>>>     >> >> >
>>>>>     >> >> >
>>>>>     >> >> > For sure translation has to be done but I'm not sure that
>>>>> an
>>>>>     empty
>>>>>     >> >> > "dma-ranges" is needed in device node to activate it. For
>>>>>     Ethernet
>>>>>     >> >> > empty
>>>>>     >> >> > "dma-ranges" is not needed. I will try with usb.
>>>>>     >> >>
>>>>>     >> >> In the case of SDIO it is needed. As example this is my
>>>>>     working SDIO
>>>>>     >> >> node:
>>>>>     >> >>
>>>>>     >> >> sdio: sdio at 40012c00 {
>>>>>     >> >> compatible = "arm,pl18x", "arm,primecell";
>>>>>     >> >> arm,primecell-periphid = <0x00480181>;
>>>>>     >> >> reg = <0x40012c00 0x400>;
>>>>>     >> >> dmas =  <&dma2 6 4 0x10400 0x3>, /* Logical - DevToMem */
>>>>>     >> >> <&dma2 3 4 0x10400 0x3>; /* Logical - MemToDev */
>>>>>     >> >> dma-names = "rx", "tx";
>>>>>     >> >> clocks = <&rcc 0 171>;
>>>>>     >> >> clock-names = "apb_pclk";
>>>>>     >> >> interrupts = <49>;
>>>>>     >> >> status = "disabled";
>>>>>     >> >> };
>>>>>     >> >>
>>>>>     >> >> &sdio {
>>>>>     >> >> status = "okay";
>>>>>     >> >> vmmc-supply = <&wlan_en>;
>>>>>     >> >> bus-width = <4>;
>>>>>     >> >> max-frequency = <24000000>;
>>>>>     >> >> pinctrl-names = "default";
>>>>>     >> >> pinctrl-0 = <&sdio_pins>;
>>>>>     >> >> ti,non-removable;
>>>>>     >> >> ti,needs-special-hs-handling;
>>>>>     >> >> dma-ranges;
>>>>>     >> >> cap-power-off-card;
>>>>>     >> >> keep-power-in-suspend;
>>>>>     >> >>
>>>>>     >> >> #address-cells = <1>;
>>>>>     >> >> #size-cells = <0>;
>>>>>     >> >> wlcore: wlcore at 0 {
>>>>>     >> >> compatible = "ti,wl1835";
>>>>>     >> >> reg = <2>;
>>>>>     >> >> interrupt-parent = <&gpioa>;
>>>>>     >> >> interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>>>>>     >> >> };
>>>>>     >> >> };
>>>>>     >> >>
>>>>>     >> >> >
>>>>>     >> >> > alex
>>>>>     >> >> >
>>>>>     >> >> >
>>>>>     >> >> >>
>>>>>     >> >> >>>
>>>>>     >> >> >>> Thanks in advance
>>>>>     >> >> >>> Alex
>>>>>     >> >> >>>
>>>>>     >> >> >>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>> Author: Bruno Herrera <bruherrera@gmail.com
>>>>>     <mailto:bruherrera@gmail.com>>
>>>>>
>>>>>     >> >> >>>> Date:   Sun Oct 16 14:50:00 2016 -0200
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>     ARM: DT: STM32: Use dma-ranges property per board
>>>>> not
>>>>>     at dtsi
>>>>>     >> >> >>>> file
>>>>>     >> >> >>>>
>>>>>     >> >> >>>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>> b/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>> index 6bfc595..2a22a82 100644
>>>>>     >> >> >>>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>>>>>     >> >> >>>> @@ -52,6 +52,10 @@
>>>>>     >> >> >>>>         model = "STMicroelectronics STM32429i-EVAL
>>>>> board";
>>>>>     >> >> >>>>         compatible = "st,stm32429i-eval",
>>>>> "st,stm32f429";
>>>>>     >> >> >>>>
>>>>>     >> >> >>>> +       soc {
>>>>>     >> >> >>>> +               dma-ranges = <0xC0000000 0x0
>>>>> 0x10000000>;
>>>>>     >> >> >>>> +       };
>>>>>     >> >> >>>> +
>>>>>     >> >> >>>>         chosen {
>>>>>     >> >> >>>>                 bootargs = "root=/dev/ram
>>>>> rdinit=/linuxrc";
>>>>>     >> >> >>>>                 stdout-path = "serial0:115200n8";
>>>>>     >> >> >>>> @@ -96,6 +100,7 @@
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>  &ethernet0 {
>>>>>     >> >> >>>>         status = "okay";
>>>>>     >> >> >>>> +       dma-ranges;
>>>>>     >> >> >>>>         pinctrl-0       = <&ethernet0_mii>;
>>>>>     >> >> >>>>         pinctrl-names   = "default";
>>>>>     >> >> >>>>         phy-mode        = "mii-id";
>>>>>     >> >> >>>> @@ -116,6 +121,7 @@
>>>>>     >> >> >>>>  };
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>  &usbotg_hs {
>>>>>     >> >> >>>> +       dma-ranges;
>>>>>     >> >> >>>>         dr_mode = "host";
>>>>>     >> >> >>>>         phys = <&usbotg_hs_phy>;
>>>>>     >> >> >>>>         phy-names = "usb2-phy";
>>>>>     >> >> >>>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>> b/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>> index 7d624a2..697a133 100644
>>>>>     >> >> >>>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>> @@ -59,7 +59,6 @@
>>>>>     >> >> >>>>         };
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>         soc {
>>>>>     >> >> >>>> -               dma-ranges = <0xc0000000 0x0
>>>>> 0x10000000>;
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>                 timer2: timer at 40000000 {
>>>>>     >> >> >>>>                         compatible = "st,stm32-timer";
>>>>>     >> >> >>>> @@ -472,13 +471,11 @@
>>>>>     >> >> >>>>                         st,syscon = <&syscfg 0x4>;
>>>>>     >> >> >>>>                         snps,pbl = <8>;
>>>>>     >> >> >>>>                         snps,mixed-burst;
>>>>>     >> >> >>>> -                       dma-ranges;
>>>>>     >> >> >>>>                         status = "disabled";
>>>>>     >> >> >>>>                 };
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>                 usbotg_hs: usb at 40040000 {
>>>>>     >> >> >>>>                         compatible = "snps,dwc2";
>>>>>     >> >> >>>> -                       dma-ranges;
>>>>>     >> >> >>>>                         reg = <0x40040000 0x40000>;
>>>>>     >> >> >>>>                         interrupts = <77>;
>>>>>     >> >> >>>>                         clocks = <&rcc 0 29>;
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>>> b/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>>> index 0596d60..3a1cfdd 100644
>>>>>     >> >> >>>>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>>>>>     >> >> >>>>> @@ -59,8 +59,6 @@
>>>>>     >> >> >>>>>         };
>>>>>     >> >> >>>>>
>>>>>     >> >> >>>>>         soc {
>>>>>     >> >> >>>>> -               dma-ranges = <0xc0000000 0x0
>>>>> 0x10000000>;
>>>>>     >> >> >>>>> -
>>>>>     >> >> >>>>>                 timer2: timer at 40000000 {
>>>>>     >> >> >>>>>                         compatible = "st,stm32-timer";
>>>>>     >> >> >>>>>                         reg = <0x40000000 0x400>;
>>>>>     >> >> >>>>> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>     >> >> >>>>> b/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>     >> >> >>>>> index 9e73656..c2213c0 100644
>>>>>     >> >> >>>>> --- a/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>     >> >> >>>>> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
>>>>>     >> >> >>>>> @@ -64,6 +64,10 @@
>>>>>     >> >> >>>>>         aliases {
>>>>>     >> >> >>>>>                 serial0 = &usart3;
>>>>>     >> >> >>>>>         };
>>>>>     >> >> >>>>> +
>>>>>     >> >> >>>>> +       soc {
>>>>>     >> >> >>>>> +               dma-ranges = <0xc0000000 0x0
>>>>> 0x10000000>;
>>>>>     >> >> >>>>> +       };
>>>>>     >> >> >>>>>  };
>>>>>     >> >> >>>>>
>>>>>     >> >> >>>>>  &clk_hse {
>>>>>     >> >> >>>>> --
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>>
>>>>>     >> >> >>>> Br.,
>>>>>     >> >> >>>> Bruno
>>>>>     >> >> >>>>
>>>>>     >> >> >>>
>>>>>     >> >> >
>>>>>     >> >>
>>>>>     >> >> _______________________________________________
>>>>>     >> >> linux-arm-kernel mailing list
>>>>>     >> >> linux-arm-kernel at lists.infradead.org
>>>>>     <mailto:linux-arm-kernel@lists.infradead.org>
>>>>>     >> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>     <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>
>>>>>     >> >
>>>>>     >> >
>>>>>     >
>>>>>     >
>>>>>
>>>>>
>>>>
>>
>>
