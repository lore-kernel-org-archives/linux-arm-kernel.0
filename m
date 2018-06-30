From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Jun 2018 18:22:31 -0300
Subject: [PATCH] i.MX6: Allow thermal probe to fail gracefully in case of
 bad calibration.
In-Reply-To: <20180630205404.25568-1-jcd@tribudubois.net>
References: <20180630205404.25568-1-jcd@tribudubois.net>
Message-ID: <CAOMZO5BqpwxZ4+hWwuoK0uhb9a61oSj4LhrxHm9dyy6JAWH2fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Sat, Jun 30, 2018 at 5:54 PM, Jean-Christophe Dubois
<jcd@tribudubois.net> wrote:
> Without this fix, the thermal probe on i.MX6 might trigger a division
> by zero exception later in the probe if the calibration does fail.
>
> Note: This linux behavior (Division by zero in kernel) has been triggered
> on a Qemu i.MX6 emulation where parameters in nvmem were not set. With this
> fix the division by zero is not triggeed anymore as the thermal probe does
> fail early.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>

Nit: subject could be improved to:

thermal: imx: Allow probe to fail gracefully in case of bad calibration

Also, you missed to Cc the thermal maintainers.

Please run ./scripts/get_maintainer.pl -f
drivers/thermal/imx_thermal.c and add these people and lists on v2 of
the patch.

> ---
>  drivers/thermal/imx_thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index 334d98be03b9..b1f82d64253e 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -604,7 +604,10 @@ static int imx_init_from_nvmem_cells(struct platform_device *pdev)
>         ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
>         if (ret)
>                 return ret;
> -       imx_init_calib(pdev, val);
> +
> +       ret = imx_init_calib(pdev, val);
> +       if (ret)
> +               return ret;

This looks good:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
