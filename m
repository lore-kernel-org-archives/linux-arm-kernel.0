From: pistol@cs.duke.edu (Valentin Pistol)
Date: Thu, 13 Sep 2012 14:42:09 -0400
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
Message-ID: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is my first list post, thanks for bearing with me.

Summary:
Kernel is compiled with CONFIG_HAVE_HW_BREAKPOINT but after boot the DSCR
register does not have monitor mode enabled which is required for debug
register use.
Kernel fails to set monitor mode in the initialization for hw
breakpoints/watchpoints.
It appears to be an EPERM which is silently discarded. I think this should
be logged as pr_warning and I would also be interested to see why it's
failing and fix this.
Any thoughts or suggestions would be greatly appreciated!

Details:
I am interested in using the ptrace interface for hw
breakpoints/watchpoints on a Cortex A9. I found out that watchpoints are
not triggering and tracked down an issue to the hw_breakpoint.c. The flow
is as follows:
arch_hw_breakpoint_init > on_each_cpu(reset_ctrl_regs, &cpumask, 1);  >
reset_ctrl_regs > enable_monitor_mode

enable_monitor_mode performs ARM_DBG_WRITE(c2, 2, (dscr |
ARM_DSCR_MDBGEN));
Another read on dscr is performed to check if the bit was set and if not it
returns -EPERM. In my case the write is not successful so it returns.

Since the reset_ctrl_regs code just returns on failure setting the monitor
mode, there is no reporting of this.
if (enable_monitor_mode)
 return ret;

Hardware: OMAP4460 CPU inside a Galaxy Nexus phone.
Software: Android 4.1.1 and Linux Kernel 3.0.31.
DSCR reads 0x01030002 before/after enable_monitor_mode showing
ARM_DSCR_MDBGEN (bit 15) is not set.
DIDR reads 0x3513702a ( 6 watchpoints and 2 breakpoints )
PTRACE_GETGBPREGS result = 0x3513702a (debug_arch 0x3, max_wp_length = 4,
wp_count = 1, bp_count = 5)

I am aware that the ptrace in my kernel version reports 1 wp as hardcoded
due to an issue with identifying which wp triggered.

dmesg shows the following happening at boot. the hw-wp lines are my own
extra pr_info lines to help debug.

<6>[    0.515777] hw-breakpoint: found 6 breakpoint and 1 watchpoint
registers.
<6>[    0.515777] hw-breakpoint: 1 breakpoint(s) reserved for watchpoint
single-step.
// core 1
<6>[    0.516265] hw-breakpoint: hw-wp: reset_ctrl_regs DBGOSLSR = 0x0
<6>[    0.516265] hw-breakpoint: hw-wp: reset_ctrl_regs DBGAUTHSTATUS = 0xaa
<6>[    0.516723] hw-breakpoint: hw-wp: enable_monitor_mode entering dscr =
0x1030002...
<6>[    0.516723] hw-breakpoint: hw-wp: enable_monitor_mode setting
ARM_DSCR_MDBGEN for ARM_DEBUG_ARCH_V7_ECP14
<6>[    0.516998] hw-breakpoint: hw-wp: enable_monitor_mode dscr write
failed with EPERM
<6>[    0.517181] hw-breakpoint: hw-wp: enable_monitor_mode leaving dscr =
0x1030002 ret = -1...
// core 2: same as above, removed for brevity
<6>[    0.517913] hw-breakpoint: maximum watchpoint size is 4 bytes.

After boot, my ptrace test example with PTRACE_GETHBPREGS works fine
but PTRACE_SETHBPREGS fails silently inside arch_install_hw_breakpoint due
to the same enable_monitor_mode issue.

Thanks for your time,
Valentin
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/e095fae0/attachment-0001.html>
