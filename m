From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jan 2012 19:43:34 +0000
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <201201111827.18890.arnd.bergmann@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
 <20120111165508.GC1068@n2100.arm.linux.org.uk>
 <201201111827.18890.arnd.bergmann@linaro.org>
Message-ID: <20120111194334.GF1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 06:27:18PM +0000, Arnd Bergmann wrote:
> On Wednesday 11 January 2012, Russell King - ARM Linux wrote:
> > > @@ -49,9 +49,9 @@ static int at91_enter_idle(struct cpuidle_device *dev,
> > >       else if (index == 1) {
> > >               asm("b 1f; .align 5; 1:");
> > >               asm("mcr p15, 0, r0, c7, c10, 4");      /* drain write buffer */
> > > -             saved_lpr = sdram_selfrefresh_enable();
> > > +             sdram_selfrefresh_enable(&rs);
> > 
> > What's the point of draining the write buffer if you then pass a buffer
> > to this function to write data to?
> > 
> > If the requirement is that the write buffer is drained before issue a
> > wait-for-interrupt instruction (in cpu_do_idle()) then this code
> > violates that.
> 
> Does that mean the existing AT91SAM9G45 version of sdram_selfrefresh_enable
> is broken already? It writes to the static saved_lpr1 variable after
> the write buffers are drained, which is what this patch was trying to
> clean up.

It works because we're lucky - this is what the compiler is producing
for my test build of this file (for AT91SAM9RL):

 100:   e3a00000        mov     r0, #0  ; 0x0
 104:   ea000005        b       120 <at91_pm_enter+0x84>
 108:   e1a00000        nop                     (mov r0,r0)
 10c:   e1a00000        nop                     (mov r0,r0)
 110:   e1a00000        nop                     (mov r0,r0)
 114:   e1a00000        nop                     (mov r0,r0)
 118:   e1a00000        nop                     (mov r0,r0)
 11c:   e1a00000        nop                     (mov r0,r0)
 120:   ee070f9a        mcr     15, 0, r0, cr7, cr10, {4}
 124:   e59f404c        ldr     r4, [pc, #76]   ; 178 <at91_pm_enter+0xdc>
 128:   e51455ef        ldr     r5, [r4, #-1519]
 12c:   e3c53003        bic     r3, r5, #3      ; 0x3
 130:   e3833001        orr     r3, r3, #1      ; 0x1
 134:   e50435ef        str     r3, [r4, #-1519]
 138:   ebfffffe        bl      0 <cpu_arm926_do_idle>
 13c:   e50455ef        str     r5, [r4, #-1519]
...
 178:   feffefff        .word   0xfeffefff

The two str instructions there are to access virtual address 0xfeffefff -
1519 = 0xfeffea10, which is a device register.  It keeps 'saved_lpr' in
r5, ready for the write to restore the value after the idle call.

Thankfully, *my* compiler hasn't decided to add many additional
instructions into that code path, but that's not to say that a newer
(or older) compiler may not do.

For SAM9G45:

 100:   e3a00000        mov     r0, #0  ; 0x0
 104:   ea000005        b       120 <at91_pm_enter+0x84>
 108:   e1a00000        nop                     (mov r0,r0)
 10c:   e1a00000        nop                     (mov r0,r0)
 110:   e1a00000        nop                     (mov r0,r0)
 114:   e1a00000        nop                     (mov r0,r0)
 118:   e1a00000        nop                     (mov r0,r0)
 11c:   e1a00000        nop                     (mov r0,r0)
 120:   ee070f9a        mcr     15, 0, r0, cr7, cr10, {4}
 124:   e59f406c        ldr     r4, [pc, #108]  ; 198 <at91_pm_enter+0xfc>
 128:   e59f606c        ldr     r6, [pc, #108]  ; 19c <at91_pm_enter+0x100>
 12c:   e5141be3        ldr     r1, [r4, #-3043]
 130:   e51459e3        ldr     r5, [r4, #-2531]
 134:   e3c12003        bic     r2, r1, #3      ; 0x3
 138:   e3c53003        bic     r3, r5, #3      ; 0x3
 13c:   e3833001        orr     r3, r3, #1      ; 0x1
 140:   e3822001        orr     r2, r2, #1      ; 0x1
 144:   e50439e3        str     r3, [r4, #-2531]
 148:   e5042be3        str     r2, [r4, #-3043]
 14c:   e5861000        str     r1, [r6]
 150:   ebfffffe        bl      0 <cpu_arm926_do_idle>
 154:   e5963000        ldr     r3, [r6]
 158:   e50459e3        str     r5, [r4, #-2531]
 15c:   e5043be3        str     r3, [r4, #-3043]

 198:   feffefff        .word   0xfeffefff
 19c:   00000000        .word   0x00000000
                        19c: R_ARM_ABS32        .bss

And there is an additional store in there to a BSS initialized variable
(via r6).

My guess is that r6 is sharing a cache line which is already cached, and
so the write is hitting that cache line and remaining unwritten out to
memory.  In other words, this also is probably mere luck.

On the other hand, we have another DWB in cpu_arm926_do_idle itself.

Whether any of this matters depends on _why_ that DWB is in the AT91
code itself - is it something that needs to be done before placing the
SDRAM into self-refresh mode, or is it being done merely because the
ARM926 docs say that a DWB is needed before WFI?

If the latter, it can be dispensed with because the CPU specific code
is already doing that.

In any case, I think we need someone to speak up who knows this bit of
the AT91 code, and it needs fixing so that it's less reliant on luck -
otherwise cleanups could introduce some rather horrible bugs.
