From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 16 Jan 2015 13:50:08 +0800
Subject: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
In-Reply-To: <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
Message-ID: <1421387408.9323.10.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, 2015-01-09 at 18:21 +0100, Wolfram Sang wrote:
>  
> + */
> +struct i2c_adapter_quirks {
> +	u64 flags;
> +	int max_num_msgs;
> +	u16 max_write_len;
> +	u16 max_read_len;
> +	u16 max_comb_write_len;
> +	u16 max_comb_read_len;
> +};
> +
> +#define I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST	BIT(0)
> +#define I2C_ADAPTER_QUIRK_COMB_READ_SECOND	BIT(1)
> +#define I2C_ADAPTER_QUIRK_COMB_WRITE_THEN_READ	(I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST | \
> +						I2C_ADAPTER_QUIRK_COMB_READ_SECOND)
> +
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus along
>   * with the access algorithms necessary to access it.
> @@ -472,6 +506,7 @@ struct i2c_adapter {
>  	struct list_head userspace_clients;
>  
>  	struct i2c_bus_recovery_info *bus_recovery_info;
> +	struct i2c_adapter_quirks *quirks;
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
>  

I suggest to add const.
	const struct i2c_adapter_quirks *quirks;

also, in i2c-core.c, should modify:
	const struct i2c_adapter_quirks *q = adap->quirks;
