From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 21 Oct 2013 08:13:07 +0100
Subject: [PATCH RFC 1/4] net: mvmdio: make orion_mdio_wait_ready consistent
In-Reply-To: <3acbec7a5077d1375777e26cd808b787eb677fb3.1382199042.git.leigh@solinno.co.uk>
References: <cover.1382199042.git.leigh@solinno.co.uk>
 <3acbec7a5077d1375777e26cd808b787eb677fb3.1382199042.git.leigh@solinno.co.uk>
Message-ID: <5264D403.1090606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2013 05:23 PM, Leigh Brown wrote:
> Amend orion_mdio_wait_ready so that the same timeout is used when
> polling or using wait_event_timeout.  Set the timeout to 10ms.
>
> Generate the same log message at timeout when polling or using
> wait_event_timeout.
>
> Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
> ---
>   drivers/net/ethernet/marvell/mvmdio.c |   41 ++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
> index e2f6626..11e6415 100644
> --- a/drivers/net/ethernet/marvell/mvmdio.c
> +++ b/drivers/net/ethernet/marvell/mvmdio.c
> @@ -44,6 +44,13 @@
>   #define  MVMDIO_ERR_INT_SMI_DONE	   0x00000010
>   #define MVMDIO_ERR_INT_MASK		   0x0080
>
> +/*
> + * Testing on a Dreamplug showed that the SMI interface took an average of
> + * 3.2ms to respond, with a maximum time of 4.9ms.
> + */
> +#define MVMDIO_SMI_TIMEOUT		   10000 /* 10000us = 10ms */
> +#define MVMDIO_SMI_POLL_INTERVAL	   10
> +
>   struct orion_mdio_dev {
>   	struct mutex lock;
>   	void __iomem *regs;
> @@ -70,32 +77,28 @@ static int orion_mdio_wait_ready(struct mii_bus *bus)
>   	struct orion_mdio_dev *dev = bus->priv;
>   	int count;
>
> -	if (dev->err_interrupt <= 0) {
> -		count = 0;
> -		while (1) {
> +	if (dev->err_interrupt <= 0)
> +		for (count = MVMDIO_SMI_TIMEOUT / MVMDIO_SMI_POLL_INTERVAL;
> +		     count > 0;
> +		     --count) {
>   			if (orion_mdio_smi_is_done(dev))
> -				break;
> -
> -			if (count > 100) {
> -				dev_err(bus->parent,
> -					"Timeout: SMI busy for too long\n");
> -				return -ETIMEDOUT;
> -			}
> +				return 0;
>
> -			udelay(10);
> -			count++;
> +			udelay(MVMDIO_SMI_POLL_INTERVAL);

Leigh,

this isn't happening in interrupt context, is it? According to
Documentation/timers/timers-howto.txt starting from 10us you
should use usleep_range instead. I guess it isn't really critical
but IMHO sleeping is always better than delay.

Sebastian

>   		}
> -	} else {
> -		if (!orion_mdio_smi_is_done(dev)) {
> +	else {
> +		if (!orion_mdio_smi_is_done(dev))
>   			wait_event_timeout(dev->smi_busy_wait,
>   				orion_mdio_smi_is_done(dev),
> -				msecs_to_jiffies(100));
> -			if (!orion_mdio_smi_is_done(dev))
> -				return -ETIMEDOUT;
> -		}
> +				usecs_to_jiffies(MVMDIO_SMI_TIMEOUT));
> +
> +		if (orion_mdio_smi_is_done(dev))
> +			return 0;
>   	}
>
> -	return 0;
> +	dev_err(bus->parent,
> +		"Timeout: SMI busy for too long\n");
> +	return -ETIMEDOUT;
>   }
>
>   static int orion_mdio_read(struct mii_bus *bus, int mii_id,
>
