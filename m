From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Jan 2017 10:28:22 -0800
Subject: [PATCH] mmc: meson-gx: set max block count to 256
In-Reply-To: <82cf7861-5cf8-302d-5354-435282d95619@gmail.com> (Heiner
 Kallweit's message of "Thu, 26 Jan 2017 23:09:01 +0100")
References: <82cf7861-5cf8-302d-5354-435282d95619@gmail.com>
Message-ID: <m2lgtwuzll.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> So far max_blk_count isn't set what results in a default of value 8
> to be used (PAGE_SIZE / block size).
>
> Set max_blk_count to 256 as used in the uboot driver.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for the patch. A minor comment below:

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 3308b5b6..030425be 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -799,6 +799,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  		goto free_host;
>  	}
>  
> +	mmc->max_blk_count = 256;

A step in the right direction, but the # blocks is actually a 9-bit
field (c.f. length field of cmd_cfg part of descriptor (bits 8:0).

So this should be more like:

	/* blk count is 'length' field of cmd_cfg part of descriptor */
	mmc->max_blk_count = CMD_CFG_LENGTH_MASK + 1;

I tested that change locally, so after changing that, please resend and
feel free to add:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
