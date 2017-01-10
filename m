From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 10 Jan 2017 14:20:09 +0300
Subject: [PATCH] usb: dwc3-exynos fix unspecified suspend clk error
 handling
In-Reply-To: <20170110022131.31042-1-shuahkh@osg.samsung.com>
References: <20170110022131.31042-1-shuahkh@osg.samsung.com>
Message-ID: <82fb5295-6640-7e9e-a42a-4067aa88e5b4@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 01/10/2017 05:21 AM, Shuah Khan wrote:

> Fix dwc3_exynos_probe() to call clk_prepare_enable() only when suspend
> clock is specified. Call clk_disable_unprepare() from remove and probe
> error path only when susp_clk has been set from remove and probe error
> paths.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index e27899b..f97a3d7 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -131,8 +131,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	if (IS_ERR(exynos->susp_clk)) {
>  		dev_info(dev, "no suspend clk specified\n");
>  		exynos->susp_clk = NULL;
> -	}
> -	clk_prepare_enable(exynos->susp_clk);
> +	} else
> +		clk_prepare_enable(exynos->susp_clk);

    CodingStyle: need {} here as well since another branch has them.

[...]

MBR, Sergei
