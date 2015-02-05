From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Feb 2015 12:07:20 +0000
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150205111443.GC24474@xora-haswell.xora.org.uk>
References: <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
 <1423076294.18187.103.camel@deneb.redhat.com>
 <20150205104149.GA18158@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-tqY4C0eaRvp5FAzx9PqOGMg+sFNzxr2f25omdJKr7JA@mail.gmail.com>
 <20150205105945.GC18158@e104818-lin.cambridge.arm.com>
 <20150205111443.GC24474@xora-haswell.xora.org.uk>
Message-ID: <20150205120720.GD18158@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 11:14:43AM +0000, Graeme Gregory wrote:
> On Thu, Feb 05, 2015 at 10:59:45AM +0000, Catalin Marinas wrote:
> > On Thu, Feb 05, 2015 at 10:47:23AM +0000, Ard Biesheuvel wrote:
> > > On 5 February 2015 at 10:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
> > > >> On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
> > > >> > On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
> > > >> > > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> > > >> > > which are already included in the kernel's linear RAM mapping. So we
> > > >> > > need ioremap_cache to avoid two mappings to the same physical page
> > > >> > > having different caching attributes.
> > > >> >
> > > >> > What's the call path to acpi_os_ioremap() on such tables already in the
> > > >> > linear mapping? I can see an acpi_map() function which already takes
> > > >> > care of the RAM mapping case but there are other cases where
> > > >> > acpi_os_ioremap() is called directly. For example,
> > > >> > acpi_os_read_memory(), can it be called on both RAM and I/O?
> > > >>
> > > >> acpi_map() is the one I've seen.
> > > >
> > > > By default, if should_use_kmap() is not patched for arm64, it translates
> > > > to page_is_ram(); acpi_map() would simply use a kmap() which returns the
> > > > current kernel linear mapping on arm64.
> > > >
> > > >> I'm not sure about others.
> > > >
> > > > Question for the ARM ACPI guys: what happens if you implement
> > > > acpi_os_ioremap() on arm64 as just ioremap()? Do you get any WARN_ON()
> > > > (__ioremap_caller() checks whether the memory is RAM)?
> > > 
> > > Regardless of whether you hit any WARN_ON()s now,
> > 
> > Actually following the WARN_ON(), ioremap() returns NULL, so it may not
> > go entirely unnoticed.
> > 
> > > we still need to distinguish between MMIO ranges with device
> > > semantics, and ACPI or other tables whose data may not be naturally
> > > aligned all the time, and hence requiring memory semantics.
> > > acpi_os_ioremap() may be used for both, afaik
> > 
> > Is acpi_os_ioremap() called directly (outside acpi_map()) to map RAM
> > that already part of the kernel linear memory? If yes, then I agree that
> > we need to do such check.
> > 
> > Another question, can we distinguish, in the ACPI core code, whether the
> > mapping is for an ACPI table in RAM or some I/O space?
> 
> Yes I think we do,
> 
> acpi_os_map_memory() is called to map tables
> 
> acpi_os_map_iomem() is called to map device IO
> 
> currently both end up in acpi_map but I guess they do not have to or
> we can add extra arguments as its an internal API.

Ending up in acpi_map() is ok as this function checks whether it should
use kmap() or acpi_os_ioremap().

> But I have not checked that no user sneaks in direct calls.

Grep'ing for acpi_os_ioremap():

suspend_nvs_save() - we don't care about this yet for arm64 as the
function is only compiled in if CONFIG_ACPI_SLEEP

acpi_os_read_memory() and acpi_os_write_memory() - do you know what kind
of memory are these used on?

couple of intel drm files that are not used on arm.

-- 
Catalin
