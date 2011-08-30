From: richard.zhu@linaro.org (Richard Zhu)
Date: Tue, 30 Aug 2011 16:54:21 +0800
Subject: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
	<20110829121214.GA15484@oksana.dev.rtsoft.ru>
	<CAMPhdO_XsrGTiiKpALVU7tZiAO_C5d_9XKoVjL_BHwpcqzXcFg@mail.gmail.com>
	<CAJNCFVJKvO+W0ogn-3GOsR8ygtn5KWtqTc2sw6HuNB2-x7ZviA@mail.gmail.com>
	<CAJNCFVKPUW95F0Wt9eVWs0+ne1pdXreYi6uSKH2TkR+Qt_sm4A@mail.gmail.com>
Message-ID: <CAJNCFVJk0ZeMpSxa=wo1ByV64mip7=Gpscym1LLz2rHC0QvaLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
Maybe we have to come back to take wolfram's suggestion.
Remove the mx53 specification in the ahci_type, and replace it by
 the generic one AHCI_PMP_RTY_SRST
Then the other ahci controller that needs the same PMP retry soft
reset SW work-around can reuse the
ata_port_info.

Hi Eric:
How about to use the generic ahci_type AHCI_PMP_RTY_SRST to replace
the IMX53_AHCI firstly?

The specified ahci_type can be added if the ahci controller needs some
different configurations refer to
the definitions in the AHCI_PMP_RTY_SRST's ata_port_info.

In this way, we can re-use the codes as much as possible.

Best Regards
Richard Zhu

On 30 August 2011 15:07, Richard Zhu <richard.zhu@linaro.org> wrote:
> Hi:
> One more concern, the .../drivers/ata/ahci.h file should be moved to
> .../include/linux/ folder.
> Because that the kinds of macros used in the ata_port_info and the
> ahci_pmp_retry_srst_ops are
> all defined in the .../drivers/ata/ahci.h file.
> Otherwise, the ata_port_info can't be defined in the board related
> platform data.
>
> How we can handle this case?
>
> Best Regard
> Richard Zhu
>
> On 30 August 2011 14:21, Richard Zhu <richard.zhu@linaro.org> wrote:
>> Hi:
>> Pass port info from the platform data is a good idea.
>> About the codes duplication in the board level, I think that we can
>> re-use the default ?port info on most boards, when the ata_port_info
>> is null in the platform data struct.
>> We can leave the ahci_platform.c without any modifications in this way.
>>
>> How do you guys think about?
>>
>> Best Regard
>> Richard Zhu
>>
>>
>> On 29 August 2011 20:25, Eric Miao <eric.miao@linaro.org> wrote:
>>> On Mon, Aug 29, 2011 at 8:12 PM, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
>>>> Hello,
>>>>
>>>> On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
>>>>> On imx53 AHCI, soft reset fails with IPMS set when PMP
>>>>> is enabled but SATA HDD/ODD is connected to SATA port,
>>>>> do soft reset again to port 0.
>>>>> So the 'ahci_pmp_retry_srst_ops' is required when imx53
>>>>> ahci is present.
>>>>>
>>>>> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
>>>>> ---
>>>> [...]
>>>>> ? ? ? struct device *dev = &pdev->dev;
>>>>> ? ? ? struct ahci_platform_data *pdata = dev->platform_data;
>>>>> - ? ? struct ata_port_info pi = {
>>>>> - ? ? ? ? ? ? .flags ? ? ? ? ?= AHCI_FLAG_COMMON,
>>>>> - ? ? ? ? ? ? .pio_mask ? ? ? = ATA_PIO4,
>>>>> - ? ? ? ? ? ? .udma_mask ? ? ?= ATA_UDMA6,
>>>>> - ? ? ? ? ? ? .port_ops ? ? ? = &ahci_ops,
>>>>> - ? ? };
>>>>> + ? ? struct platform_device_id *id_entry = platform_get_device_id(pdev);
>>>>> + ? ? struct ata_port_info pi = ahci_port_info[id_entry->driver_data];
>>>>
>>>> Why not pass port info via platform_data? It seems to be platform
>>>> specific nowadays, so leave the default as is, but let the platforms
>>>> pass their own port info through platform_data.
>>>
>>> That's also a very clean way. However I have the concern that it might
>>> end up with many duplicate entries.
>>>
>>>>
>>>> Thanks,
>>>>
>>>> --
>>>> Anton Vorontsov
>>>> Email: cbouatmailru at gmail.com
>>>>
>>>> _______________________________________________
>>>> linux-arm-kernel mailing list
>>>> linux-arm-kernel at lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
>>
>
