From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Feb 2016 18:28:42 +0000
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for
 Armada-3700 serial port
In-Reply-To: <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160202182842.GD29778@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:07:39PM +0100, Gregory CLEMENT wrote:
> From: Wilson Ding <dingwei@marvell.com>
> 
> Armada-3700's uart is a simple serial port, which doesn't
> support. Configuring the modem control lines. The uart port has a 32
> bytes Tx FIFO and a 64 bytes Rx FIFO
> 
> The uart driver implements the uart core operations. It also support the
> system (early) console based on Armada-3700's serial port.
> 
> Known Issue:
> 
> The uart driver currently doesn't support clock programming, which means
> the baud-rate stays with the default value configured by the bootloader
> at boot time

To ensure that the bootloader and kernel match, it's best to place the
rate in the stdout-path property (as in
Documentation/devicetree/bindings/chosen.txt).

Presumably that is what you want?

Is it difficutl to add clock programming?

> 
> [gregory.clement at free-electrons.com: Rewrite many part which are too long
> to enumerate]
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/tty/serial/mvebu-uart.txt  |  13 +
>  Documentation/kernel-parameters.txt                |   6 +
>  drivers/tty/serial/Kconfig                         |  22 +
>  drivers/tty/serial/Makefile                        |   1 +
>  drivers/tty/serial/mvebu-uart.c                    | 649 +++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |   3 +
>  6 files changed, 694 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
>  create mode 100644 drivers/tty/serial/mvebu-uart.c
> 
> diff --git a/Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
> new file mode 100644
> index 000000000000..6087defd9f93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tty/serial/mvebu-uart.txt
> @@ -0,0 +1,13 @@
> +* Marvell UART : Non standard UART used in some of Marvell EBU SoCs (e.g., Armada-3700)
> +
> +Required properties:
> +- compatible: "marvell,armada-3700-uart"
> +- reg: offset and length of the register set for the device.
> +- interrupts: device interrupt
> +
> +Example:
> +	serial at 12000 {
> +		compatible = "marvell,armada-3700-uart";
> +		reg = <0x12000 0x400>;
> +		interrupts = <43>;
> +	};

There are no external clock inputs?

> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 87d40a72f6a1..198f6bd56e84 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1058,6 +1058,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			A valid base address must be provided, and the serial
>  			port must already be setup and configured.
>  
> +		mvebu_uart,<addr>
> +			Start an early, polled-mode console on an some mvebu
> +			SoC (as the Armada-3700) serial port at the specified
> +			address. The serial port must already be setup and
> +			configured. Options are not yet supported.
> +

Does the the mvebu UART vary between platforms at all?

Thanks,
Mark.
