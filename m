From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 23 May 2013 14:33:01 -0700
Subject: [PATCHv6 01/11] clockevents: Prefer CPU local devices over
 global devices
In-Reply-To: <1368473175-4841-2-git-send-email-sboyd@codeaurora.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
 <1368473175-4841-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <3a735301-0634-4c83-b0f6-3ecfa04675bf@DB8EHSMHS021.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 12:26:05PM -0700, Stephen Boyd wrote:
> On an SMP system with only one global clockevent and a dummy
> clockevent per CPU we run into problems. We want the dummy
> clockevents to be registered as the per CPU tick devices, but
> we can only achieve that if we register the dummy clockevents
> before the global clockevent or if we artificially inflate the
> rating of the dummy clockevents to be higher than the rating
> of the global clockevent. Failure to do so leads to boot
> hangs when the dummy timers are registered on all other CPUs
> besides the CPU that accepted the global clockevent as its tick
> device and there is no broadcast timer to poke the dummy
> devices.
> 
> If we're registering multiple clockevents and one clockevent is
> global and the other is local to a particular CPU we should
> choose to use the local clockevent regardless of the rating of
> the device. This way, if the clockevent is a dummy it will take
> the tick device duty as long as there isn't a higher rated tick
> device and any global clockevent will be bumped out into
> broadcast mode, fixing the problem described above.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

I tested this on Zynq. Zynq uses the ARM twd timer as clockevent devices when
available. When I remove the twd nodes from DT the clockevent device is
a timer common to both CPUs. Without this patch this seems to stall the
second CPU resulting in the system to hang sooner or later.

[   65.360000] INFO: rcu_preempt detected stalls on CPUs/tasks:
[   65.360000]  1: (1 GPs behind) idle=56e/0/0 softirq=0/0 
[   65.360000]  (detected by 0, t=6502 jiffies, g=4294966997, c=4294966996, q=6844)
[   65.360000] Task dump for CPU 1:
[   65.360000] swapper/1       R running      0     0      1 0x00000000

With this patch everything looks fine.

	S?ren
