From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 19 Dec 2014 09:17:42 +0000
Subject: [PATCH] arm64: psci: Support generic pm suspend withtout CPUIDLE
 subsystem's help.
In-Reply-To: <1418967174-23943-1-git-send-email-jonghwa3.lee@samsung.com>
References: <1418967174-23943-1-git-send-email-jonghwa3.lee@samsung.com>
Message-ID: <20141219091742.GB13641@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 05:32:54AM +0000, Jonghwa Lee wrote:
> Current psci's cpu_suspend callback can be used only when common cpu idle
> configuration is enabled. However, it's also needed for system which only
> uses generic pm suspend not cpu idle. This patch modifies psci driver to
> support both of cases.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>

NAK. Apart from:

1) being buggy (how can you use your code when both SUSPEND and CPUidle
   are on)
2) not providing a patch to show how you use the API

that's not how I planned to implement system suspend, bear with me for
a couple of days and I will post an RFC publicly beginning of January.

Amit already posted a different solution and I've already replied to him:
http://www.spinics.net/lists/arm-kernel/msg373447.html

Lorenzo

> ---
>  arch/arm64/kernel/psci.c |   41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index f1dbca7..06d5527 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -35,6 +35,13 @@
>  #define PSCI_POWER_STATE_TYPE_STANDBY		0
>  #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
>  
> +enum psci_affinity_level {
> +	PSCI_AFFINITY_LEVEL_0,
> +	PSCI_AFFINITY_LEVEL_1,
> +	PSCI_AFFINITY_LEVEL_2,
> +	PSCI_AFFINITY_LEVEL_3,
> +};
> +
>  struct psci_power_state {
>  	u16	id;
>  	u8	type;
> @@ -513,27 +520,37 @@ static int psci_suspend_finisher(unsigned long index)
>  {
>  	struct psci_power_state *state = __this_cpu_read(psci_power_state);
>  
> +	/* Generic PM suspend without CPUIDLE functionality */
> +	if (!state) {
> +		struct psci_power_state s = {
> +			.affinity_level = PSCI_AFFINITY_LEVEL_3,
> +			.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
> +		};
> +		return psci_ops.cpu_suspend(s, virt_to_phys(cpu_resume));
> +	}
> +
>  	return psci_ops.cpu_suspend(state[index - 1],
>  				    virt_to_phys(cpu_resume));
>  }
>  
>  static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>  {
> -	int ret;
>  	struct psci_power_state *state = __this_cpu_read(psci_power_state);
> -	/*
> -	 * idle state index 0 corresponds to wfi, should never be called
> -	 * from the cpu_suspend operations
> -	 */
> -	if (WARN_ON_ONCE(!index))
> -		return -EINVAL;
>  
> -	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
> -		ret = psci_ops.cpu_suspend(state[index - 1], 0);
> -	else
> -		ret = __cpu_suspend(index, psci_suspend_finisher);
> +	if (state) {
> +		if (WARN_ON_ONCE(!index))
> +			return -EINVAL;
> +
> +		/*
> +		 * If idle state initialization is successfully done,
> +		 * idle state index 0 corresponds to wfi, should never be
> +		 * called from the cpu_suspend operations
> +		 */
> +		if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
> +			return psci_ops.cpu_suspend(state[index - 1], 0);
> +	}
>  
> -	return ret;
> +	return __cpu_suspend(index, psci_suspend_finisher);
>  }
>  
>  const struct cpu_operations cpu_psci_ops = {
> -- 
> 1.7.9.5
> 
> 
