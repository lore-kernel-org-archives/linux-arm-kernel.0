From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Nov 2016 15:53:31 -0800
Subject: [PATCH/RESEND] recordmcount: arm: Implement make_nop
In-Reply-To: <CAKv+Gu9GVNqXwya8hrjmBcK2L0ud-qr7iE54WUPuMNyFtAy80w@mail.gmail.com>
References: <20161018234200.5804-1-sboyd@codeaurora.org>
 <CAKv+Gu-Cp775gbLxPcJQ4G2nEnwm9G_gxh5B1Sf2LGkkov_OZA@mail.gmail.com>
 <20161115191807.GC25626@codeaurora.org>
 <CAKv+Gu9GVNqXwya8hrjmBcK2L0ud-qr7iE54WUPuMNyFtAy80w@mail.gmail.com>
Message-ID: <20161115235331.GE25626@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15, Ard Biesheuvel wrote:
> On 15 November 2016 at 19:18, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 11/15, Ard Biesheuvel wrote:
> >> On 19 October 2016 at 00:42, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> >
> >> > +static unsigned char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
> >> > +static unsigned char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */
> >>
> >> Shouldn't you be taking the difference between BE8 and BE32 into
> >> account here? IIRC, BE8 uses little endian encoding for instructions.
> >
> > I admit I haven't tested on a pre-armv6 CPU so I haven't come
> > across the case of a BE32 CPU. But from what I can tell that
> > doesn't matter.
> >
> > According to scripts/Makefile.build, cmd_record_mcount only runs
> > the recordmcount program if CONFIG_FTRACE_MCOUNT_RECORD=y. That
> > config is defined as:
> >
> >         config FTRACE_MCOUNT_RECORD
> >                 def_bool y
> >                 depends on DYNAMIC_FTRACE
> >                 depends on HAVE_FTRACE_MCOUNT_RECORD
> >
> >
> > And in arch/arm/Kconfig we see that DYNAMIC_FTRACE is selected:
> >
> >         select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> >
> > which means that FTRACE_MCOUNT_RECORD can't be set when
> > CPU_ENDIAN_BE32 is set.
> >
> > Do you agree that BE32 is not a concern here?
> >
> 
> Yes. But that implies then that you should not be using big-endian
> instruction encodings at all, and simply use the _le variants for both
> LE and BE8

Ok. I understand what you're getting at now.

I believe the linker is the one that does the instruction endian
swap to little endian. So everything is built as big-endian data
and instructions in the assembler phase and then when the linker
runs to generate the final vmlinux elf file it does the swaps to
make instructions little endian. recordmcount runs on the object
files and not the vmlinux file.

For example, the do_undefinstr() function in
arch/arm/kernel/traps.c is one place we nop out. On an le host
and an le build without this patch I see:

(This is all ARM, not thumb)

00000000 <do_undefinstr>:
   0:   e1a0c00d        mov     ip, sp
   4:   e92dd9f0        push    {r4, r5, r6, r7, r8, fp, ip, lr, pc}
   8:   e24cb004        sub     fp, ip, #4
   c:   e24dd08c        sub     sp, sp, #140    ; 0x8c
  10:   e52de004        push    {lr}            ; (str lr, [sp, #-4]!)
  14:   ebfffffe        bl      0 <__gnu_mcount_nc>

After this patch on an le host and le build I see:

00000000 <do_undefinstr>:
   0:   e1a0c00d        mov     ip, sp
   4:   e92dd9f0        push    {r4, r5, r6, r7, r8, fp, ip, lr, pc}
   8:   e24cb004        sub     fp, ip, #4
   c:   e24dd08c        sub     sp, sp, #140    ; 0x8c
  10:   e1a00000        nop                     ; (mov r0, r0)
  14:   e1a00000        nop                     ; (mov r0, r0)

So far so good. Similarly, with this patch and an le host and be
build I see:

00000000 <do_undefinstr>:
   0:   e1a0c00d        mov     ip, sp
   4:   e92dd9f0        push    {r4, r5, r6, r7, r8, fp, ip, lr, pc}
   8:   e24cb004        sub     fp, ip, #4
   c:   e24dd08c        sub     sp, sp, #140    ; 0x8c
  10:   e1a00000        nop                     ; (mov r0, r0)
  14:   e1a00000        nop                     ; (mov r0, r0)

but with *_le instead of *_be used a be build I see:

00000000 <do_undefinstr>:
   0:   e1a0c00d        mov     ip, sp
   4:   e92dd9f0        push    {r4, r5, r6, r7, r8, fp, ip, lr, pc}
   8:   e24cb004        sub     fp, ip, #4
   c:   e24dd08c        sub     sp, sp, #140    ; 0x8c
  10:   0000a0e1        andeq   sl, r0, r1, ror #1
  14:   0000a0e1        andeq   sl, r0, r1, ror #1

I confirmed this by looking at the hexdump of the .exception.text
section for the traps.o object file and the .text section of the
vmlinux file. Basically objcopy the .exception.text of traps.o to
get the first few instructions of the do_undefinstr() function:

$ hexdump -C traps.o 
00000000  e1 a0 c0 0d e9 2d d9 f0  e2 4c b0 04 e2 4d d0 8c

And then objcopy the .text section in vmlinux and seek to the
same function offset (there are a bunch of zeroes in front of it
for padding):

$ hexdump -C vmlinux
...
00001000  0d c0 a0 e1 f0 d9 2d e9  04 b0 4c e2 8c d0 4d e2

As can be seen everything is swapped from the original object
file in big-endian to be in little endian.

Does that allay your concerns?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
