From: lersek@redhat.com (Laszlo Ersek)
Date: Mon, 17 Oct 2016 16:32:37 +0200
Subject: [PATCH] arm64: kernel: numa: fix ACPI boot cpu numa node mapping
In-Reply-To: <20161017141848.5274-1-lorenzo.pieralisi@arm.com>
References: <20161017141848.5274-1-lorenzo.pieralisi@arm.com>
Message-ID: <df41f88e-6955-c0f9-ebdc-bc50bc88465f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/16 16:18, Lorenzo Pieralisi wrote:
> Commit 7ba5f605f3a0 ("arm64/numa: remove the limitation that cpu0 must
> bind to node0") removed the numa cpu<->node mapping restriction whereby
> logical cpu 0 always corresponds to numa node 0; removing the
> restriction was correct, in that it does not really exist in practice
> but the commit only updated the early mapping of logical cpu 0 to its
> real numa node for the DT boot path, missing the ACPI one, leading to
> boot failures on ACPI systems with numa enabled owing to missing
> node<->cpu map for logical cpu 0.

Small correction request: please drop the "with numa enabled"
qualification. The bug breaks ACPI boot on numa-disabled systems as well
(i.e., where there's only one node, and there are no NUMA-related ACPI
tables (like SRAT) and objects (like _PXM in the DSDT)).

Many thanks!
Laszlo

> 
> Fix the issue by updating the ACPI boot path with code that carries out
> the early cpu<->node mapping also for the boot cpu (ie cpu 0), mirroring
> what is currently done in the DT boot path.
> 
> Fixes: 7ba5f605f3a0 ("arm64/numa: remove the limitation that cpu0 must bind to node0")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Andrew Jones <drjones@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index d3f151c..8507703 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -544,6 +544,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>  			return;
>  		}
>  		bootcpu_valid = true;
> +		early_map_cpu_to_node(0, acpi_numa_get_nid(0, hwid));
>  		return;
>  	}
>  
> 
