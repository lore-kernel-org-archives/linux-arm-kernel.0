From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 May 2015 18:36:26 +0100
Subject: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
In-Reply-To: <5548FB9C.4090208@dawncrow.de>
References: <55464BB2.7030401@dawncrow.de> <20150505105111.GB1550@arm.com>
 <5548F965.9070302@dawncrow.de> <20150505171558.GO1550@arm.com>
 <5548FB9C.4090208@dawncrow.de>
Message-ID: <20150505173626.GQ1550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 06:19:24PM +0100, Andr? Hentschel wrote:
> Am 05.05.2015 um 19:15 schrieb Will Deacon:
> > On Tue, May 05, 2015 at 06:09:57PM +0100, Andr? Hentschel wrote:
> >> Am 05.05.2015 um 12:51 schrieb Will Deacon:
> >>> On Sun, May 03, 2015 at 05:24:18PM +0100, Andr? Hentschel wrote:
> >>> Curious, but why do you need this? iirc, we added this for arch/arm/ because
> >>> of some windows rt (?) emulation in wine. Is that still the case here and is
> >>> anybody actually using that?
> >>
> >> Yes, Windows ARM binaries are the well known use case, but also the compat
> >> mode should do what the arm kernel is doing I?d think and the code wasn't
> >> adjusted yet.
> > 
> > Sure, I was just curious.
> 
> OK :)
> So what about the patch?

I'll need to take a proper look (it's on the list).

> >> What i'm curious about is why the main TLS register on arm64 is the user
> >> writeable, I'm not an security expert but this looks odd. I could easily
> >> provoke a crash by writing to it...
> > 
> > You've probably got the wrong TLS. Allowing a program to clobber it's own
> > thread-local storage is no worse than allowing it to write to its general
> > purpose registers, pc, etc.
> > 
> > I'm assuming the crash you saw was just a userspace crash, rather than
> > the kernel?
> > 
> 
> True, but the system became horribly instable, files were overwritten by
> others, very strange. It was in a remote KVM VM on bare metal aarch64...
> I don't dare to try it again because it causes others some trouble, but if
> someone wants to try it out: https://github.com/AndreRH/tpidrurw-test

Seems fine to me running both as 32-bit and 64-bit binary under an arm64
4.1-rc2 kernel.

The former just has test failures (because we don't context switch the
TLS):

  [...]
  ERROR: TPIDRURW is 00000000, expected cafebabe
  [...]

whilst the latter SEGVs:

  tpidrurw-test[1691]: unhandled level 1 translation fault (11) at
  0xdeadbac2, esr 0x92000005
  pgd = ffffffc079079000
  [deadbac2] *pgd=0000000000000000, *pud=0000000000000000
  [...]

Will
