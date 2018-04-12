From: ldv@altlinux.org (Dmitry V. Levin)
Date: Thu, 12 Apr 2018 15:49:28 +0300
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180412121949.GD16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
Message-ID: <20180412124928.GA29458@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 01:19:49PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 12, 2018 at 02:03:14PM +0300, Dmitry V. Levin wrote:
> > On Thu, Apr 12, 2018 at 10:58:11AM +0100, Russell King - ARM Linux wrote:
> > > On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> > > > A similar commit v4.16-rc1~159^2~37
> > > > ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> > > > introduced a similar ABI regression to compat arm.
> > > 
> > > So, could you explain how can this change cause a regression?
> > > 
> > > +#define FPE_FIXME      0
> > > -               vfp_raise_sigfpe(0, regs);
> > > +               vfp_raise_sigfpe(FPE_FIXME, regs);
> > 
> > No, this hunk hasn't caused the regression, but another one did:
> > 
> > diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
> > new file mode 100644
> > index 0000000..d051388
> > --- /dev/null
> > +++ b/arch/arm/include/uapi/asm/siginfo.h
> > @@ -0,0 +1,13 @@
> > +#ifndef __ASM_SIGINFO_H
> > +#define __ASM_SIGINFO_H
> > +
> > +#include <asm-generic/siginfo.h>
> > +
> > +/*
> > + * SIGFPE si_codes
> > + */
> > +#ifdef __KERNEL__
> > +#define FPE_FIXME      0       /* Broken dup of SI_USER */
> > +#endif /* __KERNEL__ */
> > +
> > +#endif
> > 
> > This is due to FPE_FIXME handling in kernel/signal.c
> 
> Building strace 4.22 on ARM and running the test suite reveals no
> problems with the signal_receive test, tested on both 4.14 and 4.16
> kernels - there's no "KERNEL BUG" reports in any of the test results.

https://build.opensuse.org/public/build/home:ldv_alt/openSUSE_Factory_ARM/armv7l/strace/_log
- the test just fails there with
[   50s] + uname -a
[   50s] Linux armbuild01 4.16.0-1-lpae #1 SMP PREEMPT Wed Apr 4 13:35:56 UTC 2018 (e16f96d) armv7l armv7l armv7l GNU/Linux
...
[  570s] FAIL: signal_receive.gen
[  570s] ---- SIGFPE {si_signo=SIGFPE, si_code=SI_USER, si_pid=25332, si_uid=399} ---
[  570s] +--- SIGFPE {si_signo=SIGFPE, si_code=SI_USER, si_pid=25332, si_uid=0} ---
[  570s] signal_receive.gen.test: failed test: ../../strace -a16 -e trace=kill ../signal_receive output mismatch

> However, stock strace 4.22 source doesn't appear to contain the
> "KERNEL BUG" string anywhere, so this may be a Suse specific addition
> to the test:

The "KERNEL BUG" diagnostics I was talking about was added to strace yesterday
as a part of workaround commit, see
https://github.com/strace/strace/commit/34c7794cc16e2511eda7b1d5767c655a83b17309
Before that change the test just failed.

[...]
> Any ideas where the "KERNEL BUG" in Suse builds is coming from?

strace developers use OBS to test strace.git for regressions.
The build environment is provided by OBS, all the rest comes from strace.git.

> Any ideas how to test it on other architectures (iow, where can we get
> source that contains this test?)

Just use master branch of https://github.com/strace/strace
or https://gitlab.com/strace/strace (they are the same).

> Based on previous experience, unfortunately folk don't tend to report
> user ABI regressions to kernel developers, so we'd probably never know
> that there's a problem - I do think the safer thing would've been to
> leave it well alone, and just accept that we'll end up copying more
> words to userspace than is actually intended.

Well, these changes caused visible regressions in strace test suite on arm, ppc,
and sparc - this is the reason why I have reported them to kernel developers.


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/2641684d/attachment.sig>
