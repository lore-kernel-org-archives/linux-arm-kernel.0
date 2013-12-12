From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 12 Dec 2013 14:58:39 +0000
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <1386859963.22947.95.camel@sakura.staff.proxad.net> (Maxime
 Bizon's message of "Thu, 12 Dec 2013 15:52:43 +0100")
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
 <1386858504.22947.85.camel@sakura.staff.proxad.net>
 <yw1xd2l2jflc.fsf@unicorn.mansr.com>
 <1386859963.22947.95.camel@sakura.staff.proxad.net>
Message-ID: <yw1x4n6ejeu8.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Thu, 2013-12-12 at 14:42 +0000, M?ns Rullg?rd wrote:
>> 
>> Again, that's an optimisation that does not alter the semantics of the
>> code. Although the generated code looks very different, it does the
>> same thing.
>> 
> It cannot do the same thing as there are possibly nothing to do after
> inline.
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
> 00000000 <func>:
>    0:	e3a00000 	mov	r0, #0
>    4:	e12fff1e 	bx	lr
>
> In the first case, the compiler narrows "int a" to char and call the
> uninlined function.
>
> In the second case, there is absolutely no generated code to push any
> arguments as the function that does nothing is inlined into func().

In both cases, the effects on the global state of the program are
exactly the same.  That's all that matters.

-- 
M?ns Rullg?rd
mans at mansr.com
