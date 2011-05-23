From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 May 2011 17:34:33 +0100
Subject: [PATCH] ARM: fix missing 'cpu_relax()' declaration
In-Reply-To: <20110523162339.GC15138@n2100.arm.linux.org.uk>
References: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
	<20110523160944.GA15138@n2100.arm.linux.org.uk>
	<20110523162339.GC15138@n2100.arm.linux.org.uk>
Message-ID: <1306168473.27474.88.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-23 at 17:23 +0100, Russell King - ARM Linux wrote:
> On Mon, May 23, 2011 at 05:09:44PM +0100, Russell King - ARM Linux wrote:
> > On Mon, May 23, 2011 at 02:33:27PM +0100, Marc Zyngier wrote:
> > > ARM build fails with the following symptom:
> > > 
> > >   CC      arch/arm/kernel/asm-offsets.s
> > > In file included from include/linux/seqlock.h:29,
> > >                  from include/linux/time.h:8,
> > >                  from include/linux/timex.h:56,
> > >                  from include/linux/sched.h:57,
> > >                  from arch/arm/kernel/asm-offsets.c:13:
> > > include/linux/spinlock.h: In function 'spin_unlock_wait':
> > > include/linux/spinlock.h:360: error: implicit declaration of function 'cpu_relax'
> > > make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
> > > 
> > > Fix it by including <asm/processor.h>.
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Wonder why we haven't see this before.  Could you send this to the patch
> > system please?
> 
> Hmm, this doesn't fix the problem:
> 
>   CC      arch/arm/kernel/asm-offsets.s
> In file included from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:57,
>                  from arch/arm/kernel/asm-offsets.c:13:
> include/linux/spinlock.h: In function ?spin_unlock_wait?:
> include/linux/spinlock.h:360: error: implicit declaration of function ?cpu_relax?
> 
> My guess is that it does for you because you're building SMP, but the above
> also happens with UP.  So, I don't think this is the right fix.
> 
> I think its time to use git bisect to try and find what broke this and why.

Odd... It seems to build just fine here with UP:

$ grep SMP .config
CONFIG_BROKEN_ON_SMP=y
# CONFIG_SMP is not set
$ time make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- -j4 all
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CC      kernel/bounds.s
  GEN     include/generated/bounds.h
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1554: warning: #warning syscall sendmmsg not implemented
  CC      init/main.o
  CHK     include/generated/compile.h
  HOSTCC  usr/gen_init_cpio
[...]

	M.
-- 
Reality is an implementation detail.
