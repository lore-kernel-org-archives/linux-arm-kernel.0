From: pistol@cs.duke.edu (Valentin Pistol)
Date: Mon, 21 Jan 2013 23:28:35 -0500
Subject: ARM: hw_breakpoint mismatch breakpoint behaves unexpectedly like a
 match breakpoint on ARM_DEBUG_ARCH_V7_ECP14
Message-ID: <CAPfQmKJaYf6M4iHKuNcHgYZi5R8M7fXdXta34Q=1C0cHKimkyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I am trying to single-step each instruction in a target process by
using the hardware breakpoints with the mismatch set (bit 22) and I am
experiencing unexpected behavior: with mismatch set it behaves as a
match breakpoint.
I checked that my Debug Arch ARM_DEBUG_ARCH_V7_ECP14 has mismatch
breakpoint support.
The BCR (0x4001e5) value and DSCR (0x3070002) seem to be correct
according to the manual, so I am confused what is causing the odd
behavior.

I am testing on Pandaboard ES Rev B1 (OMAP4460) using Linux 3.0.31
with Android 4.1.1 and also on Linux 3.2.0-1424-omap4 with Ubuntu
12.04.
I checked your git repo for any updates that might be related or fix
this problem and haven't seen any but may be wrong.

I should note that I am able to set a match breakpoint using the
ptrace interface, have it trigger a SIGTRAP and capture it in my own
user space handler. When attempting to use mismatch instead, the
behavior appears to be same as a match breakpoint: breaks on the
specified PC value.

I tried setting the BVR to 0 or some short address + mismatch but that
never triggers although it should.

My own ptrace code attaches to a running test case (hello) via pid,
sets the breakpoint and detaches right after.
The hello code simply increments a value via a pointer, inside a while loop.
The hello output shows the hello handler catches the same trap for the
same PC as in BVR.
Since am not unsetting the breakpoint in the handler, it's expected
that the trap keeps triggering for a match breakpoint.
But since I am using a mistmatch, I would expect the PC value to
change across traps.
For full correctness I would still need to change the BVR on each trap
to the current PC, but that's after mismatch works in the first place.

I can provide a minicom log with full dmesg if needed.
The following logs are from Linux 3.0.31 but behavior is the same as
Linux 3.2.0-1424-omap4.
I think the multiple repeats of setting and unsetting the breakpoint
are due to context switches but I may be wrong.

ptracer log:
PTRACE_ATTACH on target pid 675
PTRACE_GETREGS for target pid:
    r0 fffffffc  r1 be912c48  r2 00000003  r3 00000000
    r4 400484b8  r5 be912c94  r6 00000001  r7 000000a2
    r8 00000000  r9 00000000  sl 00000000  fp 00000000
    ip 40049ffc  sp be912c40  lr 400e809d  pc 400db2f0  cpsr 60000110
PTRACE_GETHBPREGS result        = 0x03040105
PTRACE_GETHBPREGS debug arch    = 0x3
PTRACE_GETHBPREGS max_wp_length = 4
PTRACE_GETHBPREGS wp_count      = 1
PTRACE_GETHBPREGS bp_count      = 5
DIDR 0x3513702a
DSCR 0x03070002
Mismatch Breakpoints Support: Yes
BVR addr = 0x400db2f0
BCR ctrl = 0x4001e5
PTRACE_DETACH ...

hello log:
SIGTRAP with TRAP code: 4 at addr: 0x400db2f0
SIGTRAP with TRAP code: 4 at addr: 0x400db2f0
SIGTRAP with TRAP code: 4 at addr: 0x400db2f0
SIGTRAP with TRAP code: 4 at addr: 0x400db2f0
[repeats]

