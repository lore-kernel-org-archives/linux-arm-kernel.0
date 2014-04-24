From: tim@krieglstein.org (Tim Sander)
Date: Thu, 24 Apr 2014 13:57:58 +0200
Subject: set_fiq_handler: Bad mode in data abort handler detected
In-Reply-To: <20140424103136.GI26756@n2100.arm.linux.org.uk>
References: <2527501.cXAbiV8bqS@dabox>
 <20140424103136.GI26756@n2100.arm.linux.org.uk>
Message-ID: <1725529.gVGe6e3PGC@dabox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Am Donnerstag, 24. April 2014, 11:31:37 schrieb Russell King - ARM Linux:
> Please address kernel related problems to the linux-arm-kernel mailing
> list in preference to linux-arm.  Thanks.
Sorry, i thought linux-arm was the right list.

> On Thu, Apr 24, 2014 at 11:46:15AM +0200, Tim Sander wrote:
> > I have installed a FIQ handler with set_fiq_handler on an Xilinx Zynq.
> > I had to enable the the FIQ symbol in kconfig for the Zynq as its not
> > enabled by default. As i was not able to boot a mainline kernel i used
> > the 3.12 kernel of the xilinx repository at github. But as there are no
> > changes in the FIQ handler stuff i guess that does not matter. The Zynq
> > is a dual ArmV7 Cortex A9.
> > The handler works for an random timespan and then i see:
> The first rule of FIQs is that they are not permitted to cause any
> aborts what so ever - any aborts can be fatal as they can cause
> deadlock.
> 
> > Bad mode in data abort handler detected
> > Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP ARM
> > Modules linked in: firq(O) ipv6
> > CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O 3.12.0-xilinx-dirty
> > #54 task: c05bd420 ti: c05b2000 task.ti: c05b2000
> > PC is at 0xffff1224
> > LR is at arch_cpu_idle+0x20/0x2c
> > pc : [<ffff1224>]    lr : [<c000f344>]    psr: 600e01d1
> > sp : c05b3f70  ip : 00000000  fp : 00000000
> > r10: 00000000  r9 : 413fc090  r8 : c0a264c0
> > r7 : c05a7720  r6 : c04080c8  r5 : c05f2500  r4 : c05b2000
> > r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : c0a299f8
> > Flags: nZCv  IRQs off  FIQs off  Mode FIQ_32  ISA ARM  Segment kernel
> > Control: 18c5387d  Table: 1ec0404a  DAC: 00000015
> > Process swapper/0 (pid: 0, stack limit = 0xc05b2240)
> > Stack: (0xc05b3f70 to 0xc05b4000)
> > 3f60:                                     c0a299f8 00000000 00000000
> > 00000000 3f80: c05b2000 c05f2500 c04080c8 c05a7720 c0a264c0 413fc090
> > 00000000 00000000 3fa0: 00000000 c05b3f70 c000f344 ffff1224 600e01d1
> > ffffffff 00000000 c0055fb8 3fc0: c040a7b0 c0584a5c ffffffff ffffffff
> > c0584574 00000000 00000000 c05a7720 3fe0: 18c5387d c05ba3cc c05a771c
> > c05be440 0000406a 00008074 00000000 00000000 [<c000f344>]
> > (arch_cpu_idle+0x20/0x2c) from [<00000000>] (  (null)) Code: e320f000
> > e320f000 e320f000 eafffffe (e5889000)
> 
> The faulting instruction was:
> 
> 	str r9, [r8]
r8 indeed points to a ioremapped address.
> However, the register dump above does not include the FIQ banked registers,
> so we don't actually know what r8 was.
> 
> > My first guess would be that i had a cache page miss in the fiq handler?
> 
> Yes.
> 
> > I guess the best way would be putting the fiq-handler on the On Chip
> > Memory but then i would still have the same problem that the code jumping
> > to the OCM would have a cache miss?
> 
> I'm guessing that the address pointed to by r8 (the timer base) is
> ioremapped after other threads are already started?  
Yes: For testing purposes i wrote a kernel module which insmod'ed into the 
kernel. To the ioremap for this address is surely executed after the kernel 
threads are started (which i guess is you mean with other threads).
> The problem with
> that is other threads won't have the L1 page table pointers for these
> mappings - we populate these lazily because trying to do it at
> ioremap() time would be extremely painful.
So the success of the fiq interrupt depends on the context of the kernel thread
running (or more precisely of the L1 page table pointers of that particular 
thread) when the FIQ hits?

> What might be possible is to have a function which can be called in
> these circumstances which ensures that a kernel address is accessible
> to all threads in the system, though while it's doing that, it would
> have to stop any fork() or exit() activity to be sure that it updated
> every thread.
Well, as this would be at the time of the FIQ installment, where timing is not 
yet critical, that should at least work for this usecase.

> In years gone by, I'd have recommended that the kernel mappings for
> this stuff were done via static mappings, but with DT, that's no
> longer acceptable.  So I guess we have a problem...
Oh my, i didn't meant to open a can of worms.

Best regards
Tim
