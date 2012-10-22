From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 15:27:44 -0700
Subject: [PATCH v2 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <1350922139-3693-10-git-send-email-haojian.zhuang@gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
 <1350922139-3693-10-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121022222744.GM4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121022 09:13]:
> Dump pinmux register value, not only function part in the pinmux
> register.

This makes sense, but should be done using pcs_read, not pcs_readl,
see below.

> Also fix the issue on caluclating pin offset. The last parameter
> should be pin number, not register offset.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-single.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index a20da78..6ba2a5d 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -284,15 +284,15 @@ static int pcs_get_group_pins(struct pinctrl_dev *pctldev,
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
> +	val = pcs_readl(pcs->base + pin * mux_bytes);
>  
>  	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
>  }

You should not use pcs_readl here directly as the register
width can vary. Can you please update the patch for that and
make it independent from the rest of the series? That way we
can merge the fix for v3.7-rc series.

Regards,

Tony
