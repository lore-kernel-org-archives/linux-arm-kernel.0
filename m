From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 17 Jan 2015 12:43:48 +0000
Subject: [RFC][PATCH] arm64: efi: Obey EFI memory type in dmi_remap
In-Reply-To: <20150117115616.GK3827@bivouac.eciton.net>
References: <1421461479-31608-1-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8y428H0QQznV9SqhKNLMf6NVmNw5Lup3LiZYinRVMU-A@mail.gmail.com>
 <20150117115616.GK3827@bivouac.eciton.net>
Message-ID: <CAKv+Gu_ppM7UNTt7=iCRgk6tsO8kj+TkA0Eg1CeXRSEL0t8__g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2015 at 11:56, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Sat, Jan 17, 2015 at 08:24:15AM +0000, Ard Biesheuvel wrote:
>> On 17 January 2015 at 02:24, Laura Abbott <lauraa@codeaurora.org> wrote:
>> > Currently, dmi_remap unconditionally calls ioremap_cache for dmi_remap.
>> > The memory that's being remapped may be part of the existing EFI
>> > memory map and already remapped as uncached. Remapping as cached can
>> > created unexpected behavior so check the physical address against the
>> > EFI memory type before remapping.
>>
>> Mapping the SMBIOS tables as uncached is a bad idea, as 'uncached'
>> implies MT_DEVICE_nGnRnE in the arm64 kernel, and the SMBIOS structure
>> tables are not guaranteed to be aligned. So you should at least use
>> MT_NORMAL_NC here.
>>
>> Why does it end up mapped uncached in the first place? Is it backed by
>> a ROM instead of normal RAM?
>
> Makes no difference - the SMBIOS spec contains some not naturally
> aligned fields. So regardless of the backing store, the tables must be
> accessible by Normal memory accesses.
>

It should be mapped MT_NORMAL regardless, but it would be good to
understand how we ended up in this situation, and whether it is
something allowed by the spec. We currently assume that every
EfiRuntimeServicesData or EfiReserved region is carved out of
EfiConventionalMemory that has the EFI_MEMORY_WB attribute set, but I
suspect that this is a non-RAM region. Note that the spec defines
EFI_MEMORY_UC memory as MT_DEVICE_nGnRnE on AArch64, so if this region
is only UC then it is a firmware bug. If it has WT/WC set, but not WB,
I think we are dealing with a compliant firmware that is not handled
correctly by the kernel. More specifically, we only distinguish
between EFI_MEMORY_WB and !EFI_MEMORY_WB, where we treat the former as
RAM and the latter as device memory. WT and WC are completely ignored.


>> And does the region have any of the WT/W
>> attributes set in addition to UC? What type is it? I suppose it has
>> the EFI_MEMORY_RUNTIME bit set as well? (Note that the spec seems to
>> assume that configuration tables always reside in system RAM [UEFI
>> spec 2.4A 2.3.6])
>>
>> Also, with my latest virtmap changes, UEFI runtime regions are only
>> mapped during runtime service invocations, and explicitly when e.g.
>> the SMBIOS or ACPI layer needs to get at the data. Currently, regions
>> backed by system RAM are still covered by the linear mapping as well,
>> but that is something we intend to change too. So if the region is not
>> system RAM (!EFI_MEMORY_WB), the latest code will not have this region
>> mapped at DMI scan time, afaict.
>
> Which seems like correct behaviour to me. If your firmware gives you
> bogus data, most bets are off.
>

Let's not point fingers just yet :-)

> What might make sense would be to if(efi_enabled(EFI_CONFIG_TABLES)),
> verify WT/WC are set for the location, and bail out otherwise.
>
> But this would effectively be a pre-emptive firmware bug workaround.
>

As I said, I would like to understand better what the nature of the
region in question is.
If it is a EfiRuntimeServicesData or EfiReserved region with WT|WC set
and WB|UC cleared, for instance, then we are doing the wrong thing by
mapping it as device memory.

-- 
Ard.
