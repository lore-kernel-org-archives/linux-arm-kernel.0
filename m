From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 May 2012 21:51:07 +0800
Subject: [PATCH 1/2] gpio/generic: initialize basic_mmio_gpio shadow
 variables properly
In-Reply-To: <1337240103-4756-2-git-send-email-shawn.guo@linaro.org>
References: <1337240103-4756-1-git-send-email-shawn.guo@linaro.org>
 <1337240103-4756-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120518135104.GC5427@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Linus,

Can we manage to get it in with the upcoming merge window, as it fixes
a bug that we may not want to live with for another cycle?

Regards,
Shawn

On Thu, May 17, 2012 at 03:35:02PM +0800, Shawn Guo wrote:
> It fixes the issue in gpio-generic that commit fb14921 (gpio/mxc: add
> missing initialization of basic_mmio_gpio shadow variables) manged to
> fix in gpio-mxc driver, so that other platform specific drivers do not
> suffer from the same problem over and over again.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/gpio/gpio-generic.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
> index e38dd0c..cfc9439 100644
> --- a/drivers/gpio/gpio-generic.c
> +++ b/drivers/gpio/gpio-generic.c
> @@ -394,6 +394,10 @@ int bgpio_init(struct bgpio_chip *bgc, struct device *dev,
>  		return ret;
>  
>  	bgc->data = bgc->read_reg(bgc->reg_dat);
> +	if (bgc->gc.set == bgpio_set_set)
> +		bgc->data = bgc->read_reg(bgc->reg_set);
> +	if (bgc->reg_dir)
> +		bgc->dir = bgc->read_reg(bgc->reg_dir);
>  
>  	return ret;
>  }
> -- 
> 1.7.5.4
> 
