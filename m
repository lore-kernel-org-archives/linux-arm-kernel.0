From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 16 Feb 2016 08:33:41 -0800
Subject: [PATCH 2/3] serial: xuartps: Enable OF earlycon support
In-Reply-To: <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
References: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
 <23ab10a19b21df2ef17a5bb6ce2a70d2d3fd3551.1455552315.git.michal.simek@xilinx.com>
Message-ID: <56C34F65.1040506@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On 02/15/2016 08:05 AM, Michal Simek wrote:
> Support early console setup via DT for all listed compatible strings.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 009e0dbc12d2..6f5657766815 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1094,6 +1094,9 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
>  	return 0;
>  }
>  EARLYCON_DECLARE(cdns, cdns_early_console_setup);
> +OF_EARLYCON_DECLARE(cdns_a, "xlnx,xuartps", cdns_early_console_setup);
> +OF_EARLYCON_DECLARE(cdns_b, "cdns,uart-r1p8", cdns_early_console_setup);
> +OF_EARLYCON_DECLARE(cdns_c, "cdns,uart-r1p12", cdns_early_console_setup);

Earlycon now shares a common framework in linux-next.

The EARLYCON_DECLARE() can be deleted and the OF_EARLYCON_DECLARE()
can all share the same earlycon name. iow,

-EARLYCON_DECLARE(cdns, cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "xlnx,xuartps", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
+OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);

Regards,
Peter Hurley


>  /**
>   * cdns_uart_console_write - perform write operation
> 
