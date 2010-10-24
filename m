From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Sun, 24 Oct 2010 23:43:38 +0200
Subject: cmpxchg() in recent kernels
In-Reply-To: <AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
Message-ID: <20101024214338.GB878@boggieman.bredbandsbolaget.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 03:26:34PM +1100, Aras Vaichas wrote:
> On 9 October 2010 20:32, Alex Sverdlin <alex@gai.ru> wrote:
> >
> > Hello!
> >
> > I've probably missed something, but how to compile recent kernels on ARM?
> > I've been using GCC 3.4.3 from Cirrus for my EP9302 boards up to 2.6.35.4
> > But 2.6.36-rc and upper won't compile anymore.
> > The problem is appearing in multiplatform code of cmpxchg() function.
> > First in kernel/pid.c (2.6.36-rc4 - 2.6.36-rc6)
> > Then 4 times in 2.6.36-rc7-next... atomic_cmpxchg compiles fine, and when I
> > replace cmpxhg with atomic_ version, everything compiles fine.
> >
> > Here is output of make from 2.6.36-rc7-next:
> > ...
> > ?CHK ? ? include/generated/compile.h
> > ?UPD ? ? include/generated/compile.h
> > ?CC ? ? ?init/version.o
> > ?LD ? ? ?init/built-in.o
> > ?LD ? ? ?vmlinux
> > kernel/built-in.o: In function `alloc_pid':
> > elfcore.c:(.text+0x1c258): undefined reference to `wrong_size_cmpxchg'
> > net/built-in.o: In function `rt_bind_peer':
> > sysctl_net.c:(.text+0x3bb38): undefined reference to `wrong_size_cmpxchg'
> > net/built-in.o: In function `inet_add_protocol':
> > sysctl_net.c:(.text+0x3f4dc): undefined reference to `wrong_size_cmpxchg'
> > net/built-in.o: In function `inet_del_protocol':
> > sysctl_net.c:(.text+0x3f5a8): undefined reference to `wrong_size_cmpxchg'
> > net/built-in.o: In function `build_ehash_secret':
> > sysctl_net.c:(.text+0x6a034): undefined reference to `wrong_size_cmpxchg'
> > make[1]: *** [vmlinux] Error 1
> > ...
> 
> Sorry, no answer, but I can confirm that I am having the same problem as well.
> ARM AT91RM9200, 2.6.33.7 + at91 + rt
> 
> kernel/built-in.o: In function `__tasklet_hi_schedule':
> utsname_sysctl.c:(.text+0xca1c): undefined reference to `wrong_size_cmpxchg'
> kernel/built-in.o: In function `__tasklet_schedule':
> utsname_sysctl.c:(.text+0xcb7c): undefined reference to `wrong_size_cmpxchg'
> kernel/built-in.o: In function `__tasklet_action':
> utsname_sysctl.c:(.text+0xce4c): undefined reference to `wrong_size_cmpxchg'
> kernel/built-in.o: In function `sched_init_smp':
> utsname_sysctl.c:(.init.text+0xec): undefined reference to `____ilog2_NaN'
> make: *** [.tmp_vmlinux1] Error 1
> 
> also
> 
> kernel/built-in.o: In function `__tasklet_hi_schedule':
> slow-work.c:(.text+0xc86c): undefined reference to `wrong_size_cmpxchg'
> kernel/built-in.o: In function `__tasklet_schedule':
> slow-work.c:(.text+0xc9cc): undefined reference to `wrong_size_cmpxchg'
> kernel/built-in.o: In function `__tasklet_action':
> slow-work.c:(.text+0xcc9c): undefined reference to `wrong_size_cmpxchg'
> kernel/built-in.o: In function `sched_init_smp':
> slow-work.c:(.init.text+0xec): undefined reference to `____ilog2_NaN'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Aras

Im seeing something similiar, using GCC 3.4.5
ARM HP Jornada 720, 2.6.36

  GZIP    kernel/config_data.gz
  IKCFG   kernel/config_data.h
  CC      kernel/configs.o
  LD      kernel/built-in.o
  LD      drivers/pcmcia/built-in.o
  LD      drivers/built-in.o
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x1d038): In function `alloc_pid':
include/asm-generic/cmpxchg-local.h:42: undefined reference to `wrong_size_cmpxchg'
make: *** [.tmp_vmlinux1] Error 1

Kristoffer

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
