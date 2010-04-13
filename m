From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 13 Apr 2010 08:53:28 +0300
Subject: [RFC 02/10] arm: kdump: implement crash_setup_regs()
In-Reply-To: <20100412200144.GU3048@n2100.arm.linux.org.uk>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<20100412200144.GU3048@n2100.arm.linux.org.uk>
Message-ID: <20100413055328.GA21896@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 10:01:44PM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Mar 29, 2010 at 12:26:28PM +0300, Mika Westerberg wrote:
> > Implement machine specific function crash_setup_regs() which is responsible for
> > storing machine state when crash occured.
> 
> Slightly concerned about this...
> 
> > +	} else {
> > +		__asm__ __volatile__("mov %0, r0" : "=r"(newregs->ARM_r0));
> > +		__asm__ __volatile__("mov %0, r1" : "=r"(newregs->ARM_r1));
> > +		__asm__ __volatile__("mov %0, r2" : "=r"(newregs->ARM_r2));
> > +		__asm__ __volatile__("mov %0, r3" : "=r"(newregs->ARM_r3));
> > +		__asm__ __volatile__("mov %0, r4" : "=r"(newregs->ARM_r4));
> > +		__asm__ __volatile__("mov %0, r5" : "=r"(newregs->ARM_r5));
> > +		__asm__ __volatile__("mov %0, r6" : "=r"(newregs->ARM_r6));
> > +		__asm__ __volatile__("mov %0, r7" : "=r"(newregs->ARM_r7));
> > +		__asm__ __volatile__("mov %0, r8" : "=r"(newregs->ARM_r8));
> > +		__asm__ __volatile__("mov %0, r9" : "=r"(newregs->ARM_r9));
> > +		__asm__ __volatile__("mov %0, r10" : "=r"(newregs->ARM_r10));
> > +		__asm__ __volatile__("mov %0, r11" : "=r"(newregs->ARM_fp));
> > +		__asm__ __volatile__("mov %0, r12" : "=r"(newregs->ARM_ip));
> > +		__asm__ __volatile__("mov %0, r13" : "=r"(newregs->ARM_sp));
> > +		__asm__ __volatile__("mov %0, r14" : "=r"(newregs->ARM_lr));
> > +		__asm__ __volatile__("mov %0, r15" : "=r"(newregs->ARM_pc));
> > + 		__asm__ __volatile__("mrs %0, cpsr" : "=r"(newregs->ARM_cpsr));
> 
> How is whatever follows on supposed to work back from this state?  It's
> entirely possible that the compiler will generate a load of asm between
> each __asm__ statement corrupting the registers - and you can't save
> all this state without having one register storing the 'newregs'
> pointer.

Yeah. I'll have to admit that this is copied from other archs. For example in
x86 they do similar. Anyway I think that it is not necessary to get these
exactly correct because what we are really interested are the frames before, e.g
where the crash happened.

> It'd probably be better to do something like:
> 
> 	__asm__ __volatile__("stmia %0, {r0 - r15}" : : "r" (&newregs->ARM_r0));
> 	__asm__ __volatile__("mrs %0, cpsr" : "=r" (newregs->ARM_cpsr));
> 
> instead, which should mean only one register is (potentially) corrupted.
> However, I still think you're going to have problems knowing what's in
> each register.

Thanks. I think we can live with one register corrupted (unless someone has
better aproach for this). I'll use this in the next revision of the patches.

Regards,
MW
