From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 03 Oct 2015 00:22:38 +0200
Subject: [PATCH] serial: Enable Freescale 16550 workaround on arm
In-Reply-To: <20151002001616.GA3885@home.buserror.net>
References: <20151002001616.GA3885@home.buserror.net>
Message-ID: <5286230.7Dic6OMiYf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 October 2015 19:16:16 Scott Wood wrote:
> 
> +#ifdef CONFIG_SERIAL_8250_FSL
> +       if (of_device_is_compatible(np, "fsl,ns16550") ||
> +           of_device_is_compatible(np, "fsl,16550-FIFO64"))
> +               port->handle_irq = fsl8250_handle_irq;
> +#endif
> +
> 

Can you change this to use

	if (IS_ENABLED(CONFIG_SERIAL_8250_FSL)) && ...

The resulting code will be the same, it just get a little easier
on the eye.

Other than that, I wonder if we should do this completely differently
and have the respective entries in of_platform_serial_table[] with
an appropriate PORT_* constant to handle the freescale case.

	Arnd
