From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 05 Feb 2015 02:24:24 +0100
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <1422984576.18187.82.camel@deneb.redhat.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
Message-ID: <24983147.QcR5BoZPKE@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 03, 2015 12:29:36 PM Mark Salter wrote:
> On Mon, 2015-02-02 at 23:14 +0100, Rafael J. Wysocki wrote:
> > On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> > > From: Mark Salter <msalter@redhat.com>
> > > 
> > > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > > regions. The current implementation simply uses ioremap_cache(). This
> > > will work for some architectures, but arm64 ioremap_cache() cannot be
> > > used to map IO regions which don't support caching. So for arm64, use
> > > ioremap() for non-RAM regions.
> > > 
> > > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > ---
> > >  include/acpi/acpi_io.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > > index 444671e..9d573db 100644
> > > --- a/include/acpi/acpi_io.h
> > > +++ b/include/acpi/acpi_io.h
> > > @@ -1,11 +1,17 @@
> > >  #ifndef _ACPI_IO_H_
> > >  #define _ACPI_IO_H_
> > >  
> > > +#include <linux/mm.h>
> > >  #include <linux/io.h>
> > >  
> > >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > >  					    acpi_size size)
> > >  {
> > > +#ifdef CONFIG_ARM64
> > > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > > +		return ioremap(phys, size);
> > > +#endif
> > 
> > I don't want to see #ifdef CONFIG_ARM64 in this file.
> > 
> 
> How about something like:
> 
> From: Mark Salter <msalter@redhat.com>
> Date: Tue, 3 Feb 2015 10:51:16 -0500
> Subject: [PATCH] acpi: fix acpi_os_ioremap for arm64
> 
> The acpi_os_ioremap() function may be used to map normal RAM or IO
> regions. The current implementation simply uses ioremap_cache(). This
> will work for some architectures, but arm64 ioremap_cache() cannot be
> used to map IO regions which don't support caching. So for arm64, use
> ioremap() for non-RAM regions.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/arm64/include/asm/acpi.h | 14 ++++++++++++++
>  include/acpi/acpi_io.h        |  3 +++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index ea4d2b3..db82bc3 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/irqchip/arm-gic-acpi.h>
>  
> +#include <linux/mm.h>
>  #include <asm/smp_plat.h>
>  
>  /* Basic configuration for ACPI */
> @@ -100,4 +101,17 @@ static inline bool acpi_psci_use_hvc(void) { return false; }
>  static inline void acpi_init_cpus(void) { }
>  #endif /* CONFIG_ACPI */
>  
> +/*
> + * ACPI table mapping
> + */
> +static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> +					    acpi_size size)
> +{
> +	if (!page_is_ram(phys >> PAGE_SHIFT))
> +		return ioremap(phys, size);
> +
> +       return ioremap_cache(phys, size);
> +}
> +#define acpi_os_ioremap acpi_os_ioremap

Actually, I see that we use similar #defines in other places too, so the
patch is fine by me as is (modulo the other concerns that people seem to
have about this).

> +
>  #endif /*_ASM_ACPI_H*/
> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> index 444671e..48f504a 100644
> --- a/include/acpi/acpi_io.h
> +++ b/include/acpi/acpi_io.h
> @@ -2,12 +2,15 @@
>  #define _ACPI_IO_H_
>  
>  #include <linux/io.h>
> +#include <asm/acpi.h>
>  
> +#ifndef acpi_os_ioremap
>  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>  					    acpi_size size)
>  {
>         return ioremap_cache(phys, size);
>  }
> +#endif
>  
>  void __iomem *__init_refok
>  acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
