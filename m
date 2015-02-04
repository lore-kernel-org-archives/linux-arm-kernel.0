From: msalter@redhat.com (Mark Salter)
Date: Wed, 04 Feb 2015 13:58:14 -0500
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <20150204175734.GI26006@e104818-lin.cambridge.arm.com>
Message-ID: <1423076294.18187.103.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
> On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
> > On Wed, 2015-02-04 at 11:25 +0000, Catalin Marinas wrote:
> > > On Tue, Feb 03, 2015 at 05:29:36PM +0000, Mark Salter wrote:
> > > > On Mon, 2015-02-02 at 23:14 +0100, Rafael J. Wysocki wrote:
> > > > > On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> > > > > > From: Mark Salter <msalter@redhat.com>
> > > > > > 
> > > > > > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > > > > > regions. The current implementation simply uses ioremap_cache(). This
> > > > > > will work for some architectures, but arm64 ioremap_cache() cannot be
> > > > > > used to map IO regions which don't support caching. So for arm64, use
> > > > > > ioremap() for non-RAM regions.
> > > > > > 
> > > > > > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > > > > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > > > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > > > > ---
> > > > > >  include/acpi/acpi_io.h | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > > 
> > > > > > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > > > > > index 444671e..9d573db 100644
> > > > > > --- a/include/acpi/acpi_io.h
> > > > > > +++ b/include/acpi/acpi_io.h
> > > > > > @@ -1,11 +1,17 @@
> > > > > >  #ifndef _ACPI_IO_H_
> > > > > >  #define _ACPI_IO_H_
> > > > > >  
> > > > > > +#include <linux/mm.h>
> > > > > >  #include <linux/io.h>
> > > > > >  
> > > > > >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > > > > >  					    acpi_size size)
> > > > > >  {
> > > > > > +#ifdef CONFIG_ARM64
> > > > > > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > > > > > +		return ioremap(phys, size);
> > > > > > +#endif
> > > > > 
> > > > > I don't want to see #ifdef CONFIG_ARM64 in this file.
> > > > 
> > > > How about something like:
> > > > 
> > > > From: Mark Salter <msalter@redhat.com>
> > > > Date: Tue, 3 Feb 2015 10:51:16 -0500
> > > > Subject: [PATCH] acpi: fix acpi_os_ioremap for arm64
> > > > 
> > > > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > > > regions. The current implementation simply uses ioremap_cache(). This
> > > > will work for some architectures, but arm64 ioremap_cache() cannot be
> > > > used to map IO regions which don't support caching. So for arm64, use
> > > > ioremap() for non-RAM regions.
> > > > 
> > > > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > > ---
> > > >  arch/arm64/include/asm/acpi.h | 14 ++++++++++++++
> > > >  include/acpi/acpi_io.h        |  3 +++
> > > >  2 files changed, 17 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > > > index ea4d2b3..db82bc3 100644
> > > > --- a/arch/arm64/include/asm/acpi.h
> > > > +++ b/arch/arm64/include/asm/acpi.h
> > > > @@ -14,6 +14,7 @@
> > > >  
> > > >  #include <linux/irqchip/arm-gic-acpi.h>
> > > >  
> > > > +#include <linux/mm.h>
> > > >  #include <asm/smp_plat.h>
> > > >  
> > > >  /* Basic configuration for ACPI */
> > > > @@ -100,4 +101,17 @@ static inline bool acpi_psci_use_hvc(void) { return false; }
> > > >  static inline void acpi_init_cpus(void) { }
> > > >  #endif /* CONFIG_ACPI */
> > > >  
> > > > +/*
> > > > + * ACPI table mapping
> > > > + */
> > > > +static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > > > +					    acpi_size size)
> > > > +{
> > > > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > > > +		return ioremap(phys, size);
> > > > +
> > > > +       return ioremap_cache(phys, size);
> > > > +}
> > > > +#define acpi_os_ioremap acpi_os_ioremap
> > > 
> > > That's one way of doing this, I'm not too bothered with the approach
> > > (define the function name, an ARCH_HAS macro or a Kconfig option, it's
> > > up to Rafael).
> > > 
> > > But a question I already asked is what we need ioremap_cache() for? We
> > > don't use NVS on arm64 yet, so is there anything else requiring
> > > cacheable mapping?
> > 
> > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> > which are already included in the kernel's linear RAM mapping. So we
> > need ioremap_cache to avoid two mappings to the same physical page
> > having different caching attributes.
> 
> What's the call path to acpi_os_ioremap() on such tables already in the
> linear mapping? I can see an acpi_map() function which already takes
> care of the RAM mapping case but there are other cases where
> acpi_os_ioremap() is called directly. For example,
> acpi_os_read_memory(), can it be called on both RAM and I/O?
> 

acpi_map() is the one I've seen. I'm not sure about others.
