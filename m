From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 9 Oct 2012 14:16:27 +0800
Subject: [PATCH] ARM: tegra: cpuidle: replace LP3 with
 ARM_CPUIDLE_WFI_STATE
In-Reply-To: <5072FD25.2020600@wwwdotorg.org>
References: <1349691856-30590-1-git-send-email-josephl@nvidia.com>
 <5072FD25.2020600@wwwdotorg.org>
Message-ID: <1349763387.15153.196.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your review.

On Tue, 2012-10-09 at 00:19 +0800, Stephen Warren wrote:
> On 10/08/2012 04:24 AM, Joseph Lo wrote:
> > The Tegra CPU idle LP3 state is doing ARM WFI only. So it's same with
> > the common ARM_CPUIDLE_WFI_STATE. Using it to replace LP3 now.
> 
> Hmm. This changes the exit_latency/target_residency fields of the
> cpuidle state definition from 10 to 1, and also replaces
> tegra_idle_enter_lp3() with just a dsb/wfi as far as I can tell. What
> are the implications of removing the irq/fiq_disable/enable and
> ktim-related code? It might be worth explaining why this change is valid
> in the commit description.
> --

There were some histories about the latency. The legacy LP3 mode called
to "tegra_cpu_wfi". This func was been removed. We called to
"cpu_do_idle" right now. In the old "tegra_cpu_wfi", we did back up the
current flow controller register and set up flow controller to CPU_WFE
state. It did wait for CPU running to WFI and clock gate it externally.
We need a time duration to make flow controller to do that.

When any event or interrupt been triggered, it resume the CPU clock. And
CPU runs after WFI and restore the flow controller. We found this may
hurt performance, so we drop that. The latency is not true anymore.

Now we just using WFI to enter low-power CPU standby state where most
clocks gated.

About the missing irq/fiq disable/enable call, we enable the
"en_core_tk_irqen" in this patch. That means we enable time keeping and
irq enabling in the core cpuidle code. So the cpuidle enter code will
use the "cpuidle_wrap_enter" in "drivers/cpuidle/cpuidle.c".

After merging these concepts, I think we can use the common
ARM_CPUIDLE_WFI_STATE to replace the current LP3 code.

Thanks,
Joseph
