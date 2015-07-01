From: ahs3@redhat.com (Al Stone)
Date: Wed, 01 Jul 2015 11:02:25 -0600
Subject: [PATCH] ARM64 / SMP: Switch pr_err() to pr_debug() for disabled
 GICC entry
In-Reply-To: <1435757843-13236-1-git-send-email-hanjun.guo@linaro.org>
References: <1435757843-13236-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55941D21.5030604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2015 07:37 AM, Hanjun Guo wrote:
> It is normal that firmware presents GICC entry or entries (processors)
> with disabled flag in ACPI MADT, taking a system of 16 cpus for example,
> ACPI firmware may present 8 enabled first with another 8 cpus disabled
> in MADT, the disabled cpus can be hot-added later.
> 
> Firmware may also present more cpus than the hardware actually has, but
> disabled the unused ones, and easily enable it when the hardware has such
> cpus to make the firmware code scalable.
> 
> So that's not an error for disabled cpus in MADT, we can switch
> pr_err() to pr_debug() instead.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4b2121b..5caf04a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -402,7 +402,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>  	}
>  
>  	if (!(processor->flags & ACPI_MADT_ENABLED)) {
> -		pr_err("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
> +		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
>  		return;
>  	}
>  
> 

Yeah, good point.  I'm all for making the boot a little quieter by default.

Reviewed-by: Al Stone <ahs3@redhat.com>

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
