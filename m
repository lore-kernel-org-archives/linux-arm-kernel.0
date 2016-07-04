From: arend.vanspriel@broadcom.com (Arend van Spriel)
Date: Mon, 4 Jul 2016 20:36:05 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm, nvram_file_name
 dt property
In-Reply-To: <8717879.O1RMZcQt4V@wuerfel>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <5756670.9hMGo8oEyl@wuerfel>
 <6cc6dabf-e6da-d70d-3cce-a7f1804f233e@broadcom.com>
 <8717879.O1RMZcQt4V@wuerfel>
Message-ID: <577AAC95.7040800@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-07-16 16:54, Arnd Bergmann wrote:
> On Monday, July 4, 2016 11:08:38 AM CEST Arend Van Spriel wrote:
>> On 4-7-2016 10:55, Arnd Bergmann wrote:
>>> On Monday, July 4, 2016 10:41:20 AM CEST Arend Van Spriel wrote:
>>>> On 2-7-2016 23:30, Arnd Bergmann wrote:
>>>>> On Saturday, July 2, 2016 8:20:35 PM CEST Arend Van Spriel wrote:
>>>>>>> If you want a separate property, then I repeat my very first
>>>>>>> suggestion, the well defined model property.
>>>>>>> e.g.
>>>>>>>
>>>>>>> brcmf at 0 {
>>>>>>>         model = "ampak,ap6210";
>>>>>>>         compatible = "brcm,bcm4329-fmac";
>>>>>>>         ...
>>>>>>> };
>>>>>>>
>>>>>>> All device nodes may have a model property, not just the top "machine" one.
>>>>>>
>>>>>> I heard you the first time  I just was not sure what the implications
>>>>>> would be to use it. Hence I suggested a vendor specific property.
>>>>>> However, looking up and reading the definition in ePAPRv1.1 I suppose it
>>>>>> is fine to use the model property:
>>>>>>
>>>>>> Property: model
>>>>>> Value type: <string>
>>>>>> Description:
>>>>>> The model property value is a <string> that specifies the manufacturer?s
>>>>>> model number of the device.
>>>>>>
>>>>>> The recommended format is: ?manufacturer,model?, where manufacturer is a
>>>>>> string describing the name of the manufacturer (such as a stock ticker
>>>>>> symbol), and model specifies the model number.
>>>>>
>>>>> The model property is very similar to compatible, except that there is
>>>>> only one entry rather than a list of entries from most specific to
>>>>> most generic.
>>>>
>>>> They seem very similar, but I think there is a conceptual difference.
>>>> The compatible property is mainly used to select the appropriate driver
>>>> and as such the property is typically ignored by device drivers.
>>>> Probably there are exceptions to be found.
>>>>
>>>>> I think by writing the above example as
>>>>>
>>>>>       compatible = "ampak,ap6210", "brcm,bcm4329-fmac";
>>>>>
>>>>> we can provide the same functionality in a slightly simpler way, the driver
>>>>> then just goes on to look for the nvram file for each entry in sequence until
>>>>> it finds one.
>>>>
>>>> Not sure why this would be simpler. Why would traversing the compatible
>>>> string be simpler than handling the model property if present and
>>>> otherwise fallback to the default nvram naming.
>>>
>>> Because you have to walk the list anyway to find the other firmware files:
>>> when you have a specialization of a device that requires listing both values
>>> as compatible, the driver has no idea which of the entries to use, unless
>>> you add a lookup table that adds more complexity.
>>
>> Currently, the brcmfmac bindings describe a single compatible string,
>> ie. "brcm,bcm4329-fmac", which selects the driver/programming model. If
>> that programming model supports "use model property if present,
>> otherwise use default" there is nothing to traverse. The default way in
>> the driver to determine firmware and nvram filename already has a lookup
>> table which uses the chip id and chip revision as key, which are read
>> from the device.
> 
> In drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c I already see
> over a dozen different chips being supported, bcm4329 is only one of
> them. In particular, there seem to be some that have various modules:
> 
>         BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43241_CHIP_ID, 0x0000001F, 43241B0),
>         BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43241_CHIP_ID, 0x00000020, 43241B4),
>         BRCMF_FW_NVRAM_ENTRY(BRCM_CC_43241_CHIP_ID, 0xFFFFFFC0, 43241B5),
> 
> So if you have a bcm43241, that compatible string probably should
> include both brcm,bcm43241-b4-fmac and brcm,bcm43241-fmac, possibly also
> brcm,bcm4329-fmac, to show that it is a superset of the programming
> interface of that one.

Hi Arnd,

I have to disagree here. The compatible string "brcm,bcm4329-fmac" is
chosen as the bcm4329 chip was the first supported and we never added
others as there is no other programming required. For all supported
devices the same device tree properties apply and are handled the same.
As such there is no need to come up with a new compatible string.

Regards,
Arend
