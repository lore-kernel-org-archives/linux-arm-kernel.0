From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Jul 2013 15:12:31 -0700
Subject: [PATCH v2] ARM: Fix deadlock scenario with smp_send_stop()
In-Reply-To: <1374698170-26605-1-git-send-email-sboyd@codeaurora.org>
References: <1374698170-26605-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51F83A4F.10800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/13 13:36, Stephen Boyd wrote:
> If one process calls sys_reboot and that process then stops other
> CPUs while those CPUs are within a spin_lock() region we can
> potentially encounter a deadlock scenario like below.
>
> CPU 0                   CPU 1
> -----                   -----
>                         spin_lock(my_lock)
> smp_send_stop()
>  <send IPI>             handle_IPI()
>                          disable_preemption/irqs
>                           while(1);
>  <PREEMPT>
> spin_lock(my_lock) <--- Waits forever
>
> We shouldn't attempt to run any other tasks after we send a stop
> IPI to a CPU so disable preemption so that this task runs to
> completion. We use local_irq_disable() here for cross-arch
> consistency with x86.
>
> Reported-by: Sundarajan Srinivasan <sundaraj@codeaurora.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Ok I threw this into the patch tracker because there were no more comments.

> Changes since v1:
>  - Use local_irq_disable() instead of preempt_disable()
>
>  arch/arm/kernel/process.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index d3ca4f6..08b47eb 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -197,6 +197,7 @@ void machine_shutdown(void)
>   */
>  void machine_halt(void)
>  {
> +	local_irq_disable();
>  	smp_send_stop();
>  
>  	local_irq_disable();
> @@ -211,6 +212,7 @@ void machine_halt(void)
>   */
>  void machine_power_off(void)
>  {
> +	local_irq_disable();
>  	smp_send_stop();
>  
>  	if (pm_power_off)
> @@ -230,6 +232,7 @@ void machine_power_off(void)
>   */
>  void machine_restart(char *cmd)
>  {
> +	local_irq_disable();
>  	smp_send_stop();
>  
>  	arm_pm_restart(reboot_mode, cmd);


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
