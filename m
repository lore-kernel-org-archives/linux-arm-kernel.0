From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 21 Sep 2012 16:38:45 +0100
Subject: [PATCH v3] hwmon: Versatile Express hwmon driver
In-Reply-To: <20120920235727.GA18860@roeck-us.net>
References: <1348160058-13425-1-git-send-email-pawel.moll@arm.com>
 <20120920235727.GA18860@roeck-us.net>
Message-ID: <1348241925.11116.242.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-21 at 00:57 +0100, Guenter Roeck wrote:
> Your patch is substantially corrupted and unusable as patch file. Did you send
> it through outlook ?

No, it's normal git-send-email, but it goes through Exchange mail server
which can do stupid things with the message body (ie. change it!). Sorry
about it, I'll send the next version from my private account to avoid
such problems.

> > +static ssize_t vexpress_hwmon_name_show(struct device *dev,
> > +             struct device_attribute *dev_attr, char *buffer)
> > +{
> > +     const char *compatible = of_get_property(dev->of_node, "compatible",
> > +                     NULL);
> > +
> Can compatible be NULL ?

No, compatible value makes the device bound with the driver. Nothing of
this would happen without correct compatible string. And the device will
be never successfully probed without DT node "behind it" (the
of_match_device() below will return NULL).

> > +     return sprintf(buffer, "%s\n", compatible);
> > +}
> > +
> > +static ssize_t vexpress_hwmon_label_show(struct device *dev,
> > +             struct device_attribute *dev_attr, char *buffer)
> > +{
> > +     const char *label = of_get_property(dev->of_node, "label", NULL);
> > +
> 
> Can label be NULL (eg if missing in device tree data) ?
> What happens if it is NULL ? 

It is printed as "(null)".

> Seems to me the label attribute should not exist in that case.

I can do that, but I find the lack of label an error - essentially there
is no other way of understanding the meaning of a value. The order of
devices can be random, so no label - no idea what the value is.

I will make the label property "required" in the binding documentation.

> > +#define VEXPRESS_HWMON_ATTR(_name, _show, _divisor)          \
> > +struct vexpress_hwmon_attr vexpress_hwmon_attr_##_name = {   \
> > +     .dev_attr = __ATTR(_name, S_IRUGO, _show, NULL),        \
> > +     .divisor = _divisor,                                    \
> > +}
> 
> You should be able to use SENSOR_DEVICE_ATTR here.

I didn't want to "overload" the index value for other reason, but if you
think it's better approach I'll do that.

