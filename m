From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2011 16:02:32 +0000
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
Message-ID: <201111251602.35227.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

In addition to the good comments made by other people, here
are some other high-level comments:

On Thursday 24 November 2011, Peter Rusko wrote:
> This patch is based on the Freescale SDK 2010.08. It supports the on-chip
> Low Resolution ADC and a capacitive touchscreen connected to it.
> 
> Tested on Ka-Ro TX28 module
> 
> Signed-off-by: Peter Rusko <rusko.peter@prolan.hu>
> ---
>  arch/arm/mach-mxs/devices-mx28.h                |    6 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-mxs-lradc.c  |   25 +
>  arch/arm/mach-mxs/devices/platform-mxs-ts.c     |   34 +
>  arch/arm/mach-mxs/include/mach/devices-common.h |   22 +
>  arch/arm/mach-mxs/include/mach/lradc.h          |   61 ++
>  arch/arm/mach-mxs/include/mach/mx28.h           |    4 +-
>  arch/arm/mach-mxs/include/mach/regs-lradc.h     |  772 +++++++++++++++++++++++
>  drivers/input/touchscreen/Kconfig               |   11 +
>  drivers/input/touchscreen/Makefile              |    1 +
>  drivers/input/touchscreen/mxs_ts.c              |  470 ++++++++++++++
>  drivers/misc/Kconfig                            |    3 +
>  drivers/misc/Makefile                           |    1 +
>  drivers/misc/mxs_lradc.c                        |  381 +++++++++++
>  15 files changed, 1793 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-lradc.c
>  create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-ts.c
>  create mode 100644 arch/arm/mach-mxs/include/mach/lradc.h
>  create mode 100644 arch/arm/mach-mxs/include/mach/regs-lradc.h
>  create mode 100644 drivers/input/touchscreen/mxs_ts.c
>  create mode 100644 drivers/misc/mxs_lradc.c

The driver layering seems to be suboptimal: You have a huge header file
with register definitions and then two drivers including that. It would
be much better to have all the low-level logic in the adc driver and
put only the interface between the two drivers into the header file.

> diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
> index a8080f4..e86b193 100644
> --- a/arch/arm/mach-mxs/include/mach/devices-common.h
> +++ b/arch/arm/mach-mxs/include/mach/devices-common.h
> @@ -76,6 +76,12 @@ struct mxs_mxs_i2c_data {
>  struct platform_device * __init mxs_add_mxs_i2c(
>  		const struct mxs_mxs_i2c_data *data);
>  
> +/* lradc */
> +struct mxs_lradc_plat_data {
> +	unsigned int vddio_voltage;
> +	unsigned int battery_voltage;
> +};
> +
>  /* mmc */
>  #include <mach/mmc.h>
>  struct mxs_mxs_mmc_data {
> @@ -104,3 +110,19 @@ struct mxs_saif_data {
>  
>  struct platform_device *__init mxs_add_saif(
>  		const struct mxs_saif_data *data);
> +
> +/* touchscreen */
> +struct mxs_touchscreen_plat_data {
> +	u8 x_plus_chan;
> +	u8 x_minus_chan;
> +	u8 y_plus_chan;
> +	u8 y_minus_chan;
> +	unsigned int x_plus_val;
> +	unsigned int x_minus_val;
> +	unsigned int y_plus_val;
> +	unsigned int y_minus_val;
> +	unsigned int x_plus_mask;
> +	unsigned int x_minus_mask;
> +	unsigned int y_plus_mask;
> +	unsigned int y_minus_mask;
> +};

Platform data nowadays is defined in include/linux/platform_data/.
We are not at the point where we do mass-moves from arch directories
there, but I think it would be useful to put new data into that
location.

> diff --git a/arch/arm/mach-mxs/include/mach/lradc.h b/arch/arm/mach-mxs/include/mach/lradc.h
> new file mode 100644
> index 0000000..c2c0a7d

> +
> +int hw_lradc_use_channel(int);
> +int hw_lradc_unuse_channel(int);
> +extern u32 hw_lradc_vddio(void);
> +void hw_lradc_set_delay_trigger_kick(int trigger, int value);
> +void hw_lradc_configure_channel(int channel, int enable_div2,
> +		int enable_acc, int samples);
> +int hw_lradc_present(int channel);
> +int hw_lradc_init_ladder(int channel, int trigger, unsigned sampling);
> +int hw_lradc_stop_ladder(int channel, int trigger);
> +void hw_lradc_set_delay_trigger(int trigger, u32 trigger_lradc,
> +		u32 delay_triggers, u32 loops, u32 delays);
> +void hw_lradc_clear_delay_trigger(int trigger, u32 trigger_lradc,
> +		u32 delay_triggers);

As indicated by Shawn, adding a new driver specific kernel-level ADC
interface is not a good idea. IIRC, the result of the last discussion
was that all ADC drivers should be part of IIO and you should use
the IIO in-kernel interfaces. Not sure what the state of that code
is, but if it's not in mainline yet, you should work with Jonathan
to make sure it gets there. Having more users for that code can
only speed up the process, and I'm going to refuse another ADC driver
in drivers/misc or arch/arm/mach-*/.

> diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
> index 75d8611..30c7990 100644
> --- a/arch/arm/mach-mxs/include/mach/mx28.h
> +++ b/arch/arm/mach-mxs/include/mach/mx28.h
> @@ -104,8 +104,8 @@
>  #define MX28_INT_CAN1			9
>  #define MX28_INT_LRADC_TOUCH		10
>  #define MX28_INT_HSADC			13
> -#define MX28_INT_IRADC_THRESH0		14
> -#define MX28_INT_IRADC_THRESH1		15
> +#define MX28_INT_LRADC_THRESH0		14
> +#define MX28_INT_LRADC_THRESH1		15
>  #define MX28_INT_LRADC_CH0		16
>  #define MX28_INT_LRADC_CH1		17
>  #define MX28_INT_LRADC_CH2		18

This seems to be a cleanup of existing code. While useful, it is not
part of the new driver submission, and would be better handled in a
separate patch, either before or after the new driver (changing all
users in the latter case).

> diff --git a/arch/arm/mach-mxs/include/mach/regs-lradc.h b/arch/arm/mach-mxs/include/mach/regs-lradc.h
> new file mode 100644
> index 0000000..d7906b9
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/regs-lradc.h
> @@ -0,0 +1,772 @@
> +/*
> + * Freescale LRADC Register Definitions

As mentioned, just include the contents of this file in the low-level
driver. Header files are for interfaces between source files.

> +#define HW_LRADC_CTRL0	(0x00000000)
> +#define HW_LRADC_CTRL0_SET	(0x00000004)
> +#define HW_LRADC_CTRL0_CLR	(0x00000008)
> +#define HW_LRADC_CTRL0_TOG	(0x0000000c)
> +
> +#define BM_LRADC_CTRL0_SFTRST	0x80000000
> +#define BM_LRADC_CTRL0_CLKGATE	0x40000000


This device seems to follow the "stmp" pattern for which Wolfram has
proposed an abstraction. I suppose you should be using that.
Also, it would appear to be a useful addition to provide
a set of inline functions for these registers like

stmp_reg_get(void __iomem *reg)
{
	return readl_relaxed(reg);
}

stmp_reg_set(void __iomem *reg, u32 mask)
{
	writel_relaxed(reg + 4, mask);
}

And then you can drop the four separate definitions for
each register.

> +#define BP_LRADC_CTRL0_RSRVD2	27
> +#define BM_LRADC_CTRL0_RSRVD2	0x38000000
> +#define BF_LRADC_CTRL0_RSRVD2(v)  \
> +		(((v) << 27) & BM_LRADC_CTRL0_RSRVD2)
> +#define BM_LRADC_CTRL0_ONCHIP_GROUNDREF	0x04000000
> +#define BV_LRADC_CTRL0_ONCHIP_GROUNDREF__OFF 0x0
> +#define BV_LRADC_CTRL0_ONCHIP_GROUNDREF__ON  0x1
> +#define BM_LRADC_CTRL0_BUTTON1_DETECT_ENABLE	0x02000000
> +#define BV_LRADC_CTRL0_BUTTON1_DETECT_ENABLE__OFF 0x0
> +#define BV_LRADC_CTRL0_BUTTON1_DETECT_ENABLE__ON  0x1
> +#define BM_LRADC_CTRL0_BUTTON0_DETECT_ENABLE	0x01000000
> +#define BV_LRADC_CTRL0_BUTTON0_DETECT_ENABLE__OFF 0x0
> +#define BV_LRADC_CTRL0_BUTTON0_DETECT_ENABLE__ON  0x1
> +#define BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE	0x00800000
> +#define BV_LRADC_CTRL0_TOUCH_DETECT_ENABLE__OFF 0x0
> +#define BV_LRADC_CTRL0_TOUCH_DETECT_ENABLE__ON  0x1

This is much more verbose than necessary, making it rather unreadable.
Why not just like this:?

enum {
	LRADC_CTRL0_ONCHIP_GROUNDREF		= 0x04000000,
	LRADC_CTRL0_BUTTON1_DETECT_ENABLE	= 0x02000000,
	LRADC_CTRL0_BUTTON0_DETECT_ENABLE	= 0x01000000,
	LRADC_CTRL0_TOUCH_DETECT_ENABLE		= 0x00800000,
	LRADC_CTRL0_TOUCH_SCREEN_TYPE		= 0x00400000,
	...
};

> +
> +static inline void enter_state_touch_detect(struct mxs_ts_info *info)
> +{
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->x_plus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->y_plus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->x_minus_chan));
> +	__raw_writel(0xFFFFFFFF,
> +		     info->base + HW_LRADC_CHn_CLR(info->y_minus_chan));
> +
> +	__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
> +		     info->base + HW_LRADC_CTRL1_CLR);
> +	__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
> +		     info->base + HW_LRADC_CTRL1_CLR);

Don't use __raw_writel/__raw_readl in drivers. readl_relaxed is
the right abstraction for non-DMA drivers with fixed-endian hardware
registers. If you need the driver to support both big- and little-
endian devices, roll your own hardware accessors as a wrapper around
that.

> +	/*
> +	 * turn off the yplus and yminus pullup and pulldown, and turn off touch
> +	 * detect (enables yminus, and xplus through a resistor.On a press,
> +	 * xplus is pulled down)
> +	 */
> +	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_SET);
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 0);
> +	info->state = TS_STATE_TOUCH_DETECT;
> +	info->sample_count = 0;
> +}
> +
> +static inline void enter_state_disabled(struct mxs_ts_info *info)
> +{
> +	__raw_writel(info->y_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->y_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_plus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(info->x_minus_mask, info->base + HW_LRADC_CTRL0_CLR);
> +	__raw_writel(BM_LRADC_CTRL0_TOUCH_DETECT_ENABLE,
> +		     info->base + HW_LRADC_CTRL0_CLR);
> +	hw_lradc_set_delay_trigger_kick(LRADC_DELAY_TRIGGER_TOUCHSCREEN, 0);
> +	info->state = TS_STATE_DISABLED;
> +	info->sample_count = 0;
> +}
> +
> +static inline void enter_state_x_plane(struct mxs_ts_info *info)
> +{
> ...
> +}
> +
> +static inline void enter_state_y_plane(struct mxs_ts_info *info)
> +{
> + ...
> +}
> +
> +static inline void enter_state_touch_verify(struct mxs_ts_info *info)
> +{
> + ...
> +}

When you do six almost identical functions, the natural thing to
do is to split out the common parts into a separate function.

> +static irqreturn_t ts_handler(int irq, void *dev_id)
> +{
> +	struct mxs_ts_info *info = dev_id;
> +	u16 x_plus, y_plus;
> +	int pressure = 0;
> +
> +	if (irq == info->touch_irq)
> +		__raw_writel(BM_LRADC_CTRL1_TOUCH_DETECT_IRQ,
> +			     info->base + HW_LRADC_CTRL1_CLR);
> +	else if (irq == info->device_irq)
> +		__raw_writel(BM_LRADC_CTRL1_LRADC0_IRQ << info->y_minus_chan,
> +			     info->base + HW_LRADC_CTRL1_CLR);
> +
> +	/* get x, y values */
> +	x_plus = __raw_readl(info->base + HW_LRADC_CHn(info->x_plus_chan)) &
> +		BM_LRADC_CHn_VALUE;
> +	y_plus = __raw_readl(info->base + HW_LRADC_CHn(info->y_plus_chan)) &
> +		BM_LRADC_CHn_VALUE;
> +
> +	/* pressed? */
> +	if (__raw_readl(info->base + HW_LRADC_STATUS) &
> +	    BM_LRADC_STATUS_TOUCH_DETECT_RAW)
> +		pressure = 1;
> +
> +	pr_debug("%s: irq %d, x_plus %d, y_plus %d, pressure %d\n",
> +			__func__, irq, x_plus, y_plus, pressure);
> +
> +	process_lradc(info, x_plus, y_plus, pressure);
> +
> +	return IRQ_HANDLED;
> +}

The interrupt handler seems to be rather heavyweight (with process_lradc). Have you
considered using a work queue or a threaded IRQ handler?

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		printk(KERN_ERR "%s: couldn't get MEM resource\n", __func__);
> +		ret = -ENODEV;
> +		goto out_nodev;
> +	}
> +	info->base = (unsigned int)MXS_IO_ADDRESS(res->start);

