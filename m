From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 15:11:15 +0100
Subject: [PATCH] ARM64: tegra: Add support for Google Pixel C
In-Reply-To: <568E65F0.2070201@nvidia.com>
References: <1452073222-2956-1-git-send-email-jonathanh@nvidia.com>
 <568D0D70.4020309@nvidia.com> <568E65F0.2070201@nvidia.com>
Message-ID: <4442990.rM1mk43t6M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 January 2016 13:19:44 Jon Hunter wrote:
> 
> Adding Arnd.
> 
> Hmmm ... well apparently stdout-path does not work for tegra and in
> order to make this work I had to do the following ...
> 
> 
> [PATCH] serial: 8250: of: Add earlycon support for Tegra
> 
> Currently, early console support only works for Tegra when the serial
> port information is passed via the earlycon boot parameter. If the
> serial port information is specified via device-tree using the
> "stdout-path" then the early console does not work because:
> 
> 1. The tegra serial ports compatibility parameter does not match any
>    of the supported serial drivers for early console.
> 2. The of_setup_earlycon() function assumes that serial port registers
>    are byte aligned and for tegra they are 32-bit aligned.
> 
> Add an early console setup function for tegra so that the early console
> can be specified via the device-tree "stdout-path" variable.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/tty/serial/8250/8250_of.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 33021c1f7d55..98adf83e83c2 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -44,6 +44,16 @@ void tegra_serial_handle_break(struct uart_port *p)
>                 udelay(1);
>         } while (1);
>  }
> +
> +int __init tegra_earlycon_setup(struct earlycon_device *device,
> +                               const char *options)
> +{
> +       device->port.iotype = UPIO_MEM32;
> +       device->port.regshift = 2;
> +
> +       return early_serial8250_setup(device, options);
> +}
> +OF_EARLYCON_DECLARE(tegra20_uart, "nvidia,tegra20-uart", tegra_earlycon_setup);
>  #else
>  static inline void tegra_serial_handle_break(struct uart_port *port)
>  {
> 
> 
> Arnd, does the above look ok, or should there be a generic
> early_serial8250x32_setup() somewhere?

I think it would be better to put it into 8250_early.c rather than 
8250_of.c, as there are already some other definitions in there,
and the #ifdef CONFIG_TEGRA in 8250_of.c is for some other workaround.

Would it be possible to handle the "reg-io-width" parsing in
early_serial8250_setup instead of keying it off the string?

	Arnd
