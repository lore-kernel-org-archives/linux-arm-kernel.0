From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Oct 2014 15:57:44 +0200
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141022223845.GE27405@n2100.arm.linux.org.uk>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <20141022223845.GE27405@n2100.arm.linux.org.uk>
Message-ID: <3595731.DoMBPMAkQj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 October 2014 23:38:45 Russell King - ARM Linux wrote:
> On Tue, Oct 21, 2014 at 10:44:12PM -0700, Olof's autobuilder wrote:
> > drivers/scsi/aic7xxx/aic7xxx_core.c:48:37: fatal error: dev/aic7xxx/aic7xxx_osm.h: No such file or directory
> > drivers/scsi/aic7xxx/aic7xxx_93cx6.c:72:37: fatal error: dev/aic7xxx/aic7xxx_osm.h: No such file or directory
> > drivers/scsi/aic7xxx/aic7xxx_pci.c:50:37: fatal error: dev/aic7xxx/aic7xxx_osm.h: No such file or directory
> > drivers/scsi/aic7xxx/aic79xx_core.c:48:37: fatal error: dev/aic7xxx/aic79xx_osm.h: No such file or directory
> > drivers/scsi/aic7xxx/aic79xx_pci.c:48:37: fatal error: dev/aic7xxx/aic79xx_osm.h: No such file or directory
> 
> I have a patch for the aic7xxx stuff to fix it for split builds, but
> whenever I've talked to jejb about it, the response is always negative,
> blaming my build environment as the cause of it because... apparently,
> no one else sees problems.  Maybe it's time to gang up on jejb and
> convince him otherwise?

I think the problem here is

#ifdef __linux__
#include "aic7xxx_osm.h"
#include "aic7xxx_inline.h"
#include "aic7xxx_93cx6.h"
#else
#include <dev/aic7xxx/aic7xxx_osm.h>
#include <dev/aic7xxx/aic7xxx_inline.h>
#include <dev/aic7xxx/aic7xxx_93cx6.h>
#endif

so it should work as long as __linux__ is set. I remember having discussed similar
issues in the past, but don't remember the exact outcome. I would have expected
normal compilers to set __linux__, but we also have hacks in various places
to work around toolchains that don't

$ git grep __linux__
Makefile:CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
arch/arc/Makefile:cflags-y      += -mA7 -fno-common -pipe -fno-builtin -D__linux__
arch/avr32/Makefile:KBUILD_CFLAGS       += -pipe -fno-builtin -mno-pic -D__linux__
arch/hexagon/Makefile:KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -DTHREADINFO_REG=$(TIR_NAME) -D__linux__
arch/mips/include/uapi/asm/sgidefs.h:#ifndef __linux__
arch/openrisc/Makefile:KBUILD_CFLAGS    += -pipe -ffixed-r10 -D__linux__
arch/score/Makefile:    -D__linux__ -ffunction-sections -ffreestanding
arch/xtensa/Makefile:KBUILD_CFLAGS += -ffreestanding -D__linux__
drivers/gpu/drm/radeon/radeon_cp.c:#ifdef __linux__
drivers/gpu/drm/radeon/radeon_cp.c:#ifdef __linux__
drivers/scsi/aic7xxx/aic7770.c:#ifdef __linux__
drivers/scsi/aic7xxx/aic79xx.h:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx.h:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx_core.c:#ifdef __linux__
drivers/scsi/aic7xxx/aic79xx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic79xx_pci.c:#ifdef __linux__
drivers/scsi/aic7xxx/aic7xxx.h:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx.h:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx_93cx6.c:#ifdef __linux__
drivers/scsi/aic7xxx/aic7xxx_core.c:#ifdef __linux__
drivers/scsi/aic7xxx/aic7xxx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx_core.c:#ifndef __linux__
drivers/scsi/aic7xxx/aic7xxx_pci.c:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm.h:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm_gram.y:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.l:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm_scan.l:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c:#ifdef __linux__
drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h:#ifdef __linux__
drivers/scsi/dpt/osd_defs.h:#if (defined(__linux__))
fs/ext4/ext4.h:#if defined(__KERNEL__) || defined(__linux__)
fs/ext4/ext4.h:#endif /* defined(__KERNEL__) || defined(__linux__) */
include/acpi/platform/acenv.h:#if defined(_LINUX) || defined(__linux__)
include/acpi/platform/acenvex.h:#if defined(_LINUX) || defined(__linux__)
include/linux/coda.h:#if defined(__linux__)
include/uapi/drm/drm.h:#if defined(__KERNEL__) || defined(__linux__)
include/uapi/linux/coda.h:#if defined(__linux__)

So five parts of the kernel check for __linux__, all of them are shared
with another OS, or at least used to be: drm, coda, ext4, acpi and aic7xxx.
The check is to determine whether we are building for Linux or not.
Some of them check for __KERNEL__ or __linux__, and we know that __KERNEL__
is always set when building the Linux kernel, and __linux__ is always set
when building Linux user space.

Some architectures evidently have workarounds to define __linux__ even
when building with other compilers.

See also https://bugs.launchpad.net/linaro-android/+bug/868550

> So, size_t is typedef'd as "unsigned int" - and indeed, the compiler thinks
> that size_t is "unsigned int".  But it doesn't seem to like the use of the
> 'z' flag in the printf format string with size_t.
> 
> Any ideas what's going on here?  Does gcc 4.9 stddef.h define size_t
> differently?

This may be a related issue to the first one. Maybe the linux toolchain uses
a different type from the generic toolchain. 

	Arnd
