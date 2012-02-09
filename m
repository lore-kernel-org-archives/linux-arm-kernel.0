From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Feb 2012 13:11:45 +0200
Subject: [PATCH] gpio: omap: be more aggressive with pm_runtime
In-Reply-To: <20120209060939.GB1121@legolas.emea.dhcp.ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <877gzwyivt.fsf@ti.com>
 <20120209060939.GB1121@legolas.emea.dhcp.ti.com>
Message-ID: <20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

On Thu, Feb 09, 2012 at 08:09:40AM +0200, Felipe Balbi wrote:
> On Wed, Feb 08, 2012 at 04:01:42PM -0800, Kevin Hilman wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> > 
> > > try to keep gpio block suspended as much as possible.
> > >
> > > Tested with pandaboard and a sysfs exported gpio.
> > >
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > 
> > Looks like you need a few more get/puts around other places where
> > registers are accessed.  It currently causes a boot crash on OMAP3 in
> > _set_gpio_triggering().
> 
> it was a missing get/put on gpio_irq_set_type(). Fixed.
> 
> > Did you test GPIO wakeups?  both IO ring wakeups and GPIO module-level
> > wakeups?
> 
> how can I test that easily with panda ?

Ok, I have added gpio-keys to panda's boardfile:

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 30ad40d..0a38282 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
@@ -90,7 +91,30 @@ static struct platform_device leds_gpio = {
 	},
 };
 
+static struct gpio_keys_button gpio_buttons[] = {
+	{
+		.code		= BTN_EXTRA,
+		.gpio		= 121,
+		.desc		= "user",
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device keys_gpio = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_key_info,
+	},
+};
+
 static struct platform_device *panda_devices[] __initdata = {
+	&keys_gpio,
 	&leds_gpio,
 	&wl1271_device,
 };

Then I enabled IRQ wake on gpio-keys driver:

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ed1ed46..e6a0c37a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -410,6 +410,8 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 		goto fail3;
 	}
 
