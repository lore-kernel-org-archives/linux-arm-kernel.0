From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 14 Jan 2013 17:37:01 +0400
Subject: [PATCH 2/4] serial: vt8500: ioremap'd resource is never freed
In-Reply-To: <1358129060-9399-3-git-send-email-linux@prisktech.co.nz>
References: <1358129060-9399-1-git-send-email-linux@prisktech.co.nz>
 <1358129060-9399-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <50F409FD.9070700@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-01-2013 6:04, Tony Prisk wrote:

> Memory mapped via ioremap call is never released. Rather than add an
> iounmap call, change allocation function to devm_request_and_ioremap.

> Also, change the error on failure for this call to -EBUSY rather than
> -ENOMEM.

    Not really well justified. See below.

> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>   drivers/tty/serial/vt8500_serial.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
> index 4c4a58d..8865afd 100644
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
> +		ret = -EBUSY;

    According to the comment to devm_request_and_ioremap(), the recommended 
return code on its failure -EADDRNOTAVAIL.

WBR, Sergei
