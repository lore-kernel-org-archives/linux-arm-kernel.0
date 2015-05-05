From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 May 2015 18:15:58 +0100
Subject: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
In-Reply-To: <5548F965.9070302@dawncrow.de>
References: <55464BB2.7030401@dawncrow.de> <20150505105111.GB1550@arm.com>
 <5548F965.9070302@dawncrow.de>
Message-ID: <20150505171558.GO1550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 06:09:57PM +0100, Andr? Hentschel wrote:
> Am 05.05.2015 um 12:51 schrieb Will Deacon:
> > On Sun, May 03, 2015 at 05:24:18PM +0100, Andr? Hentschel wrote:
> >> From: Andr? Hentschel <nerv@dawncrow.de>
> >>
> >> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable TLS
> >> register on ARM is preserved per thread.
> >>
> >> This patch does it analogous to the ARM patch, but for compat mode on ARM64.
> >>
> >> Signed-off-by: Andr? Hentschel <nerv@dawncrow.de>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: Jonathan Austin <jonathan.austin@arm.com> 
> >>
> >> ---
> >> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)
> > 
> > Curious, but why do you need this? iirc, we added this for arch/arm/ because
> > of some windows rt (?) emulation in wine. Is that still the case here and is
> > anybody actually using that?
> 
> Yes, Windows ARM binaries are the well known use case, but also the compat
> mode should do what the arm kernel is doing I?d think and the code wasn't
> adjusted yet.

Sure, I was just curious.

> What i'm curious about is why the main TLS register on arm64 is the user
> writeable, I'm not an security expert but this looks odd. I could easily
> provoke a crash by writing to it...

You've probably got the wrong TLS. Allowing a program to clobber it's own
thread-local storage is no worse than allowing it to write to its general
purpose registers, pc, etc.

I'm assuming the crash you saw was just a userspace crash, rather than
the kernel?

Will
