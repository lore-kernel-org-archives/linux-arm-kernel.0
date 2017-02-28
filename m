From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 28 Feb 2017 14:27:23 +0530
Subject: [PATCH v3 3/6] ARM: davinci: da8xx: add pdata-quirks for VPIF
 capture
In-Reply-To: <1487772805-19021-4-git-send-email-bgolaszewski@baylibre.com>
References: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
 <1487772805-19021-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <2a3c9c5e-b61b-806e-0bd2-e6989328780a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2017 07:43 PM, Bartosz Golaszewski wrote:
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
> [Bartosz: removed unnecessary #ifdefs]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da8xx-dt.c     |   1 +
>  arch/arm/mach-davinci/pdata-quirks.c | 104 +++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index e3cef50..5699ce3 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -53,6 +53,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
>  	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
>  	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
> +	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),

You don't talk about adding OF_DEV_AUXDATA in patch description. Can you
either add description for this change or spin it into a separate patch?
I prefer the later, but will take it either way.

> +static void __init da850_vpif_legacy_init(void)
> +{
> +	int ret;
> +
> +	/* LCDK doesn't have the 2nd TVP514x on CH1 */
> +	if (of_machine_is_compatible("ti,da850-lcdk"))
> +		da850_vpif_capture_config.subdev_count = 1;

Since you anyway register quirk for lcdk separately, you can as well
create da850_lcdk_vpif_capture_init() which sets subdev_count to 1
unconditionally.

Also, since you rename the function to add "capture" down the series,
you can as well have that name from the start. It will make the later
patches easier to read.

Thanks,
Sekhar
