From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 31 Oct 2013 16:42:41 +0000
Subject: [PATCH 1/6] arm: zynq: platsmp: Fix CPU presence check
In-Reply-To: <1383235819-2552-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383235819-2552-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <52728881.7000902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

On 31/10/13 16:10, Soren Brinkmann wrote:
> From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> 
> Fix an off-by-one error in the logic that checks if a CPU is present.
> The ncores variable is a count of cores while the cpu variable is a
> 0 based index. So if ncores == cpu, cpu is out of range. Fix this
> comparison so non-existent CPUs are not probed.
>

Not entirely related to this patch, I had found that zynq_smp_prepare_cpus is
setting cpu_present_mask which is redundant(CMIIW present == possible). I had
posted a patch[1] to remove that, consider including that in the series if you
think it make sense.

Regards,
Sudeep

[1] http://www.spinics.net/lists/arm-kernel/msg260734.html

> Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/mach-zynq/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> index 689fbbc3d9c8..2512624e657d 100644
> --- a/arch/arm/mach-zynq/platsmp.c
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -39,7 +39,7 @@ int zynq_cpun_start(u32 address, int cpu)
>  	u32 trampoline_code_size = &zynq_secondary_trampoline_end -
>  						&zynq_secondary_trampoline;
>  
> -	if (cpu > ncores) {
> +	if (cpu >= ncores) {
>  		pr_warn("CPU No. is not available in the system\n");
>  		return -1;
>  	}
> 
