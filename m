From: davidm@egauge.net (David Mosberger)
Date: Wed, 17 May 2017 16:28:44 -0600
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <20170517170940.GJ22219@n2100.armlinux.org.uk>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
Message-ID: <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 11:09 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, May 17, 2017 at 10:04:32AM -0600, David Mosberger wrote:
> > I added some instrumentation code to the SIGCHLD handler of lighttpd
> > v1.4.45 and I have seen crashes after the SIGCHLD handler
> > interrupted __libc_fork() and close().  The one constant so far is
> > that the pc register in the signal handler machine-context
> > (mcontext_t) points to the instruction after the "svc 0" instruction.
>
> I don't think there's much to be read into that as signal delivery to
> a process always occurs on the thread's exit path from kernel mode to
> user mode.
>
> This happens after:
>
> - completion of an interrupt handler
> - completion of a kernel syscall
> - completion of a page fault

You may well be right.  I added some instrumentation and it looks like
about 4 out of 5 signals are delivered during return from system call.
I have certainly watched many more than 5 of these failures and all
where delivered during syscall return, but of course that doesn't
prove that the problem doesn't happen on non-syscall kernel return.

> What would help is to enable CONFIG_DEBUG_USER and pass 'user_debug=31'
> to the kernel.  It should be more verbose about the cause of the fault
> from the kernel point of view.

OK, since I see various faults, including SIGILL, I used
user_debug=63.  Here is one example:

2017-05-17 22:12:20: (log.c.217) server started
[  129.810000] pgd = cf0b4000
[  129.810000] [00000073] *pgd=2f903831, *pte=00000000, *ppte=00000000
[  129.820000] CPU: 0 PID: 701 Comm: lighttpd Not tainted 4.9.28+ #58
[  129.820000] Hardware name: Atmel SAMA5
[  129.830000] task: cecfcd80 task.stack: cf102000
[  129.830000] PC is at 0x18af4 <-- points to "movle r6, r3" instruction
[  129.830000] LR is@0xb6c04510
[  129.840000] pc : [<00018af4>]    lr : [<b6c04510>]    psr: 00070030
[  129.840000] sp : bee098ec  ip : ffffffff  fp : 01ee4740
[  129.850000] r10: 00000008  r9 : 00000000  r8 : b6d12c40
[  129.850000] r7 : 00034684  r6 : 00000062  r5 : ffffffff  r4 : 00000000
[  129.860000] r3 : ff000000  r2 : bee09978  r1 : bee098f8  r0 : 00000073
[  129.870000] Flags: nzcv  IRQs on  FIQs on  Mode USER_32  ISA Thumb
Segment user
[  129.870000] Control: 10c53c7d  Table: 2f0b4059  DAC: 00000055
[  129.880000] CPU: 0 PID: 701 Comm: lighttpd Not tainted 4.9.28+ #58
[  129.890000] Hardware name: Atmel SAMA5
[  129.890000] Backtrace:
[  129.890000] [<c010a640>] (dump_backtrace) from [<c010a890>]
(show_stack+0x18/0x1c)
[  129.900000]  r7:00000817 r6:00000073 r5:0000000b r4:cecfcd80
[  129.910000] [<c010a878>] (show_stack) from [<c0244e6c>]
(dump_stack+0x20/0x28)
[  129.910000] [<c0244e4c>] (dump_stack) from [<c01079d0>] (show_regs+0x14/0x18)
[  129.920000] [<c01079bc>] (show_regs) from [<c011023c>]
(__do_user_fault+0x7c/0xc4)
[  129.930000] [<c01101c0>] (__do_user_fault) from [<c01104ec>]
(do_page_fault+0x268/0x310)
[  129.940000]  r7:00000055 r6:00030001 r5:00000073 r4:cf103fb0
[  129.940000] [<c0110284>] (do_page_fault) from [<c010123c>]
(do_DataAbort+0x3c/0xbc)
[  129.950000]  r10:00000008 r9:00000000 r8:10c53c7d r7:cf103fb0
r6:c060679c r5:00000073
[  129.960000]  r4:00000817
[  129.960000] [<c0101200>] (do_DataAbort) from [<c010b620>]
(__dabt_usr+0x40/0x60)
[  129.970000] Exception stack(0xcf103fb0 to 0xcf103ff8)
[  129.970000] 3fa0:                                     00000073
bee098f8 bee09978 ff000000
[  129.980000] 3fc0: 00000000 ffffffff 00000062 00034684 b6d12c40
00000000 00000008 01ee4740
[  129.990000] 3fe0: ffffffff bee098ec b6c04510 00018af4 00070030 ffffffff
[  130.000000]  r7:10c53c7d r6:ffffffff r5:00070030 r4:00018af4

Program received signal SIGSEGV, Segmentation fault.

I'm not very good at reading ARM tombstones but if I read this right,
the kernel got a page fault due to a data access but a "movle r6, r3"
instruction doesn't access data memory.  Are we dealing with a
instruction cache issue?

And it says we're in "Thumb" mode?  That shouldn't be the case.

For the record, during the last SIGCHLD signal before the above fault,
my instrumentation code captures this machine-context:

(gdb) p/x sigtrace.mctx[sigtrace.idx]
$4 = {
  trap_no = 0x6,
  error_code = 0x0,
  oldmask = 0x0,
  arm_r0 = 0x0,
  arm_r1 = 0x6,
  arm_r2 = 0x3,
  arm_r3 = 0xbee05aa4,
  arm_r4 = 0x4,
  arm_r5 = 0x0,
  arm_r6 = 0x1ea4718,
  arm_r7 = 0x126,
  arm_r8 = 0x40000,
  arm_r9 = 0x0,
  arm_r10 = 0x0,
  arm_fp = 0x0,
  arm_ip = 0x4aafc,
  arm_sp = 0xbee05a90,
  arm_lr = 0x1e344, <--- network_write_chunkqueue() function in lighttpd
  arm_pc = 0xb6ca9b70,    <---- first instruction after setsockopt syscall
  arm_cpsr = 0x200b0010,
  fault_address = 0x0
}

Also for the record, using an alternate signal stack doesn't help.

  --david
