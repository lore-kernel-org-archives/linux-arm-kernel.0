From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Oct 2014 23:38:45 +0100
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <5447442c.a9ca440a.2060.5e09@mx.google.com>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
Message-ID: <20141022223845.GE27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 10:44:12PM -0700, Olof's autobuilder wrote:
> drivers/scsi/aic7xxx/aic7xxx_core.c:48:37: fatal error: dev/aic7xxx/aic7xxx_osm.h: No such file or directory
> drivers/scsi/aic7xxx/aic7xxx_93cx6.c:72:37: fatal error: dev/aic7xxx/aic7xxx_osm.h: No such file or directory
> drivers/scsi/aic7xxx/aic7xxx_pci.c:50:37: fatal error: dev/aic7xxx/aic7xxx_osm.h: No such file or directory
> drivers/scsi/aic7xxx/aic79xx_core.c:48:37: fatal error: dev/aic7xxx/aic79xx_osm.h: No such file or directory
> drivers/scsi/aic7xxx/aic79xx_pci.c:48:37: fatal error: dev/aic7xxx/aic79xx_osm.h: No such file or directory

I have a patch for the aic7xxx stuff to fix it for split builds, but
whenever I've talked to jejb about it, the response is always negative,
blaming my build environment as the cause of it because... apparently,
no one else sees problems.  Maybe it's time to gang up on jejb and
convince him otherwise?

>       3 arch/arm/common/dmabounce.c:318:2: warning: format '%zx' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]
>       3 arch/arm/common/dmabounce.c:369:2: warning: format '%zx' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]
>       3 arch/arm/common/dmabounce.c:409:2: warning: format '%zx' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]

I really can't fathom these warnings.  From what I can tell, in userspace,
size_t is typedef'd from the __SIZE_TYPE__ preprocessor definition, which
is provided by the compiler.  As Olof has already found out, with his gcc
4.9, __SIZE_TYPE__ is 'unsigned int'.

What I see in my latest compiler's provided stddef.h (from ubuntu 14.04.1's
gcc 4.8) is:

typedef __SIZE_TYPE__ size_t;

and sure enough:

$ echo '#include <stddef.h>' | gcc -E -xc -o - -

gives:

typedef unsigned int size_t;

In the kernel we have for ARM:

include/uapi/asm-generic/posix-types.h:typedef unsigned int    __kernel_size_t;
include/linux/types.h:typedef __kernel_size_t         size_t;

So, size_t is typedef'd as "unsigned int" - and indeed, the compiler thinks
that size_t is "unsigned int".  But it doesn't seem to like the use of the
'z' flag in the printf format string with size_t.

Any ideas what's going on here?  Does gcc 4.9 stddef.h define size_t
differently?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
