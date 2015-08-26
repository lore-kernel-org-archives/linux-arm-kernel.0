From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Aug 2015 13:35:56 +0100
Subject: [PATCH] regmap: Fix the null function of format_val on
 regmap_bulk_read.
In-Reply-To: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
References: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20150826123556.GB2977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 07:43:16PM +0800, Henry Chen wrote:
> The regmap_format will not be initialize if device driver not declare the regmap_bus
> when registering the regmap. To avoid the null function of format_val when
> called regmap_bulk_read(). It need to give a format function when regmap init.

> Call trace:
> [<          (null)>]           (null)
> [<ffffffc0004cbdd0>] mtk_rtc_read_time+0x9c/0x134
> [<ffffffc0004c9618>] __rtc_read_time.isra.3+0x40/0x7c
> [<ffffffc0004c9688>] rtc_read_time+0x34/0x58

Please don't paste entire backtraces in, they're enormous and tend to
obscure the actual content while adding little value.  If needed then
edited highlights work better.  I'm fairly sure I've mentioned this
before...

> @@ -783,8 +783,22 @@ struct regmap *regmap_init(struct device *dev,
>  		map->defer_caching = true;
>  		map->reg_write = _regmap_bus_raw_write;
>  	}
> +/*
> + * For bulk read, need to hook the format function.
> + */
> +simple_format_initialization:

The indentation is all messed up here, we're misssing a blank line and
the comment is not indented.

> -skip_format_initialization:
> +	switch (config->val_bits) {
> +		case 8:
> +			map->format.format_val = regmap_format_8;
> +			break;
> +		case 16:
> +			map->format.format_val = regmap_format_16_native;
> +			break;
> +		case 32:
> +			map->format.format_val = regmap_format_32_native;
> +			break;
> +	}

Why are these format functions sensible?  Converting a null pointer
dereference into data corruption wouldn't be ideal.  The commit message
should really cover this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150826/7785bcae/attachment.sig>
