From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 16 Jan 2013 17:29:47 +0400
Subject: [PATCH 2/4] serial: vt8500: ioremap'd resource is never freed
In-Reply-To: <1358225886-5686-3-git-send-email-linux@prisktech.co.nz>
References: <1358225886-5686-1-git-send-email-linux@prisktech.co.nz>
 <1358225886-5686-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <50F6AB4B.6090902@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-01-2013 8:58, Tony Prisk wrote:

> Memory mapped via ioremap call is never released. Rather than add an
> iounmap call, change allocation function to devm_request_and_ioremap.

> Also, change the error on failure for this call to -EBUSY rather than
> -EADDRNOTAVAIL.

    You meant "-EADDRNOTAVAIL rather than -ENOMEM". ;-)

> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>   drivers/tty/serial/vt8500_serial.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 4c4a58d..3e76dff 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -615,9 +615,9 @@ static int vt8500_serial_probe(struct platform_device *pdev)
>   	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
>   		 "VT8500 UART%d", pdev->id);
>
> -	vt8500_port->uart.membase = ioremap(mmres->start, resource_size(mmres));
> +	vt8500_port->uart.membase = devm_request_and_ioremap(&pdev->dev, mmres);
>   	if (!vt8500_port->uart.membase) {
> -		ret = -ENOMEM;
> +		ret = -EADDRNOTAVAIL;
>   		goto err;
>   	}

WBR, Sergei
