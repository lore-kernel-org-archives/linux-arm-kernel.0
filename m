From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 1 Sep 2013 00:54:34 +0100
Subject: Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7
In-Reply-To: <5222758D.2050306@leahnim.org>
References: <52221A70.5060707@leahnim.org>
 <20130831200649.GJ6617@n2100.arm.linux.org.uk> <5222758D.2050306@leahnim.org>
Message-ID: <20130831235434.GM6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 07:00:29PM -0400, Jochen De Smet wrote:
> On 8/31/2013 16:06, Russell King - ARM Linux wrote:
>> Neither call quirk_usb_early_handoff().  I'm going to assume that it's
>> the EHCI one.
> Curiously enough, I don't see either one (ehci-q.c or fusbh200-hcd.c) in  
> the kernel "make" output.
> Ah, ehci-q gets directly included by ehci-hcd.c, which I do see. Don't  
> see anything similar for fusbh200
> or oxu210hp-hcd.c, so I'm pretty sure the EHCI one is the only one I'm  
> compiling and your guess is
> right.

Thanks for confirming.

> (gdb) disassemble /r start_unlink_async
> Dump of assembler code for function start_unlink_async:
>    0xc020bff4 <+0>:     0d c0 a0 e1     mov     r12, sp
>    0xc020bff8 <+4>:     18 d8 2d e9     push    {r3, r4, r11, r12, lr, pc}
>    0xc020bffc <+8>:     04 b0 4c e2     sub     r11, r12, #4
>    0xc020c000 <+12>:    2c 30 d1 e5     ldrb    r3, [r1, #44]   ; 0x2c
>    0xc020c004 <+16>:    00 40 a0 e1     mov     r4, r0
>    0xc020c008 <+20>:    01 00 53 e3     cmp     r3, #1
>    0xc020c00c <+24>:    18 a8 9d 18     ldmne   sp, {r3, r4, r11, sp, pc}
>    0xc020c010 <+28>:    ca f1 ff eb     bl      0xc0208740  
> <single_unlink_async>
>    0xc020c014 <+32>:    04 00 a0 e1     mov     r0, r4
>    0xc020c018 <+36>:    40 ff ff eb     bl      0xc020bd20  
> <start_iaa_cycle>
>    0xc020c01c <+40>:    18 a8 9d e8     ldm     sp, {r3, r4, r11, sp, pc}
> End of assembler dump.

Okay, so 0xc020c014 is the location of interest, and it's immediately after
a branch to single_unlink_async().  Okay, that confirms that the suspected
path is valid, and we did enter single_unlink_async from the correct place
in the code.

> disassemble /m  doesn't seem to work for this; is that normal?

Hmm, disassemble /m... I'm not up with gdb I'm afraid.

> (gdb) disassemble single_unlink_async
> Dump of assembler code for function single_unlink_async:
>    0xc0208740 <+0>:     mov     r12, sp
>    0xc0208744 <+4>:     push    {r11, r12, lr, pc}
>    0xc0208748 <+8>:     sub     r11, r12, #4
>    0xc020874c <+12>:    mov     r3, #4
>    0xc0208750 <+16>:    strb    r3, [r1, #44]   ; 0x2c
>    0xc0208754 <+20>:    ldr     r3, [r0, #212]  ; 0xd4
>    0xc0208758 <+24>:    add     r2, r1, #32
>    0xc020875c <+28>:    add     r12, r0, #208   ; 0xd0
>    0xc0208760 <+32>:    str     r2, [r0, #212]  ; 0xd4
>    0xc0208764 <+36>:    str     r12, [r1, #32]
>    0xc0208768 <+40>:    str     r3, [r1, #36]   ; 0x24
>    0xc020876c <+44>:    str     r2, [r3]
>    0xc0208770 <+48>:    ldr     r2, [r0, #200]  ; 0xc8
>    0xc0208774 <+52>:    b       0xc020877c <single_unlink_async+60>
>    0xc0208778 <+56>:    mov     r2, r3
>    0xc020877c <+60>:    ldr     r3, [r2, #8]
>    0xc0208780 <+64>:    cmp     r3, r1
>    0xc0208784 <+68>:    bne     0xc0208778 <single_unlink_async+56>

Okay.  First, here's the stack from your previous post, annotated with
the saved registers:

fd80:                                                       c03efdbc c03efda8
                                                            r11      r12
fda0: c020c014 c020874c ef2735d0 ef273500 c03efdd4 c03efdc0 c020c0e0 c020c000
      lr       pc       r3       r4       r11      r12      lr       pc

Unfortunately, this don't really provide much in the way of useful
information other than confirming that the stack layout is as we'd
expect it to be if we got into this function.

Let's now look at the register state:

pc : [<c020837c>]    lr : [<c020c014>] psr: 00000193
sp : c03efd98  ip : ef2735d0  fp : c03efda4
r10: 60000193  r9 : 00000006  r8 : c03013ec
r7 : 000031ac  r6 : d77d6a38  r5 : 00000001  r4 : 00000ef4
r3 : ee817c00  r2 : ef2de8c0  r1 : ee804600  r0 : ef273500

The trick here is to pull out what this tells us based on the code from
the above function.  The first thing to note is that the sp/fp values
are correct: the fp points at the saved PC for this stack frame, which
is what I'd expect.  (Because of prefetching, the saved PC will be ahead
of the instruction which saved it.)

The second thing to note is this:

ip (ef2735d0) = r0 (ef273500) + 0xd0

That suggests that the instruction at 0xc020875c was executed, which is
fair confirmation that we made it into this function and got that far.
Unfortunately, we can't tell much else from comparing the registers and
this code.  Let's look at the code where we ended up:

c0208374:   c0406068        subgt   r6, r0, r8, rrx
c0208378:   c0394a20        eorsgt  r4, r9, r0, lsr #20
c020837c:   c03949f0        ldrshtgt        r4, [r9], -r0

I've annotated this with the correct address from your previous report.
An important thing to note here is that the PSR flags are zero (NZCV
are all clear) so the 'gt' condition will allow these instructions to
execute.

So, can we deduce anything from this?  Well, we have this:

r4 (00000ef4) = r9 (00000006) ^ (r0 (ef273500) >> 20)

so it looks like the instruction at c0208378 was executed.  Obviously
the instruction at c020837c caused a fault, so that was definitely
executed.  What about c0208374?

r6 (d77d6a38) != r0 (ef273500) ^ (r8 (c03013ec) rrx) (rotate right with
extend - a 33 bit right rotate).

That doesn't work, so it suggests that the instruction at c0208374 wasn't
executed.

Now.  How can we get from the above function to c0208378?  Nothing in
this function does a call through pointer, and we certainly haven't
loaded anything off the stack.  Did the PC just spontaneously jump
there?  I think not, but there are two branches in the above code.

There is this:

>    0xc0208784 <+68>:    bne     0xc0208778 <single_unlink_async+56>  

Notice the destination addresses similarity to the address of the first
instruction we think was executed - 0xc0208778 vs c0208378.  Here's
the instruction opcodes for branches to those two locations:

c02107d8:	1affdfe6 	bne	c0208778
c02107d8:	1affdee6 	bne	c0208378

See the single bit difference there on bit 8?

So, this is what I think: either _something_ has cleared that bit, or
you have a problem with your SDRAM wiring, or your SDRAM containing
this location is going bad and is suffering from a bit error at this
location.

I'm afraid that I think you have a hardware problem.
