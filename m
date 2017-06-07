From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 7 Jun 2017 13:00:21 +0300
Subject: [PATCH 4/9] net: mvmdio: move the read valid check into its own
 function
In-Reply-To: <20170607083810.30922-5-antoine.tenart@free-electrons.com>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
 <20170607083810.30922-5-antoine.tenart@free-electrons.com>
Message-ID: <71f0a99b-4736-a405-1d06-9c05f80aa327@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 6/7/2017 11:38 AM, Antoine Tenart wrote:

> Move the read valid check in its own function. This is needed as a
> requirement to factorize the driver to add the xMDIO support in the
> future.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/net/ethernet/marvell/mvmdio.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
> index 96af8d57d9e5..56bbe3990590 100644
> --- a/drivers/net/ethernet/marvell/mvmdio.c
> +++ b/drivers/net/ethernet/marvell/mvmdio.c
> @@ -69,6 +69,11 @@ static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
>  	return !(readl(dev->regs) & MVMDIO_SMI_BUSY);
>  }
>
> +static int orion_mdio_smi_is_read_valid(struct orion_mdio_dev *dev)
> +{
> +	return !(readl(dev->regs) & MVMDIO_SMI_READ_VALID);
> +}
> +
>  /* Wait for the SMI unit to be ready for another operation
>   */
>  static int orion_mdio_wait_ready(struct mii_bus *bus)
> @@ -113,7 +118,6 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
>  			   int regnum)
>  {
>  	struct orion_mdio_dev *dev = bus->priv;
> -	u32 val;
>  	int ret;
>
>  	mutex_lock(&dev->lock);
> @@ -131,14 +135,13 @@ static int orion_mdio_read(struct mii_bus *bus, int mii_id,
>  	if (ret < 0)
>  		goto out;
>
> -	val = readl(dev->regs);
> -	if (!(val & MVMDIO_SMI_READ_VALID)) {
> +	if (orion_mdio_smi_is_read_valid(dev)) {
>  		dev_err(bus->parent, "SMI bus read not valid\n");

    I think you reversed the valuid/invalid sense in the new function's name.

>  		ret = -ENODEV;
>  		goto out;
>  	}
>
[...]

MBR, Sergei
