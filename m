From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 8 Jun 2017 09:42:21 -0700
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170608092653.25221-8-antoine.tenart@free-electrons.com>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
Message-ID: <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2017 02:26 AM, Antoine Tenart wrote:
> This patch adds the xMDIO interface support in the mvmdio driver. This
> interface is used in Ethernet controllers on Marvell 370, 7k and 8k (as
> of now). The xSMI interface supported by this driver complies with the
> IEEE 802.3 clause 45 (while the SMI interface complies with the clause
> 22). The xSMI interface is used by 10GbE devices.

In the previous version you were properly defining a new compatibles
strings for xmdio, but now you don't and instead you runtime select the
operations based on whether MII_ADDR_C45 is set in the register which is
fine from a functional perspective.

If I get this right, the xMDIO controller is actually a superset of the
MDIO controller and has an extra MVMDIO_XSMI_ADDR_REG register to
preform C45 accesses?

If that is the case (and looking at patch 8 that seems to be the case),
you probably still need to define a new compatible string for that
block, because it has a different register layout than its predecessor.

[snip]
>  static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
> @@ -164,7 +236,7 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
>  			   int regnum)
>  {
>  	struct orion_mdio_dev *dev = bus->priv;
> -	const struct orion_mdio_ops *ops = &orion_mdio_smi_ops;
> +	const struct orion_mdio_ops *ops = orion_mdio_get_ops(regnum);
>  	int ret;
>  
>  	mutex_lock(&dev->lock);
> @@ -195,7 +267,7 @@ static int orion_mdio_write(struct mii_bus *bus, int mii_id,
>  			    int regnum, u16 value)
>  {
>  	struct orion_mdio_dev *dev = bus->priv;
> -	const struct orion_mdio_ops *ops = &orion_mdio_smi_ops;
> +	const struct orion_mdio_ops *ops = orion_mdio_get_ops(regnum);
>  	int ret;

ok, that seems to work since you get the operation based on
MII_ADDR_C45. Thanks!
--
Florian
