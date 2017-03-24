From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 14:09:36 +0000
Subject: [PATCH] arm64: fix NULL dereference in have_cpu_die()
In-Reply-To: <20170324135356.25881-1-msalter@redhat.com>
References: <20170324135356.25881-1-msalter@redhat.com>
Message-ID: <20170324140936.GA29588@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 09:53:56AM -0400, Mark Salter wrote:
> Commit 5c492c3f5255 ("arm64: smp: Add function to determine if cpus are
> stuck in the kernel") added a helper function to determine if die() is
> supported in cpu_ops. This function assumes a cpu will have a valid
> cpu_ops entry, but that may not be the case for cpu0 is spin-table or
> parking protocol is used to boot secondary cpus. In that case, there
> is a NULL dereference if have_cpu_die() is called by cpu0. So add a
> check for a valid cpu_ops before dereferencing it.
> 
> Fixes: 5c492c3f5255 ("arm64: smp: Add function to determine if cpus are stuck in the kernel")
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index ef1caae..9b10365 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -944,7 +944,7 @@ static bool have_cpu_die(void)
>  #ifdef CONFIG_HOTPLUG_CPU
>  	int any_cpu = raw_smp_processor_id();
>  
> -	if (cpu_ops[any_cpu]->cpu_die)
> +	if (cpu_ops[any_cpu] && cpu_ops[any_cpu]->cpu_die)
>  		return true;

We take similar care in op_cpu_disable() and cpu_die_early(), so this is
certainly more in keeping with the rest of the arm64 code, and is an
improvement.

... however, I think there is a larger problem. Given cpu_ops can differ
by CPU, we could encounter a case where some CPUs had PSCI ops, and some
had none. In that case, have_cpu_die() can return different values on
different CPUs.

... which means that cpus_are_stuck_in_kernel() is on shaky ground, and
we may need a more comprehensive fix.

Thanks,
Mark.
