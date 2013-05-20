From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 11:05:25 +0800
Subject: [PATCH v3] tty: serial: add Freescale lpuart driver support
In-Reply-To: <1368685096-13177-1-git-send-email-b35083@freescale.com>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
Message-ID: <20130520030523.GB25113@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:18:15PM +0800, Jingchang Lu wrote:
> Add Freescale lpuart driver support. The lpuart device
> can be founded on Vybrid MVF600 and Layerscape LS-1 SoCs.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> v3:
>   change the uart driver name from mvf to lpuart for further share between SoCs.

I do not think it's going to be a problem to name the IP with mvf family
name even though it will be used on LS-1 too.  That can simply telling
the history that the IP is firstly used on mvf family and then get
reused on LS-1.  But I'm fine you name the driver in a generic way,
purely using the IP name, if you feel like to do that strongly ...

>   add bind doc in Documentation/devicetree/bindings/tty/serial.
>   remove unused #include header lines.
>   clean up code.
> 
>  .../devicetree/bindings/tty/serial/fsl-lpuart.txt  |  14 +
>  drivers/tty/serial/Kconfig                         |  14 +
>  drivers/tty/serial/Makefile                        |   1 +
>  drivers/tty/serial/fsl_lpuart.c                    | 916 +++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |   3 +
>  5 files changed, 948 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt
>  create mode 100644 drivers/tty/serial/fsl_lpuart.c
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt
> new file mode 100644
> index 0000000..46ffdb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-lpuart.txt
> @@ -0,0 +1,14 @@
> +* Freescale Low Power Universal Asynchronous Receiver/Transmitter (LPUART)
> +
> +Required properties:
> +- compatible : Should be "fsl,lpuart"

... but I don't think purely using IP name as the compatible string is a
such a good idea, since it tells nothing about compatibility/version
info.  So please encode the SoC name (mvf600) in the string.

> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain uart interrupt
> +
> +Example:
> +
> +uart0: serial at 40027000 {
> +	       compatible = "fsl,lpuart";
> +	       reg = <0x40027000 0x1000>;
> +	       interrupts = <0 61 0x00>;
> +       };
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e7006f..2cea1a0 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1484,6 +1484,20 @@ config SERIAL_RP2_NR_UARTS
>  	  If multiple cards are present, the default limit of 32 ports may
>  	  need to be increased.
>  
> +config SERIAL_FSL_LPUART
> +	bool "Freescale Lpuart serial port support"
> +	select SERIAL_CORE
> +	help
> +	  Support for the on-chip LPUARTs on some Freescal SOCs.
> +
> +config SERIAL_FSL_LPUART_CONSOLE
> +	bool "Console on Vybrid serial port"

This should be updated accordingly since the prompt text of
SERIAL_FSL_LPUART has changed?

Shawn

> +	depends on SERIAL_FSL_LPUART
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  If you have enabled the lpuart serial port on the Freescale SoCs,
> +	  you can make it the console by answering Y to this option.
> +
>  endmenu
