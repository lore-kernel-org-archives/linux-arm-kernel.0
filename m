From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Apr 2012 16:53:41 +0100
Subject: [PATCH 1/2] mfd: da9052: add device-tree support for i2c driver
In-Reply-To: <1334245182-31725-1-git-send-email-paul.liu@linaro.org>
References: <1334245182-31725-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120412155341.GB3195@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 11:39:41PM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +- compatible : Should be "dialog,da9052", "dialog,da9053-aa",
> +			 "dialog,da9053-ab", or "dialog,da9053-bb"

This is generally the stock ticker symbol so DLG for Dialog.

> +Sub-nodes:
> +- regulators : Contain the regulator nodes.  The DA9052 regulators are
> +  sorted as following:

This seems poor from a usability point of view, the user shouldn't have
to care about the order in which they list things in their device tree
and they should be able to only list the regulators they use.

> +    buck_core : regulator BUCK_CORE (id: 0 )

Having to care about numeric IDs also seems bad for usability.

> +#ifdef CONFIG_OF
> +	if (!id) {
> +		int i;
> +		struct device_node *np = client->dev.of_node;
> +
> +		for (i = 0;
> +		     i < sizeof(dialog_dt_ids)/sizeof(dialog_dt_ids[0]);
> +		     i++)
> +			if (of_device_is_compatible(np,
> +						dialog_dt_ids[i].compatible))
> +				id = &da9052_i2c_id[i];
> +	}
> +#endif

Ick, this doesn't look terribly nice - are you sure this is idiomatic?
The bound for the iteration also looks a lot like ARRAY_SIZE().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120412/a3724d25/attachment.sig>
