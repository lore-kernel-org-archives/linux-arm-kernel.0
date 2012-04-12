From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Apr 2012 16:59:18 +0100
Subject: [PATCH 2/2] regulator: da9052: add device tree support
In-Reply-To: <1334245182-31725-2-git-send-email-paul.liu@linaro.org>
References: <1334245182-31725-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120412155917.GC3195@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 11:39:42PM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +#ifdef CONFIG_OF
> +		struct device_node *nproot = da9052->dev->of_node;
> +		struct device_node *np;
> +		int c;
> +
> +		if (!nproot) {
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +
> +		nproot = of_find_node_by_name(nproot, "regulators");
> +		if (!nproot) {
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +
> +		c = 0;
> +		for (np = of_get_next_child(nproot, NULL);
> +		     np != NULL;
> +		     np = of_get_next_child(nproot, np)) {
> +			if (c == pdev->id) {
> +				initdata = of_get_regulator_init_data(
> +					&pdev->dev, np);
> +				break;
> +			}
> +			c++;
> +		}

This is really quite unclear but it looks like this is relying on the
order of regulators in the OF table to match things.  As I said in my
reply to the first patch this is really poor for usability and it's
also making the code here more obscure - we should be looking for the
regulator nodes by name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120412/d3cf74de/attachment.sig>
