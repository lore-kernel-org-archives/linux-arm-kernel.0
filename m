From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 02 Jun 2014 17:06:31 +0100
Subject: [PATCH 1/3] i2c: Provide 'device type' to 'OF device node' look-up
In-Reply-To: <1401716463-23457-2-git-send-email-lee.jones@linaro.org>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
 <1401716463-23457-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20140602160631.F2F6DC40476@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  2 Jun 2014 14:41:01 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> We have a problem.  There are lots of I2C device ID tables scattered
> around the kernel which are redundant in all Device Tree and/or ACPI
> only supported device drivers.  After recent discussions it has become
> apparent that the only thing blocking the complete removal of these
> tables is the continued support of 'register an I2C device via sysfs'
> functionality.  As the sysfs method doesn't know anything about Device
> Tree or ACPI, we can not pass any nodes in.  This patch searches all
> known Device Tree nodes and attempts to acquire a match from the
> device name provided via sysfs.  It can not fail, but if found assigns
> the matching of_node to i2c_board_info prior to registering.

Ummm... blech!  :-)

It shouldn't actually be necessary to have a node when instantiating an
i2c_device... in fact, there /shouldn't/ be a node if the device is
getting instantiated by had via sysfs. If there was a node, then I would
expect a device to have been created at the same time.

I think panto's overlays solve the problem where a node actually is
required to instantiate the device by actually adding a node and letting
the i2c subsystem create the associated device automatically.

g.

> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/i2c-core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 7c7f4b8..2e47641 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -64,6 +64,7 @@ static DEFINE_IDR(i2c_adapter_idr);
>  
>  static struct device_type i2c_client_type;
>  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *driver);
> +static struct device_node *of_i2c_type_to_node(char *type);
>  
>  static struct static_key i2c_trace_msg = STATIC_KEY_INIT_FALSE;
>  
> @@ -863,6 +864,8 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> +	info.of_node = of_i2c_type_to_node(info.type);
> +
>  	client = i2c_new_device(adap, &info);
>  	if (!client)
>  		return -EINVAL;
> @@ -1088,8 +1091,36 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
>  	return i2c_verify_adapter(dev);
>  }
>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> +
> +static struct device_node *of_i2c_type_to_node(char *type)
> +{
> +	struct device_node *np;
> +	const char *compatible, *name;
> +	int len;
> +
> +	if (!type)
> +		return NULL;
> +
> +	for_each_of_allnodes(np) {
> +		compatible = of_get_property(np, "compatible", &len);
> +		if (!compatible)
> +			continue;
> +
> +		name = strchr(compatible, ',');
> +		if (!name)
> +			name = compatible;
> +		else
> +			name++;
> +
> +		if (!strncmp(name, type, len - (name - compatible)))
> +			return np;
> +	}
> +
> +	return NULL;
> +}
>  #else
>  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
> +static struct device_node *of_i2c_type_to_node(char *type) { return NULL; }
>  #endif /* CONFIG_OF */
>  
>  /* ACPI support code */
> -- 
> 1.8.3.2
> 