dmesg log with additional debugging for breakpoint:
[   65.857971] ptrace_gethbpregs entering...
[   65.863159] ptrace_sethbpregs entering...
[   65.867248] ptrace_hbp_create entering...
[   65.872375] register_user_hw_breakpoint entering...
[   65.877868] ptrace_sethbpregs setting bp_addr = 0x400db2f0
[   65.884490] modify_user_hw_breakpoint entering...
[   65.884490] modify_user_hw_breakpoint returning
[   65.895263] ptrace_sethbpregs entering...
[   65.900024] ptrace_sethbpregs setting bp_len = 4 bp_type = 4 enabled = 1
[   65.907440] modify_user_hw_breakpoint entering...
[   65.911193] modify_user_hw_breakpoint returning
[   65.917724] hw_breakpoint_add entering
[   65.922027] hw-breakpoint: arch_install_hw_breakpoint entering ...
[   65.922027] hw-breakpoint: enable_monitor_mode entering dscr = 0x3070002...
[   65.936035] hw-breakpoint: enable_monitor_mode setting
ARM_DSCR_MDBGEN for ARM_DEBUG_ARCH_V7_ECP14
[   65.946685] hw-breakpoint: enable_monitor_mode leaving dscr =
0x3078002 ret = 0...
[   65.946685] hw-breakpoint: arch_install_hw_breakpoint Setup addr +
ctrl registers
[   65.962921] hw-breakpoint: arch_install_hw_breakpoint returning 0
[   65.970062] hw-breakpoint: arch_uninstall_hw_breakpoint entering...
[   65.976684] hw-breakpoint: arch_uninstall_hw_breakpoint returning
[   65.983703] hw_breakpoint_add entering
[   65.987945] hw-breakpoint: arch_install_hw_breakpoint entering ...
[   65.994934] hw-breakpoint: enable_monitor_mode entering dscr = 0x3070002...
[   66.002807] hw-breakpoint: enable_monitor_mode setting
ARM_DSCR_MDBGEN for ARM_DEBUG_ARCH_V7_ECP14
[   66.012573] hw-breakpoint: enable_monitor_mode leaving dscr =
0x3078002 ret = 0...
[   66.020874] hw-breakpoint: arch_install_hw_breakpoint Setup addr +
ctrl registers
[   66.028747] hw-breakpoint: arch_install_hw_breakpoint returning 0
[   66.035888] hw-breakpoint: arch_uninstall_hw_breakpoint entering...
[   66.042510] hw-breakpoint: arch_uninstall_hw_breakpoint returning
[   66.049316] hw_breakpoint_add entering
[   66.049377] hw-breakpoint: arch_install_hw_breakpoint entering ...
[   66.060607] hw-breakpoint: enable_monitor_mode entering dscr = 0x3078002...
[   66.068634] hw-breakpoint: enable_monitor_mode leaving dscr =
0x3078002 ret = 0...
[   66.076812] hw-breakpoint: arch_install_hw_breakpoint Setup addr +
ctrl registers
[   66.084869] hw-breakpoint: arch_install_hw_breakpoint returning 0
[   66.091857] hw-breakpoint: arch_uninstall_hw_breakpoint entering...
[   66.098571] hw-breakpoint: arch_uninstall_hw_breakpoint returning
[multiple repeats of above 8 lines]
[   67.567230] hw_breakpoint_add entering
[   67.570800] hw-breakpoint: arch_install_hw_breakpoint entering ...
[   67.570800] hw-breakpoint: enable_monitor_mode entering dscr = 0x3078002...
[   67.586486] hw-breakpoint: enable_monitor_mode leaving dscr =
0x3078002 ret = 0...
[   67.586486] hw-breakpoint: arch_install_hw_breakpoint Setup addr +
ctrl registers
[   67.586486] hw-breakpoint: arch_install_hw_breakpoint returning 0
[   67.609802] hw-breakpoint: hw_breakpoint_pending entering...
[   67.609802] hw-breakpoint: breakpoint fired: address = 0x400db2f0
[   67.623016] hw-breakpoint: arch_uninstall_hw_breakpoint entering...
[   67.625061] hw-breakpoint: arch_uninstall_hw_breakpoint returning
[...]
[   68.909637] hw_breakpoint_add entering
[   68.909637] hw-breakpoint: arch_install_hw_breakpoint entering ...
[   68.920898] hw-breakpoint: enable_monitor_mode entering dscr = 0x3078006...
[   68.920898] hw-breakpoint: enable_monitor_mode leaving dscr =
0x3078006 ret = 0...
[   68.920898] hw-breakpoint: arch_install_hw_breakpoint Setup addr +
ctrl registers
[   68.920898] hw-breakpoint: arch_install_hw_breakpoint returning 0
[   68.952056] hw-breakpoint: arch_uninstall_hw_breakpoint entering...
[   68.958801] hw-breakpoint: arch_uninstall_hw_breakpoint returning
[multiple repeats of above 8 lines]

Any comments or suggestions would be very appreciated. Thanks!

Regards,
Valentin
