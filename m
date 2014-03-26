From: joe@perches.com (Joe Perches)
Date: Tue, 25 Mar 2014 22:39:17 -0700
Subject: [PATCH v6] can: xilinx CAN controller support
In-Reply-To: <5ff46a21-3047-40ff-9221-f08e476f9ce6@VA3EHSMHS030.ehs.local>
References: <5ff46a21-3047-40ff-9221-f08e476f9ce6@VA3EHSMHS030.ehs.local>
Message-ID: <1395812357.3726.14.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-03-26 at 10:56 +0530, Kedareswara rao Appana wrote:
> This patch adds xilinx CAN controller support.
> This driver supports both ZYNQ CANPS and Soft IP
> AXI CAN controller.

Just trivial notes about dmesg logging output.

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
[]
> +static int set_reset_mode(struct net_device *ndev)
> +{
[]
> +			netdev_warn(ndev, "timedout waiting for config mode\n");

timed out

> +static int xcan_set_bittiming(struct net_device *ndev)
> +{
[]
> +	if (!is_config_mode) {
> +		netdev_alert(ndev,
> +			"BUG! Cannot set bittiming can is notin config mode\n");

"Cannot set bit timing - CAN is not in config mode\n"

> +static int xcan_chip_start(struct net_device *ndev)
> +{

> +			netdev_warn(ndev,
> +				"time out waiting for correct mode\n");

Please be consistent.  Maybe
"timed out waiting for correct mode\n"

> +static int xcan_open(struct net_device *ndev)
> +{
> +	struct xcan_priv *priv = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = request_irq(ndev->irq, xcan_interrupt, priv->irq_flags,
> +			ndev->name, ndev);
> +	if (ret < 0) {
> +		netdev_err(ndev, "Irq allocation for CAN failed\n");

irq is almost always lower case.
