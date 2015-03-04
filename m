From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 4 Mar 2015 15:10:00 -0800
Subject: [PATCH 06/10] iio: exynos-adc: add experimental touchscreen
 support
In-Reply-To: <1425299763-4066822-7-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-7-git-send-email-arnd@arndb.de>
Message-ID: <20150304231000.GD38298@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 02, 2015 at 01:35:59PM +0100, Arnd Bergmann wrote:
> This adds support for the touchscreen on Samsung s3c64xx.
> The driver is completely untested but shows roughly how
> it could be done, following the example of the at91 driver.
> 
> compared to the old plat-samsung/adc driver, there is
> no support for prioritizing ts over other clients, nor
> for oversampling. From my reading of the code, the
> priorities didn't actually have any effect at all, but
> the oversampling might be needed.
> 
> Verifying this driver is the main issue that is currently
> holding up multiplatform support for s3c64xx, so any help
> in testing is very much appreciated.
> 
> The current version uses the IS_REACHABLE() that is
> going to be introduced in the linux-media tree, please
> comment this out for testing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |   3 +
>  drivers/iio/adc/exynos_adc.c                       | 222 ++++++++++++++++++++-
>  2 files changed, 218 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> index f46ca9a316a2..ccaaec6014bd 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
> @@ -47,6 +47,9 @@ Required properties:
>  
>  - samsung,syscon-phandle Contains the PMU system controller node
>  			(To access the ADC_PHY register on Exynos5250/5420/5800/3250)
> +Optional properties:
> +- has-touchscreen:	If present, indicates that a touchscreen is
> +			connected an usable.
>  
>  Note: child nodes can be added for auto probing from device tree.
>  
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 3a2dbb3b4926..75cd381a8181 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -35,6 +35,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/of_platform.h>
>  #include <linux/err.h>
> +#include <linux/input.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/machine.h>
> @@ -42,12 +43,18 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/platform_data/touchscreen-s3c2410.h>
> +
>  /* S3C/EXYNOS4412/5250 ADC_V1 registers definitions */
>  #define ADC_V1_CON(x)		((x) + 0x00)
> +#define ADC_V1_TSC(x)		((x) + 0x04)
>  #define ADC_V1_DLY(x)		((x) + 0x08)
>  #define ADC_V1_DATX(x)		((x) + 0x0C)
> +#define ADC_V1_DATY(x)		((x) + 0x10)
> +#define ADC_V1_UPDN(x)		((x) + 0x14)
>  #define ADC_V1_INTCLR(x)	((x) + 0x18)
>  #define ADC_V1_MUX(x)		((x) + 0x1c)
> +#define ADC_V1_CLRINTPNDNUP(x)	((x) + 0x20)
>  
>  /* S3C2410 ADC registers definitions */
>  #define ADC_S3C2410_MUX(x)	((x) + 0x18)
> @@ -71,6 +78,30 @@
>  #define ADC_S3C2410_DATX_MASK	0x3FF
>  #define ADC_S3C2416_CON_RES_SEL	(1u << 3)
>  
> +/* touch screen always uses channel 0 */
> +#define ADC_S3C2410_MUX_TS	0
> +
> +/* ADCTSC Register Bits */
> +#define ADC_S3C2443_TSC_UD_SEN		(1u << 8)
> +#define ADC_S3C2410_TSC_YM_SEN		(1u << 7)
> +#define ADC_S3C2410_TSC_YP_SEN		(1u << 6)
> +#define ADC_S3C2410_TSC_XM_SEN		(1u << 5)
> +#define ADC_S3C2410_TSC_XP_SEN		(1u << 4)
> +#define ADC_S3C2410_TSC_PULL_UP_DISABLE	(1u << 3)
> +#define ADC_S3C2410_TSC_AUTO_PST	(1u << 2)
> +#define ADC_S3C2410_TSC_XY_PST(x)	(((x) & 0x3) << 0)
> +
> +#define ADC_TSC_WAIT4INT (ADC_S3C2410_TSC_YM_SEN | \
> +			 ADC_S3C2410_TSC_YP_SEN | \
> +			 ADC_S3C2410_TSC_XP_SEN | \
> +			 ADC_S3C2410_TSC_XY_PST(3))
> +
> +#define ADC_TSC_AUTOPST	(ADC_S3C2410_TSC_YM_SEN | \
> +			 ADC_S3C2410_TSC_YP_SEN | \
> +			 ADC_S3C2410_TSC_XP_SEN | \
> +			 ADC_S3C2410_TSC_AUTO_PST | \
> +			 ADC_S3C2410_TSC_XY_PST(0))
> +
>  /* Bit definitions for ADC_V2 */
>  #define ADC_V2_CON1_SOFT_RESET	(1u << 2)
>  
> @@ -88,7 +119,9 @@
>  /* Bit definitions common for ADC_V1 and ADC_V2 */
>  #define ADC_CON_EN_START	(1u << 0)
>  #define ADC_CON_EN_START_MASK	(0x3 << 0)
> +#define ADC_DATX_PRESSED	(1u << 15)
>  #define ADC_DATX_MASK		0xFFF
> +#define ADC_DATY_MASK		0xFFF
>  
>  #define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(100))
>  
> @@ -98,17 +131,24 @@
>  struct exynos_adc {
>  	struct exynos_adc_data	*data;
>  	struct device		*dev;
> +	struct input_dev	*input;
>  	void __iomem		*regs;
>  	struct regmap		*pmu_map;
>  	struct clk		*clk;
>  	struct clk		*sclk;
>  	unsigned int		irq;
> +	unsigned int		tsirq;
> +	unsigned int		delay;
>  	struct regulator	*vdd;
>  
>  	struct completion	completion;
>  
>  	u32			value;
>  	unsigned int            version;
> +
> +	bool			read_ts;
> +	u32			ts_x;
> +	u32			ts_y;
>  };
>  
>  struct exynos_adc_data {
> @@ -197,6 +237,9 @@ static void exynos_adc_v1_init_hw(struct exynos_adc *info)
>  	/* Enable 12-bit ADC resolution */
>  	con1 |= ADC_V1_CON_RES;
>  	writel(con1, ADC_V1_CON(info->regs));
> +
> +	/* set touchscreen delay */
> +	writel(info->delay, ADC_V1_DLY(info->regs));
>  }
>  
>  static void exynos_adc_v1_exit_hw(struct exynos_adc *info)
> @@ -480,8 +523,8 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  	if (info->data->start_conv)
>  		info->data->start_conv(info, chan->address);
>  
> -	timeout = wait_for_completion_timeout
> -			(&info->completion, EXYNOS_ADC_TIMEOUT);
> +	timeout = wait_for_completion_timeout(&info->completion,
> +					      EXYNOS_ADC_TIMEOUT);
>  	if (timeout == 0) {
>  		dev_warn(&indio_dev->dev, "Conversion timed out! Resetting\n");
>  		if (info->data->init_hw)
> @@ -498,13 +541,55 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
> +{
> +	struct exynos_adc *info = iio_priv(indio_dev);
> +	unsigned long timeout;
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	info->read_ts = true;
> +
> +	reinit_completion(&info->completion);
> +
> +	writel(ADC_S3C2410_TSC_PULL_UP_DISABLE | ADC_TSC_AUTOPST,
> +	       ADC_V1_TSC(info->regs));
> +
> +	/* Select the ts channel to be used and Trigger conversion */
> +	info->data->start_conv(info, ADC_S3C2410_MUX_TS);
> +
> +	timeout = wait_for_completion_timeout(&info->completion,
> +					      EXYNOS_ADC_TIMEOUT);
> +	if (timeout == 0) {
> +		dev_warn(&indio_dev->dev, "Conversion timed out! Resetting\n");
> +		if (info->data->init_hw)
> +			info->data->init_hw(info);
> +		ret = -ETIMEDOUT;
> +	} else {
> +		*x = info->ts_x;
> +		*y = info->ts_y;
> +		ret = 0;
> +	}
> +
> +	info->read_ts = false;
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
>  {
>  	struct exynos_adc *info = (struct exynos_adc *)dev_id;
>  	u32 mask = info->data->mask;
>  
>  	/* Read value */
> -	info->value = readl(ADC_V1_DATX(info->regs)) & mask;
> +	if (info->read_ts) {
> +		info->ts_x = readl(ADC_V1_DATX(info->regs));
> +		info->ts_y = readl(ADC_V1_DATY(info->regs));
> +		writel(ADC_TSC_WAIT4INT | ADC_S3C2443_TSC_UD_SEN, ADC_V1_TSC(info->regs));
> +	} else {
> +		info->value = readl(ADC_V1_DATX(info->regs)) & mask;
> +	}
>  
>  	/* clear irq */
>  	if (info->data->clear_irq)
> @@ -515,6 +600,46 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Here we (ab)use a threaded interrupt handler to stay running
> + * for as long as the touchscreen remains pressed, we report
> + * a new event with the latest data and then sleep until the
> + * next timer tick. This mirrors the behavior of the old
> + * driver, with much less code.
> + */
> +static irqreturn_t exynos_ts_isr(int irq, void *dev_id)
> +{
> +	struct exynos_adc *info = dev_id;
> +	struct iio_dev *dev = dev_get_drvdata(info->dev);
> +	u32 x, y;
> +	bool pressed;
> +	int ret;
> +
> +	while (info->input->users) {
> +		ret = exynos_read_s3c64xx_ts(dev, &x, &y);
> +		if (ret == -ETIMEDOUT)
> +			break;
> +
> +		pressed = x & y & ADC_DATX_PRESSED;
> +		if (!pressed) {
> +			input_report_key(info->input, BTN_TOUCH, 0);
> +			input_sync(info->input);
> +			break;
> +		}
> +
> +		input_report_abs(info->input, ABS_X, x & ADC_DATX_MASK);
> +		input_report_abs(info->input, ABS_Y, y & ADC_DATY_MASK);
> +		input_report_key(info->input, BTN_TOUCH, 1);
> +		input_sync(info->input);
> +
> +		msleep(1);
> +	};
> +
> +	writel(0, ADC_V1_CLRINTPNDNUP(info->regs));
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int exynos_adc_reg_access(struct iio_dev *indio_dev,
>  			      unsigned reg, unsigned writeval,
>  			      unsigned *readval)
> @@ -566,18 +691,70 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
>  	return 0;
>  }
>  
> +static int exynos_adc_ts_open(struct input_dev *dev)
> +{
> +	struct exynos_adc *info = input_get_drvdata(dev);
> +
> +	enable_irq(info->tsirq);
> +
> +	return 0;
> +}
> +
> +static void exynos_adc_ts_close(struct input_dev *dev)
> +{
> +	struct exynos_adc *info = input_get_drvdata(dev);
> +
> +	disable_irq(info->tsirq);
> +}
> +
> +static int exynos_adc_ts_init(struct exynos_adc *info)
> +{
> +	int ret;
> +
> +	if (info->tsirq <= 0)
> +		return -ENODEV;
> +
> +	info->input = input_allocate_device();
> +	if (!info->input)
> +		return -ENOMEM;
> +
> +	info->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	info->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +	input_set_abs_params(info->input, ABS_X, 0, 0x3FF, 0, 0);
> +	input_set_abs_params(info->input, ABS_Y, 0, 0x3FF, 0, 0);
> +
> +	info->input->name = "S3C24xx TouchScreen";
> +	info->input->id.bustype = BUS_HOST;
> +	info->input->open = exynos_adc_ts_open;
> +	info->input->close = exynos_adc_ts_close;
> +
> +	input_set_drvdata(info->input, info);
> +
> +	ret = input_register_device(info->input);
> +	if (ret)
> +		input_free_device(info->input);


If you fail to register input device are you sure you want to continue
and register interrupt?

> +
> +	disable_irq(info->tsirq);
> +	ret = request_threaded_irq(info->tsirq, NULL, exynos_ts_isr,
> +				   0, "touchscreen", info);
> +	if (ret)
> +		input_unregister_device(info->input);
> +
> +	return ret;
> +}
> +
>  static int exynos_adc_probe(struct platform_device *pdev)
>  {
>  	struct exynos_adc *info = NULL;
>  	struct device_node *np = pdev->dev.of_node;
> +	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
>  	struct iio_dev *indio_dev = NULL;
>  	struct resource	*mem;
> +	bool has_ts = false;
>  	int ret = -ENODEV;
>  	int irq;
>  
> -	if (!np)
> -		return ret;
> -
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
>  	if (!indio_dev) {
>  		dev_err(&pdev->dev, "failed allocating iio device\n");
> @@ -613,8 +790,14 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "no irq resource?\n");
>  		return irq;
>  	}
> -
>  	info->irq = irq;
> +
> +	irq = platform_get_irq(pdev, 1);
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +
> +	info->tsirq = irq;
> +
>  	info->dev = &pdev->dev;
>  
>  	init_completion(&info->completion);
> @@ -680,6 +863,22 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	if (info->data->init_hw)
>  		info->data->init_hw(info);
>  
> +	/* leave out any TS related code if unreachable */
> +	if (IS_REACHABLE(CONFIG_INPUT)) {
> +		has_ts = of_property_read_bool(pdev->dev.of_node,
> +					       "has-touchscreen") || pdata;
> +	}
> +
> +	if (pdata)
> +		info->delay = pdata->delay;
> +	else
> +		info->delay = 10000;
> +
> +	if (has_ts)
> +		ret = exynos_adc_ts_init(info);
> +	if (ret)
> +		goto err_iio;
> +
>  	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed adding child nodes\n");
> @@ -691,6 +890,11 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  err_of_populate:
>  	device_for_each_child(&indio_dev->dev, NULL,
>  				exynos_adc_remove_devices);
> +	if (has_ts) {
> +		input_unregister_device(info->input);
> +		free_irq(info->tsirq, info);
> +	}
> +err_iio:
>  	iio_device_unregister(indio_dev);
>  err_irq:
>  	free_irq(info->irq, info);
> @@ -710,6 +914,10 @@ static int exynos_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct exynos_adc *info = iio_priv(indio_dev);
>  
> +	if (IS_REACHABLE(CONFIG_INPUT)) {
> +		free_irq(info->tsirq, info);
> +		input_unregister_device(info->input);
> +	}
>  	device_for_each_child(&indio_dev->dev, NULL,
>  				exynos_adc_remove_devices);
>  	iio_device_unregister(indio_dev);
> -- 
> 2.1.0.rc2
> 

Thanks.

-- 
Dmitry
