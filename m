From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 1 Aug 2012 17:50:16 +0530
Subject: omap_device: query on "fck" clk alias created
Message-ID: <50191F00.1040501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In OMAP world, we have omap_device layer, which exports api's like
omap_device_build() to create and register platform_device to the
kernel. This layer understands hwmod infrastructure and parses all the
platform specific information from it.
Now with DT migration, the same thing is achieved using a notifier,
which in turn omap_device_build_from_dt(), which in turn does same thing.

One of the thing which is happening in both execution path is, creating
alias for functional clock (hwmod_data->main_clk) for each device
getting created with the con_id = "fck".

Now the problem with this is,

The clk_get() api will not work, unless we pass both the arguments (dev,
con_id) properly. Now expecting driver to always label con_id with "fck"
is undesirable, as the same driver can be reused on multiple platforms,
which can be non-omap and/or non-ti platforms.
Also we have multiple examples where driver simply calls (which is right)

clk = clk_get(&pdev->dev, NULL);

This would fail on OMAP platforms, unless you modify clockxxx_data.c
file with,

CLK("<device>",  NULL,           &xxx_fck,    CK_34XX),


Devices specially with only one clock source always prefer not to
specify con_id.
And it seems wrong thing, as across platforms IP integration can be very
different and you can not expect to change the clock-tree table always.

So the option here we have is,

1. Instead of creating alias with "fck", create an alias only with dev
pointer, that means con_id = NULL.
I have already tested this and it works on AM33xx platform.

2. Add a new flag inside hwmod or omap_device, so that it can be read at
omap_device layer and based on that we can decide whether to add con_id
or not while invoking clkdev_alloc().
This may be required to support legacy drivers which are not migrated to
runtime_pm and still calls clk_get() for both "fck" and "ick", so here
we need "fck" clk alias.


Any comments or opinion on this? Based on the feedback I can create the
changes and submit it to the list.

Thanks,
Vaibhav
