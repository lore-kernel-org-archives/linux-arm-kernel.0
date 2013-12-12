From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 15:00:27 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386859963.22947.95.camel@sakura.staff.proxad.net>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
 <1386858504.22947.85.camel@sakura.staff.proxad.net>
 <yw1xd2l2jflc.fsf@unicorn.mansr.com>
 <1386859963.22947.95.camel@sakura.staff.proxad.net>
Message-ID: <20131212150027.GP4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:52:43PM +0100, Maxime Bizon wrote:
> 
> On Thu, 2013-12-12 at 14:42 +0000, M?ns Rullg?rd wrote:
> > 
> > Again, that's an optimisation that does not alter the semantics of the
> > code. Although the generated code looks very different, it does the
> > same thing.
> > 
> It cannot do the same thing as there are possibly nothing to do after
> inline.
> 
> 
> static __attribute__((noinline)) unsigned int do_nothing(unsigned char foo)                                 
> {
>         foo += 42;
>         return 0;
> }
> 
> int func(int a)
> {
>         return do_nothing(a);
> }
> 
> 00000000 <do_nothing>:
>    0:	e3a00000 	mov	r0, #0
>    4:	e12fff1e 	bx	lr
> 
> 00000008 <func>:
>    8:	e52de004 	push	{lr}		; (str lr, [sp, #-4]!)
>    c:	e24dd004 	sub	sp, sp, #4
>   10:	e20000ff 	and	r0, r0, #255	; 0xff
>   14:	ebfffff9 	bl	0 <do_nothing>
>   18:	e28dd004 	add	sp, sp, #4
>   1c:	e8bd8000 	ldmfd	sp!, {pc}
> 
> 
> static inline unsigned int do_nothing(unsigned char foo)                                 
> {
>         foo += 42;
>         return 0;
> }
> 
> int func(int a)
> {
>         return do_nothing(a);
> }
> 
> 
> 00000000 <func>:
>    0:	e3a00000 	mov	r0, #0
>    4:	e12fff1e 	bx	lr
> 
> 
> In the first case, the compiler narrows "int a" to char and call the
> uninlined function.
> 
> In the second case, there is absolutely no generated code to push any
> arguments as the function that does nothing is inlined into func().

This is different - the compiler has recognised in both cases that the
addition od 42 to foo is useless as the result is not used, and therefore
has optimised the addition away.  In the second case, it has realised that
the narrowing cast used to then add 42 to is also not used, and it has
also optimised that away.

A better test case would be do to do this:

	foo += 42;
	return foo;

so that "foo" is actually used.  Or, if you don't feel happy with that:

extern void use_result(unsigned int);

	foo += 42;
	use_result(foo);
	return 0;

so that the compiler can't decide that 'foo' is never used.
