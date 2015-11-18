From: binmlist@gmail.com (Bin Liu)
Date: Wed, 18 Nov 2015 14:45:32 -0600
Subject: [PATCH] usb: musb: USB_TI_CPPI41_DMA requires dmaengine support
In-Reply-To: <87y4dvgi0j.fsf@saruman.tx.rr.com>
References: <4370741.70D0kgBgnp@wuerfel>
 <CADYTM3baomio7+nFizOKFXMav7guow+=GsVaGExBWxQyn9t=2w@mail.gmail.com>
 <87a8qbhzvf.fsf@saruman.tx.rr.com>
 <CADYTM3Ye=7iydzeg2j3VNkiHVoZqE6Hasm6N6=2UNiHEr2Ti4g@mail.gmail.com>
 <87y4dvgi0j.fsf@saruman.tx.rr.com>
Message-ID: <CADYTM3ZuYPw7TZaf7DeGpnnf21-uAhia+jgT1UTtEStckYgT3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 2:38 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> Hi,
>
> Bin Liu <binmlist@gmail.com> writes:
>>> Bin Liu <binmlist@gmail.com> writes:
>>>> On Wed, Nov 18, 2015 at 10:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> The CPPI-4.1 driver selects TI_CPPI41, which is a dmaengine
>>>>> driver and that may not be available when CONFIG_DMADEVICES
>>>>> is not set:
>>>>>
>>>>> warning: (USB_TI_CPPI41_DMA) selects TI_CPPI41 which has unmet direct dependencies (DMADEVICES && ARCH_OMAP)
>>>>>
>>>>> This adds an extra dependency to avoid generating warnings in randconfig
>>>>> builds. Ideally we'd remove the 'select' statement, but that has the
>>>>> potential to break defconfig files.
>>>>>
>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>>> Fixes: 411dd19c682d ("usb: musb: Kconfig: Select the DMA driver if DMA mode of MUSB is enabled")
>>>>>
>>>>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>>>>> index 1f2037bbeb0d..45c83baf675d 100644
>>>>> --- a/drivers/usb/musb/Kconfig
>>>>> +++ b/drivers/usb/musb/Kconfig
>>>>> @@ -159,7 +159,7 @@ config USB_TI_CPPI_DMA
>>>>>
>>>>>  config USB_TI_CPPI41_DMA
>>>>>         bool 'TI CPPI 4.1 (AM335x)'
>>>>> -       depends on ARCH_OMAP
>>>>> +       depends on ARCH_OMAP && DMADEVICES
>>>>>         select TI_CPPI41
>>>>
>>>> I am not sure what the generic policy is, but instead of hiding
>>>> USB_TI_CPPI41_DMA if DMADEVICES is disabled, I'd like to enable
>>>> DMADEVICES if USB_TI_CPPI41_DMA is enabled, from user experience
>>>> perspective.
>>>
>>> that would mean "select DMADEVICES" and that's frowned upon.
>>
>> Currently 'select DMADEVICES' is not in there. Will adding it fix the
>> dependency warning in randconfig? Sorry for the question, but I don't
>> know enough about Kconfig to get the answer.
>
> it certainly would, but we don't like to add "select XYZ" to Kconfig
> because a select bypasses the dependency tree. Let me explain:
>
> config A
>        tristate "A"
>        depends on B
>
> config B
>        tristate "B"
>
>
> config C
>        tristate "C"
>        select A
>
>
> C can select A without B being enabled.

Thanks for the explanation, very clear.

>
> --
> balbi
