From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 May 2014 09:24:40 +0100
Subject: [PATCH 6/8] arm64/kexec: kexec needs cpu_die
In-Reply-To: <4408c92fbc8f2f2a81054b9f2ac38331562e658a.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
 <4408c92fbc8f2f2a81054b9f2ac38331562e658a.1399594544.git.geoff@infradead.org>
Message-ID: <20140509082439.GC4757@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> Kexec uses the cpu_die method of struct cpu_operations, so add
> defined(CONFIG_KEXEC) to the preprocessor conditional that enables cpu_die.

Why not make kexec depend on !CONFIG_SMP || CONFIG_HOTPLUG_CPU instead?

>From the POV of the PSCI code in the kernel, it's hotplugging a CPU. Why
it's performing the hotplug operation shouldn't matter.

> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/psci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index ea4828a..0e5fa69 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -253,7 +253,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
>  	return err;
>  }
>  
> -#ifdef CONFIG_HOTPLUG_CPU
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
>  static int cpu_psci_cpu_disable(unsigned int cpu)
>  {
>  	/* Fail early if we don't have CPU_OFF support */
> @@ -284,7 +284,7 @@ const struct cpu_operations cpu_psci_ops = {
>  	.cpu_init	= cpu_psci_cpu_init,
>  	.cpu_prepare	= cpu_psci_cpu_prepare,
>  	.cpu_boot	= cpu_psci_cpu_boot,
> -#ifdef CONFIG_HOTPLUG_CPU
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
>  	.cpu_disable	= cpu_psci_cpu_disable,
>  	.cpu_die	= cpu_psci_cpu_die,
>  #endif

Doesn't his cause the build to fail when KEXEC && !HOTPLUG_CPU? I didn't
see cpu_ops.h updated similarly.

Thanks,
Mark.
