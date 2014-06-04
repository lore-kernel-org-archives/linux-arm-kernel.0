From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jun 2014 13:51:37 +0100
Subject: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
In-Reply-To: <3061297.feg5DGUjIt@vostro.rjw.lan>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-2-git-send-email-lee.jones@linaro.org>
 <3061297.feg5DGUjIt@vostro.rjw.lan>
Message-ID: <20140604125137.GA18171@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:

> On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
> > Any drivers which support ACPI and Device Tree probing need to include
> > both respective header files.  Without this patch, if a driver is being
> > used on a platform which does not support ACPI and subsequently does not
> > have the config option enabled, but includes linux/acpi.h the build
> > breaks with:
> > 
> >   In file included from ../include/acpi/platform/acenv.h:150:0,
> >                    from ../include/acpi/acpi.h:56,
> >                    from ../include/linux/match.h:2,
> >                    from ../drivers/i2c/i2c-core.c:43:
> >   ../include/acpi/platform/aclinux.h:73:23:
> >    fatal error: asm/acenv.h: No such file or directory
> >    #include <asm/acenv.h>
> >                        ^
> 
> Which kernel does this happen with?

a0a962d (tag: refs/tags/next-20140602, refs/remotes/next/master)
  Add linux-next specific files for 20140602

> > Cc: Lv Zheng <lv.zheng@intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: linux-acpi at vger.kernel.org
> > Cc: devel at acpica.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  include/acpi/platform/aclinux.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> > index cd1f052..fdf7663 100644
> > --- a/include/acpi/platform/aclinux.h
> > +++ b/include/acpi/platform/aclinux.h
> > @@ -70,9 +70,10 @@
> >  #ifdef EXPORT_ACPI_INTERFACES
> >  #include <linux/export.h>
> >  #endif
> > -#include <asm/acenv.h>
> >  
> > -#ifndef CONFIG_ACPI
> > +#ifdef CONFIG_ACPI
> > +#include <asm/acenv.h>
> > +#else
> >  
> >  /* External globals for __KERNEL__, stubs is needed */
> >  
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
