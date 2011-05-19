From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 19 May 2011 12:08:17 +0100
Subject: Question on ARM inline assembly - stackframes, sp/fp usage,
	__naked
References: <alpine.DEB.2.00.1105181505080.2374@localhost6.localdomain6>
	<20110518174531.GA28300@arm.com>
	<alpine.DEB.2.00.1105190858320.2374@localhost6.localdomain6>
Message-ID: <yw1x4o4rx80u.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank Hofmann <frank.hofmann@tomtom.com> writes:

>>> 	register void *saved_ctx asm ("r0") = ctx;
>>>
>>> 	__asm__ __volatile__("" : "+sp"(sp));		/* don't optimize away ! */
>>
>> Is this an attempt to force gcc to change sp before the subsequent loop?
>
> That's exactly what it does.
>
>> I think you don't mean "+sp".  Something like "+r" might be appropriate.
>>
>> This feels subtle and fragile to me.
>
> Looked this up; again you're right the direct use of "rXX" (or the
> higher reg names) for gcc ARM inline assembly input/output constraints
> is undocumented, but the "Extended ASM" section in the manual,
>
> 	http://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
>
> states that the way to force a variable into a specific register is:
>
> 	register <type> variable asm("register") = ...;
>
> and then to make sure it happens, to create an
> empty-asm-with-constraint that forces a register write,
>
> 	asm volatile("" : "+r"(variable));

This is not how gcc inline asm works.  A variable declared with an
asm("rXX") tag will be placed in that register when used as a parameter
of an asm code statement.  Outside that statement no promises are made.
It is possible, and it does happen, that gcc moves the value to the
requested register immediately before asm statement and moves it back
where it came from immediately after.

> For the paranoid, one could do:
>
> 	asm volatile("mov sp, %0\n\t" : "+r"(variable) : : "sp");
>
> which is, unlike the use of "sp" as input/output register, actually
> documented explicitly in the "Extended ASM" section of gcc's manual,
> quote:
>
> 	If you refer to a particular hardware register from the
> 	assembler code, you will probably have to list the register
> 	after the third colon to tell the compiler the register's
> 	value is modified. In some assemblers, the register names
> 	begin with `%'; to produce one `%' in the assembler code,
> 	you must write `%%' in the input.
>
> (That's the only place where the doc acknowledges gcc's inline
> assembler's knowledge of machine register names as constraints - in
> the clobber list)

The clobber list enumerates all explicitly named registers (not from
parameters) used in the code section, and the compiler will assume these
contain garbage after the asm statement, reloading them from memory or
otherwise repopulating them with good values.  Whatever values they were
given in the asm statement are lost.

>>> Is the use of a naked "bounce function" for this specific purpose
>>> (switch the stackpointer) acceptable, and guaranteed to create the
>>> correct code ?
>>>
>>>
>>> It'd be nice not having to dump this piece into assembly...
>>
>> Using out-of-line assembler avoids the ABI issues, and is often
>> more readable IMHO.
>>
>> On Wed, May 18, 2011 at 06:50:07PM +0200, Mikael Pettersson wrote:
>> [...]
>>> Just write the stack switching fragment in proper assembly, and
>>> keep both sides of it in normal C.  End of problem.
>>
>> Indeed, though there is only a little section of C, in the middle
>> of some assembler which is not implementable in C.
>
> The stack switching segment isn't the problem ... it's the C bit, as
> long as it lives in the same func.

A stack switching trampoline in pure asm seems to me the cleaner
solution by far.

> Yow, morale of the exercise, I guess: It's possible to shoehorn GCC
> into doing what I want, but the shoe isn't a good fit ;-)
>
> I'm still not convinced why:
>
> void __naked swsusp_arch_resume(void)
> {
> 	register void *sp asm("sp") = ...;
> 	asm volatile("" : "+r"(sp));
> 	__swsusp_arch_resume_copy_pages();
> 	__swsusp_arch_resume_cpu();
> }
>
> with two explicit "noinline" funcs wouldn't be ok.

I'm not convinced it _would_ be OK.  Messing with the stack pointer from
inline asm usually causes all kinds of bad things to happen.  Been
there, done that.

-- 
M?ns Rullg?rd
mans at mansr.com
