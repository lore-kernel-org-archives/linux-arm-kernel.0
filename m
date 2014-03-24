From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 11:28:21 +0000
Subject: [PATCH 6/8] tty/serial: pl011: add generic earlycon support
In-Reply-To: <1395436128-11244-7-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-7-git-send-email-robherring2@gmail.com>
Message-ID: <20140324112821.GE3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 09:08:46PM +0000, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Add earlycon support for the pl011 serial port. This allows enabling
> the pl011 for console when early_params are processed. This is based
> on the arm64 earlyprintk support and is intended to replace it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> ---
>  Documentation/kernel-parameters.txt |  5 +++--
>  drivers/tty/serial/amba-pl011.c     | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 5ce8b7a..81bdd52 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -887,8 +887,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		uart[8250],io,<addr>[,options]
>  		uart[8250],mmio,<addr>[,options]
>  		uart[8250],mmio32,<addr>[,options]
> -			Start an early, polled-mode console on the 8250/16550
> -			UART at the specified I/O port or MMIO address.
> +		pl011,<addr>
> +			Start an early, polled-mode console on a serial port
> +			at the specified I/O port or MMIO address. 8250
>  			MMIO inter-register address stride is either 8-bit
>  			(mmio) or 32-bit (mmio32).
>  			The options are the same as for ttyS, above.

I think the last line is a bit misleading. Or did you intend to leave it
with the uart[8250] parameter? See below:

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index d4eda24..4227c0a 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
[...]
> +static int __init pl011_early_console_setup(struct earlycon_device *device,
> +					    const char *opt)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write = pl011_early_write;
> +	return 0;
> +}
> +EARLYCON_DECLARE(pl011, pl011_early_console_setup);

Here we expect the PL011 to be already initialised by the boot loader
and the kernel continues using the same settings. So maybe clarify this
in the pl011 kernel parameter doc and we can add proper configuration
using a separate patch.

-- 
Catalin
