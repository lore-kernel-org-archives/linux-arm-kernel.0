From: balbi@ti.com (Felipe Balbi)
Date: Sat, 2 Mar 2013 13:49:35 +0200
Subject: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting
 irq type
In-Reply-To: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Message-ID: <20130302114934.GB9965@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 11:22:48AM -0600, Jon Hunter wrote:
> For OMAP devices, if a gpio is being used as an interrupt source but has
> not been requested by calling gpio_request(), a call to request_irq()
> may cause the kernel hang because the gpio bank may be disabled and
> hence the register access will fail. To prevent such hangs, test for
> this case and warn if this is detected.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index c3598d1..0d30c7a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -427,6 +427,9 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>  	int retval;
>  	unsigned long flags;
>  
> +	if (WARN_ON(!bank->mod_usage))

It would be better to use WARN(!bank->mod_usage, "error message\n") IMO.

no strong feelings however:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130302/236f9c77/attachment.sig>
