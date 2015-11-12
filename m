From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Nov 2015 16:03:29 +0000
Subject: [PATCH 2/3] arm64: reimplement page_is_ram() using memblock and
 UEFI memory map
In-Reply-To: <CAKv+Gu8oYv1Ad=n+dgM5o-DTs-xSdSrv9RaDJEu_cQvppLssfw@mail.gmail.com>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
 <1446126059-25336-3-git-send-email-ard.biesheuvel@linaro.org>
 <20151112153150.GC2681@codeblueprint.co.uk>
 <CAKv+Gu8oYv1Ad=n+dgM5o-DTs-xSdSrv9RaDJEu_cQvppLssfw@mail.gmail.com>
Message-ID: <20151112160329.GE26564@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 04:40:23PM +0100, Ard Biesheuvel wrote:
> On 12 November 2015 at 16:31, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> > On Thu, 29 Oct, at 02:40:58PM, Ard Biesheuvel wrote:
> >> This patch overrides the __weak default implementation of page_is_ram(),
> >> which uses string comparisons to find entries called 'System RAM' in
> >> /proc/iomem. Since we used the contents of memblock to create those entries
> >> in the first place, let's use memblock directly.
> >>
> >> Also, since the UEFI memory map may describe regions backed by RAM that are
> >> not in memblock (i.e., reserved regions that were removed from the linear
> >> mapping), check the pfn against the UEFI memory map as well.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/mm/mmu.c | 34 ++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >
> > Am I correct in thinking that the purpose of this series is just to
> > placate acpi_os_ioremap() on arm64, and its use of page_is_ram()?
> >
> 
> That is currently the primary user, but we need this information for
> other purposes as well. One example is /dev/mem, which is used for
> both devices and memory (for instance, tools like dmidecode rely
> heavily on it). When using it to access a memory region that we
> punched out of the linear mapping, we should typically not map it as a
> device, since unaligned accesses cause faults in that case.
> 
> In summary, it would be nice if we could preserve the 'is ram"
> annotation for regions that are not covered by the linear mapping.
> 
> > While there aren't many users of page_is_ram() right now, I can see
> > how in the future if new users are added they'd be extremely confused
> > to find that page_is_ram(pfn) returns true but 'pfn' isn't accessible
> > by the kernel proper.
> >
> 
> Well, who knows. page_is_ram() is poorly documented, and so is the
> 'System RAM' iomem annotation that its default implementation relies
> on.

Sorry if this is a bit of a derailment, but perhaps now is a good
opportunity to introduce something like:

#ifndef page_is_linear_mapped
#define page_is_linear_mapped page_is_ram
#endif

With documentation as to the semantic difference, and a conversion of
existing users.

Thanks,
Mark.
