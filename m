From: marek.behun@nic.cz (Marek =?ISO-8859-1?Q?Beh=FAn?=)
Date: Wed, 8 Aug 2018 17:32:40 +0200
Subject: [PATCH v1 2/7] drivers: mfd: Add support for Moxtet bus
In-Reply-To: <20180808152706.21727-3-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-3-marek.behun@nic.cz>
Message-ID: <20180808173240.34c56b49@dellmb.labs.office.nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found out that there are two calls to dev_err with too many
arguments, will patch in next version.

On Wed,  8 Aug 2018 17:27:01 +0200
Marek Beh?n <marek.behun@nic.cz> wrote:

> +static void
> +moxtet_register_devices_from_topology(struct moxtet *moxtet)
> +{
> +	struct moxtet_device *dev;
> +	int i, ret;
> +
> +	for (i = 0; i < moxtet->count; ++i) {
> +		dev = moxtet_alloc_device(moxtet);
> +		if (!dev) {
> +			dev_err(moxtet->dev, "Moxtet device %u alloc
> error\n",
> +				i, moxtet->modules[i]);

here

> +			continue;
> +		}
> +
> +		dev->idx = i;
> +		dev->id = moxtet->modules[i];
> +
> +		ret = moxtet_add_device(dev);
> +		if (ret && ret != -EBUSY) {
> +			dev_err(moxtet->dev,
> +				"Moxtet device %u register error:
> %i\n", i,
> +				moxtet->modules[i], ret);

and here

> +		}
> +	}
> +}
