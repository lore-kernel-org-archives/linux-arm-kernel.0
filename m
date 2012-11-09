From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Nov 2012 14:44:46 +0000
Subject: [PATCH v2 1/5] ARM: kernel: smp_setup_processor_id() updates
In-Reply-To: <1352471654-20207-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1352471654-20207-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1352471654-20207-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121109144446.GC17405@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 02:34:10PM +0000, Lorenzo Pieralisi wrote:
> This patch applies some basic changes to the smp_setup_processor_id()
> ARM implementation to make the code that builds cpu_logical_map more
> uniform across the kernel.
> 
> The function now prints the full extent of the boot CPU MPIDR[23:0] and
> initializes the cpu_logical_map for CPUs up to nr_cpu_ids.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm/kernel/setup.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index da1d1aa..ede7c84 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -426,13 +426,14 @@ int __cpu_logical_map[NR_CPUS];
>  void __init smp_setup_processor_id(void)
>  {
>  	int i;
> -	u32 cpu = is_smp() ? read_cpuid_mpidr() & 0xff : 0;
> +	u32 mpidr = read_cpuid_mpidr() & 0xffffff;

We need that is_smp() check, otherwise we'll go and do a funky CP15
operation on CPU's that might not be too happy about it.

Will
