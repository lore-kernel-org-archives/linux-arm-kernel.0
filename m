From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 25 Sep 2018 17:19:56 +0200
Subject: [PATCH -next] serial: uartps: Fix missing unlock on error in
 cdns_get_id()
In-Reply-To: <1537885401-18605-1-git-send-email-weiyongjun1@huawei.com>
References: <1537885401-18605-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <138f0ca2-7e84-faa8-2105-1e49e96cea14@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.9.2018 16:23, Wei Yongjun wrote:
> Add the missing unlock before return from function cdns_get_id()
> in the error handling case.
> 
> Fixes: ae1cca3fa347 ("serial: uartps: Change uart ID port allocation")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index f77200a..0e3dae4 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1394,8 +1394,10 @@ static int cdns_get_id(struct platform_device *pdev)
>  	if (!alias_bitmap_initialized) {
>  		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
>  					      alias_bitmap, MAX_UART_INSTANCES);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&bitmap_lock);
>  			return ret;
> +		}
>  
>  		alias_bitmap_initialized++;
>  	}
> 

Thanks for the fix.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
