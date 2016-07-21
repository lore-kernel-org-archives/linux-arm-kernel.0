From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Jul 2016 11:36:44 +0100
Subject: [PATCH] [4.7] arm64: Honor nosmp kernel command line option
In-Reply-To: <1469096127-1136-1-git-send-email-suzuki.poulose@arm.com>
References: <1469096127-1136-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160721103643.GD20559@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 11:15:27AM +0100, Suzuki K Poulose wrote:
> Passing "nosmp" should boot the kernel with a single processor, without
> provision to enable secondary CPUs even if they are present. "nosmp" is
> implemented by setting maxcpus=0. At the moment we still mark the secondary
> CPUs present even with nosmp, which allows the userspace to bring them
> up. This patch corrects the smp_prepare_cpus() to honor the maxcpus == 0.
> 
> Commit 44dbcc93ab67145 ("arm64: Fix behavior of maxcpus=N") fixed the
> behavior for maxcpus >= 1, but broke maxcpus = 0.
> 
> Fixes: commit 44dbcc93ab67145 ("arm64: Fix behavior of maxcpus=N")
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/smp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d242e81..ec08b7a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -694,6 +694,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	smp_store_cpu_info(smp_processor_id());
>  
>  	/*
> +	 * If UP is mandated by "nosmp"(implies maxcpus=0), don't bother about

Nit: missing space between the quote abnd opening bracket. It would also
be nicer to have s/implies/which implies/

Otherwise:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +	 * secondary CPUs.
> +	 */
> +	if (max_cpus == 0)
> +		return;
> +
> +	/*
>  	 * Initialise the present map (which describes the set of CPUs
>  	 * actually populated at the present time) and release the
>  	 * secondaries from the bootloader.
> -- 
> 2.7.4
> 
