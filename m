From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 13 Sep 2013 07:30:55 -0700
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130913065434.GZ7393@intel.com> (Mika Westerberg's message of
 "Fri, 13 Sep 2013 09:54:34 +0300")
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
Message-ID: <87bo3whjz4.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Thu, Sep 12, 2013 at 02:34:21PM -0700, Kevin Hilman wrote:
>> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> > index f32ca29..44374b4 100644
>> > --- a/drivers/i2c/i2c-core.c
>> > +++ b/drivers/i2c/i2c-core.c
>> > @@ -248,11 +248,30 @@ static int i2c_device_probe(struct device *dev)
>> >  					client->flags & I2C_CLIENT_WAKE);
>> >  	dev_dbg(dev, "probe\n");
>> >  
>> > +	/* Make sure the adapter is active */
>> > +	pm_runtime_get_sync(&client->adapter->dev);
>> > +
>> > +	/*
>> > +	 * Enable runtime PM for the client device. If the client wants to
>> > +	 * participate on runtime PM it should call pm_runtime_put() in its
>> > +	 * probe() callback.
>> > +	 */
>> > +	pm_runtime_get_noresume(&client->dev);
>> > +	pm_runtime_set_active(&client->dev);
>> 
>> Why the set_active here?
>> 
>> For hardware that is disabled/powered-off on startup, there will now be
>> a mismatch between the hardware state an the RPM core state.
>
> The call to pm_runtime_get_noresume() should make sure that the device is
> in active state (at least in state where it can access the bus) if I'm
> understanding this right.

No, after _get_noresume(), nothing happens to the hardware.  It simply
increments the usecount.  From pm_runtime.h:

static inline void pm_runtime_get_noresume(struct device *dev)
{
	atomic_inc(&dev->power.usage_count);
}

So after the _get_noresume() and _set_active() you're very likely to
have a disconnect between the hardware state and what state RPM thinks
the hardware is in.

Kevin
