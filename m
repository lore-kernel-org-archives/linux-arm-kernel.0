From: fcooper@ti.com (Franklin S Cooper Jr.)
Date: Thu, 17 Mar 2016 17:37:18 -0500
Subject: [PATCH v5 1/6] pwms: pwm-ti*: Get the clock from the PWMSS
 (parent)
In-Reply-To: <1457400224-24797-2-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-2-git-send-email-fcooper@ti.com>
Message-ID: <56EB319E.3050502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gentle ping on this

On 03/07/2016 07:23 PM, Franklin S Cooper Jr wrote:
> The eCAP and ePWM doesn't have their own separate clocks. They simply
> utilize the clock provided directly by the PWMSS. Therefore, they simply
> need to grab a reference to their parent's clock.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  drivers/pwm/pwm-tiecap.c   | 2 +-
>  drivers/pwm/pwm-tiehrpwm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
> index 616af76..9418159 100644
> --- a/drivers/pwm/pwm-tiecap.c
> +++ b/drivers/pwm/pwm-tiecap.c
> @@ -212,7 +212,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
>  	if (!pc)
>  		return -ENOMEM;
>  
> -	clk = devm_clk_get(&pdev->dev, "fck");
> +	clk = devm_clk_get(pdev->dev.parent, "fck");
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
>  		return PTR_ERR(clk);
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 6a41e66..09dc1bc 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -443,7 +443,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
>  	if (!pc)
>  		return -ENOMEM;
>  
> -	clk = devm_clk_get(&pdev->dev, "fck");
> +	clk = devm_clk_get(pdev->dev.parent, "fck");
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "failed to get clock\n");
>  		return PTR_ERR(clk);
