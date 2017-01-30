From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Jan 2017 08:58:14 -0800
Subject: [PATCH v2] mmc: meson-gx: set max block count
In-Reply-To: <0309625d-e24b-13e1-bba7-ada6b5a202c1@gmail.com> (Heiner
 Kallweit's message of "Sat, 28 Jan 2017 09:25:35 +0100")
References: <0309625d-e24b-13e1-bba7-ada6b5a202c1@gmail.com>
Message-ID: <m2k29ctrh5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> So far max_blk_count isn't set what results in a default of value 8
> to be used (PAGE_SIZE / block size).

This describes the problem...
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - block length field has 9 bits, so set max_blk_count to 2^9-1 = 511
> - in addition set max_req_size because max_blk_count is also limited
>   by max_req_size / block_size

... and this part describes the fix, so should also be in the changelog.

with an updated changelog, feel free to add:

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 83361f1f..d4d174ed 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -810,6 +810,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>  		goto free_host;
>  	}
>  
> +	mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
> +	mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
>  	mmc->ops = &meson_mmc_ops;
>  	mmc_add_host(mmc);
