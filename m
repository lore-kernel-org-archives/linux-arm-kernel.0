From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Sat, 17 Jan 2015 11:56:16 +0000
Subject: [RFC][PATCH] arm64: efi: Obey EFI memory type in dmi_remap
In-Reply-To: <CAKv+Gu8y428H0QQznV9SqhKNLMf6NVmNw5Lup3LiZYinRVMU-A@mail.gmail.com>
References: <1421461479-31608-1-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8y428H0QQznV9SqhKNLMf6NVmNw5Lup3LiZYinRVMU-A@mail.gmail.com>
Message-ID: <20150117115616.GK3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 08:24:15AM +0000, Ard Biesheuvel wrote:
> On 17 January 2015 at 02:24, Laura Abbott <lauraa@codeaurora.org> wrote:
> > Currently, dmi_remap unconditionally calls ioremap_cache for dmi_remap.
> > The memory that's being remapped may be part of the existing EFI
> > memory map and already remapped as uncached. Remapping as cached can
> > created unexpected behavior so check the physical address against the
> > EFI memory type before remapping.
> 
> Mapping the SMBIOS tables as uncached is a bad idea, as 'uncached'
> implies MT_DEVICE_nGnRnE in the arm64 kernel, and the SMBIOS structure
> tables are not guaranteed to be aligned. So you should at least use
> MT_NORMAL_NC here.
> 
> Why does it end up mapped uncached in the first place? Is it backed by
> a ROM instead of normal RAM?

Makes no difference - the SMBIOS spec contains some not naturally
aligned fields. So regardless of the backing store, the tables must be
accessible by Normal memory accesses.

> And does the region have any of the WT/WC
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

Which seems like correct behaviour to me. If your firmware gives you
bogus data, most bets are off.

What might make sense would be to if(efi_enabled(EFI_CONFIG_TABLES)),
verify WT/WC are set for the location, and bail out otherwise.

But this would effectively be a pre-emptive firmware bug workaround.

/
    Leif
