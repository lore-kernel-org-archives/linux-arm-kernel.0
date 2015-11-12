From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Nov 2015 16:13:09 +0000
Subject: [PATCH 0/3] remove UEFI reserved regions from the linear mapping
In-Reply-To: <CAKv+Gu8Rd3T_2mjMkx0VZQ052mFjxufGB-U7_EuivvR+5M64cw@mail.gmail.com>
References: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151112155523.GD26564@leverpostej>
 <CAKv+Gu8Rd3T_2mjMkx0VZQ052mFjxufGB-U7_EuivvR+5M64cw@mail.gmail.com>
Message-ID: <20151112161309.GF26564@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 05:01:19PM +0100, Ard Biesheuvel wrote:
> On 12 November 2015 at 16:55, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Oct 29, 2015 at 02:40:56PM +0100, Ard Biesheuvel wrote:
> >> This is yet another approach to solving the issues around removing RAM
> >> regions known to UEFI from the linear mapping while preserving the record
> >> of the fact that these regions are backed by memory.
> >>
> >> The previous approach added a memblock flag called MEMBLOCK_NOMAP to keep
> >> track of RAM regions that should be removed from the linear mapping.
> >>
> >> The primary motivation for the new approach is the observation that there
> >> is only a single use case that requires this, which is acpi_os_ioremap().
> >> Since ACPI implies UEFI on arm64 platforms, and since acpi_os_ioremap()
> >> uses page_is_ram() internally (which is a __weak generic function), we
> >> can simply reimplement page_is_ram() to take the UEFI memory map into
> >> account if we are booted via UEFI.
> >
> > Just to check, is the above the only reason for this new approach? Or
> > were there other issues with the MEMBLOCK_NOMAP approach other than the
> > diffstat?
> >
> > I quite liked the MEMBLOCK_NOMAP approach as it looked reusable.
> >
> 
> I think the MEMBLOCK_NOMAP approach is sound, but it is harder to
> prove that there are no corner cases that behave incorrectly.

Ok.

> > I take it there aren't any lurking instances of page_is_ram() used to
> > test if something exists in the linear mapping?
> >
> 
> Well, first of all, the linear mapping only covers lowmem, so that in
> itself would not be a portable use. In general, pfn_valid() would be
> the correct test for that (possibly combined with PageHighmem())

Good point, I hadn't considered that.

> page_is_ram() and the 'System RAM' iomem region are so poorly defined
> or documented that we may be better off just removing it in the first
> place and replace it with something meaningful.

I'd be very much in favour of tightening up and/or replacing
page_is_ram with something well-defined.

I believe that some userspace depends on the 'System RAM' info (e.g. I
think kexec tools parse that to decide a good location for the next
kernel), but I would expect that users want to know about _usable_ RAM
rather than anything that happens to be physical RAM.

> >> Patch #1 slightly reorders the UEFI runtime services initialization routines
> >> so that the EFI_MEMMAP flag is only set if the permanent mapping of the UEFI
> >> memory map is in place.
> >
> > This also means that the memory map is mapped even with EFI runtime
> > support disabled, but I guess that's not a big problem.
> >
> 
> Yes. You need that anyway if you are going to rely on it even when the
> runtime services are disabled.

Not with the MEMBLOCK_NOMAP approach.

I don't have a strong case for caring about that; I only imagine that
being a problem if you're trying to track down extremely nasty memory
corruption / bad pointer bugs and want the bare minimum VA space mapped.
Even then the impact is minimal.

> > As a side thought, it would be nice if we could memremap_ro the system
> > table and memory map in future to prevent potential corruption, given
> > they have fixed VAs and are always mapped.
> >
> 
> I agree, and I already have some local patches using
> early_memremap_ro() for the EFI init code.

Ah, nice!

> memremap_ro() does not actually exist yet, but I intend to propose
> MEMREMAP_RO and MEMREMAP_NX flags to Dan Williams's memremap() work
> once I get around to it.

That sounds good; I would certainly be in favour of that.

For some reason I thought the memremap arch changes had gone in for
v4.3, but I see that's not the case. I'll take a look around.

Thanks,
Mark.