One line, two bugs:

1. A base address is not an integer, it's a '(void __iomem *)' pointer,
   and so should be all variables you assign it to.
2. Never use MXS_IO_ADDRESS (or similar macros) in device drivers. Instead,
   call ioremap to get an iomem token for the physical address. Your
   code is non-portable and much more fragile in case the architecture code
   changes how it works with the mmio mapping.

> --- /dev/null
> +++ b/drivers/misc/mxs_lradc.c
> @@ -0,0 +1,381 @@
>
> +
> +struct lradc_device {
> +	struct sys_device sys;
> +	unsigned int base;
> +	unsigned int vddio_voltage;
> +	unsigned int battery_voltage;
> +};
> +
> +static int channels[8];
> +
> +static __refdata struct lradc_device mxs_lradc;
> +
> +int hw_lradc_use_channel(int channel)
> +{
> +	if (channel < 0 || channel > 7)
> +		return -EINVAL;
> +	channels[channel]++;
> +	return 0;
> +}
> +EXPORT_SYMBOL(hw_lradc_use_channel);
> +
> +int hw_lradc_unuse_channel(int channel)
> +{
> +	if (channel < 0 || channel > 7)
> +		return -EINVAL;
> +	channels[channel]--;
> +	return 0;
> +}
> +EXPORT_SYMBOL(hw_lradc_unuse_channel);

As mentioned, the API will have to change with the move to IIO, but
remember anyway to use EXPORT_SYMBOL_GPL() for new interfaces unless
you have a good (and well-documented) reason not to.

> +static int __init lradc_freq_setup(char *str)
> +{
> +	long freq;
> +
> +	if (kstrtol(str, 0, &freq) < 0)
> +		return 0;
> +
> +	if (freq < 0)
> +		return 0;
> +	if (freq >= 6)
> +		lradc_freq = LRADC_CLOCK_6MHZ;
> +	else if (freq >= 4)
> +		lradc_freq = LRADC_CLOCK_4MHZ;
> +	else if (freq >= 3)
> +		lradc_freq = LRADC_CLOCK_3MHZ;
> +	else if (freq >= 2)
> +		lradc_freq = LRADC_CLOCK_2MHZ;
> +	else
> +		return 0;
> +	return 1;
> +}
> +
> +__setup("lradc_freq=", lradc_freq_setup);

Why is this a command line argument? Can't you put it into the platform data
or hardcode it?

	Arnd
