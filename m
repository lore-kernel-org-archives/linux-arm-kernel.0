From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Jun 2017 17:28:36 +0200
Subject: [RFT 1/2] pinctrl: samsung: Fix NULL pointer exception on
 external interrupts on S3C24xx
In-Reply-To: <44ca46f9-0607-d750-4f26-eab717518fd9@163.com>
References: <20170614131828.28683-1-krzk@kernel.org>
 <44ca46f9-0607-d750-4f26-eab717518fd9@163.com>
Message-ID: <20170615152836.j6y4k4ydkterifii@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 10:42:30PM +0800, Yao Lihua wrote:
> Hi Krzysztof,
> 
> Another Oops on S3C6410.

(...)

 > diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > index f542642eed8d..a25c3ffae25c 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > @@ -1013,6 +1013,11 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
> >   		bank->eint_base = virt_base[0];
> >   		bank->pctl_base = virt_base[bdata->pctl_res_idx];
> >   	}
> > +	/*
> > +	 * For legacy platforms which need to access IO memory through
> > +	 * samsung_pinctrl_drv_data:
> > +	 */
> > +	d->virt_base = virt_base[bdata->pctl_res_idx];
> > 
>     for (i = 0; i < ctrl->nr_banks; ++i, ++bdata, ++bank) {
>         ......
>     }
>     /*
>      * For legacy platforms which need to access IO memory through
>      * samsung_pinctrl_drv_data:
>      */
>     d->virt_base = virt_base[bdata->pctl_res_idx];
>                                                     ^
>                                                      **bdata** is invalid here.

Ah, of course, apparently it worked in my case by coincidence. Thanks
for spotting this.


Best regards,
Krzysztof
