From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Feb 2014 14:39:07 -0800
Subject: BUG: Null pointer dereference on booting TC2 with vexpress_defconfig
Message-ID: <20140217223907.GH21070@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting my TC2 using 3.14-rc3 and vexpress_defconfig causes a NULL
pointer dereference in schedule_work_on.

A quick look at the trace indicates that schedule_work() is called
before system_wq is initialized.

Further, a bisect seems to indicate that this call path is triggered by
the changes in this merge commit of Theodore T'so's random_for_linus
tag:
0891ad829d2a0501053703df66029e843e3b8365

(However, my bisect may not be 100% correct, as some of the commits
between 3.13 and 3.12 don't boot the TC2 with vexpress_defconfig,
specifically the ones after f9300eaaac1ca300083ad41937923a90cc3a2394,
which causes boot to halt after "ARM CCI driver probed").

Disabling CONFIG_ARCH_VEXPRESS_TC2_PM avoids the issue.

I'm not familiar enough with any of these code paths to quicly identify
what the issue could be.  Apologies if I missed a previous post about
this issue (I couldn't find anything but would be surprised if I'm the
only one doing vexpress_defconfig on a TC2).

Here's the full details of the error I'm seeing:

Unable to handle kernel NULL pointer dereference at virtual address
00000080
pgd = 80004000
[00000080] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.0-rc3 #463
task: ee460000 ti: ee446000 task.ti: ee446000
PC is at __queue_work+0x20/0x27c
LR is at queue_work_on+0x48/0x54
pc : [<80033d68>]    lr : [<80034078>]    psr: 200001d3
sp : ee447c60  ip : 00000000  fp : 00000570
r10: 00004000  r9 : 00007ffe  r8 : 00000008
r7 : 00000000  r6 : 00000000  r5 : 805ec388  r4 : 800001d3
r3 : 600001d3  r2 : 805ec388  r1 : 00000000  r0 : 00000008

Backtrace:

[<80033d68>] (__queue_work) from [<80034078>] (queue_work_on+0x48/0x54)
[<80034078>] (queue_work_on) from [<802748a4>]
(credit_entropy_bits+0x1b0/0x248)
[<802748a4>] (credit_entropy_bits) from [<802756b4>]
(add_interrupt_randomness+0x17c/0x1a)
[<802756b4>] (add_interrupt_randomness) from [<80058070>]
(handle_irq_event_percpu+0x8c/0)
[<80058070>] (handle_irq_event_percpu) from [<800581c0>]
(handle_irq_event+0x44/0x64)
[<800581c0>] (handle_irq_event) from [<8005afd0>]
(handle_fasteoi_irq+0x7c/0x148)
[<8005afd0>] (handle_fasteoi_irq) from [<80057a38>]
(generic_handle_irq+0x20/0x30)
[<80057a38>] (generic_handle_irq) from [<8000ec34>]
(handle_IRQ+0x38/0x94)
[<8000ec34>] (handle_IRQ) from [<80008568>] (gic_handle_irq+0x28/0x5c)
[<80008568>] (gic_handle_irq) from [<80012040>] (__irq_svc+0x40/0x50)


Thanks,
-- 
Christoffer
