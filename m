From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Jul 2015 22:27:02 +0200
Subject: [PATCH 3/9] gpio: Allow hogged gpios to be requested
In-Reply-To: <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20150717202702.GK7013@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jul 17, 2015 at 11:32:44AM +0200, Markus Pargmann wrote:
> It can be useful to claim hogged gpios later, for example from
> userspace. This allows to set defaults for GPIOs using the hogging
> mechanism and override the setup later from userspace or a kernel driver.
> 
> This patch adds a check for hogged gpios to allow requesting them. If
> the gpio is not hogged but marked as requested, it still fails with
> -EBUSY.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/gpio/gpiolib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index bf4bd1d120c3..9f402b159cbe 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -798,7 +798,8 @@ static int __gpiod_request(struct gpio_desc *desc, const char *label)
>  	 * before IRQs are enabled, for non-sleeping (SOC) GPIOs.
>  	 */
>  
> -	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0) {
> +	if (test_and_set_bit(FLAG_REQUESTED, &desc->flags) == 0 ||
> +	    test_and_clear_bit(FLAG_IS_HOGGED, &desc->flags) == 1) {
>  		desc_set_label(desc, label ? : "?");
>  		status = 0;
I don't like this patch. IMHO hogging is a "use" of a GPIO that should
prevent it being requested.

While I think it's useful to be able to export some hogged pins I don't
think this should be possible for all hogged pins unconditionally. And
for gpios being used by drivers I'd expect they don't need to be hogged
at all.

I don't have a good idea how to solve that. Adding another property to a
gpio that should be allowd to be exported can hardly count as hardware
description and so doesn't belong in a device tree?!

Please don't consider this objection as a reason for a NACK, only as
starting point for a discussion.

Apart from that: Does this result in hogged gpios being able to be
requested by two additional drivers in parallel? Maybe the IS_HOGGED
flag should be dropped when the gpio is requested?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
