From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 May 2013 10:09:11 +0100
Subject: arch/arm/mach-omap2/id.c - IS_ERR_OR_NULL()
Message-ID: <20130509090911.GM21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, I eliminated all but a very few of these from arch/arm, and I notice
today that there's a new couple of instances introduced by:

commit 6770b211432564c562c856d612b43bbd42e4ab5e
Author: Ruslan Bilovol <ruslan.bilovol@ti.com>
Date:   Thu Feb 14 13:55:24 2013 +0200

    ARM: OMAP2+: Export SoC information to userspace

    In some situations it is useful for userspace to
    know some SoC-specific information. For example,
    this may be used for deciding what kernel module to
    use or how to better configure some settings etc.
    This patch exports OMAP SoC information to userspace
    using existing in Linux kernel SoC infrastructure.

    This information can be read under
    /sys/devices/socX directory

    Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
    [tony at atomide.com: updated for multiplatform changes]
    Signed-off-by: Tony Lindgren <tony@atomide.com>

+       soc_dev = soc_device_register(soc_dev_attr);
+       if (IS_ERR_OR_NULL(soc_dev)) {
+               kfree(soc_dev_attr);
+               return;
+       }
+
+       parent = soc_device_to_device(soc_dev);
+       if (!IS_ERR_OR_NULL(parent))
+               device_create_file(parent, &omap_soc_attr);

This is nonsense.  For the first, IS_ERR() is sufficient.  For the second,
tell me what error checking is required in the return value of this
function:

struct device *soc_device_to_device(struct soc_device *soc_dev)
{
        return &soc_dev->dev;
}

when you've already determined that the passed soc_dev is a valid pointer.
If you read the comments against the prototype:

/**
 * soc_device_to_device - helper function to fetch struct device
 * @soc: Previously registered SoC device container
 */
struct device *soc_device_to_device(struct soc_device *soc);

if "soc" is valid, it means the "previously registered SoC device container"
must have succeeded and that can only happen if the struct device has been
registered.  Ergo, there will always be a valid struct device pointer for
any registered SoC device container.  Therefore, if soc_device_register()
succeeds, then the return value from soc_device_to_device() will always be
valid and no error checking of it is required.

Simples.  The rule as ever applies here: get to know the APIs your using
and don't fumble around in the dark hoping that you'll get this stuff
right.
