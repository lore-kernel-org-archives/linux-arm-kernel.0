From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 4 Aug 2015 16:20:17 +0300
Subject: [PATCH v4 15/16] clk: shmobile: mstp: Consider "zb_clk" suitable
 for power management
In-Reply-To: <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
 <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
Message-ID: <55C0BC11.3030509@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/04/2015 03:28 PM, Geert Uytterhoeven wrote:

> Currently the CPG/MSTP Clock Domain code looks for MSTP clocks to power
> manage a device.

> Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
> the Bus State Controller (BSC) is not power-managed by an MSTP clock,
> but by a plain CPG clock (zb_clk).  Add a special case to handle this,
> so the clock is properly managed, and devices connected to the BSC work
> as expected.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
[...]

> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index b1df7b2f1e970adb..a117c3f0f257b5e1 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c
> @@ -259,6 +259,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
>   					    "renesas,cpg-mstp-clocks"))
>   			goto found;
>
> +		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock*/

    Please add a space before */.

> +		if (!strcmp(clkspec.np->name, "zb_clk"))
> +			goto found;
> +
>   		of_node_put(clkspec.np);
>   		i++;
>   	}

MBR, Sergei
