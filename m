From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 17 Jun 2013 11:22:50 -0700
Subject: linux-next: manual merge of the arm-soc tree with the tty tree
In-Reply-To: <20130617164841.41561f78f3465bd4007411b6@canb.auug.org.au>
References: <20130617164841.41561f78f3465bd4007411b6@canb.auug.org.au>
Message-ID: <ed138cdb-8a20-4c84-95f4-6137e5803e36@CO9EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 04:48:41PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/tty/serial/xilinx_uartps.c between commit 696faedd616e ("serial:
> use platform_{get,set}_drvdata()") from the tty tree and commit
> 30e1e28598c2 ("arm: zynq: Migrate platform to clock controller") from the
> arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc drivers/tty/serial/xilinx_uartps.c
> index 6c91745,a4a3028..0000000
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@@ -972,14 -1004,15 +1004,14 @@@ static int xuartps_probe(struct platfor
>   		port->mapbase = res->start;
>   		port->irq = res2->start;
>   		port->dev = &pdev->dev;
> - 		port->uartclk = clk_get_rate(clk);
> - 		port->private_data = clk;
> + 		port->uartclk = clk_get_rate(xuartps_data->refclk);
> + 		port->private_data = xuartps_data;
>  -		dev_set_drvdata(&pdev->dev, port);
>  +		platform_set_drvdata(pdev, port);
>   		rc = uart_add_one_port(&xuartps_uart_driver, port);
>   		if (rc) {
>   			dev_err(&pdev->dev,
>   				"uart_add_one_port() failed; err=%i\n", rc);
> - 			return rc;
>  -			dev_set_drvdata(&pdev->dev, NULL);
> + 			goto err_out_clk_disable;
>   		}
>   		return 0;
>   	}
> @@@ -993,14 -1039,19 +1038,18 @@@ err_out_free
>    **/
>   static int xuartps_remove(struct platform_device *pdev)
>   {
>  -	struct uart_port *port = dev_get_drvdata(&pdev->dev);
>  +	struct uart_port *port = platform_get_drvdata(pdev);
> - 	struct clk *clk = port->private_data;
> + 	struct xuartps *xuartps_data = port->private_data;
>   	int rc;
>   
>   	/* Remove the xuartps port from the serial core */
>   	rc = uart_remove_one_port(&xuartps_uart_driver, port);
>  -	dev_set_drvdata(&pdev->dev, NULL);
>   	port->mapbase = 0;
> - 	clk_disable_unprepare(clk);
> + 	clk_disable_unprepare(xuartps_data->refclk);
> + 	clk_disable_unprepare(xuartps_data->aperclk);
> + 	clk_put(xuartps_data->refclk);
> + 	clk_put(xuartps_data->aperclk);
> + 	kfree(xuartps_data);
>   	return rc;
>   }
Looks correct and boots fine on Zynq. Thanks.

	S?ren
