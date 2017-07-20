From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jul 2017 16:24:37 +0100
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <1500563640.26680.12.camel@pengutronix.de>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
 <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
 <D24E577EA1E37B4788A3BFBC418F14A70759249B@wetsrvex01.loepfe.com>
 <20170720141528.kxrw5r4hpa2hebvd@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
 <1500563640.26680.12.camel@pengutronix.de>
Message-ID: <20170720152437.GC31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 05:14:00PM +0200, Lucas Stach wrote:
> Am Donnerstag, den 20.07.2017, 15:06 +0000 schrieb Vellemans, Noel:
> > Hi  , 
> [...]
> > 
> > ====BEGIN- Test-code=======================================================================================
> > 
> > #include <stdio.h>
> > #include<stdlib.h>
> > #include<string.h>
> > #include<unistd.h>
> > #include<fcntl.h>
> > #include <time.h>
> > #include <sys/times.h>
> > 
> > 
> > 
> > #define MS_TICKTIME2 ({\
> > 				struct timespec tp;\
> > 				clock_gettime(4, &tp);\
> > 				(unsigned long)tp.tv_sec*1000+tp.tv_nsec/1000000;})
> 
> clock_gettime is one of the things which get optimized into "not a
> syscall at all" if your kernel provides a VDSO. Are you sure your new
> kernel configuration has CONFIG_VDSO enabled?

It won't be on imx53 - you need something way more modern (with an
architected timer).

As "getting time" is one of the most used syscalls, I wanted older
systems to be unaffected by VDSO, and pushed for the VDSO to be
omitted unless we had an architected timer.  If you look at
patch_vdso() in arch/arm/kernel/signal.c, we disable
__vdso_gettimeofday and __vdso_clock_gettime if we have no
architected timer or the architected timer is not functional.

PS, am I talking to your sales department?  Your message had a
Reply-to set...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
