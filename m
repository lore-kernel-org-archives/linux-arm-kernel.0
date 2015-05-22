From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 May 2015 11:34:17 +0100
Subject: [PATCH] arm64: support ACPI tables outside of kernel RAM
In-Reply-To: <CAKv+Gu8wXrCnnDEw2gpJ9e1qixkVvBCsUf0wLorsdLJwknZELA@mail.gmail.com>
References: <1431613373-10928-1-git-send-email-msalter@redhat.com>
 <20150518111143.GC21251@e104818-lin.cambridge.arm.com>
 <1431957525.9933.4.camel@deneb.redhat.com>
 <20150518164108.GH21251@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8wXrCnnDEw2gpJ9e1qixkVvBCsUf0wLorsdLJwknZELA@mail.gmail.com>
Message-ID: <20150522103417.GT29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 06:49:28PM +0200, Ard Biesheuvel wrote:
> On 18 May 2015 at 18:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, May 18, 2015 at 09:58:45AM -0400, Mark Salter wrote:
> >> On Mon, 2015-05-18 at 12:11 +0100, Catalin Marinas wrote:
> >> > On Thu, May 14, 2015 at 10:22:53AM -0400, Mark Salter wrote:
> >> > > There is no guarantee that ACPI tables will be located in RAM linearly
> >> > > mapped by the kernel. This could be because UEFI placed them below the
> >> > > kernel image or because mem= places them beyond the reach of the linear
> >> > > kernel mapping. Even though these tables are outside the linear mapped
> >> > > RAM, they still need to be accessed as normal memory in order to support
> >> > > unaligned accesses from ACPI code. In this case, the page_is_ram() test
> >> > > in acpi_os_ioremap() is not sufficient.
> >> >
> >> > And can we not simply add the rest of the RAM to the resource list as
> >> > "System RAM" without being part of memblock?
> >>
> >> If it is in "System RAM", then it needs a valid pfn and struct page.
> >> Parts of the kernel expect that (page_is_ram(), memory hotplug, etc).
> >
> > OK, I had the impression that we could get away with this.
> >
> >> > > Additionally, if the table spans multiple pages, it may fall partially
> >> > > within the linear map and partially without. If the table overlaps the
> >> > > end of the linear map, the test for whether or not to use the existing
> >> > > mapping in ioremap_cache() could lead to a panic when ACPI code tries
> >> > > to access the part beyond the end of the linear map. This patch
> >> > > attempts to address these problems.
> >> >
> >> > That's a problem with ioremap_cache() that should be fixed independently.
> >>
> >> I can submit that separately if you prefer.
> >
> > Yes, please.
> >
> >> > Ideally, I'd like to see the ACPI code use different APIs to distinguish
> >> > between table access in RAM and device access, so that we don't have to
> >> > guess whether the page is RAM or not.
> >>
> >> I don't think the ACPI code has enough info to make that decision, but
> >> I'm not sure honestly.
> >
> > Do we have a guarantee that UEFI tells the kernel about the whole RAM?
> 
> Yes, the UEFI memory map must describe all of RAM, no matter how it is
> used. I may also describe some MMIO regions, but typically only
> regions that it needs itself to implement the UEFI Runtime Services
> (e.g., RTC base address, NOR flash for the variable store)
> 
> So we could potentially query the UEFI memory map directly to find out
> whether some otherwise unqualified region is backed by RAM or not,
> although I'd prefer some intermediate data structure (such as the
> physmem memblock table) if we go that route.

OK, so my preferred options, in this order:

1. Change the core ACPI kernel code to distinguish between mapping I/O
   or RAM (could be as simple as acpi_map not using acpi_os_ioremap but
   another API). I guess the code knows when it plans to map tables or
   I/O registers

2. If the above is not possible, add the extra checks as per Mark's
   patch but I would rather call this resource "UEFI RAM" than "ACPI",
   it's not really ACPI specific.

-- 
Catalin
