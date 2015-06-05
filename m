From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Jun 2015 10:49:14 -0700
Subject: [PATCH v3 2/3] ARM: rockchip: ensure CPU to enter WFI/WFE state
In-Reply-To: <1433517104-7595-3-git-send-email-wxt@rock-chips.com>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
 <1433517104-7595-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=UMkFtOFYpY+MUZOegnmFLdW3ZgNivwdHChv0MLr50sVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Fri, Jun 5, 2015 at 8:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> In idle mode, core1/2/3 of Cortex-A17 should be either power off or in
> WFI/WFE state.
> we can delay 1ms to ensure the CPU enter WFI/WFE state.
>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---
>
>  arch/arm/mach-rockchip/platsmp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 25da16f..6672fdd 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -325,6 +325,9 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int rockchip_cpu_kill(unsigned int cpu)
>  {
> +       /* ensure CPU can enter the WFI/WFE state */
> +       mdelay(1);

This is a pretty weak assurance.  Is there any stronger assurance you
can give that we're in WFI/WFE state and won't come out of it?

Do you actually see problems if you power off a CPU when it's not in
WFI/WFE state?

...so I _think_ I see the path that is happening here and what you're
trying to handle.  Specifically, I see:

On dying CPU:
1. cpu_die() calls 'complete(&cpu_died)'
2. cpu_die() calls 'smp_ops.cpu_die(cpu)' AKA rockchip_cpu_die()
3. rockchip_cpu_die() does a bit more cache flushing before looping in
cpu_do_idle()

The problem is that the moment the completion happens in step #1 above
the dying CPU can be killed.  ...so you're trying to make sure the
dying CPU makes it to cpu_do_idle().  In that case a fixed mdelay(1)
might be OK since the time that the CPU takes to run through a few
instructions (with no interrupts) is pretty predictable.  It would be
really nice if the commit message went through all this, though.

...but is there any chance that cpu_do_idle() could somehow return?
We shouldn't send any events since we've marked the core offline, but
perhaps some per-core interrupt (arch timer?) that didn't get
migrated?


-Doug
