From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 7 Jun 2013 11:56:25 +0100
Subject: [PATCH 2/2] ARM: vexpress/TC2: implement PM suspend method
In-Reply-To: <1370587152-4630-3-git-send-email-nicolas.pitre@linaro.org>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130607105625.GB3111@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On Fri, Jun 07, 2013 at 07:39:12AM +0100, Nicolas Pitre wrote:
> From: Nicolas Pitre <nico@linaro.org>
> 
> This is simplistic for the moment as the expected residency is used to
> prevent the shutting down of L2 and the cluster if the residency for
> the last man is lower than 5 ms.  To make this right, the shutdown
> latency for each CPU would need to be recorded and taken into account.
> 
> On a suspend, the firmware mailbox address has to be set prior entering
> low power mode.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-vexpress/tc2_pm.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
> index a3ea524372..7901528566 100644
> --- a/arch/arm/mach-vexpress/tc2_pm.c
> +++ b/arch/arm/mach-vexpress/tc2_pm.c
> @@ -79,7 +79,7 @@ static int tc2_pm_power_up(unsigned int cpu, unsigned int cluster)
>  	return 0;
>  }
>  
> -static void tc2_pm_power_down(void)
> +static void tc2_pm_down(u64 residency)
>  {
>  	unsigned int mpidr, cpu, cluster;
>  	bool last_man = false, skip_wfi = false;
> @@ -100,7 +100,8 @@ static void tc2_pm_power_down(void)
>  		vexpress_spc_set_cpu_wakeup_irq(cpu, cluster, 1);
>  		if (!tc2_pm_use_count[0][cluster] &&
>  		    !tc2_pm_use_count[1][cluster] &&
> -		    !tc2_pm_use_count[2][cluster]) {
> +		    !tc2_pm_use_count[2][cluster] &&
> +		    (!residency || residency > 5000)) {

I would remove the line above altogether. It is ok to have parameter (we
should still define what that residency actually is), I do not think it
makes sense to add policy at this stage, I have a patchset to queue for
that.

Thanks,
Lorenzo
