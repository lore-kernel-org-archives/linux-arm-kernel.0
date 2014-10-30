From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 30 Oct 2014 10:29:48 +0000
Subject: [PATCH 1/3] arm64: psci: warn if psci_power_state variable is
 not initialised
In-Reply-To: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
References: <1414641338-25279-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <20141030102948.GB17843@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 03:55:36AM +0000, Amit Daniel Kachhap wrote:
> Without this cpu_suspend may cause crash dump when psci cpuidle
> is not initialised and cpu_suspend is called.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm64/kernel/psci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 866c1c8..2178d6e 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -523,9 +523,11 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>  	struct psci_power_state *state = __get_cpu_var(psci_power_state);
>  	/*
>  	 * idle state index 0 corresponds to wfi, should never be called
> -	 * from the cpu_suspend operations
> +	 * from the cpu_suspend operations.
> +	 * Also psci_power_state variable should have been populated by
> +	 * above init idle routine.
>  	 */
> -	if (WARN_ON_ONCE(!index))
> +	if (WARN_ON_ONCE(!index || !state))
>  		return -EINVAL;

I thought about this when developing the code, at the moment this can't
happen so I did not add any check for that. I would wait for the dust
to settle on the API usage (and if we need it for something different
than idle) before adding checks that might turn out useless, so we will
keep this patch on the back-burner for now.

Thanks,
Lorenzo
