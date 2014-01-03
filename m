From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 2 Jan 2014 23:45:11 -0800
Subject: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140103074511.GA10680@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiubo,

On Fri, Jan 03, 2014 at 01:24:21PM +0800, Xiubo Li wrote:
> +
> +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> +					       enum fsl_pwm_clk index)
> +{

Why do you declare this (and other module-local) function as inline?
It is usually better let compiler decide if given function should be
inlined or not.

[...]

> +
> +static int fsl_pwm_remove(struct platform_device *pdev)
> +{
> +	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&fpc->lock);
> +
> +	return pwmchip_remove(&fpc->chip);

fpc->lock will be used while pwmchip_remove() is running so you should
not be destroying it before calling pwmchip_remove(). It should probbaly
go into free() method or just drop it altogether.

Thanks.

-- 
Dmitry
