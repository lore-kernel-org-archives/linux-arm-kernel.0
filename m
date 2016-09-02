From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Fri, 2 Sep 2016 13:07:52 -0300
Subject: [PATCHv2] pwm: lpc-18xx: use pwm_set_chip_data
In-Reply-To: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
References: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
Message-ID: <30dc5bbd-8005-7bb1-1b72-9c40510d1b07@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

On 08/25/2016 01:47 PM, Olliver Schinagl wrote:
> The lpc18xx driver currently manipulates the pwm_device struct directly
> rather then using the pwm_set_chip_data. While the current method may
> save a clock cycle or two, it is more obvious that data is set to
> the local chip data pointer.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Reviewed-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

> ---
> Hi,
> 
> This is a resend of a patch-series I sent last year. There was no technical
> related feedback and so I am re-sending the patch as is. I did rebase it to
> Linus's current master.
> 
> Changes since v1:
> 	- removed wrongfully added sun4i patch
> 	- split patch series into a single patch
> 	- added author
> 
>  drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 19dc64c..a630fc5 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -413,14 +413,17 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
> +		struct lpc18xx_pwm_data *lpc18xx_data;
> +
>  		pwm = &lpc18xx_pwm->chip.pwms[i];
> -		pwm->chip_data = devm_kzalloc(lpc18xx_pwm->dev,
> -					      sizeof(struct lpc18xx_pwm_data),
> -					      GFP_KERNEL);
> -		if (!pwm->chip_data) {
> +		lpc18xx_data = devm_kzalloc(lpc18xx_pwm->dev,
> +					    sizeof(struct lpc18xx_pwm_data),
> +					    GFP_KERNEL);
> +		if (!lpc18xx_data) {
>  			ret = -ENOMEM;
>  			goto remove_pwmchip;
>  		}
> +		pwm_set_chip_data(pwm, lpc18xx_data);
>  	}
>  
>  	platform_set_drvdata(pdev, lpc18xx_pwm);
> 

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
