From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Feb 2015 10:36:53 +0000
Subject: [Linaro-acpi] [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <CAKv+Gu922UwYRN7ZgFNTR7yGGKPLTU8Us7KbvXX-Q8=rqLKNog@mail.gmail.com>
References: <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
 <1423076294.18187.103.camel@deneb.redhat.com>
 <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
 <1423144447.18187.110.camel@deneb.redhat.com>
 <54D39D6B.5090304@linaro.org>
 <20150205174826.GD21970@e104818-lin.cambridge.arm.com>
 <CAKv+Gu922UwYRN7ZgFNTR7yGGKPLTU8Us7KbvXX-Q8=rqLKNog@mail.gmail.com>
Message-ID: <20150206103653.GA23190@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 10:16:03PM +0000, Ard Biesheuvel wrote:
> On 5 February 2015 at 17:48, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Feb 05, 2015 at 04:42:19PM +0000, Al Stone wrote:
> >> On 02/05/2015 06:54 AM, Mark Salter wrote:
> >> > On Thu, 2015-02-05 at 10:41 +0000, Catalin Marinas wrote:
> >> >> On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
> >> >>> On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
> >> >>>> On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
> >> >>>>> acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> >> >>>>> which are already included in the kernel's linear RAM mapping. So we
> >> >>>>> need ioremap_cache to avoid two mappings to the same physical page
> >> >>>>> having different caching attributes.
> >> >>>>
> >> >>>> What's the call path to acpi_os_ioremap() on such tables already in the
> >> >>>> linear mapping? I can see an acpi_map() function which already takes
> >> >>>> care of the RAM mapping case but there are other cases where
> >> >>>> acpi_os_ioremap() is called directly. For example,
> >> >>>> acpi_os_read_memory(), can it be called on both RAM and I/O?
> >> >>>
> >> >>> acpi_map() is the one I've seen.
> >> >>
> >> >> By default, if should_use_kmap() is not patched for arm64, it translates
> >> >> to page_is_ram(); acpi_map() would simply use a kmap() which returns the
> >> >> current kernel linear mapping on arm64.
> >> >
> >> > The problem with kmap() is that it only maps a single page. I've seen
> >> > tables over 4k which is why I patched acpi_map() not to use kmap() on
> >> > arm64.
> >>
> >> Right.  Mark replied to this before I could; using kmap() enforced a 4k
> >> (one page) limit that we kept breaking with some ACPI tables being larger
> >> than that (DSDTs and SSDTs, fwiw).  This would lead to some very odd behaviors
> >> when most but not all of a device definition was within the page; using the
> >> table checksums was one way of detecting the issues.
> >
> > OK. So I think Mark's original patch was ok, assuming that the System
> > Memory cases mentioned by Graeme are detected with page_is_ram().
> 
> page_is_ram() returns whether a pfn is covered by the linear mapping,
> so memory before the kernel or after a mem= limit will be
> misidentified.

OK. So in conclusion acpi_os_ioremap() may need to create a cacheable
mapping even when !page_is_ram() but it has no way of knowing that
unless we change the core ACPI code to differentiate between
ioremap_cache and ioremap_nocache. Did I get it right?

-- 
Catalin
