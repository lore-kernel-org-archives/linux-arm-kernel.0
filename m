From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 13 Sep 2013 17:14:56 +0200
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130913065434.GZ7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
Message-ID: <52332BF0.4060605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 08:54 AM, Mika Westerberg wrote:
> On Thu, Sep 12, 2013 at 02:34:21PM -0700, Kevin Hilman wrote:
>>> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>> > > index f32ca29..44374b4 100644
>>> > > --- a/drivers/i2c/i2c-core.c
>>> > > +++ b/drivers/i2c/i2c-core.c
>>> > > @@ -248,11 +248,30 @@ static int i2c_device_probe(struct device *dev)
>>> > >  					client->flags & I2C_CLIENT_WAKE);
>>> > >  	dev_dbg(dev, "probe\n");
>>> > >  
>>> > > +	/* Make sure the adapter is active */
>>> > > +	pm_runtime_get_sync(&client->adapter->dev);
>>> > > +
>>> > > +	/*
>>> > > +	 * Enable runtime PM for the client device. If the client wants to
>>> > > +	 * participate on runtime PM it should call pm_runtime_put() in its
>>> > > +	 * probe() callback.
>>> > > +	 */
>>> > > +	pm_runtime_get_noresume(&client->dev);
>>> > > +	pm_runtime_set_active(&client->dev);
>> > 
>> > Why the set_active here?
>> > 
>> > For hardware that is disabled/powered-off on startup, there will now be
>> > a mismatch between the hardware state an the RPM core state.
>
> The call to pm_runtime_get_noresume() should make sure that the device is
> in active state (at least in state where it can access the bus) if I'm
> understanding this right.

I can't see how this would happen. How runtime_resume/runtime_suspend
callbacks would get invoked with this code, if, e.g. originally driver called 
pm_runtime_enable(), pm_runtime_get_sync(), pm_runtime_put_sync() in probe() ? 

pm_runtime_get_noresume() merely increments usage counter of a device. 
It seems that these changes will break the s5p-tv driver. I might be missing 
something though.

As Mark pointed out this is currently unwanted behaviour to runtime PM
activate a bus controller device manually in the core for when the client's
probe() is executed, since i2c core will activate the bus controller for when 
transfer is being carried out.  
But I can understand this is needed for ACPI and it shouldn't break existing
drivers, that do runtime PM activate the client device in probe().

Now I'm sure this will break power management of the drivers/media/exynos4-is
driver, due to incorrect power sequence (power domain and clocks handling).
I'll try to take care of it in separate patch, as I have some patches pending,
that move most of code from drivers/media/exynos4-is/fimc-is-sensor.c to 
drivers/media/i2c/s5k6a3.c.

--
Regards,
Sylwester