> > +static struct of_device_id vexpress_hwmon_of_match[] = {
> > +#if !defined(CONFIG_REGULATOR_VEXPRESS)
> > +     {
> > +             .compatible = "arm,vexpress-volt",
> > +             .data = &vexpress_hwmon_group_volt,
> > +     },
> > +#endif
> 
> Just wondering - is the hwmon driver mutually exclusive with the regulator
> driver, or can both coexist ?

The device model will not let one device to be bound to two different
drivers, so there will be a race for the device, depending on the
initcall ordering... And the regulator driver must have "higher
priority" then hwmon.

Having said that, it seems that we could have a "generic" hwmon
"regulator sensor" driver (as in: in1_input doing
regulator_get_voltage()), as I think a regulator can be shared between
consumers under certain conditions (I'd have to check this, though).

> FWIW, the references to "arm,vexpress-volt" I can find on the web all do not
> include "label", so I think you'll really have to look into what happens if
> there is no such property.

Yes, the patches you saw were prepared for the previous version of the
driver. Last night when testing the code I spotted the (null) labels and
updated the DTS files so the all the "volts" already have labels (I
haven't reposted the Device Tree patches yet).

> > +     {
> > +             .compatible = "arm,vexpress-amp",
> > +             .data = &vexpress_hwmon_group_amp,
> > +     }, {
> > +             .compatible = "arm,vexpress-temp",
> > +             .data = &vexpress_hwmon_group_temp,
> > +     }, {
> > +             .compatible = "arm,vexpress-power",
> > +             .data = &vexpress_hwmon_group_power,
> > +     }, {
> > +             .compatible = "arm,vexpress-energy",
> > +             .data = &vexpress_hwmon_group_energy,
> > +     },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, vexpress_hwmon_of_match);
> > +
> 
> Just wondering .... would the following work ?
> 
>         hwmon at 0 {
>                 compatible = "arm,vexpress-hwmon";
>                 volt at 0 {
>                         /* Logic level voltage */
>                         arm,vexpress-sysreg,func = <2 0>;
>                         label = "VIO";
>                 };
> 
>                 amp at 0 {
>                         /* Total current for the two cores */
>                         arm,vexpress-sysreg,func = <3 0>;
>                         label = "Core current";
>                 };
> 
>                 temp at 0 {
>                         /* DCC internal temperature */
>                         arm,vexpress-sysreg,func = <4 0>;
>                         label = "DCC";
>                 };
> 
>                 power at 0 {
>                         /* Total power */
>                         arm,vexpress-sysreg,func = <12 0>;
>                         label = "Core power";
>                 };
> 
>                 energy at 0 {
>                         /* Total energy */
>                         arm,vexpress-sysreg,func = <13 0>;
>                         label = "Core energy";
>                 };
>         };
> 
> I am not a device tree expert, but it seems to me that you would only
> have a single device node with this approach, and you could parse its
> children with for_each_child_of_node().

The thing is that there are other config devices, non hwmon relevant. In
particular: clock generators ("oscillators"), reset controllers, DVI
multiplexers etc. etc. And they are treated equally, as simple platform
devices. And the -volt case is a good example why...
	
> > +static int vexpress_hwmon_probe(struct platform_device *pdev)
> > +{
> > +     int err;
> > +     const struct of_device_id *match;
> > +     struct vexpress_hwmon_data *data;
> > +
> > +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data) {
> > +             err = -ENOMEM;
> > +             goto error_kzalloc;
> > +     }
> > +
> > +     match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
> > +     if (!match) {
> > +             err = -EINVAL;
> 
> ENODEV ?

Frankly speaking the "/* Invalid argument */" seems more appropriate
here, but can do, no problem.

> > +             goto error_match_device;
> > +     }
> > +
> > +     data->func = vexpress_config_func_get_by_dev(&pdev->dev);
> > +     if (!data->func) {
> > +             err = -ENXIO;
> 
> ENODEV ?

Again, it's "/* No such device or address */" vs "/* No such device */".
Both fine with me, will do.

> > +             goto error_get_func;
> > +     }
> > +
> > +     err = sysfs_create_group(&pdev->dev.kobj, match->data);
> > +     if (err)
> > +             goto error_create_group;
> > +
> > +     data->hwmon_dev = hwmon_device_register(&pdev->dev);
> > +     if (IS_ERR(data->hwmon_dev)) {
> > +             err = PTR_ERR(data->hwmon_dev);
> > +             goto error_hwmon_device_register;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, data);
> > +
> Must be set before sysfs files are created.

Sure thing, thanks for spotting this.

> > +     return 0;
> > +
> > +error_hwmon_device_register:
> > +     sysfs_remove_group(&pdev->dev.kobj, match->data);
> > +error_create_group:
> > +     vexpress_config_func_put(data->func);
> > +error_get_func:
> > +error_match_device:
> > +error_kzalloc:
> 
> Just return the error instead of using goto. No need for all those goto labels.

I've heard exactly the opposite number of times (usually pointing me at
CodingStyle ;-) but no problem, will do.

> > +module_init(vexpress_hwmon_init);
> > +module_exit(vexpress_hwmon_exit);
> 
> You can use module_platform_driver here.

Sure, forgot about this new feature.

Thanks for the review!

Pawe?
