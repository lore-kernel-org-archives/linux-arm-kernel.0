From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 17 Jan 2017 10:03:41 +0100 (CET)
Subject: [PATCH] clocksource: exynos_mct: clear irq at stop local mct to
 fix suspend
In-Reply-To: <1484628876-22065-1-git-send-email-jy0922.shim@samsung.com>
References: <CGME20170117045403epcas1p1c64f1563c31947059430e0fbf370ee75@epcas1p1.samsung.com>
 <1484628876-22065-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <alpine.DEB.2.20.1701170955250.3495@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jan 2017, Joonyoung Shim wrote:

> This patch adds clear interrupt to exynos4_mct_dying_cpu(). Without

Please read Documentation/process/SubmittingPatches. Search for 'This
patch' ....

A changelog should explain the problem first and then explain the concept
of the fix. You start explaining WHAT the patch does and not what the
problem is.

> clearing, after turning on non boot cpu at wakeup from suspend to
> ram, not cleared tick interrupt occurs and it causes following null
> deference for MCT_INT_SPI type mct.

This has nothing to do with suspend. That can happen with a normal cpu
offline/online sequence as well, which happens to be utilized by
suspend/resume.

Please trim back traces so they contain only useful information. There is
no point in having all these useless stack entries and whatever, which do
not at all help to diagnose the problem.

I'll fix that up when applying the patch. Checkout the resulting changelog
and please be more careful next time.

> [   51.251378] Unable to handle kernel NULL pointer dereference at virtual address 00000040
> [   51.257980] pgd = c0004000
> [   51.260666] [00000040] *pgd=00000000
> [   51.264222] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [   51.269503] Modules linked in:
> [   51.272541] CPU: 7 PID: 53 Comm: ksoftirqd/7 Tainted: G        W 4.9.0-rc7-next-20161201-00007-g74076859ec44 #140
> [   51.283282] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   51.289348] task: ee942d00 task.stack: ee960000
> [   51.293861] PC is at tick_periodic+0x38/0xb0
> [   51.298102] LR is at tick_handle_periodic+0x1c/0x90
> [   51.486409] [<c0183358>] (tick_periodic) from [<ef013ec0>] (0xef013ec0)
> [   51.492990] Code: ee1d2f90 e34c30b6 e8bd4070 e7923003 (e5933040)
> [   51.499057] ---[ end trace 995703fe1bede0b4 ]---
 
> Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
> Cc: stable at vger.kernel.org #v4.2+ #v4.1.4+ #3.18.18+ #v3.16.18+ #v3.12.46+

Adding the version tags is pointless when you have a Fixes tag, which
allows the stable maintainers to find the affected kernels automatically.

> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

This Signed-off-by sequence is wrong.

Seung-Woo reported the problem. You wrote the patch and sent it to the
mailing list. The above sequence suggests that you wrote the patch and
Seung-Woo sent it to the mailing list, which is obviously not the case.

Thanks,

	tglx
