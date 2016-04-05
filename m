From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 5 Apr 2016 11:38:12 +0530
Subject: [PATCH v5 1/6] pwms: pwm-ti*: Get the clock from the PWMSS
 (parent)
In-Reply-To: <1457400224-24797-2-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-2-git-send-email-fcooper@ti.com>
Message-ID: <5703564C.7090700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 March 2016 06:53 AM, Franklin S Cooper Jr wrote:
> The eCAP and ePWM doesn't have their own separate clocks. They simply
> utilize the clock provided directly by the PWMSS. Therefore, they simply
> need to grab a reference to their parent's clock.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

So this assumes that eCAP and eHRPWM are always under the PWMSS
umbrella. But on TI AM18x, thats not true. These IPs exist independently
and receive functional clock from PLL sysclk outputs.

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

Even keeping the AM18x usecase aside, this seems to be pushing too much
platform information into the driver. The "fck" is a valid connection id
for the eCAP IP. Whether its valid for the parent device too is not
something this driver should need to know.

So it looks like what you need is for the clock hierarchy for the
platform to have clocks for eHRPWM and eCAP derived out of PWMSS clock?

Thanks,
Sekhar
