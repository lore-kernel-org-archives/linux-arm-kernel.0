From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 13 Jun 2013 02:01:43 +0200
Subject: [RFC PATCH v3 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <1370512763-32200-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370512763-32200-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130613000143.GB4567@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

I don't particularily like this code, but I guess most of my dislike
comes from the whole bridge interface API and how that forces you into
implementing pretty much static code.
A few nitpicks:

On Thu, Jun 06, 2013 at 10:59:23AM +0100, Lorenzo Pieralisi wrote:
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index d54e985..391eda1 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1148,3 +1148,10 @@ config VEXPRESS_CONFIG
>  	help
>  	  Platform configuration infrastructure for the ARM Ltd.
>  	  Versatile Express.
> +
> +config VEXPRESS_SPC
> +	bool "Versatile Express SPC driver support"
> +	depends on ARM
> +	depends on VEXPRESS_CONFIG
> +	help
Please provide a detailed help entry here. 


> +	  Serial Power Controller driver for ARM Ltd. test chips.
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 718e94a..3a01203 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -153,5 +153,6 @@ obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
>  obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
>  obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o vexpress-sysreg.o
> +obj-$(CONFIG_VEXPRESS_SPC)	+= vexpress-spc.o
So you have Versatile Express platforms that will not need SPC ? i.e.
why isn't all that stuff under a generic CONFIG_VEXPRESS symbol ?



> +static struct vexpress_spc_drvdata *info;
> +static u32 *vexpress_spc_config_data;
> +static struct vexpress_config_bridge *vexpress_spc_config_bridge;
> +static struct vexpress_config_func *opp_func, *perf_func;
> +
> +static int vexpress_spc_load_result = -EAGAIN;
As I said, quite static...

> +irqreturn_t vexpress_spc_irq_handler(int irq, void *data)
missing a static here ?


> +static bool __init __vexpress_spc_check_loaded(void);
> +/*
> + * Pointer spc_check_loaded is swapped after init hence it is safe
> + * to initialize it to a function in the __init section
> + */
> +static bool (*spc_check_loaded)(void) __refdata = &__vexpress_spc_check_loaded;
> +
> +static bool __init __vexpress_spc_check_loaded(void)
> +{
> +	if (vexpress_spc_load_result == -EAGAIN)
> +		vexpress_spc_load_result = vexpress_spc_init();
> +	spc_check_loaded = &vexpress_spc_initialized;
> +	return vexpress_spc_initialized();
> +}
> +
> +/*
> + * Function exported to manage early_initcall ordering.
> + * SPC code is needed very early in the boot process
> + * to bring CPUs out of reset and initialize power
> + * management back-end. After boot swap pointers to
> + * make the functionality check available to loadable
> + * modules, when early boot init functions have been
> + * already freed from kernel address space.
> + */
> +bool vexpress_spc_check_loaded(void)
> +{
> +	return spc_check_loaded();
> +}
> +EXPORT_SYMBOL_GPL(vexpress_spc_check_loaded);
That one and the previous function look really nasty to me.
The simple fact that you need a static variable in your code to check if
your module is loaded sounds really fishy.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
