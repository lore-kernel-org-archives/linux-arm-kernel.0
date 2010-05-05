From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 05 May 2010 14:09:26 +0400
Subject: [PATCH] serial/imx: only parse for iomem resources once
In-Reply-To: <1271838838.643120.804272014834.1.gpush@pororo>
References: <1271838838.643120.804272014834.1.gpush@pororo>
Message-ID: <4BE143D6.5060502@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Jeremy Kerr wrote:

> Currently, the iomem resources are parsed in serial_imx_probe, then
> again in imx_request_port and imx_release_port.
>
> This change uses the imx_port data to retrieve the start and size of the
> memory region, rather than re-parsing the resources through
> platform_get_resource.
>
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
>
> ---
>  drivers/serial/imx.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
> index e579d7a..7de6bf7 100644
> --- a/drivers/serial/imx.c
> +++ b/drivers/serial/imx.c
>   
[...]
> @@ -1245,6 +1238,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	sport->port.dev = &pdev->dev;
>  	sport->port.mapbase = res->start;
>  	sport->port.membase = base;
> +	sport->mapsize = res->end - res->start + 1;
>   

   There's resource_size() for this calculation.

WBR, Sergei
