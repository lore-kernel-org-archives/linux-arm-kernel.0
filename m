From: msalter@redhat.com (Mark Salter)
Date: Fri, 15 May 2015 09:58:04 -0400
Subject: [PATCH] arm64: support ACPI tables outside of kernel RAM
In-Reply-To: <CAKv+Gu8nEs9e2XMJJooZMNbHysOxmzb25JZqr=COH9TW9OJTpA@mail.gmail.com>
References: <1431613373-10928-1-git-send-email-msalter@redhat.com>
 <CAKv+Gu8nEs9e2XMJJooZMNbHysOxmzb25JZqr=COH9TW9OJTpA@mail.gmail.com>
Message-ID: <1431698284.21896.25.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 16:50 +0200, Ard Biesheuvel wrote:
> On 14 May 2015 at 16:22, Mark Salter <msalter@redhat.com> wrote:
> > There is no guarantee that ACPI tables will be located in RAM linearly
> > mapped by the kernel. This could be because UEFI placed them below the
> > kernel image or because mem= places them beyond the reach of the linear
> > kernel mapping. Even though these tables are outside the linear mapped
> > RAM, they still need to be accessed as normal memory in order to support
> > unaligned accesses from ACPI code. In this case, the page_is_ram() test
> > in acpi_os_ioremap() is not sufficient. Additionally, if the table spans
> > multiple pages, it may fall partially within the linear map and partially
> > without. If the table overlaps the end of the linear map, the test for
> > whether or not to use the existing mapping in ioremap_cache() could lead
> > to a panic when ACPI code tries to access the part beyond the end of the
> > linear map. This patch attempts to address these problems.
> >
> 
> I would strongly prefer memblock_remove()'ing all UEFI reserved
> regions entirely, and keeping track of which areas are backed my RAM
> using a table rather than string matching on the iomem resource table.

Why? It isn't a performance issue is it? ACPI caches mappings and out of
the two systems I checked, one called acpi_os_ioremap() 11 times, and
the other only once.

> When I looked into this a while ago [1], I ended up with a separate
> physmem memblock table (borrowed from another arch) that tracks the
> regions which are memory while removing all the EFI reserved region
> from the 'memory' memblock table. That way, page_is_ram() could be
> reimplemented as memblock_is_physmem(), and ioremap_cache() would
> always do the right thing automagically.
> 
> I kind of held off with this series until the ACPI stuff had landed,
> which is obviously the case now. Would you mind having a look at these
> patches and sharing your opinion?
> [1] http://thread.gmane.org/gmane.linux.kernel.efi/5133
> 

Thanks for reminding me of this. I went back and took a look. Using
memblock physmem would simplify this patch but the problem I see is
that physmem only has 4 regions. I don't think that would be enough,
so how many is enough?

Right now, I'd like to fix the real problem of mem= breaking ACPI
boots ASAP. Some more thought needs to go into using memblock physmem
and if it does turn out to be better or needed for other things like
removing reserved regions from memory, then that patch can clean up
the use of the iomem table.
