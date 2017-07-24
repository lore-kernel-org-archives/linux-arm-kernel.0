From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 24 Jul 2017 19:40:01 +0300
Subject: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY address when
 connecting to the PHY
In-Reply-To: <20170724134848.19330-4-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
Message-ID: <7ccc9080-5967-5728-bb1e-f41b9c91b254@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 07/24/2017 04:48 PM, Antoine Tenart wrote:

> When connecting to the PHY, explicitly set the SMI PHY address in the
> controller registers to configure a given port to be connected to the
> selected PHY.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index 1e592abc9067..6ffff929b22a 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
[...]
> @@ -5954,6 +5958,16 @@ static int mvpp2_phy_connect(struct mvpp2_port *port)
>  	port->duplex  = 0;
>  	port->speed   = 0;
>
> +	if (priv->hw_version != MVPP22)
> +		return 0;
> +
> +	/* Set the SMI PHY address */
> +	if (of_property_read_u32(port->phy_node, "reg", &phy_addr)) {
> +		netdev_err(port->dev, "cannot find the PHY address\n");
> +		return -EINVAL;

    Wny not propagte the error from of_property_read_u32()?

[...]

MBR, Sergei
