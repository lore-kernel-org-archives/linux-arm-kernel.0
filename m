From: ldv@altlinux.org (Dmitry V. Levin)
Date: Thu, 12 Apr 2018 04:34:35 +0300
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180409152253.GD10489@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
Message-ID: <20180412013435.GA21219@altlinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 09, 2018 at 06:22:53PM +0300, Dmitry V. Levin wrote:
> There seems to be a regression in v4.16 on ppc compat very similar
> to sparc compat regression reported earlier at
> https://marc.info/?l=linux-sparc&m=151501500704383 .
> 
> The symptoms are exactly the same: the same signal_receive test from
> the strace test suite fails with the same diagnostics:
> https://build.opensuse.org/public/build/home:ldv_alt/openSUSE_Factory_PowerPC/ppc/strace/_log

The log is big, just look for "KERNEL BUG".

> Unfortunately, I do not have any means to investigate further,
> so just passing this information on to those who care.

OK, the faulty commit is v4.16-rc1~159^2~39
("signal/powerpc: Document conflicts with SI_USER and SIGFPE and SIGTRAP").

One might think that a commit called "Document conflicts" shouldn't
introduce an ABI regression, but this one definitely does by defining
FPE_FIXME and TRAP_FIXME in arch/powerpc/include/uapi/asm/siginfo.h
that affect siginfo_layout().

A similar commit v4.16-rc1~159^2~37
("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
introduced a similar ABI regression to compat arm.

An earlier commit v4.14-rc1~60^2^2~5
("signal/sparc: Document a conflict with SI_USER with SIGFPE") introduced
a similar ABI regression to compat sparc.

There is a clear pattern of sneaking in ABI changes using innocently
looking commit messages.


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/1b9648bb/attachment.sig>
