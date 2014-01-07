From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Jan 2014 00:04:04 +0400
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
Message-ID: <52CC5DB4.6070205@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-01-2014 22:57, Geert Uytterhoeven wrote:

> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

> When using DT to instantiate the rcar-thermal device, it prints the
> following error:

>      rcar_thermal e61f0000.thermal: thermal sensor was broken

> Explicitly request and enable the thermal clock to fix this.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>   drivers/thermal/rcar_thermal.c |   40 +++++++++++++++++++++++++++++++++-------
>   1 file changed, 33 insertions(+), 7 deletions(-)

> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 88f92e1a9944..a5629500723a 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
[...]
> @@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device *pdev)
[...]
> +	ret = clk_prepare(common->clk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to prepare clock\n");
> +		return ret;
> +	}
> +
> +	clk_enable(common->clk);
> +

    Why not just clk_prepare_enable()?

[...]
> @@ -465,9 +484,13 @@ error_unregister:
>   			rcar_thermal_irq_disable(priv);
>   	}
>
> +error_unpm:
>   	pm_runtime_put_sync(dev);
>   	pm_runtime_disable(dev);
>
> +	clk_disable(common->clk);
> +	clk_unprepare(common->clk);
> +

    Why not just clk_disable_unprepare()?

>   	return ret;
>   }
>
> @@ -486,6 +509,9 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>   	pm_runtime_put_sync(dev);
>   	pm_runtime_disable(dev);
>
> +	clk_disable(common->clk);
> +	clk_unprepare(common->clk);
> +

    Likewise.

WBR, Sergei
