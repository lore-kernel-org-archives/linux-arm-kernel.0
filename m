From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Nov 2012 17:25:51 -0800
Subject: [PATCH v4 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <1352301582-12244-10-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-10-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121108012550.GV6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:22]:
> Dump pinmux register value, not only function part in the pinmux
> register.
> 
> Also fix the issue on caluclating pin offset. The last parameter
> should be pin number, not register offset.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-single.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 77aec05..243a9ca 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -286,15 +286,15 @@ static int pcs_get_group_pins(struct pinctrl_dev *pctldev,
>  
>  static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
>  					struct seq_file *s,
> -					unsigned offset)
> +					unsigned pin)
>  {
>  	struct pcs_device *pcs;
> -	unsigned val;
> +	unsigned val, mux_bytes;
>  
>  	pcs = pinctrl_dev_get_drvdata(pctldev);
>  
> -	val = pcs->read(pcs->base + offset);
> -	val &= pcs->fmask;
> +	mux_bytes = pcs->width / BITS_PER_BYTE;
> +	val = pcs->read(pcs->base + pin * mux_bytes);
>  
>  	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
>  }
> -- 
> 1.7.10.4
> 
