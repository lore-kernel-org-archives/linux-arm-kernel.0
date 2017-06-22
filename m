From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Jun 2017 08:31:57 +0200
Subject: [PATCH 1/9] serial: Add common rs485 device tree parsing function
In-Reply-To: <20170621102130.21024-2-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
 <20170621102130.21024-2-u.kleine-koenig@pengutronix.de>
Message-ID: <20170622063157.qih2mriprczpj7zn@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 12:21:22PM +0200, Uwe Kleine-K?nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Several drivers have the same device tree parsing code. Create
> a common helper function for it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/Kconfig  |  4 ++++
>  drivers/tty/serial/Makefile |  2 ++
>  drivers/tty/serial/of.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h | 12 ++++++++++++
>  4 files changed, 63 insertions(+)
>  create mode 100644 drivers/tty/serial/of.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 5c8850f7a2a0..8baef5b95bed 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -14,6 +14,10 @@ config SERIAL_EARLYCON
>  	  the console before standard serial driver is probed. The console is
>  	  enabled when early_param is processed.
>  
> +config OF_SERIAL
> +	depends on SERIAL_CORE
> +	def_bool y
> +
>  source "drivers/tty/serial/8250/Kconfig"
>  
>  comment "Non-8250 serial port support"
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 53c03e005132..0fee8f4e36cb 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -7,6 +7,8 @@ obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
>  
> +obj-$(CONFIG_OF_SERIAL) += of.o
> +
>  # These Sparc drivers have to appear before others such as 8250
>  # which share ttySx minor node space.  Otherwise console device
>  # names change and other unplesantries.
> diff --git a/drivers/tty/serial/of.c b/drivers/tty/serial/of.c
> new file mode 100644
> index 000000000000..660a8cb09b44
> --- /dev/null
> +++ b/drivers/tty/serial/of.c
> @@ -0,0 +1,45 @@
> +#include <linux/kernel.h>
> +#include <linux/export.h>
> +#include <linux/of.h>
> +#include <linux/serial_core.h>
> +
> +/**
> + * of_get_rs485_mode() - Implement parsing rs485 properties
> + * @np: uart node
> + * @rs485conf: output parameter
> + *
> + * This function implements the device tree binding described in
> + * Documentation/devicetree/bindings/serial/rs485.txt.
> + *
> + * Return: 0 on success, 1 if the node doesn't contain rs485 stuff, or a
> + * negative error code.
> + */
> +int of_get_rs485_mode(struct device_node *np, struct serial_rs485 *rs485conf)
> +{
> +	u32 rs485_delay[2];
> +	int ret;
> +
> +	ret = of_property_read_u32_array(np, "rs485-rts-delay" rs485_delay, 2);
> +	if (ret == -EINVAL) /* property does not exist */
> +		return 1;

As the de-facto standard for the drivers implementing the rs485 bindings
is to make the properties optional, despite the documentation. Wouldn't
it be better to make this property optional in the binding instead? This
wouldn't unnecessarily break old device trees and 0/0 seems a sane
default we can use when the property doesn't exist.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
