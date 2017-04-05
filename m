From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Wed, 5 Apr 2017 13:07:21 +0100
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable PCI_MSI
In-Reply-To: <001c01d2ad85$b06af1a0$1140d4e0$@gmail.com>
References: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
 <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2Fb7gpO0LsoVpPbUX5rSyH3yC4K30JpAf5j7aQkDH9tw@mail.gmail.com>
 <1460708469.22710.4.camel@pengutronix.de>
 <CAJ+vNU1-M3qSODKHMf872kfOsH0g9xFgKNEgKqiJu6A8z-ChxA@mail.gmail.com>
 <CAJ+vNU0+ksyYCpydpmcJOO-w0v4D0axvG84wK7f09iK_1yzo_A@mail.gmail.com>
 <001c01d2ad85$b06af1a0$1140d4e0$@gmail.com>
Message-ID: <6eb58d54-b6e8-b709-c7f9-fa19d52cd492@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?s 9:54 PM de 4/4/2017, Jingoo Han escreveu:
> On Friday, March 31, 2017 12:05 PM, Tim Harvey wrote:
>> On Thu, Mar 30, 2017 at 4:42 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>>> On Fri, Apr 15, 2016 at 1:21 AM, Lucas Stach <l.stach@pengutronix.de>
>> wrote:
>>>> Am Donnerstag, den 14.04.2016, 08:13 -0700 schrieb Tim Harvey:
>>>>> On Mon, Nov 30, 2015 at 9:00 AM, Lucas Stach <l.stach@pengutronix.de>
>> wrote:
>>>>>> This has been stable on i.MX6 for a good while now and there is no
>>>>>> reason to keep it disabled, as it allows to allocate non-shared
>>>>>> IRQs if several PCIe devices are connected to a single host.
>>>>>>
>>>>>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>>>>> ---
>>>>>>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
>> b/arch/arm/configs/imx_v6_v7_defconfig
>>>>>> index 4187f69f6630..e2ce60d00e8a 100644
>>>>>> --- a/arch/arm/configs/imx_v6_v7_defconfig
>>>>>> +++ b/arch/arm/configs/imx_v6_v7_defconfig
>>>>>> @@ -45,6 +45,7 @@ CONFIG_SOC_IMX7D=y
>>>>>>  CONFIG_SOC_LS1021A=y
>>>>>>  CONFIG_SOC_VF610=y
>>>>>>  CONFIG_PCI=y
>>>>>> +CONFIG_PCI_MSI=y
>>>>>>  CONFIG_PCI_IMX6=y
>>>>>>  CONFIG_SMP=y
>>>>>>  CONFIG_PREEMPT_VOLUNTARY=y
>>>>>> --
>>>>>> 2.6.2
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> linux-arm-kernel mailing list
>>>>>> linux-arm-kernel at lists.infradead.org
>>>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Darm-2Dkernel&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=yQx7ybu-JGcPPh6ZlQyxkC6_Uw62cuBKLb7o3zpK7hQ&s=o-tR0mZ5yKNTTXKX1MR7NuDLpHfvSHIjzi47YLue0aA&e= 
>>>>>
>>>>> Lucas,
>>>>>
>>>>> Any thoughts on why enabling MSI on IMX6 breaks legacy interrupts?
>>>>>
>>>>> Again, many PCI devices/drivers don't support MSI and thus enabling
>>>>> MSI as this patch does makes this config break many PCI devices on
>>>>> IMX6.
>>>>>
>>>>> I have found that MSI does indeed work on the IMX6 for cards/drivers
>>>>> that use MSI, but for those that don't the legacy interrupts never
>>>>> fire regardless of going through a bridge or directly hanging off the
>>>>> IMX6. I assume you can confirm this on your boards/devices as well?
>>>>>
>>>> No, this seems to be an errata in the DW PCIe core. The manual states
>>>> that legacy IRQs and MSIs can't be used together, but I thought this
>>>> only applies to the EP part of the core.
>>>>
>>>> We can probably fix the simple configuration by not enabling MSI
>> support
>>>> until someone actually requests to set up an MSI IRQ, so both IRQ types
>>>> work when only one EP is connected.
>>>> I don't have any idea yet how to fix setups with a PCIe switch where
>>>> some connected EPs might like to use MSIs while some others can't use
>>>> them.
>>>>
>>>> Regards,
>>>> Lucas
>>>>
>>>
>>> Lucas,
>>>
>>> I feel a bit dumb here for forgetting about this issue and letting it
>>> drop, but I've just spent a day debugging an issue with the ath9k
>>> wireless driver only to realize it was that the ath9k card and/or
>>> driver doesn't support MSI interrupts and thus no longer work on
>>> mainline kernels that have MSI enabled. To be honest I'm not sure how
>>> many PCIe devices out there can't support MSI because of hardware
>>> limitations vs drivers that simply have not implemented it.
>>>
>>> To make matters worse 3ee803641e76bea76ec730c80dcc64739a9919ff makes
>>> it such that you can't disable MSI on the IMX6.
>>>
>>> Is there some fix you can think of to make the IMX6 PCIe host
>>> controller raise an interrupt for cards/drivers that use legacy irq's?
>>> If not, then we need to allow MSI to be disabled for IMX6 and default
>>> it to disabled for compatibility.
>>>
>>
>> Joao / Jingoo,
>>
>> (Adding linux-pci to the list to pick up maintainers of other DWC PCIe
>> core drivers)
>>
>> Is Luca's statement that 'legacy IRQs and MSIs can't be used together'
>> true in general for the DW PCIe core? If any of the host controllers
>> using this core can't support both legacy and MSI irqs together I
>> still believe we shouldn't enable/require MSI as it breaks any
>> card/driver that only supports legacy interrupts (such as ath9k).
> 
> If there are 2 DW PCIe controllers, one controller can be used for legacy
> and another controller can be used for MSI.
> 
> But, I am not sure that one DW PCIe controller can support both MSI device
> and legacy interrupt device at the same time.
> 
> To Joao Pinto,
> Will you confirm this?
> 

Hi Jingoo,
I confirm that if a RC has MSI enable, it won't support legacy interrupts.

Regards,
Joao

> Or if there is anyone who knows this well, please share your knowledge. :-)
> Thanks.
> 
> Best regards,
> Jingoo Han
> 
>>
>> Regards,
>>
>> Tim
> 
