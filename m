From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Nov 2013 11:49:37 +0000
Subject: [RFC] ARM: lib: delay-loop: Add align directive to fix
 BogoMIPS calculation
In-Reply-To: <CAOMZO5AyjD4f2o2c-QbK13Pb5cZCWEV4f5dc38MspDBY6_OjDg@mail.gmail.com>
References: <1385121212-30182-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AyjD4f2o2c-QbK13Pb5cZCWEV4f5dc38MspDBY6_OjDg@mail.gmail.com>
Message-ID: <20131130114937.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 09:02:05AM -0200, Fabio Estevam wrote:
> Hi Russell,
> 
> On Fri, Nov 22, 2013 at 9:53 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Currently mx53 (CortexA8) running at 1GHz reports:
> > Calibrating delay loop... 663.55 BogoMIPS (lpj=3317760)
> >
> > Tom Evans verified that alignments of 0x0 and 0x8 run the two instructions of
> > __loop_delay in one clock cycle (1 clock/loop), while alignments of 0x4 and
> > 0xc take 3 clocks to run the loop twice. (1.5 clock/loop)
> >
> > The original object code looks like this:
> >
> > 00000010 <__loop_const_udelay>:
> >   10:   e3e01000        mvn     r1, #0
> >   14:   e51f201c        ldr     r2, [pc, #-28]  ; 0 <__loop_udelay-0x8>
> >   18:   e5922000        ldr     r2, [r2]
> >   1c:   e0800921        add     r0, r0, r1, lsr #18
> >   20:   e1a00720        lsr     r0, r0, #14
> >   24:   e0822b21        add     r2, r2, r1, lsr #22
> >   28:   e1a02522        lsr     r2, r2, #10
> >   2c:   e0000092        mul     r0, r2, r0
> >   30:   e0800d21        add     r0, r0, r1, lsr #26
> >   34:   e1b00320        lsrs    r0, r0, #6
> >   38:   01a0f00e        moveq   pc, lr
> >
> > 0000003c <__loop_delay>:
> >   3c:   e2500001        subs    r0, r0, #1
> >   40:   8afffffe        bhi     3c <__loop_delay>
> >   44:   e1a0f00e        mov     pc, lr
> >
> > After adding the 'align 3' directive to __loop_delay (align to 8 bytes):
> >
> > 00000010 <__loop_const_udelay>:
> >   10:   e3e01000        mvn     r1, #0
> >   14:   e51f201c        ldr     r2, [pc, #-28]  ; 0 <__loop_udelay-0x8>
> >   18:   e5922000        ldr     r2, [r2]
> >   1c:   e0800921        add     r0, r0, r1, lsr #18
> >   20:   e1a00720        lsr     r0, r0, #14
> >   24:   e0822b21        add     r2, r2, r1, lsr #22
> >   28:   e1a02522        lsr     r2, r2, #10
> >   2c:   e0000092        mul     r0, r2, r0
> >   30:   e0800d21        add     r0, r0, r1, lsr #26
> >   34:   e1b00320        lsrs    r0, r0, #6
> >   38:   01a0f00e        moveq   pc, lr
> >   3c:   e320f000        nop     {0}
> >
> > 00000040 <__loop_delay>:
> >   40:   e2500001        subs    r0, r0, #1
> >   44:   8afffffe        bhi     40 <__loop_delay>
> >   48:   e1a0f00e        mov     pc, lr
> >   4c:   e320f000        nop     {0}
> >
> > , which now reports:
> > Calibrating delay loop... 996.14 BogoMIPS (lpj=4980736)
> >
> > Some more test results:
> >
> > On mx31 (ARM1136) running at 532 MHz, before the patch:
> > Calibrating delay loop... 351.43 BogoMIPS (lpj=1757184)
> >
> > On mx31 (ARM1136) running at 532 MHz after the patch:
> > Calibrating delay loop... 528.79 BogoMIPS (lpj=2643968)
> >
> > Also tested on mx6 (CortexA9) and on mx27 (ARM926), which shows the same
> > BogoMIPS value before and after this patch.
> >
> > Reported-by: Tom Evans <tom_usenet@optusnet.com.au>
> > Suggested-by: Tom Evans <tom_usenet@optusnet.com.au>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Any comments on this, please?

Any chance that you could run hackbench, and build the kernel with
-falign-functions=32, comparing the kernel without and with this
option ?

If alignment has as much effect as the above suggests, the results
may be interesting.

As far as this patch is concerned, I'm happy with it, please put it in
the patch system, thanks.

Thanks.
