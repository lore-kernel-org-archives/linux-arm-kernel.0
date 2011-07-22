From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 22 Jul 2011 22:27:31 +0200
Subject: [PATCH, RFC] fix UP futex code to not generate invalid streqt
	instruction
In-Reply-To: <20110722181322.GE25947@n2100.arm.linux.org.uk>
References: <20009.45690.158286.161591@pilspetsen.it.uu.se>
	<20110722181322.GE25947@n2100.arm.linux.org.uk>
Message-ID: <20009.56627.409192.240162@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Fri, Jul 22, 2011 at 07:25:14PM +0200, Mikael Pettersson wrote:
 > > Compiling kernel 3.0 for UP ARM (ARMv5) I see:
 > > 
 > > kernel/futex.c: In function 'fixup_pi_state_owner':
 > > kernel/futex.c:1549: warning: 'curval' may be used uninitialized in this function
 > > kernel/futex.c: In function 'handle_futex_death':
 > > kernel/futex.c:2454: warning: 'nval' may be used uninitialized in this function
 > > /tmp/ccVDjh0q.s: Assembler messages:
 > > /tmp/ccVDjh0q.s:113: Warning: source register same as write-back base
 > 
 > It's actually not a problem - the warning has been around for quite a long
 > time and I've just been ignoring it having investigated it already.  Why?
 > The compare-and-exchange is guaranteed to fail at this point without this
 > instruction even being executed.
 > 
 > > @@ -104,13 +104,14 @@ futex_init:
 > >         mvnne   r3, #13
 > >         bne     .L6
 > >         mvn     r2, #13
 > >  #APP
 > >  @ 97 "/tmp/linux-3.0/arch/arm/include/asm/futex.h" 1
 > >         @futex_atomic_cmpxchg_inatomic
 > > -1:     ldrt    r1, [r3]
 > >         teq     r1, r3
 > >         it      eq      @ explicit IT needed for the 2b label
 > > -2:     streqt  r3, [r3]
 > >  3:
 > >         .pushsection __ex_table,"a"
 > >         .align  3
 > 
 > r3 = 0, so the ldrt causes a data abort, and invokes the fixup, which
 > will skip over the above.
 > 
 > So it's really not a problem, and this is the only place where that
 > 'optimization' by the compiler will happen.  So no need to fix it.
 > Really.

OK.  Patch withdrawn.
