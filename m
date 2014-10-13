From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 13 Oct 2014 08:12:13 +0200
Subject: [PATCH 2/3] pwm: push up dynamic printk level on errors in
 of_pwm_get()
In-Reply-To: <1412956207-24008-3-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1412956207-24008-3-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20141013081213.286b775a@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Vladimir Zapolskiy wrote:
> The changed three user messages on fault are printed under pr_debug(),
> however all of them are unrecoverable and result in failed pwm device
> registration, report this to a user.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 681d154..ccf1be7 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -532,19 +532,19 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>  	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
>  					 &args);
>  	if (err) {
> -		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
> +		pr_warn("%s(): can't parse \"pwms\" property\n", __func__);
>
As this is an error that leads to not loading the driver it should be
printed with ERROR level.

>  		return ERR_PTR(err);
>  	}
>  
>  	pc = of_node_to_pwmchip(args.np);
>  	if (IS_ERR(pc)) {
> -		pr_debug("%s(): PWM chip not found\n", __func__);
> +		pr_warn("%s(): PWM chip not found\n", __func__);
>
dto.

>  		goto put;
>  	}
>  
>  	if (args.args_count != pc->of_pwm_n_cells) {
> -		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
> +		pr_warn("%s: wrong #pwm-cells for %s\n", np->full_name,
>
dto.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
