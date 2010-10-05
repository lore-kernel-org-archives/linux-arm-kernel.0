From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Oct 2010 14:25:06 +0200
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <1286279904-4378-2-git-send-email-yong.shen@linaro.org>
References: <1286279904-4378-1-git-send-email-yong.shen@linaro.org>
	<1286279904-4378-2-git-send-email-yong.shen@linaro.org>
Message-ID: <201010051425.06523.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Yong Shen <yong.shen@linaro.org>
> 
> it is tested on babbage 3.0

One big comment and a couple of smaller ones:

It would be better to make this code a proper device driver,
probably a platform_driver unless you have a way to probe
the presence of the registers on another bus.

Making it a driver that registers to a bus lets you separate
the probing from the implementation, and gives you a structure
to add your private variables to.

> @@ -43,6 +43,10 @@
>  #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
>  #define	MX51_USB_PLL_DIV_24_MHZ	0x02
>  
> +
> +extern struct cpu_wp *mx51_get_cpu_wp(int *wp);
> +struct cpu_wp *(*get_cpu_wp)(int *wp);
> +
>  static struct platform_device *devices[] __initdata = {
>  	&mxc_fec_device,
>  };

Please put the extern declarations into a header file, not
in the implementation.

> @@ -246,6 +250,7 @@ static void __init mxc_board_init(void)
>  
>  static void __init mx51_babbage_timer_init(void)
>  {
> +	get_cpu_wp = mx51_get_cpu_wp;
>  	mx51_clocks_init(32768, 24000000, 22579200, 0);
>  }

It feels like mx51_babbage_timer_init() is not the right place
to initialize this. Why not the mxc_board_init function?

> +#define SPIN_DELAY	1000000 /* in nanoseconds */
>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>  
>  static int _clk_ccgr_enable(struct clk *clk)

The SPIN_DELAY variable doesn't seem to be used anywhere.

> @@ -330,6 +338,32 @@ static int _clk_lp_apm_set_parent(struct clk *clk, struct clk *parent)
>  	return 0;
>  }
>  
> +/*!
> + * Setup cpu clock based on working point.
> + * @param	wp	cpu freq working point
> + * @return		0 on success or error code on failure.
> + */
> +int cpu_clk_set_wp(int wp)
> +{

could be 'static'.

> +	struct cpu_wp *p;
> +	u32 reg;
> +
> +	if (wp == cpu_curr_wp)
> +		return 0;
> +
> +	p = &cpu_wp_tbl[wp];
> +
> +	/*use post divider to change freq
> +	 */
> +	reg = __raw_readl(MXC_CCM_CACRR);
> +	reg &= ~MXC_CCM_CACRR_ARM_PODF_MASK;
> +	reg |= cpu_wp_tbl[wp].cpu_podf << MXC_CCM_CACRR_ARM_PODF_OFFSET;
> +	__raw_writel(reg, MXC_CCM_CACRR);
> +	cpu_curr_wp = wp;
> +
> +	return 0;
> +}

This might need a spinlock to protect concurrent register access.

Don't use __raw_readl but readl/ioread32, which have more well-defined
behaviour.

> +int cpu_freq_khz_min;
> +int cpu_freq_khz_max;
> +int arm_lpm_clk;
> +int arm_normal_clk;
> +int cpufreq_suspended;
> +int cpufreq_trig_needed;

You should not have private variables in the global name space like this.
At least mark everything static that is only used in one file. Any
global variable must (local variables should) be prefixed with the
name of the driver like:

static int mxc_cpufreq_khz_min;
static int mxc_cpufreq_khz_max;
static int mxc_lpm_clk;

This will become more important when we move to multiplatform kernels.

> +extern int set_low_bus_freq(void);
> +extern int set_high_bus_freq(int high_bus_speed);
> +extern int low_freq_bus_used(void);
> +
> +extern struct cpu_wp *(*get_cpu_wp)(int *wp);
> +static int cpu_wp_nr;
> +static struct cpu_wp *cpu_wp_tbl;

The same rules apply for functions.

Again, anything that can not be static should be declared in a
header file.

> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");

Please put your name and email address in here.

> +#ifndef CONFIG_ARCH_MX5
> +struct cpu_wp *get_cpu_wp(int *wp);
> +#endif

Do not enclose declarations in #ifdef. Anybody should be able to
just enable your driver anyway without getting conflicts.

	Arnd
