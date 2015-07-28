From: johan@kernel.org (Johan Hovold)
Date: Tue, 28 Jul 2015 11:58:42 +0200
Subject: [PATCH 9/9] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <1437125570-28623-10-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-10-git-send-email-mpa@pengutronix.de>
Message-ID: <20150728095842.GO28535@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 11:32:50AM +0200, Markus Pargmann wrote:
> Add some information about gpio names to the debugfs gpio file. name and
> label of a GPIO are then displayed next to each other. This way it is
> easy to see what the real name of GPIO is and what the driver requested
> it for.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/gpio/gpiolib.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index dcac3bcf21dd..0f1d1f5faf5d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2308,14 +2308,19 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>  	int			is_irq;
>  
>  	for (i = 0; i < chip->ngpio; i++, gpio++, gdesc++) {
> -		if (!test_bit(FLAG_REQUESTED, &gdesc->flags))
> +		if (!test_bit(FLAG_REQUESTED, &gdesc->flags)) {
> +			if (gdesc->name) {
> +				seq_printf(s, " gpio-%-3d (%-20.20s)\n",
> +					   gpio, gdesc->name);
> +			}

So now we'd no longer just be listing requested gpios, but on a similar
format to how requested ones used to be represented.

Then there's the debugfs as ABI discussion...

Johan
