From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 1 Nov 2018 13:56:41 +0000
Subject: [PATCH] RFC: ARM: do not handle Spectre V2 on Vexpress CA9
In-Reply-To: <20181101125406.8874-1-linus.walleij@linaro.org>
References: <20181101125406.8874-1-linus.walleij@linaro.org>
Message-ID: <42704270-8d9f-3f7a-9af1-4bd87f413815@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 01/11/2018 12:54, Linus Walleij wrote:
> Since the introduction of the Spectre V2 fixes for ARMv7,
> especially the BPIALL workaround, the Versatile Express CA9
> with its fragile CA9 core tile simply doesn't boot for me
> anymore.
> 
> If I turn on low level debugging the boot log stops short
> at:
> 
> smp: Bringing up secondary CPUs ...
> GIC: PPI13 is secure or misconfigured
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> CPU1: Spectre v2: using BPIALL workaround
> GIC: PPI13 is secure or misconfigured
> CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> CPU1: Spectre v2: using BPIALL workaround
> 
> This is pretty much consistent behaviour, I think it managed
> to boot at one point but these fixes are definately rubbing
> this CPU the wrong way.
> 
> This (not elegant) workaround tries to work around it by
> simply not applying any Spectre v2 fixes on the ARM
> Vexpress CA9. My other A9 platforms seem to work fine
> with the fixes, so this appears to be related to the
> fragility of the core tile on this one reference design,
> so maybe it would be acceptable to mitigate it like this.
> 
> I don't know how much this could be related to my particular
> specimen, it would be great if others with this machine
> could verify the problem.

As far as I remember, the usual V2P_CA9 problem where the L2 cache locks 
up for unfathomable reasons can come and go reasonably consistently 
depending on the exact kernel configuration/version, and ultimately 
seems like it might be more sensitive to the general shape and timing of 
the early boot code than any particular feature. As such I'd be wary 
that there might still be some other combinations of options which would 
manage to boot with the mitigation left enabled, and others which won't 
even if (or at worst *because*) we do skip it.

Robin.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/arm/mm/proc-v7-bugs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
> index 5544b82a2e7a..10b9eedc3b37 100644
> --- a/arch/arm/mm/proc-v7-bugs.c
> +++ b/arch/arm/mm/proc-v7-bugs.c
> @@ -3,6 +3,7 @@
>   #include <linux/kernel.h>
>   #include <linux/psci.h>
>   #include <linux/smp.h>
> +#include <linux/of.h>
>   
>   #include <asm/cp15.h>
>   #include <asm/cputype.h>
> @@ -42,6 +43,11 @@ static void cpu_v7_spectre_init(void)
>   	const char *spectre_v2_method = NULL;
>   	int cpu = smp_processor_id();
>   
> +	if (of_machine_is_compatible("arm,vexpress,v2p-ca9")) {
> +		pr_err("CPU%u: Spectre v2: can't handle mitigations, CPU is vulnerable\n", cpu);
> +		return;
> +	}
> +
>   	if (per_cpu(harden_branch_predictor_fn, cpu))
>   		return;
>   
> 
