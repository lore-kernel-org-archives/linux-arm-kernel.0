From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 20 Nov 2015 06:43:48 -0800
Subject: [PATCH v2 1/3] serial: xuartps: Spliting the ISR into smaller
 routines.
In-Reply-To: <1448026478-22131-1-git-send-email-navam@xilinx.com>
References: <1448026478-22131-1-git-send-email-navam@xilinx.com>
Message-ID: <20151120144348.GS32017@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-11-20 at 07:04PM +0530, Nava kishore Manne wrote:
> Breaking the single big ISR that has both Rx and Tx
> in a single function into smaller ones
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v2:
> 	--Splits up the ISR without any functional changes as suggested
> 	by Peter Hurley
> 
>  drivers/tty/serial/xilinx_uartps.c | 247 ++++++++++++++++++++-----------------
>  1 file changed, 135 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 009e0db..2e1b0a8 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -172,6 +172,9 @@ struct cdns_uart {
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
>  		clk_rate_change_nb);
>  
> +static void cdns_uart_handle_tx(void *dev_id);
> +static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus);

Can't you just move these functions here instead of adding prototypes
here? Also, this is likely to conflict with
https://lkml.org/lkml/2015/11/19/622

	S?ren
