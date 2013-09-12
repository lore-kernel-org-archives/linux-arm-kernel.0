From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 12 Sep 2013 14:34:21 -0700
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 (Mika Westerberg's message of "Wed, 11 Sep 2013 18:32:32 +0300")
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <87vc25pvvm.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> From: Aaron Lu <aaron.lu@intel.com>
>
> This patch adds runtime PM support for the I2C bus in a similar way that
> has been done for PCI bus already. This means that the I2C bus core
> prepares runtime PM for a client device just before a driver is about to be
> bound to it. Devices that are not bound to any driver are not prepared for
> runtime PM.
>
> In order to take advantage of this runtime PM support, the client device
> driver needs drop the device runtime PM reference count by calling
> pm_runtime_put() in its ->probe() callback and possibly implement rest of
> the runtime PM callbacks.
>
> If the driver doesn't support runtime PM (like most of the existing I2C
> client drivers), the device in question is regarded as being runtime PM
> active and powered on.

But for existing drivers which already support runtime PM (at least 7 by
a quick grep), they will be stuck runtime enabled and stop hitting
low-power states after this patch.

> The patch adds also runtime PM support for the adapter device because it is
> needed to be able to runtime power manage the I2C controller device. The
> adapter device is handled along with the I2C controller device (it uses
> pm_runtime_no_callbacks()).
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/i2c/i2c-core.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index f32ca29..44374b4 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -248,11 +248,30 @@ static int i2c_device_probe(struct device *dev)
>  					client->flags & I2C_CLIENT_WAKE);
>  	dev_dbg(dev, "probe\n");
>  
> +	/* Make sure the adapter is active */
> +	pm_runtime_get_sync(&client->adapter->dev);
> +
> +	/*
> +	 * Enable runtime PM for the client device. If the client wants to
> +	 * participate on runtime PM it should call pm_runtime_put() in its
> +	 * probe() callback.
> +	 */
> +	pm_runtime_get_noresume(&client->dev);
> +	pm_runtime_set_active(&client->dev);

Why the set_active here?

For hardware that is disabled/powered-off on startup, there will now be
a mismatch between the hardware state an the RPM core state.

Kevin
