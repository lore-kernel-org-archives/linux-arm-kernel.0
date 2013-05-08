From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 16:34:43 +0200
Subject: [RFC 1/8] serial:st-asc: Add ST ASC driver.
In-Reply-To: <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022248-2153-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201305081634.43498.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

> +*st-asc(Serial Port)
> +
> +Required properties:
> +- compatible : Should be "st,asc".

Are there any hardware revision numbers for the asc? If there are potentially
incompatible or backwards-compatible variants, it would be good to include
the version in this string.

> +- reg, reg-names, interrupts, interrupt-names	: Standard way to define device
> +			resources with names. look in
> +			Documentation/devicetree/bindings/resource-names.txt
> +
> +Optional properties:
> +- st,hw-flow-ctrl	bool flag to enable hardware flow control.
> +- st,force-m1		bool flat to force asc to be in Mode-1 recommeded
> +			for high bit rates (above 19.2K)
> +Example:
> +serial at fe440000{
> +    compatible    = "st,asc";
> +    reg         = <0xfe440000 0x2c>;
> +    interrupts     =  <0 209 0>;
> +};

I would also recommed adding a way to set the default baud rate through
a property. Following the example of the 8250 driver, you should probably
call that "current-speed".

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e7006f..346f325 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1484,6 +1484,25 @@ config SERIAL_RP2_NR_UARTS
>  	  If multiple cards are present, the default limit of 32 ports may
>  	  need to be increased.
>  
> +config SERIAL_ST_ASC
> +	tristate "ST ASC serial port support"
> +	depends on PLAT_STIXXXX
> +	default y
> +	select SERIAL_CORE
> +	help
> +	  This driver is for the on-chip Asychronous Serial Controller on
> +	  STMicroelectronics STixxxx SoCs.
> +	  ASC is embedded in ST COMMS IP block. It supports Rx & Tx functionality.
> +	  It support all industry standard baud rates.
> +
> +	  If unsure, say N.

I would not make it "default y".

> +config SERIAL_ST_ASC_CONSOLE
> +	bool "Support for console on ST ASC"
> +	depends on SERIAL_ST_ASC
> +	default y
> +	select SERIAL_CORE_CONSOLE
> +
>  endmenu

This needs to be "depends on SERIAL_ST_ASC=y". You would get a link error
if you try to make SERIAL_ST_ASC a loadable module and SERIAL_ST_ASC_CONSOLE
built-in.

> +
> +static struct asc_port asc_ports[ASC_MAX_PORTS];
> +static struct uart_driver asc_uart_driver;
> +
> +/*---- Forward function declarations---------------------------*/
> +static irqreturn_t asc_interrupt(int irq, void *ptr);
> +static void asc_transmit_chars(struct uart_port *);
> +static int asc_set_baud(struct asc_port *ascport, int baud);
> +

Please remove all forward declarations, by reordering the functions in
the way they are called.


> diff --git a/drivers/tty/serial/st-asc.h b/drivers/tty/serial/st-asc.h
> new file mode 100644
> index 0000000..e59f818
> --- /dev/null
> +++ b/drivers/tty/serial/st-asc.h
> +#ifndef _ST_ASC_H
> +#define _ST_ASC_H
> +
> +#include <linux/serial_core.h>
> +#include <linux/clk.h>
> +
> +struct asc_port {
> +	struct uart_port port;
> +	struct clk *clk;
> +	unsigned int hw_flow_control:1;
> +	unsigned int check_parity:1;
> +	unsigned int force_m1:1;
> +};

Since this header file is only used in one place, just merge it into
the driver itself.

> +#define ASC_MAJOR		204
> +#define ASC_MINOR_START		40

I don't know what the current policy is on allocating major/minor numbers,
but I'm sure you cannot just reuse one that is already used.

Documentation/devices.txt lists the ones that are officially assigned.
Can't you use dynamic allocation here?

	Arnd
