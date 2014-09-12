From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 15:46:48 +0200
Subject: [PATCH 2/8] i2c: Add the ability to match device to compatible
 string without an of_node
In-Reply-To: <1409236538-21274-3-git-send-email-lee.jones@linaro.org>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
 <1409236538-21274-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20140912134648.GF1930@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 03:35:32PM +0100, Lee Jones wrote:
> A great deal of I2C devices are currently matched via DT node name, and
> as such the compatible naming convention of '<vendor>,<device>' has gone
> somewhat awry - some nodes don't supply one, some supply an arbitrary
> string and others the correct device name with an arbitrary vendor prefix.
> 
> In an effort to correct this problem we have to supply a mechanism to
> match a device by compatible string AND by simple device name.  This
> function strips off the '<vendor>,' part of a supplied compatible string
> and attempts to match without it.
> 
> The plan is to remove this function once all of the compatible strings
> for each device have been brought into line.

Is this really the plan? I mean, the old matching mechanism has been out
there for ages and I dunno how many already deployed DTs depend on it.
I'd think we need to keep this around forever.

> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/i2c-core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index d3c8e9f..eb46d15 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1095,6 +1095,27 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
>  	return i2c_verify_adapter(dev);
>  }
>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> +
> +static const struct of_device_id*
> +i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
> +				  struct i2c_client *client)
> +{
> +	const char *name;
> +
> +	for (; matches->compatible[0]; matches++) {
> +		name = strchr(matches->compatible, ',');
> +		if (!name)
> +			name = matches->compatible;
> +		else
> +			name++;
> +
> +		if (!strnicmp(client->name, name, strlen(client->name)))

Are compatible-properties case-independent? I though they were not.

> +			return matches;
> +	}
> +
> +	return NULL;
> +}
> +
>  #else
>  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
>  #endif /* CONFIG_OF */
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/b13801fa/attachment-0001.sig>
