From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 18 Sep 2012 16:25:02 +0100
Subject: Bad traps for unaligned access in STM instruction
In-Reply-To: <20120915105151.GZ1943@vicerveza.homeunix.net>
References: <20120915104602.GY1943@vicerveza.homeunix.net>
 <20120915105151.GZ1943@vicerveza.homeunix.net>
Message-ID: <20120918152502.GB2110@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 12:51:51PM +0200, Llu?s Batlle i Rossell wrote:
> On Sat, Sep 15, 2012 at 12:46:02PM +0200, Llu?s Batlle i Rossell wrote:
> > I'll start looking at the arm traps for unaligned accesses, but maybe someone
> > here can give a quick answer.
> 
> Ah stupid me, here goes the quick answer. I had mode 'warn', and not
> 'fixup+warn'. With 'fixup' enabled, all works fine.
> 
> I was used to mips, where I think there isn't a 'warn' that doesn't 'fixup'.

What source are you actually trying to build/run here?  The "fixup" alignment
mode is primarily a workaround for incorrect code, because the legacy rotated
unaligned access behaviour would cause really weird things to happen silently
in the offending code.  (Although misaligned LDM/STM was never permitted by
the architecture anyway, and normally indicates badly-written code.)

Pure C code should never trigger alignment faults fixups unless it
violates the C language specification.

Assembler should not trigger faults at all, because it's arch-specific
and so you can and should fix it not to cause faults.  Optimising code
in assembler becomes pointless if you write or use it in a way which
triggers unnecessary faults into the kernel.

If you are getting faults in compiled code and the source code follows
the C standard with regard to alignment requirements, this suggests a
bug in the compiler.

Either way, it needs investigating.

Cheers
---Dave
