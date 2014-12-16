From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Tue, 16 Dec 2014 13:54:04 -0800
Subject: [PATCHv1] rtc: bcm-iproc: Add support for Broadcom iproc rtc
In-Reply-To: <549095CA.7090505@broadcom.com>
References: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
 <7947905.aK8KkUx4sY@wuerfel> <54909074.2070804@broadcom.com>
 <1418783023.hzNZBNCmFc@wuerfel> <549095CA.7090505@broadcom.com>
Message-ID: <5490A9FC.6030305@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14-12-16 12:27 PM, Ray Jui wrote:
>
>
> On 12/16/2014 12:19 PM, Arnd Bergmann wrote:
>> On Tuesday 16 December 2014 12:05:08 Arun Ramamurthy wrote:
>>> On 14-12-16 11:42 AM, Arnd Bergmann wrote:
>>>> On Tuesday 16 December 2014 11:22:30 arun.ramamurthy at broadcom.com
>>>> wrote:
>>>>> +       rtc: iproc_rtc at 0x03026000 {
>>>>> +               compatible = "brcm,iproc-rtc";
>>>>> +               reg =   spru_bbl:               <0x03026000 0xC>,
>>>>> +                       crmu_pwr_good_status:   <0x0301C02C 0x14>,
>>>>> +                       crmu_bbl_auth:          <0x03024C74 0x8>;
>>>>> +               interrupts = spru_rtc_periodic: <GIC_SPI 142
>>>>> IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                            spru_alarm:        <GIC_SPI 133
>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>
>>>> The reg properties look really random, could it be that the registers
>>>> are really part of some other device that contains multiple functions?
>>>>
>>> This RTC block is on a battery backed logic island and is accessed
>>> indirectly using the spru_bbl registers. The CRMU registers are required
>>> to read the power status and write to some authentication registers.
>>> Without writing to these authentication
>>> registers, we cannot access any of the spru_bbl registers. In conclusion
>>> I don't think the CRMU register accesses can be considered as another
>>> device access. Do you agree Arnd?
>>
>> It sounds like CRMU is some other unit aside from the RTC. Could this
>> be something like a generic system controller? I think it should
>> either have its own driver or use the syscon logic if that is what
>> this is.
>>
> Giving that CRMU has scattered, miscellaneous control logic for multiple
> different peripherals, it probably makes more sense to use the syscon
> logic here.
>
Arnd, thanks for the feedback. If I was to write a separate driver for 
the CRMU, I would have to export certain functions and create an api 
that only this RTC driver would use. I am not sure that is efficient or 
required. What is your opinion?
Would it be better if I use the syson api in my current driver and move 
the CRMU registers to separate syscon device tree entry?

>>>> Also, what do you use the labels for?
>>>>
>>> The labels are purely to improve readability of the device tree entry
>>
>> Please remove them then, they don't help at all.
>>
Sure, I will remove the labels
>>     Arnd
>>
