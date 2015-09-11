From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 15:03:07 +0100
Subject: mysterious crashes on OMAP5 uevm
In-Reply-To: <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
 <CANOLnOM-PYcAL=f4rgucfdWZ1+U3HkP34bfwrKP4Rob+J6iTfw@mail.gmail.com>
Message-ID: <20150911140306.GB21098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:27:13PM +0200, Grazvydas Ignotas wrote:
> On Thu, Sep 10, 2015 at 10:30 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Sep 10, 2015 at 08:42:57AM +0200, Dr. H. Nikolaus Schaller wrote:
> >> ...
> >>
> >> Now, disabling CONFIG_ARCH_MULTI_V6 also makes the bug go away and adding the
> >> >> #if 0 //__LINUX_ARM_ARCH__ >= 7
> >> makes it re-appear.
> >>
> >> A while ago I tried to debug running the x-server under strace and could find that it also has
> >> something to do with SIGALRM.
> >>
> >> And that is very consistent with ?enable/disable? by modifying arch/arm/kernel/signal.c
> >
> > It would be really nice if someone could diagnose what's going on here.
> > What exception is causing the X server to be killed (someone said a
> > segfault)?  What is the register state at the point that happens?  What
> > does the code look like  Is it happening inside the SIGALRM handler, or
> > when the SIGALRM handler has returned?
> >
> > I'd suggest attaching gdb to the X server, but remember to set gdb to
> > ignore SIGPIPEs.
> 
> It's actually pretty random, see some debug sessions in [1].
> The first one is the most useful one, but I haven't though of checking
> what pixman_rasterize_edges() was doing when the signal arrived, and
> most often the "less useful" segfaults occur. However from the
> disassembly (see debug1_libpixman.gz) it can be seen that the signal
> arrived right after IT.
> 
> [1] http://notaz.gp2x.de/tmp/thumb_segfault/

We're not going from ARM -> Thumb or Thumb -> ARM here, but Thumb code
in libpixman is being interrupted calling a Thumb signal handler.

Working through the code:

   0x7f717ec8 <SmartScheduleTimer>:     ldr     r2, [pc, #20]   ; = 0x0004112e
   0x7f717eca <SmartScheduleTimer+2>:   ldr     r1, [pc, #24]   ; = 0x00000c48
   0x7f717ecc <SmartScheduleTimer+4>:   ldr     r3, [pc, #24]   ; = 0x00000e6c
   0x7f717ece <SmartScheduleTimer+6>:   add     r2, pc
   0x7f717ed0 <SmartScheduleTimer+8>:   ldr     r1, [r2, r1]
   0x7f717ed2 <SmartScheduleTimer+10>:  ldr     r3, [r2, r3]
=> 0x7f717ed4 <SmartScheduleTimer+12>:  ldr     r2, [r1, #0]

The instruction at 0x7f717ed4 was trying to access 0xd1242963 which
is in kernel space, and this is the faulting instruction.

At this point, r2 should contain 0x0004112e plus the PC value.  r2 in
the register dump was 0x7f717fa0.  Let's calculate the value that PC
should be here.  0x7f717fa0 - 0x0004112e = 0x7f6d6e72, which is
clearly wrong.

So, I don't think the first instruction here was executed by the CPU.

gdb indicates that the parent context to the signal frame, pc was at
0xb6dd87f8, which works out at 0x297f8 into the libpixman-1 library:

   297f0:       449c            add     ip, r3
   297f2:       f1bc 0fff       cmp.w   ip, #255        ; 0xff
   297f6:       bfd4            ite     le
   297f8:       fa5f fc8c       uxtble.w        ip, ip
   297fc:       f04f 0cff       movgt.w ip, #255        ; 0xff
   29800:       f88a c000       strb.w  ip, [sl]

and as you say, is just after an IT instruction, which would have
set the IT execution state to appropriately skip either the first or
the second instruction.

Unfortunately, the IT instruction's condition is being carried forward
to the signal handler, causing either the first or second instruction
there to be skipped.

Looking back at the history, the original commit introducing the
clearing of the PSR_IT_MASK bits is just wrong:

-               if (thumb)
+               if (thumb) {
                        cpsr |= PSR_T_BIT;
-               else
+#if __LINUX_ARM_ARCH__ >= 7
+                       /* clear the If-Then Thumb-2 execution state */
+                       cpsr &= ~PSR_IT_MASK;
+#endif
+               } else
                        cpsr &= ~PSR_T_BIT;

This shouldn't be a compile-time decision at all, and it certainly should
not be dependent on __LINUX_ARM_ARCH__, which marks the _lowest_ supported
architecture.

However, even the idea that it's ARMv7 or later is wrong.  According to
the ARM ARM, the IT instruction is present in ARMv6T2 as well, which
means it's ARMv6 too (which would have __LINUX_ARM_ARCH__ = 6).

Looking at the ARM ARM, these bits are "reserved" in previous non-T2
architectures, have an undefined value at reset, and are probably zero
anyway.

Merely changing __LINUX_ARM_ARCH__ >= 7 to >= 6 should fix the problem,
and I doubt there's any ARMv6 non-T2 systems out there that would be
affected by clearing the IT state bits.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
