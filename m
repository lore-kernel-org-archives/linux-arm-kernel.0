From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 10 Aug 2011 03:23:45 +0800
Subject: [PATCH] pxa/hx4700: Set DS1WM clock_rate
In-Reply-To: <E1Qqp5V-0000FE-DF@outmx01.plus.net>
References: <E1Qqp5V-0000FE-DF@outmx01.plus.net>
Message-ID: <CAMPhdO_xL_sUui-22p27oAw52YHnBhm90cn12t5eJsdRLnUfNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 12:23 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The mfd/asic3 driver did not set the ds1wm_driver_data.clock_rate field before
> passing the structure to the ds1wm cell driver. By chance, ds1wm_find_divisor()
> returned the correct divisor when this zero clock_rate was passed in. However
> a recent change to ds1wm_find_divisor() removed this unintended behaviour. This
> patch explicitly sets the ds1wm_driver_data.clock_rate field.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
> diff -uprN clean-3.0.1/arch/arm/mach-pxa/hx4700.c linux-3.0.1/arch/arm/mach-pxa/hx4700.c
> --- clean-3.0.1/arch/arm/mach-pxa/hx4700.c ? ? ?2011-08-05 05:59:21.000000000 +0100
> +++ linux-3.0.1/arch/arm/mach-pxa/hx4700.c ? ? ?2011-08-07 23:02:18.653447085 +0100
> @@ -310,6 +310,7 @@ static struct asic3_platform_data asic3_
> ? ? ? ?.gpio_config_num = ARRAY_SIZE(asic3_gpio_config),
> ? ? ? ?.irq_base ? ? ? ?= IRQ_BOARD_START,
> ? ? ? ?.gpio_base ? ? ? = HX4700_ASIC3_GPIO_BASE,
> + ? ? ? .clock_rate ? ? ?= 4000000,
> ?};
>
> ?static struct platform_device asic3 = {
> diff -uprN clean-3.0.1/drivers/mfd/asic3.c linux-3.0.1/drivers/mfd/asic3.c
> --- clean-3.0.1/drivers/mfd/asic3.c ? ? 2011-08-05 05:59:21.000000000 +0100
> +++ linux-3.0.1/drivers/mfd/asic3.c ? ? 2011-08-07 23:02:18.653447085 +0100
> @@ -867,10 +867,13 @@ static int __init asic3_mfd_probe(struct
> ? ? ? ?asic3_mmc_resources[0].start >>= asic->bus_shift;
> ? ? ? ?asic3_mmc_resources[0].end ? >>= asic->bus_shift;
>
> - ? ? ? ret = mfd_add_devices(&pdev->dev, pdev->id,
> + ? ? ? if (pdata->clock_rate) {
> + ? ? ? ? ? ? ? ds1wm_pdata.clock_rate = pdata->clock_rate;
> + ? ? ? ? ? ? ? ret = mfd_add_devices(&pdev->dev, pdev->id,
> ? ? ? ? ? ? ? ? ? ? ? ?&asic3_cell_ds1wm, 1, mem, asic->irq_base);
> - ? ? ? if (ret < 0)
> - ? ? ? ? ? ? ? goto out;
> + ? ? ? ? ? ? ? if (ret < 0)
> + ? ? ? ? ? ? ? ? ? ? ? goto out;
> + ? ? ? }

Or this parent driver can silently pass the clock_rate to ds1wm sub-driver
without the if () condition, as it leaves to the sub-driver to decide whether
it's a valid value, unless you want to use 'clock_rate' to explicitly control
the registration of the sub-device.

>
> ? ? ? ?if (mem_sdio && (irq >= 0)) {
> ? ? ? ? ? ? ? ?ret = mfd_add_devices(&pdev->dev, pdev->id,
> diff -uprN clean-3.0.1/include/linux/mfd/asic3.h linux-3.0.1/include/linux/mfd/asic3.h
> --- clean-3.0.1/include/linux/mfd/asic3.h ? ? ? 2011-08-05 05:59:21.000000000 +0100
> +++ linux-3.0.1/include/linux/mfd/asic3.h ? ? ? 2011-08-07 23:02:18.653447085 +0100
> @@ -31,6 +31,8 @@ struct asic3_platform_data {
>
> ? ? ? ?unsigned int gpio_base;
>
> + ? ? ? unsigned int clock_rate;
> +
> ? ? ? ?struct asic3_led *leds;
> ?};
>
>
>
