From: marex@denx.de (Marek Vasut)
Date: Sat, 22 Jun 2013 04:28:44 +0200
Subject: [PATCH v1 12/12] input: matrix-keypad: add diagnostics in probe()
In-Reply-To: <1371838198-7327-13-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-13-git-send-email-gsi@denx.de>
Message-ID: <201306220428.44614.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerhard Sittig,

> optionally dump relevant configuration of pins, matrix lines,
> and delay/interval times at the very end of the probe routine
> (development feature, silent by default)
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  drivers/input/keyboard/matrix_keypad.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c
> b/drivers/input/keyboard/matrix_keypad.c index 275b157..69b15720 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -800,6 +800,24 @@ static int matrix_keypad_probe(struct platform_device
> *pdev) device_init_wakeup(&pdev->dev, pdata->wakeup);
>  	platform_set_drvdata(pdev, keypad);
> 
> +	dev_dbg(&pdev->dev, "gpios col num[%u] lvl[%s] drv[%s] enc[%s]\n",
> +		pdata->num_col_gpios,
> +		pdata->col_gpios_active_low ? "low" : "high",
> +		pdata->col_gpios_push_pull ? "pp" : "od",
> +		pdata->col_gpios_binary_encoded ? "bin" : "1-1");
> +	dev_dbg(&pdev->dev, "gpios row num[%u] lvl[%s]\n",
> +		pdata->num_row_gpios,
> +		pdata->row_gpios_active_low ? "low" : "high");
> +	dev_dbg(&pdev->dev, "matrix cols[%u] rows[%u] code shift[%u]\n",
> +		pdata->num_matrix_cols,
> +		pdata->num_matrix_rows,
> +		keypad->row_shift);
> +	dev_dbg(&pdev->dev, "times scan[%u-%u] bounce[%u] switch[%u]\n",
> +		pdata->col_scan_delay_us,
> +		pdata->col_scan_delay_us_max,
> +		pdata->debounce_ms,
> +		pdata->col_switch_delay_ms);
> +

It's a bit hard to understand this kind of debug output. Besides, we already 
have all the DT props in /proc/device-tree where you can check them , do we 
really need this patch then ?

>  	return 0;
> 
>  err_free_gpio:

Best regards,
Marek Vasut
