From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Jun 2014 13:59:44 +0200
Subject: [PATCH v2 3/5] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to request_resources
In-Reply-To: <1401544899-405-4-git-send-email-hdegoede@redhat.com>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
 <1401544899-405-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20140602115944.GE27722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 04:01:37PM +0200, Hans de Goede wrote:
> With level triggered interrupt mask / unmask will get called for each
> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> not a good idea. Instead add a request_resources callback and do it there.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index c199337..61d3246 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -531,6 +531,19 @@ static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>  	return irq_find_mapping(pctl->domain, desc->irqnum);
>  }
>  
> +static int sunxi_pinctrl_irq_request_resources(struct irq_data *d)
> +{
> +	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> +	struct sunxi_desc_function *func;
> +
> +	func = sunxi_pinctrl_desc_find_function_by_pin(pctl,
> +					pctl->irq_array[d->hwirq], "irq");

I know you're just moving code here, but we should add a check for
func being !NULL here, otherwise, the kernel is going to blow up at
the next line.

And since gpio_to_irq might not be called before the request_irq, you
might be in such a case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/f95a9644/attachment.sig>
