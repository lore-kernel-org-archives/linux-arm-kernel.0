From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 13 Oct 2010 16:13:27 +0200
Subject: [BUG] 2.6.36-rc6 on kirkwood breaks gcc precompiled-headers
In-Reply-To: <19636.8353.699455.193582@pilspetsen.it.uu.se>
References: <19636.8353.699455.193582@pilspetsen.it.uu.se>
Message-ID: <19637.48775.443015.466238@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson writes:
 > I've entered <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=45979>
 > in gcc bugzilla, which is about gcc precompiled-headers tests
 > failing with the 2.6.36-rc6 kernel, but working with 2.6.35 and
 > older kernels.  gcc trunk and 4.4 release branch are affected,
 > haven't bothered checking 4.5.
 > 
 > I'm starting a kernel bisection to try to identify the cause of
 > this regression.  For now all I can say is that
 > 
 > - 2.6.36-rc6 on kirkwood (ts119) causes the breakage
 > - 2.6.35 and earlier are Ok on kirkwood and iop32x (n2100)
 > 
 > I haven't seen these gcc test failures with 2.6.36-rc kernels on
 > {x86,sparc64,ppc64,alpha}, so it looks ARM or kirkwood specific.

It was generic ARM breakage caused by Nicolas Pitre's mmap() randomization
patch:

 > From: Nicolas Pitre <nico@fluxnic.net>
 > Date: Tue, 15 Jun 2010 01:16:19 +0000 (-0400)
 > Subject: [ARM] add address randomization to mmap()
 > X-Git-Tag: v2.6.36-rc1~591^2^2~6^2~2
 > X-Git-Url: http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git;a=commitdiff_plain;h=cc92c28b2db5b406657ecc05235d4ca4e222ae34
 > 
 > [ARM] add address randomization to mmap()
 > 
 > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
 > ---
 > 
 > diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
 > index f5abc51..4f5b396 100644
 > --- a/arch/arm/mm/mmap.c
 > +++ b/arch/arm/mm/mmap.c
 > @@ -7,6 +7,7 @@
 >  #include <linux/shm.h>
 >  #include <linux/sched.h>
 >  #include <linux/io.h>
 > +#include <linux/random.h>
 >  #include <asm/cputype.h>
 >  #include <asm/system.h>
 >  
 > @@ -80,6 +81,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 >                 start_addr = addr = TASK_UNMAPPED_BASE;
 >                 mm->cached_hole_size = 0;
 >         }
 > +       /* 8 bits of randomness in 20 address space bits */
 > +       if (current->flags & PF_RANDOMIZE)
 > +               addr += (get_random_int() % (1 << 8)) << PAGE_SHIFT;
 >  
 >  full_search:
 >         if (do_align)

I've added a patch to <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=45979>
which seems to work around the problem in gcc.  People with unpatched gccs
may want to disable vm randomization via /proc/sys/kernel/randomize_va_space.

/Mikael
