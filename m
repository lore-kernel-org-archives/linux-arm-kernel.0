From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Oct 2014 15:59:11 +0000
Subject: [percpu] Convert remaining __get_cpu_var uses in 3.18-rcX
In-Reply-To: <alpine.DEB.2.11.1410271047400.17089@gentwo.org>
References: <alpine.DEB.2.11.1410271047400.17089@gentwo.org>
Message-ID: <20141027155910.GX8768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 03:49:45PM +0000, Christoph Lameter wrote:
> During the 3.18 merge period additional __get_cpu_var uses were
> added. The patch converts these to this_cpu_ptr().
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> 
> Index: linux/arch/arm64/kernel/psci.c
> ===================================================================
> --- linux.orig/arch/arm64/kernel/psci.c
> +++ linux/arch/arm64/kernel/psci.c
> @@ -511,7 +511,7 @@ static int cpu_psci_cpu_kill(unsigned in
> 
>  static int psci_suspend_finisher(unsigned long index)
>  {
> -	struct psci_power_state *state = __get_cpu_var(psci_power_state);
> +	struct psci_power_state *state = __this_cpu_read(psci_power_state);
> 
>  	return psci_ops.cpu_suspend(state[index - 1],
>  				    virt_to_phys(cpu_resume));
> @@ -520,7 +520,7 @@ static int psci_suspend_finisher(unsigne
>  static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
>  {
>  	int ret;
> -	struct psci_power_state *state = __get_cpu_var(psci_power_state);
> +	struct psci_power_state *state = __this_cpu_read(psci_power_state);
>  	/*
>  	 * idle state index 0 corresponds to wfi, should never be called
>  	 * from the cpu_suspend operations

Apologies for not spotting this one during review:

  Acked-by: Will Deacon <will.deacon@arm.com>

Feel free to take this via some other route (than the arm64 tree).

Will
