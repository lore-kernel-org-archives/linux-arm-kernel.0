From: davidb@codeaurora.org (David Brown)
Date: Tue, 24 May 2011 16:56:28 -0700
Subject: [PATCH v6 00/18] ARM: Add support for the Large Physical Address
	Extensions
In-Reply-To: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
	(Catalin Marinas's message of "Tue, 24 May 2011 22:39:06 +0100")
References: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <8yapqn7fyab.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24 2011, Catalin Marinas wrote:

> This set of patches adds support for the Large Physical Extensions on
> the ARM architecture (available with the Cortex-A15 processor). LPAE
> comes with a 3-level page table format (compared to 2-level for the
> classic one), allowing up to 40-bit physical address space.

Do you expect non LPAE targets to be able to boot with these changes
applied (and LPAE enabled)?  I am able to build this tree for the
MSM8660 (with a minor patch below), but it fails to boot with LPAE
enabled.  It seems to work fine with LPAE not enabled.

I did have to fix the msm timer code to get the branch you mentioned to
compile.  The return type of the function changed back to 'void' without
changing the returns:

---
 arch/arm/mach-msm/timer.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 50cc0bc..6e659e4 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -268,7 +268,7 @@ static void __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
 
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
-		return 0;
+		return;
 
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 
@@ -296,7 +296,8 @@ static void __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
 	if (res) {
 		pr_err("local_timer_setup: request_irq failed for %s\n",
 		       clock->clockevent.name);
-		return res;
+		/* TODO: How to handle this error. */
+		return;
 	}
 
 	clockevents_register_device(evt);

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
