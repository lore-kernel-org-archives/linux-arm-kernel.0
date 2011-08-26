From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2011 09:21:35 +0100
Subject: [PATCH 1/2] Adding platform level cpuidle driver for i.MX SoCs.
In-Reply-To: <1314325995-29118-1-git-send-email-rob.lee@linaro.org>
References: <1314325995-29118-1-git-send-email-rob.lee@linaro.org>
Message-ID: <20110826082135.GC11250@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: [PATCH 1/2] Adding platform level cpuidle driver for i.MX SoCs.

	"Add platform level cpuidle driver for i.MX SoCs."

is more natural to read in the git logs after the patch has been
committed.

On Thu, Aug 25, 2011 at 09:33:14PM -0500, Robert Lee wrote:
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/plat-mxc/Kconfig   |   10 ++++
>  arch/arm/plat-mxc/Makefile  |    2 +
>  arch/arm/plat-mxc/cpuidle.c |  112 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/cpuidle.c
> 
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index a5353fc..84672b3 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -122,4 +122,14 @@ config IRAM_ALLOC
>  	bool
>  	select GENERIC_ALLOCATOR
>  
> +config ARCH_HAS_CPUIDLE
> +	bool
> +
> +config MXC_CPUIDLE
> +	bool
> +	depends on ARCH_HAS_CPUIDLE && CPU_IDLE
> +	default y
> +	help
> +	  Internal node to signify that the ARCH has CPUIDLE support.
> +
>  endif
> diff --git a/arch/arm/plat-mxc/Makefile b/arch/arm/plat-mxc/Makefile
> index d53c35f..59f20ac 100644
> --- a/arch/arm/plat-mxc/Makefile
> +++ b/arch/arm/plat-mxc/Makefile
> @@ -19,6 +19,8 @@ obj-$(CONFIG_ARCH_MXC_AUDMUX_V1) += audmux-v1.o
>  obj-$(CONFIG_ARCH_MXC_AUDMUX_V2) += audmux-v2.o
>  obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
>  obj-$(CONFIG_CPU_FREQ_IMX)    += cpufreq.o
> +obj-$(CONFIG_MXC_CPUIDLE) += cpuidle.o
> +
>  ifdef CONFIG_SND_IMX_SOC
>  obj-y += ssi-fiq.o
>  obj-y += ssi-fiq-ksym.o
> diff --git a/arch/arm/plat-mxc/cpuidle.c b/arch/arm/plat-mxc/cpuidle.c
> new file mode 100644
> index 0000000..cd637e1
> --- /dev/null
> +++ b/arch/arm/plat-mxc/cpuidle.c
> @@ -0,0 +1,112 @@
> +/*
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/cpuidle.h>
> +#include <asm/proc-fns.h>
> +#include <mach/hardware.h>
> +#include <mach/system.h>
> +#include <mach/cpuidle.h>
> +
> +
> +#ifndef MXC_OVERRIDE_DEFAULT_CPUIDLE_PARAMS
> +
> +#define MXC_X_MACRO(a, b, c) {c}
> +static struct imx_cpuidle_params default_cpuidle_params[] = \
> +	MXC_CPUIDLE_TABLE;
> +#undef MXC_X_MACRO
> +
> +static struct imx_cpuidle_params *imx_cpuidle_params = default_cpuidle_params;
> +
> +#else
> +
> +static struct imx_cpuidle_params *imx_cpuidle_params;
> +
> +#endif
> +
> +
> +
> +/* in case you want to override the mach level params at the board level */
> +void imx_cpuidle_board_params(struct imx_cpuidle_params *cpuidle_params)
> +{
> +	imx_cpuidle_params = cpuidle_params;
> +}
> +
> +static int imx_enter_idle(struct cpuidle_device *dev,
> +			       struct cpuidle_state *state)
> +{
> +	struct timeval before, after;
> +	int idle_time, i;
> +
> +	/* We only need to pass an index to the mach level so here we
> +	 * find the index of the name contained in the cpuidle_state
> +	 * to pass. */
> +	for (i = 0; i < MXC_NUM_CPUIDLE_STATES && i < CPUIDLE_STATE_MAX; i++)
> +		if (state == &dev->states[i])
> +			break;
> +
> +	local_irq_disable();
> +	local_fiq_disable();
> +
> +	do_gettimeofday(&before);
> +
> +	imx_cpu_do_idle(i);
> +
> +	do_gettimeofday(&after);
> +
> +	local_fiq_enable();
> +	local_irq_enable();
> +
> +	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
> +			(after.tv_usec - before.tv_usec);
> +
> +	return idle_time;
> +}
> +
> +static struct cpuidle_driver imx_cpuidle_driver = {
> +	.name =         "imx_idle",
> +	.owner =        THIS_MODULE,
> +};
> +
> +static DEFINE_PER_CPU(struct cpuidle_device, imx_cpuidle_device);
> +
> +static int __init imx_cpuidle_init(void)
> +{
> +	struct cpuidle_device *device;
> +	int i;
> +
> +	#define MXC_X_MACRO(a, b, c) #a
> +	char *mxc_cpuidle_state_name[] = MXC_CPUIDLE_TABLE;
> +	#undef MXC_X_MACRO
> +
> +	#define MXC_X_MACRO(a, b, c) b
> +	char *mxc_cpuidle_state_desc[] = MXC_CPUIDLE_TABLE;
> +	#undef MXC_X_MACRO
> +
> +	if (imx_cpuidle_params == NULL)
> +		return -ENODEV;
> +
> +	cpuidle_register_driver(&imx_cpuidle_driver);
> +
> +	device = &per_cpu(imx_cpuidle_device, smp_processor_id());
> +	device->state_count = MXC_NUM_CPUIDLE_STATES;
> +
> +	for (i = 0; i < MXC_NUM_CPUIDLE_STATES && i < CPUIDLE_STATE_MAX; i++) {
> +		device->states[i].enter = imx_enter_idle;
> +		device->states[i].exit_latency = imx_cpuidle_params[i].latency;
> +		device->states[i].flags = CPUIDLE_FLAG_TIME_VALID;
> +		strcpy(device->states[i].name, mxc_cpuidle_state_name[i]);
> +		strcpy(device->states[i].desc, mxc_cpuidle_state_desc[i]);
> +	}
> +
> +	if (cpuidle_register_device(device)) {
> +		printk(KERN_ERR "imx_cpuidle_init: Failed registering\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +late_initcall(imx_cpuidle_init);
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
