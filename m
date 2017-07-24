From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 24 Jul 2017 19:49:03 +0300
Subject: [PATCH net-next 09/18] net: mvpp2: use named interrupts
In-Reply-To: <20170724134848.19330-10-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-10-antoine.tenart@free-electrons.com>
Message-ID: <80d4b082-a5ed-73da-0634-8295996dc29d@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2017 04:48 PM, Antoine Tenart wrote:

> This patch update the Marvell PPv2 driver to use named interrupts. A
> compatibility path is kept to allow using device trees using the old dt
> bindings. This change is needed as other interrupts will be used by the
> PPv2 driver at some point.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index f6eb98d38ced..77eef2cc40a1 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -6789,10 +6789,20 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>
>  	port = netdev_priv(dev);
>
> -	port->irq = irq_of_parse_and_map(port_node, 0);
> -	if (port->irq <= 0) {
> -		err = -EINVAL;
> -		goto err_free_netdev;
> +	if (of_get_property(port_node, "interrupt-names", NULL)) {
> +		port->irq = of_irq_get_byname(port_node, "rx-shared");
> +		if (port->irq <= 0) {
> +			err = (port->irq == -EPROBE_DEFER) ?
> +			      -EPROBE_DEFER : -EINVAL;

    Perhaps better:

		err = port->irq ?: -EINVAL;

> +			goto err_free_netdev;
> +		}
> +	} else {
> +		/* kept for dt compatibility */
> +		port->irq = irq_of_parse_and_map(port_node, 0);
> +		if (port->irq <= 0) {

    Note that irq_of_parse_and_map() returns *unsigned int*, so negative error 
codes are not possible, 0 indicates bad IRQ.

> +			err = -EINVAL;
> +			goto err_free_netdev;
> +		}
>  	}
>
>  	if (of_property_read_bool(port_node, "marvell,loopback"))

MBR, Sergei
