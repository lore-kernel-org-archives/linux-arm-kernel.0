From: monstr@monstr.eu (Michal Simek)
Date: Fri, 17 May 2013 14:09:38 +0200
Subject: [PATCH v2 1/5] tty: xuartps: Remove suspend/resume functions
In-Reply-To: <1368467199-8702-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1368467199-8702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368467199-8702-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <51961E02.9020501@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

can you please add this patch to your tree?
It is unrelated to clk changes which Soren sent.

Thanks,
Michal

On 05/13/2013 07:46 PM, Soren Brinkmann wrote:
> Currently Zynq does not support suspend/resume.
> The driver callbacks are never used or tested, broken and using the old
> PM interface.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial at vger.kernel.org
> ---
>  drivers/tty/serial/xilinx_uartps.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 4e5c778..b5f655d 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1006,34 +1006,6 @@ static int xuartps_remove(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -/**
> - * xuartps_suspend - suspend event
> - * @pdev: Pointer to the platform device structure
> - * @state: State of the device
> - *
> - * Returns 0
> - **/
> -static int xuartps_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -	/* Call the API provided in serial_core.c file which handles
> -	 * the suspend.
> -	 */
> -	uart_suspend_port(&xuartps_uart_driver, &xuartps_port[pdev->id]);
> -	return 0;
> -}
> -
> -/**
> - * xuartps_resume - Resume after a previous suspend
> - * @pdev: Pointer to the platform device structure
> - *
> - * Returns 0
> - **/
> -static int xuartps_resume(struct platform_device *pdev)
> -{
> -	uart_resume_port(&xuartps_uart_driver, &xuartps_port[pdev->id]);
> -	return 0;
> -}
> -
>  /* Match table for of_platform binding */
>  static struct of_device_id xuartps_of_match[] = {
>  	{ .compatible = "xlnx,xuartps", },
> @@ -1044,8 +1016,6 @@ MODULE_DEVICE_TABLE(of, xuartps_of_match);
>  static struct platform_driver xuartps_platform_driver = {
>  	.probe   = xuartps_probe,		/* Probe method */
>  	.remove  = xuartps_remove,		/* Detach method */
> -	.suspend = xuartps_suspend,		/* Suspend */
> -	.resume  = xuartps_resume,		/* Resume after a suspend */
>  	.driver  = {
>  		.owner = THIS_MODULE,
>  		.name = XUARTPS_NAME,		/* Driver name */
> 


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/0fdc1a86/attachment.sig>
