From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Wed, 15 Feb 2017 11:24:25 +0000
Subject: [PATCH v1 3/3] ASoC: zx-96p22: add zte's aud96p22 controller
 driver
In-Reply-To: <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
 <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170215112425.GC30007@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 06:55:10PM +0800, Baoyou Xie wrote:
> This patch adds aud96p22 controller driver for zte's SoC family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
<snip>
> +static int zx_aud96p22_i2c_write(struct i2c_client *i2c_client,
> +				 const void *data, size_t count)
> +{
> +	int xfer;
> +
> +	xfer = i2c_master_send(i2c_client, data, count);
> +	if (xfer == count)
> +		return 0;
> +	else if (xfer < 0)
> +		return xfer;
> +	else
> +		return -EIO;
> +}
> +
> +static int zx_aud96p22_i2c_read(struct i2c_client *i2c_client,
> +				unsigned char addr)
> +{
> +	int xfer;
> +
> +	xfer = i2c_smbus_read_word_data(i2c_client, addr);
> +	if (xfer < 0)
> +		dev_warn(&i2c_client->dev, "transfer error %d\n", xfer);
> +
> +	return xfer;
> +}
> +

Is there any reason this isn't using regmap? It looks like it
should be, have a look at any of the other mainline CODECs for an
example.

Thanks,
Charles
