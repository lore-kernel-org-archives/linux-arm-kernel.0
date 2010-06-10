From: herman_swartz@yahoo.com (Herman Swartz)
Date: Thu, 10 Jun 2010 16:22:22 -0700 (PDT)
Subject: Context Switching is Broken
In-Reply-To: <AANLkTilfwCVpr7JrLlWLIXV1DtAGZyRpvDd_8W-qfq5t@mail.gmail.com>
References: <503171.97993.qm@web51806.mail.re2.yahoo.com>
	<20100610140136.GA32362@n2100.arm.linux.org.uk>
	<20100610142015.GC32362@n2100.arm.linux.org.uk>
	<AANLkTimeZ6xawjcYfVDohBFcMbbLlC3h2gDs91CyGcBX@mail.gmail.com>
	<148780.29764.qm@web51806.mail.re2.yahoo.com>
	<AANLkTilfwCVpr7JrLlWLIXV1DtAGZyRpvDd_8W-qfq5t@mail.gmail.com>
Message-ID: <291734.41656.qm@web51808.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

esoteric "confined to and understandable by only an enlightened inner circle"

Sounds like there was a decision made during porting not to include these calls because they weren't considered useful enough.

What is the chance of requesting this to be included, along with other mods,?in the next release of the kernel for ARM?

The Sheeva PLUG is a neat/thrifty little box that runs 7X24. Unlike other computers laying around the house. :-)

JNOS is an Amateur Radio?packet radio communications program for TCP/IP running many?time dependent?segments.

Here is a requested?segment of the code:

/* Now do the context switch.
???? * This technique was inspired by Rob, PE1CHL, and is a bit tricky.
???? *
???? * If the old process has gone away, simply load the new process's
???? * environment. Otherwise, save the current process's state. Then if
???? * this is still the old process, load the new environment. Since the
???? * new task will "think" it's returning from the setjmp() with a return
???? * value of 1, the comparison with 0 will bypass the longjmp(), which
???? * would otherwise cause an infinite loop.
???? */
??? /* i_state isn't needed --- the signal mask is part of the context */
??? if (oldproc == NULLPROC)
??????? setcontext(&Curproc->env);
??? else
??????? swapcontext(&oldproc->env, &Curproc->env);
??? /* At this point, we're running in the newly dispatched task */
??? tmp = Curproc->retval;
??? Curproc->retval = 0;
??? /* Also restore the true interrupt state here, in case the longjmp
???? * DOES restore the interrupt state saved at the time of the setjmp().
???? * This is the case with Turbo-C's setjmp/longjmp.
???? */
??? restore(Curproc->i_state);
??? return tmp;
}




----- Original Message ----
From: Martin Guy <martinwguy@gmail.com>
To: Herman Swartz <herman_swartz@yahoo.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>; Will Deacon <will.deacon@arm.com>; linux-arm-kernel at lists.infradead.org
Sent: Thu, June 10, 2010 5:29:12 PM
Subject: Re: Context Switching is Broken

Hermann

While context switching works fine - any Unix system would have a hard
time working without it - these four esoteric system calls are not
implemented in the ARM port of Linux. If you'd like to modify the
linux source code to implement them, I'm sure the community would be
happy to review the patches for inclusion in the next version of the
kernel.

They seem to be implemented on x86 processors if you need them.

? ? M



      
