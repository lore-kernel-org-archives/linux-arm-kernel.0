From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Sep 2012 22:41:02 +0100
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
Message-ID: <20120913214102.GB11399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 07:42:09PM +0100, Valentin Pistol wrote:
> Hi everyone,

Hi Valentin,

> This is my first list post, thanks for bearing with me.

You might want to configure your mail client to wrap lines at 76-80 columns
in order to make your mails more readable.

> Summary:
> Kernel is compiled with CONFIG_HAVE_HW_BREAKPOINT but after boot the DSCR register does not have monitor mode enabled which is required for debug register use.

That means that hardware breakpoints are unusable on your platform, likely
because it has been locked down in the hardware (there is a signal that
can be tied off to prevent monitor mode debug).

> I am interested in using the ptrace interface for hw breakpoints/watchpoints on a Cortex A9. I found out that watchpoints are not triggering and tracked down an issue to the hw_breakpoint.c. The flow is as follows:
> arch_hw_breakpoint_init > on_each_cpu(reset_ctrl_regs, &cpumask, 1);  > reset_ctrl_regs > enable_monitor_mode
> 
> enable_monitor_mode performs ARM_DBG_WRITE(c2, 2, (dscr | ARM_DSCR_MDBGEN));
> Another read on dscr is performed to check if the bit was set and if not it returns -EPERM. In my case the write is not successful so it returns.
> 
> Since the reset_ctrl_regs code just returns on failure setting the monitor mode, there is no reporting of this.
> if (enable_monitor_mode)
>  return ret;

I'll fix this, we should print something here. Thanks.

> After boot, my ptrace test example with PTRACE_GETHBPREGS works fine but PTRACE_SETHBPREGS fails silently inside arch_install_hw_breakpoint due to the same enable_monitor_mode issue.

That's probably because the monitor mode check is at *install* time, which
is asynchronous wrt the ptrace system call (i.e. when the child is next
scheduled). How about we move the check to validation time instead? We
should never try to install an unvalidated breakpoint and trying to support
hardware debuggers and software debuggers simultaneously isn't actually
support by the architecture, requiring some discipline from the guy with the
JTAG cable.

Completely untested patch below, please let me know how you get on...

Will

--->8

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index ba386bd..f513b0e 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -322,14 +322,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event **slot, **slots;
-	int i, max_slots, ctrl_base, val_base, ret = 0;
+	int i, max_slots, ctrl_base, val_base;
 	u32 addr, ctrl;
 
-	/* Ensure that we are in monitor mode and halting mode is disabled. */
-	ret = enable_monitor_mode();
-	if (ret)
-		goto out;
-
 	addr = info->address;
 	ctrl = encode_ctrl_reg(info->ctrl) | 0x1;
 
@@ -356,10 +351,8 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		}
 	}
 
-	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot\n")) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot\n"))
+		return -EBUSY;
 
 	/* Override the breakpoint data with the step data. */
 	if (info->step_ctrl.enabled) {
@@ -378,8 +371,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	/* Setup the control register. */
 	write_wb_reg(ctrl_base + i, ctrl);
 
-out:
-	return ret;
+	return 0;
 }
 
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
@@ -590,6 +582,10 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	int ret = 0;
 	u32 offset, alignment_mask = 0x3;
 
+	/* Ensure that we are in monitor mode and halting mode is disabled. */
+	if (enable_monitor_mode())
+		return -ENODEV;
+
 	/* Build the arch_hw_breakpoint. */
 	ret = arch_build_bp_info(bp);
 	if (ret)
@@ -935,8 +931,10 @@ static void reset_ctrl_regs(void *unused)
 	isb();
 
 reset_regs:
-	if (enable_monitor_mode())
+	if (enable_monitor_mode()) {
+		pr_warning("CPU %d failed to enable monitor mode\n", cpu);
 		return;
+	}
 
 	/* We must also reset any reserved registers. */
 	raw_num_brps = get_num_brp_resources();
