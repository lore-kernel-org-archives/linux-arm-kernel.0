From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Feb 2017 15:22:59 +0530
Subject: [PATCH 2/4] ARM: davinci: da8xx: add pdata-quirks for VPIF capture
In-Reply-To: <1487269285-6948-3-git-send-email-bgolaszewski@baylibre.com>
References: <1487269285-6948-1-git-send-email-bgolaszewski@baylibre.com>
 <1487269285-6948-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <de4558ee-c31c-e8d9-7c53-972dcb7422ea@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2017 11:51 PM, Bartosz Golaszewski wrote:
> From: Kevin Hilman <khilman@baylibre.com>
> 
> For da8xx DT platforms, use pdata-quirks to add legacy platform data for
> vpif_capture driver.
> 
> Passing legacy platform_data is required until the V4L2 framework, and
> subdevice drivers (such as the tvp514x) grow a way of selecting input
> and output routing  (c.f. V4L2 s_routing API)
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

[...]

>  static struct pdata_init pdata_quirks[] __initdata = {
> +#if IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE)
> +	{ "ti,da850-lcdk", da850_vpif_legacy_init, },
> +#if defined(CONFIG_DA850_UI_SD_VIDEO_PORT)
> +	{ "ti,da850-evm", da850_vpif_legacy_init, },
> +#endif

We should remove these ifdefs around device registration. Devices should
be registered irrespective of driver support. Also, these were being
used in the board file to drive selection gpios. That functionality
should now move to drivers.

Thanks,
Sekhar
