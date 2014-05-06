From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 May 2014 18:44:55 +0200
Subject: [PATCH v2 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM
 bindings
In-Reply-To: <1399363824-23543-1-git-send-email-sachin.kamat@linaro.org>
References: <1399363824-23543-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <53691187.80101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

Thanks for addressing the comments. I need to verify few things on 
Universal C210 board first, before I could give my Reviewed-by tag or 
further comments.

I also have some general comments that I missed before, due to limited 
time for review. Please see inline.

On 06.05.2014 10:10, Sachin Kamat wrote:
> Instead of hardcoding the SYSRAM details for each SoC,
> pass this information through device tree (DT) and make
> the code SoC agnostic. Generic SRAM bindings are used
> for achieving this.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes since v1:
> * Addressed Tomasz Figa's comments
> - Fixed sram node for universal_c210
> - Check the node status before mapping the address
>
> This patch is based on linux next (next-20140501) on top of
> my Kconfig consolidation patch
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/28642

[snip]

> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 63e34b24b04f..9813b068cfd8 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -28,6 +28,30 @@
>   		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>   	};
>
> +	sram at 02020000 {
> +		status = "disabled";
> +		smp-sram at 0 {
> +			status = "disabled";
> +		};
> +
> +		smp-sram at 1f000 {
> +			status = "disabled";
> +		};
> +	};
> +
> +	sram at 02025000 {
> +		compatible = "mmio-sram";
> +		reg = <0x02025000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x02025000 0x1000>;
> +
> +		smp-sram at 0 {
> +			compatible = "samsung,exynos4210-sram";
> +			reg = <0x0 0x1000>;
> +		};
> +	};

I wonder if this really should be defined like this. 0x2025000 really 
looks just like an offset from the normal SRAM address. This is the 
thing I need to check in documentation and by experiment when I'll 
return back to work tomorrow, but maybe it could be possible to normally 
use the sram at 02020000 and just disable smp-sram at 0 and smp-sram at 1f000, 
replacing them with smp-sram at 5000 on Universal C210.

> +
>   	mct at 10050000 {
>   		compatible = "none";
>   	};

[snip]

> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> index 932129ef26c6..7d583cb73850 100644
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -18,6 +18,7 @@
>
>   #include <mach/map.h>
>
> +#include "common.h"
>   #include "smc.h"
>
>   static int exynos_do_idle(void)
> @@ -34,7 +35,12 @@ static int exynos_cpu_boot(int cpu)
>
>   static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>   {
> -	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> +	void __iomem *boot_reg;
> +
> +	if (!sram_ns_base_addr)
> +		return 0;

Shouldn't this return an error instead? I'm not sure which one would be 
appropriate, though, probably one of -ENODEV, -ENXIO or -EFAULT.

> +
> +	boot_reg = sram_ns_base_addr + 0x1c + 4*cpu;
>
>   	__raw_writel(boot_addr, boot_reg);
>   	return 0;
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 7b046b59d9ec..548269a60634 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -23,13 +23,6 @@
>
>   #include <plat/map-s5p.h>
>
> -#define EXYNOS4_PA_SYSRAM0		0x02025000
> -#define EXYNOS4_PA_SYSRAM1		0x02020000
> -#define EXYNOS5_PA_SYSRAM		0x02020000
> -#define EXYNOS4210_PA_SYSRAM_NS		0x0203F000
> -#define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
> -#define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
> -
>   #define EXYNOS_PA_CHIPID		0x10000000
>
>   #define EXYNOS4_PA_SYSCON		0x10010000
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 03e5e9f94705..ccbcdd7b8a86 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -20,6 +20,7 @@
>   #include <linux/jiffies.h>
>   #include <linux/smp.h>
>   #include <linux/io.h>
> +#include <linux/of_address.h>
>
>   #include <asm/cacheflush.h>
>   #include <asm/smp_plat.h>
> @@ -33,11 +34,35 @@
>
>   extern void exynos4_secondary_startup(void);
>
> +static void __iomem *sram_base_addr;
> +void __iomem *sram_ns_base_addr;

This is probably just a matter of preference, but I'd make this static 
and provide a getter function, like exynos_get_sram_ns_base();

Also this address seems to be used by the firmware code exclusively. If 
we want to make the firmware code more self-contained, maybe the mapping 
of firmware-specific SRAM region could be handled there, instead? This 
would also eliminate the need for having an exported variable or getter 
function. What do you think?

> +
> +static void __init exynos_smp_prepare_sram(void)
> +{
> +	struct device_node *node;
> +
> +	for_each_compatible_node(node, NULL, "samsung,exynos4210-sram") {
> +		if (of_device_is_available(node)) {
> +			sram_base_addr = of_iomap(node, 0);
> +			if (!sram_base_addr)
> +				pr_err("Secondary CPU boot address not found\n");

I don't think this is an error at this stage. Some platforms might not 
have either of these SRAM reserved regions (such as those using INFORM 
registers instead). Instead, the base address should be checked whenever 
it is needed and errors should be handled then, like in 
exynos_set_cpu_boot_addr().

> +		}
> +	}

Also we don't need to look further in DT after we find a matching node 
already. So combining both comments the resulting code would be:

for_each_compatible_node(node, NULL, "samsung,exynos4210-sram") {
	if (!of_device_is_available(node))
		continue;
	sram_base_addr = of_iomap(node, 0);
	break;
}

> +
> +	for_each_compatible_node(node, NULL, "samsung,exynos4210-sram-ns") {
> +		if (of_device_is_available(node)) {
> +			sram_ns_base_addr = of_iomap(node, 0);
> +			if (!sram_ns_base_addr)
> +				pr_err("Secondary CPU boot address not found\n");
> +		}
> +	}

Same comments here.

> +}
> +
>   static inline void __iomem *cpu_boot_reg_base(void)
>   {
>   	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
>   		return S5P_INFORM5;
> -	return S5P_VA_SYSRAM;
> +	return sram_base_addr;
>   }
>
>   static inline void __iomem *cpu_boot_reg(int cpu)
> @@ -147,7 +172,8 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   		 * and fall back to boot register if it fails.
>   		 */
>   		if (call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr))
> -			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
> +			if (cpu_boot_reg_base())
> +				__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));

I'd rework this for proper error handling, e.g.

	int ret;

	/* ... */

	ret = call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr);
	if (ret && ret != -ENOSYS)
		goto fail;
	if (ret == -ENOSYS) {
		/* Fall back to firmware-less way. */
		void __iomem *boot_reg = cpu_boot_reg(phys_cpu);

		if (IS_ERR(boot_reg)) {
			ret = PTR_ERR(boot_reg);
			goto fail;
		}
	}

	/* ... */

fail:
	/* Clean-up after error */

Of course, cpu_boot_reg() will need to be converted to follow the 
ERR_PTR() model, but IMHO proper error handling is a good reason to do so.

>
>   		call_firmware_op(cpu_boot, phys_cpu);
>
> @@ -205,6 +231,8 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>   	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>   		scu_enable(scu_base_addr());
>
> +	exynos_smp_prepare_sram();
> +
>   	/*
>   	 * Write the address of secondary startup into the
>   	 * system-wide flags register. The boot monitor waits
> @@ -222,7 +250,8 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>   		boot_addr = virt_to_phys(exynos4_secondary_startup);
>
>   		if (call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr))
> -			__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
> +			if (cpu_boot_reg_base())
> +				__raw_writel(boot_addr, cpu_boot_reg(phys_cpu));

I wonder if setting the addresses at this stage is really needed. IMHO 
doing it once in exynos_boot_secondary() should be enough. But this is 
probably a material for further patch.

Best regards,
Tomasz
