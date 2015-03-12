From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 10:52:10 +0000
Subject: [PATCH v2 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
In-Reply-To: <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
Message-ID: <20150312105210.GK8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 05:59:54PM +0000, Andre Przywara wrote:
> +static struct uart_ops sbsa_uart_pops = {
> +	.tx_empty	= pl011_tx_empty,
> +	.set_mctrl	= sbsa_uart_set_mctrl,
> +	.get_mctrl	= sbsa_uart_get_mctrl,
> +	.stop_tx	= pl011_stop_tx,
> +	.start_tx	= pl011_start_tx,
> +	.stop_rx	= pl011_stop_rx,
> +	.enable_ms	= NULL,
> +	.break_ctl	= NULL,

It is generally accepted that we don't mention pointers/values which are
initialised to NULL/0 in initialisers.

> +static struct platform_driver arm_sbsa_uart_platform_driver = {
> +	.probe		= sbsa_uart_probe,
> +	.remove		= sbsa_uart_remove,
> +	.driver	= {
> +		.name	= "sbsa-uart",
> +		.of_match_table = of_match_ptr(sbsa_uart_match),
> +	},
> +};
> +
> +module_platform_driver(arm_sbsa_uart_platform_driver);

No need to open code the initialisation, rather than using the
module_*_driver() helper macros to avoid the problem which Dave mentioned.

These macros are only there to avoid having to write out the same boiler
plate in loads of simple drivers.  As soon as a driver has more than one
device driver structure in it, it needs to be open coded.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
