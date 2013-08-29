From: syin@broadcom.com (Sherman Yin)
Date: Thu, 29 Aug 2013 17:35:08 +0000
Subject: [PATCH] pinctrl: sunxi: drop lock on error path
In-Reply-To: <1377796784-31147-1-git-send-email-linus.walleij@linaro.org>
References: <1377796784-31147-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <051069C10411E24D9749790C498526FA1BDE04FD@SJEXCHMB12.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>@@ -291,8 +291,10 @@ static int sunxi_pconf_group_set(struct pinctrl_dev
>*pctldev,
> 		switch (pinconf_to_config_param(configs[i])) {
> 		case PIN_CONFIG_DRIVE_STRENGTH:
> 			strength = pinconf_to_config_argument(configs[i]);
>-			if (strength > 40)
>+			if (strength > 40) {
>+				spin_unlock_irqrestore(&pctl->lock, flags);
> 				return -EINVAL;
>+			}
> 			/*
> 			 * We convert from mA to what the register expects:
> 			 *   0: 10mA

Looks good.

Regards,
Sherman
