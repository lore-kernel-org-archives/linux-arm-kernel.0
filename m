From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 18 May 2011 18:50:07 +0200
Subject: Question on ARM inline assembly - stackframes, sp/fp usage,
	__naked
In-Reply-To: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
Message-ID: <19923.63679.305921.452962@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank Hofmann writes:
 > with the work on the hibernation support code, I've managed to make it all 
 > C-with-inline-asm. This happens to work fine on OMAP3, but there's an 
 > issue when I build it for Samsung 64xx. It's about this code:
 > 
 > 
 > int __naked swsusp_arch_resume(void)
 > {
 >  	register struct pbe *pbe;
 >  	register void *sp asm("sp") = swsusp_resume_stack + PAGE_SIZE - 8;
 >  	register void *saved_ctx asm ("r0") = ctx;
 > 
 >  	__asm__ __volatile__("" : "+sp"(sp));		/* don't optimize away ! */
...
 > This has the special requirement to run on a separate stack, because the 
 > copy loop will blot over whatever there is. Clobbering everything is part 
 > of the design/intent.
...
 > I am wondering if there's a way to convince gcc to do the right thing 
 > here, __naked notwithstanding.
 > 
 > Is the use of a naked "bounce function" for this specific purpose (switch 
 > the stackpointer) acceptable, and guaranteed to create the correct code ?
 > 
 > 
 > It'd be nice not having to dump this piece into assembly...

Just write the stack switching fragment in proper assembly, and
keep both sides of it in normal C.  End of problem.
