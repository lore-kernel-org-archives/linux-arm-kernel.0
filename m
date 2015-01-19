From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 19 Jan 2015 15:02:47 -0800
Subject: [RFC][PATCH] arm64: efi: Obey EFI memory type in dmi_remap
In-Reply-To: <CAKv+Gu8y428H0QQznV9SqhKNLMf6NVmNw5Lup3LiZYinRVMU-A@mail.gmail.com>
References: <1421461479-31608-1-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8y428H0QQznV9SqhKNLMf6NVmNw5Lup3LiZYinRVMU-A@mail.gmail.com>
Message-ID: <54BD8D17.10202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/2015 12:24 AM, Ard Biesheuvel wrote:
> On 17 January 2015 at 02:24, Laura Abbott <lauraa@codeaurora.org> wrote:
>> Currently, dmi_remap unconditionally calls ioremap_cache for dmi_remap.
>> The memory that's being remapped may be part of the existing EFI
>> memory map and already remapped as uncached. Remapping as cached can
>> created unexpected behavior so check the physical address against the
>> EFI memory type before remapping.
>>
>
> Mapping the SMBIOS tables as uncached is a bad idea, as 'uncached'
> implies MT_DEVICE_nGnRnE in the arm64 kernel, and the SMBIOS structure
> tables are not guaranteed to be aligned. So you should at least use
> MT_NORMAL_NC here.
>
> Why does it end up mapped uncached in the first place? Is it backed by
> a ROM instead of normal RAM? And does the region have any of the WT/WC
> attributes set in addition to UC? What type is it? I suppose it has
> the EFI_MEMORY_RUNTIME bit set as well? (Note that the spec seems to
> assume that configuration tables always reside in system RAM [UEFI
> spec 2.4A 2.3.6])
>
> Also, with my latest virtmap changes, UEFI runtime regions are only
> mapped during runtime service invocations, and explicitly when e.g.
> the SMBIOS or ACPI layer needs to get at the data. Currently, regions
> backed by system RAM are still covered by the linear mapping as well,
> but that is something we intend to change too. So if the region is not
> system RAM (!EFI_MEMORY_WB), the latest code will not have this region
> mapped at DMI scan time, afaict.
>
> Finally, I have been looking into classifying memory as system RAM or
> not myself[0]. Even if SMBIOS is UEFI only in arm64, I would prefer
> not to add infrastructure that allows us to answer these kind of
> questions only when booted via UEFI.
>
> [0] http://article.gmane.org/gmane.linux.kernel.efi/5133
>
>

Thanks for the feedback. The tables aren't in ROM, they are in external
memory which needs to be accessed by other devices (e.g. BMC) which
necessitates having it marked as uncached without WT/WC attributes.
I think for now we are going to re-evaluate the need for the support
provided by this patch based on the feedback given.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