+	enable_irq_wake(irq);
+
 	irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 	/*
 	 * If platform has specified that the button can be disabled,


and enabled wakeup on the gpio-keys:

# echo enabled > /sys/devices/platform/gpio-keys/power/wakeup

suspended the device, and woke it up by pressing S2 (user button). It
almost works, hehe. I can suspend and wake pandaboard up with the user
button. But after that, GPIO module is dead. BTW, I had to prevent
gpio's suspend/resume functions from being called. For some reason,
pm-core is still calling them:

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index db5dcca..d6c1fef 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1170,6 +1170,9 @@ static int omap_gpio_suspend(struct device *dev)
 	void __iomem *wakeup_enable;
 	unsigned long flags;
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 
@@ -1194,6 +1197,9 @@ static int omap_gpio_resume(struct device *dev)
 	void __iomem *base = bank->base;
 	unsigned long flags;
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	if (!bank->mod_usage || !bank->loses_context)
 		return 0;
 

I will continue debugging this, I think it's just something stupid that
I did. Here's entire log:

root at legalas:~# echo enabled > /sys/devices/platform/gpio-keys/power/wakeup
root at legolas:~# echo enabled > /sys/devices/platform/omap/omap_uart.2/power/wakeup
root at legolas:~# grep user /proc/interrupts 
281:          0          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:          2          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:          5          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:          7          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:          8          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:          9          0      GPIO  user
root at legolas:~# 
root at legolas:~# 
root at legolas:~# echo mem > /sys/power/state 
[   62.593200] PM: Syncing filesystems ... done.
[   62.605743] Freezing user space processes ... (elapsed 0.03 seconds) done.
[   62.636230] Freezing remaining freezable tasks ... (elapsed 0.04 seconds) done.
[   62.692993] Suspending console(s) (use no_console_suspend to debug)
[   62.709960] PM: suspend of devices complete after 8.270 msecs
[   62.711853] PM: late suspend of devices complete after 1.770 msecs
[   62.711853] Disabling non-boot CPUs ...
[   62.715118] CPU1: shutdown
[   65.369873] Successfully put all powerdomains to target state
[   65.369995] Enabling non-boot CPUs ...
[   65.371612] CPU1: Booted secondary processor
[   65.372161] Calibrating delay loop (skipped) already calibrated this CPU
[   65.372741] CPU1 is up
[   65.373962] PM: early resume of devices complete after 1.220 msecs
[   65.373962] ------------[ cut here ]------------
[   65.374114] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interrupt_handler+0x184/0x1c4()
[   65.374114] L3 custom error: MASTER:MPU TARGET:L4 PER2
[   65.374114] Modules linked in:
[   65.374114] [<c001b824>] (unwind_backtrace+0x0/0xf0) from [<c0042a60>] (warn_slowpath_common+0x4c/0x64)
[   65.374206] [<c0042a60>] (warn_slowpath_common+0x4c/0x64) from [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40)
[   65.374206] [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40) from [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4)
[   65.374267] [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4) from [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c)
[   65.374267] [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c) from [<c00a2104>] (handle_irq_event+0x3c/0x5c)
[   65.374298] [<c00a2104>] (handle_irq_event+0x3c/0x5c) from [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140)
[   65.374328] [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140) from [<c00a170c>] (generic_handle_irq+0x30/0x48)
[   65.374328] [<c00a170c>] (generic_handle_irq+0x30/0x48) from [<c0014bd8>] (handle_IRQ+0x4c/0xac)
[   65.374389] [<c0014bd8>] (handle_IRQ+0x4c/0xac) from [<c000848c>] (gic_handle_irq+0x28/0xac)
[   65.374389] [<c000848c>] (gic_handle_irq+0x28/0xac) from [<c04809e4>] (__irq_svc+0x44/0x60)
[   65.374389] Exception stack(0xee147e60 to 0xee147ea8)
[   65.374450] 7e60: 00011de7 00000003 00000000 ee0f7580 60000113 c068c194 00000000 c068c194
[   65.374450] 7e80: 60000113 ee04d780 c068c140 000d7518 00001584 ee147ea8 00011de8 c04807a4
[   65.374450] 7ea0: 20000113 ffffffff
[   65.374481] [<c04809e4>] (__irq_svc+0x44/0x60) from [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[   65.374481] [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c00a717c>] (resume_irqs+0x9c/0xbc)
[   65.374511] [<c00a717c>] (resume_irqs+0x9c/0xbc) from [<c0080998>] (suspend_enter+0xa4/0x168)
[   65.374542] [<c0080998>] (suspend_enter+0xa4/0x168) from [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c)
[   65.374542] [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c) from [<c0080d24>] (enter_state+0x13c/0x17c)
[   65.374572] [<c0080d24>] (enter_state+0x13c/0x17c) from [<c007fa1c>] (state_store+0xd0/0x178)
[   65.374603] [<c007fa1c>] (state_store+0xd0/0x178) from [<c0258f48>] (kobj_attr_store+0x14/0x20)
[   65.374603] [<c0258f48>] (kobj_attr_store+0x14/0x20) from [<c0169958>] (sysfs_write_file+0x100/0x184)
[   65.374633] [<c0169958>] (sysfs_write_file+0x100/0x184) from [<c0109d10>] (vfs_write+0xb4/0x148)
[   65.374664] [<c0109d10>] (vfs_write+0xb4/0x148) from [<c0109f98>] (sys_write+0x40/0x70)
[   65.374664] [<c0109f98>] (sys_write+0x40/0x70) from [<c0013cc0>] (ret_fast_syscall+0x0/0x3c)
[   65.374694] ---[ end trace 4898b0d1d1bc4fab ]---
[   65.374694] ------------[ cut here ]------------
[   65.374694] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interrupt_handler+0x184/0x1c4()
[   65.374694] L3 custom error: MASTER:MPU TARGET:L4 PER2
[   65.375305] Modules linked in:
[   65.375305] [<c001b824>] (unwind_backtrace+0x0/0xf0) from [<c0042a60>] (warn_slowpath_common+0x4c/0x64)
[   65.375335] [<c0042a60>] (warn_slowpath_common+0x4c/0x64) from [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40)
[   65.375335] [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40) from [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4)
[   65.375366] [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4) from [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c)
[   65.375396] [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c) from [<c00a2104>] (handle_irq_event+0x3c/0x5c)
[   65.375396] [<c00a2104>] (handle_irq_event+0x3c/0x5c) from [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140)
[   65.375427] [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140) from [<c00a170c>] (generic_handle_irq+0x30/0x48)
[   65.375427] [<c00a170c>] (generic_handle_irq+0x30/0x48) from [<c0014bd8>] (handle_IRQ+0x4c/0xac)
[   65.375457] [<c0014bd8>] (handle_IRQ+0x4c/0xac) from [<c000848c>] (gic_handle_irq+0x28/0xac)
[   65.375457] [<c000848c>] (gic_handle_irq+0x28/0xac) from [<c04809e4>] (__irq_svc+0x44/0x60)
[   65.375488] Exception stack(0xee147e60 to 0xee147ea8)
[   65.375488] 7e60: 00011fc7 00000003 00000000 ee0f7580 60000113 c06974d4 00000000 c06974d4
[   65.375488] 7e80: 60000113 ee04d780 c0697480 000d7518 00001584 ee147ea8 00011fc8 c04807a4
[   65.375518] 7ea0: 20000113 ffffffff
[   65.375518] [<c04809e4>] (__irq_svc+0x44/0x60) from [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[   65.375549] [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c00a717c>] (resume_irqs+0x9c/0xbc)
[   65.375549] [<c00a717c>] (resume_irqs+0x9c/0xbc) from [<c0080998>] (suspend_enter+0xa4/0x168)
[   65.375579] [<c0080998>] (suspend_enter+0xa4/0x168) from [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c)
[   65.375579] [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c) from [<c0080d24>] (enter_state+0x13c/0x17c)
[   65.375610] [<c0080d24>] (enter_state+0x13c/0x17c) from [<c007fa1c>] (state_store+0xd0/0x178)
[   65.375610] [<c007fa1c>] (state_store+0xd0/0x178) from [<c0258f48>] (kobj_attr_store+0x14/0x20)
[   65.375640] [<c0258f48>] (kobj_attr_store+0x14/0x20) from [<c0169958>] (sysfs_write_file+0x100/0x184)
[   65.375640] [<c0169958>] (sysfs_write_file+0x100/0x184) from [<c0109d10>] (vfs_write+0xb4/0x148)
[   65.375671] [<c0109d10>] (vfs_write+0xb4/0x148) from [<c0109f98>] (sys_write+0x40/0x70)
[   65.375671] [<c0109f98>] (sys_write+0x40/0x70) from [<c0013cc0>] (ret_fast_syscall+0x0/0x3c)
[   65.375671] ---[ end trace 4898b0d1d1bc4fac ]---
[   65.375701] ------------[ cut here ]------------
[   65.375762] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interrupt_handler+0x184/0x1c4()
[   65.375762] L3 custom error: MASTER:MPU TARGET:L4 PER2
[   65.375762] Modules linked in:
[   65.375793] [<c001b824>] (unwind_backtrace+0x0/0xf0) from [<c0042a60>] (warn_slowpath_common+0x4c/0x64)
[   65.375793] [<c0042a60>] (warn_slowpath_common+0x4c/0x64) from [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40)
[   65.375823] [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40) from [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4)
[   65.375854] [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4) from [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c)
[   65.375854] [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c) from [<c00a2104>] (handle_irq_event+0x3c/0x5c)
[   65.375885] [<c00a2104>] (handle_irq_event+0x3c/0x5c) from [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140)
[   65.375885] [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140) from [<c00a170c>] (generic_handle_irq+0x30/0x48)
[   65.375915] [<c00a170c>] (generic_handle_irq+0x30/0x48) from [<c0014bd8>] (handle_IRQ+0x4c/0xac)
[   65.375915] [<c0014bd8>] (handle_IRQ+0x4c/0xac) from [<c000848c>] (gic_handle_irq+0x28/0xac)
[   65.375946] [<c000848c>] (gic_handle_irq+0x28/0xac) from [<c04809e4>] (__irq_svc+0x44/0x60)
[   65.375946] Exception stack(0xee147d60 to 0xee147da8)
[   65.375946] 7d60: 00011fce 00000003 00000000 ee0f7580 c0697480 00000119 c06e669c c06e669c
[   65.375976] 7d80: 00000000 c06854a8 c069f108 c0723300 00000000 ee147da8 00011fcf c00a4224
[   65.375976] 7da0: 60000113 ffffffff
[   65.375976] [<c04809e4>] (__irq_svc+0x44/0x60) from [<c00a4224>] (resend_irqs+0x50/0x74)
[   65.376007] [<c00a4224>] (resend_irqs+0x50/0x74) from [<c0049990>] (tasklet_action+0x80/0x180)
[   65.376037] [<c0049990>] (tasklet_action+0x80/0x180) from [<c0049f04>] (__do_softirq+0xd0/0x200)
[   65.376037] [<c0049f04>] (__do_softirq+0xd0/0x200) from [<c004a4c0>] (irq_exit+0x94/0x9c)
[   65.376068] [<c004a4c0>] (irq_exit+0x94/0x9c) from [<c0014bdc>] (handle_IRQ+0x50/0xac)
[   65.376068] [<c0014bdc>] (handle_IRQ+0x50/0xac) from [<c000848c>] (gic_handle_irq+0x28/0xac)
[   65.376098] [<c000848c>] (gic_handle_irq+0x28/0xac) from [<c04809e4>] (__irq_svc+0x44/0x60)
[   65.376098] Exception stack(0xee147e60 to 0xee147ea8)
[   65.376098] 7e60: 00011fc7 00000003 00000000 ee0f7580 60000113 c06974d4 00000000 c06974d4
[   65.376129] 7e80: 60000113 ee04d780 c0697480 000d7518 00001584 ee147ea8 00011fc8 c04807a4
[   65.376129] 7ea0: 20000113 ffffffff
[   65.376159] [<c04809e4>] (__irq_svc+0x44/0x60) from [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[   65.376159] [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c00a717c>] (resume_irqs+0x9c/0xbc)
[   65.376190] [<c00a717c>] (resume_irqs+0x9c/0xbc) from [<c0080998>] (suspend_enter+0xa4/0x168)
[   65.376190] [<c0080998>] (suspend_enter+0xa4/0x168) from [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c)
[   65.376220] [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c) from [<c0080d24>] (enter_state+0x13c/0x17c)
[   65.376220] [<c0080d24>] (enter_state+0x13c/0x17c) from [<c007fa1c>] (state_store+0xd0/0x178)
[   65.376220] [<c007fa1c>] (state_store+0xd0/0x178) from [<c0258f48>] (kobj_attr_store+0x14/0x20)
[   65.376251] [<c0258f48>] (kobj_attr_store+0x14/0x20) from [<c0169958>] (sysfs_write_file+0x100/0x184)
[   65.376281] [<c0169958>] (sysfs_write_file+0x100/0x184) from [<c0109d10>] (vfs_write+0xb4/0x148)
[   65.376281] [<c0109d10>] (vfs_write+0xb4/0x148) from [<c0109f98>] (sys_write+0x40/0x70)
[   65.376312] [<c0109f98>] (sys_write+0x40/0x70) from [<c0013cc0>] (ret_fast_syscall+0x0/0x3c)
[   65.376312] ---[ end trace 4898b0d1d1bc4fad ]---
[   66.479217] PM: resume of devices complete after 1102.905 msecs
[   67.393280] Restarting tasks ... done.
root at legolas:~# [   71.719665] mmcblk0: error -110 transferring data, sector 3557217, nr 72, cmd response 0x900, card status 0xc00
[   71.730468] end_request: I/O error, dev mmcblk0, sector 3557280
[   71.730651] end_request: I/O error, dev mmcblk0, sector 3557281
[   71.743591] Aborting journal on device mmcblk0p2.
[   71.753845] EXT3-fs (mmcblk0p2): error: ext3_journal_start_sb: Detected aborted journal
[   71.753845] EXT3-fs (mmcblk0p2): error: remounting filesystem read-only

root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user
root at legolas:~# grep user /proc/interrupts 
281:         10          0      GPIO  user

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/1f0bec5b/attachment-0001.sig>
