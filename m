From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Apr 2012 13:55:49 -0600
Subject: [PATCH v2 2/2] pinctrl: show pin name for pingroups in sysfs
In-Reply-To: <1334646046-467-2-git-send-email-b29396@freescale.com>
References: <1334646046-467-1-git-send-email-b29396@freescale.com>
 <1334646046-467-2-git-send-email-b29396@freescale.com>
Message-ID: <4F8DCAC5.6000706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2012 01:00 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Pin name is more useful to users.
...
> @@ -964,10 +984,14 @@ static int pinctrl_groups_show(struct seq_file *s, void *what)
>  			seq_printf(s, "%s [ERROR GETTING PINS]\n",
>  				   gname);
>  		else {
> -			seq_printf(s, "group: %s, pins = [ ", gname);
> -			for (i = 0; i < num_pins; i++)
> -				seq_printf(s, "%d ", pins[i]);
> -			seq_puts(s, "]\n");
> +			seq_printf(s, "group: %s\n", gname);
> +			for (i = 0; i < num_pins; i++) {
> +				pname = pin_get_name(pctldev, pins[i]);
> +				if (WARN_ON(!pname))
> +					return -EINVAL;

The main issue I had here was that the loop should continue rather than
erroring out. Still, I suppose this condition "can't" happen, so perhaps
that isn't such a big deal after all. So:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

> +				seq_printf(s, "pin %d (%s)\n", pins[i], pname);
> +			}
