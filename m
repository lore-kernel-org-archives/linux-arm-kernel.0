From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 19 Jan 2015 09:49:54 +0000
Subject: [RFC][PATCH] arm64: efi: Obey EFI memory type in dmi_remap
In-Reply-To: <20150117143601.GM3827@bivouac.eciton.net>
References: <1421461479-31608-1-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8y428H0QQznV9SqhKNLMf6NVmNw5Lup3LiZYinRVMU-A@mail.gmail.com>
 <20150117115616.GK3827@bivouac.eciton.net>
 <CAKv+Gu_ppM7UNTt7=iCRgk6tsO8kj+TkA0Eg1CeXRSEL0t8__g@mail.gmail.com>
 <20150117143601.GM3827@bivouac.eciton.net>
Message-ID: <CAKv+Gu9K3TWWacsJ4-z0iKb3p09vKb7XyDnpgzaRfvGHhEjGSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2015 at 14:36, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Sat, Jan 17, 2015 at 12:43:48PM +0000, Ard Biesheuvel wrote:
>> >> Mapping the SMBIOS tables as uncached is a bad idea, as 'uncached'
>> >> implies MT_DEVICE_nGnRnE in the arm64 kernel, and the SMBIOS structure
>> >> tables are not guaranteed to be aligned. So you should at least use
>> >> MT_NORMAL_NC here.
>> >>
>> >> Why does it end up mapped uncached in the first place? Is it backed by
>> >> a ROM instead of normal RAM?
>> >
>> > Makes no difference - the SMBIOS spec contains some not naturally
>> > aligned fields. So regardless of the backing store, the tables must be
>> > accessible by Normal memory accesses.
>>
>> It should be mapped MT_NORMAL regardless, but it would be good to
>> understand how we ended up in this situation, and whether it is
>> something allowed by the spec.
>
> It is not really a question of the spec. If the spec does not

It /is/ a question of the spec: it specifies an exact mapping between
EFI_MEMORY_xx constants and MAIR_ELx values, which is worse than just
unhelpful if using WT cannot be supported by the architecture.

> explicitly ban you from doing something that the architecture you are
> executing on _does_, then you need to follow the architecture.
>
> Which is not to say that the spec couldn't be more helpful in this
> regard.
>
>> We currently assume that every
>> EfiRuntimeServicesData or EfiReserved region is carved out of
>> EfiConventionalMemory that has the EFI_MEMORY_WB attribute set, but I
>> suspect that this is a non-RAM region.
>
> Which does not automatically mean it should not be mapped as either
> uncached or non-WC. Flash that is being read/executed from _should_ be
> mapped as not only WC, but WB. Only when you are writing to the flash
> do you need to change the mappings to a non-WC type.
>

Executing from device memory is not a problem at all, so let's
disregard that for now.

As far as mapping ROM is concerned: I think it makes perfect sense to
specify WT instead of WB in that case, as it will be more helpful in
spotting inadvertent writes.

>> Note that the spec defines
>> EFI_MEMORY_UC memory as MT_DEVICE_nGnRnE on AArch64, so if this region
>> is only UC then it is a firmware bug. If it has WT/WC set, but not WB,
>> I think we are dealing with a compliant firmware that is not handled
>> correctly by the kernel.
>
> I agree with you on the purely philosophical level, but it is the WC
> attribute that can atually cause problems for other things than
> software. Even WT does not provide any of the memory ordering
> guarantees that would be required for it to become invisible. (This is
> also trued for UC, which is why WT can usually be treated as identical
> to Normal UC.)
>

I don't follow, especially the 'invisble' bit ..

>> More specifically, we only distinguish
>> between EFI_MEMORY_WB and !EFI_MEMORY_WB, where we treat the former as
>> RAM and the latter as device memory. WT and WC are completely ignored.
>
> Ignoring the WT is not a problem. WC should not be completely ignored,
> i.e. we need to respect its absence and never map as Normal unless it
> is provided. _But_ WB and WT (at least on ARM) both implicitly mean
> WC. Setting anything else in the memory map is creating an incorrect
> memory map. And hence "fixing up" where firmware does so would hide
> firmware issues.
>

OK, but that is not at all what I am suggesting. Note that the bits
mean 'this region /may/ be mapped as xxxx'
My suspicion is (and @Laura, please confirm) that this region is
WT|WC|UC simply because WB on a ROM is semantically dubious, and
restricting to WT makes it easier to spot errors.

> If we are, for example, talking about a flash region flagged as non-WC
> in the memory map because some AML routine might directly write to it,
> then it cannot simultaneously be legal for that region to contain data
> that is expected to require unaligned accesses to read (such as SMBIOS).
>

Agreed,

>> >> And does the region have any of the WT/W
>> >> attributes set in addition to UC? What type is it? I suppose it has
>> >> the EFI_MEMORY_RUNTIME bit set as well? (Note that the spec seems to
>> >> assume that configuration tables always reside in system RAM [UEFI
>> >> spec 2.4A 2.3.6])
>> >>
>> >> Also, with my latest virtmap changes, UEFI runtime regions are only
>> >> mapped during runtime service invocations, and explicitly when e.g.
>> >> the SMBIOS or ACPI layer needs to get at the data. Currently, regions
>> >> backed by system RAM are still covered by the linear mapping as well,
>> >> but that is something we intend to change too. So if the region is not
>> >> system RAM (!EFI_MEMORY_WB), the latest code will not have this region
>> >> mapped at DMI scan time, afaict.
>> >
>> > Which seems like correct behaviour to me. If your firmware gives you
>> > bogus data, most bets are off.
>>
>> Let's not point fingers just yet :-)
>>
>> > What might make sense would be to if(efi_enabled(EFI_CONFIG_TABLES)),
>> > verify WT/WC are set for the location, and bail out otherwise.
>> >
>> > But this would effectively be a pre-emptive firmware bug workaround.
>>
>> As I said, I would like to understand better what the nature of the
>> region in question is.
>> If it is a EfiRuntimeServicesData or EfiReserved region with WT|WC set
>> and WB|UC cleared, for instance, then we are doing the wrong thing by
>> mapping it as device memory.
>
> Mmm, maybe. But, if the firmware states that a region that can be
> accessed as WT but not WB, then at the very least it is doing
> something very fishy. WT does not really make sense on ARM (it does
> not support hardware coherency).
>

This may be an issue in general, but for immutable data I don't see a
problem here.

> It is entirely legal for an ARM processor to treat WT regions as
> uncached. Again - if the spec provides a distinction that is not
> available in the architecture on which the software runs, the
> architecture wins.
>
> If it is an EfiReserved region, surely we shouldn't be touching it at
> all?
>

We shouldn't, but we don't enforce that.

-- 
Ard.
