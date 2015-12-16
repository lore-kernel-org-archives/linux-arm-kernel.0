From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Dec 2015 17:27:47 +0100
Subject: [PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode timers
In-Reply-To: <5637458D.60106@baylibre.com>
References: <5637458D.60106@baylibre.com>
Message-ID: <20151216162747.GL28947@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 12:14:21PM +0100, Neil Armstrong wrote:
> Adds support for using a OMAP dual-mode timer with PWM capability
> as a Linux PWM device. The driver controls the timer by using the
> dmtimer API.
> 
> Add a platform_data structure for each pwm-omap-dmtimer nodes containing
> the dmtimers functions in order to get driver not rely on platform
> specific functions.
> 
> Cc: Grant Erickson <marathon96@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
>  drivers/pwm/Kconfig                                |   9 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++++++++
>  include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
>  create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
>  create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

I've applied this with some coding style bikeshedding applied. Also I
think there's a timer leak in the probe function:

> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
[...]
> +static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> +{
[...]
> +	dm_timer = pdata->request_by_node(timer);
> +	if (!dm_timer)
> +		return -EPROBE_DEFER;

dm_timer holds the requested timer now.

> +
> +	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
> +	if (!omap)
> +		return -ENOMEM;

But it's not released when this allocation fails...

> +
> +	omap->pdata = pdata;
> +	omap->dm_timer = dm_timer;
> +	omap->dm_timer_pdev = of_find_device_by_node(timer);
> +	if (!omap->dm_timer_pdev) {
> +		dev_err(&pdev->dev, "Unable to find timer pdev\n");
> +		return -EINVAL;
> +	}

... nor when this lookup fails. I've taken the liberty of adding two
calls to omap->pdata->free(dm_timer) to these error paths.

Please take a look at what's in the pwm/for-next branch to see if it
still works correctly.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/3a336f85/attachment.sig>
