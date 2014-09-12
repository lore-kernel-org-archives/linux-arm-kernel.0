From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 15:50:24 +0200
Subject: [PATCH 6/8] i2c: Provide a temporary .probe2() call-back type
In-Reply-To: <1409236538-21274-7-git-send-email-lee.jones@linaro.org>
References: <1409236538-21274-1-git-send-email-lee.jones@linaro.org>
 <1409236538-21274-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20140912135023.GG1930@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 79b674d..c8240e5 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -125,7 +125,8 @@ extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
>   * struct i2c_driver - represent an I2C device driver
>   * @class: What kind of i2c device we instantiate (for detect)
>   * @attach_adapter: Callback for bus addition (deprecated)
> - * @probe: Callback for device binding
> + * @probe: Callback for device binding - soon to be deprecated
> + * @probe2: New callback for device binding

I don't like the naming. What about 'simplified_probe' instead of
'probe2'? The old 'probe' would be deprecated immediately, I guess.

Also, this needs more information in the kernel docs. Come to think of
it, I'd like to see some more documentation in general. A document in
Documentation/i2c should explain the differences between the
probe-functions, the reason why they are there, the intended path to
migrate over and examples how to convert drivers and what to keep in
mind doing so.

>   * @remove: Callback for device unbinding
>   * @shutdown: Callback for device shutdown
>   * @suspend: Callback for device suspend
> @@ -170,6 +171,11 @@ struct i2c_driver {
>  	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
>  	int (*remove)(struct i2c_client *);
>  
> +	/* New driver model interface to aid the seamless removal of the
> +	 * current probe()'s, more commonly unused than used second parameter.

"largely unused second parameter"? Maybe more readable? At least, I
needed to read this sentence more than once to get it. BTW have you
measured how often it was used/unused?

> +	 */
> +	int (*probe2)(struct i2c_client *);
> +
>  	/* driver model interfaces that don't relate to enumeration  */
>  	void (*shutdown)(struct i2c_client *);
>  	int (*suspend)(struct i2c_client *, pm_message_t mesg);

What I like in general: After your series I2C does more like what other
subsystems (especially SPI) do.

What I dislike about this in general: Putting to the drivers that they
should find out about the matching. I mean the core already did the
matching, so why should a driver do that again? Especially since it can
get very cumbersome to do so with platform_data, DT and ACPI around
which need to be checked. This is why I stopped my implementation to
fix this issue. I felt the need for a helper function to assist the
drivers how they were matched. Ideally by just retrieving the
information which the subsystem cores already gathered. Making such a
thing generic was where I stopped working on that.

Has this been discussed somewhere already?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/84f9e089/attachment.sig>
