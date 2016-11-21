From: nicolae.rosia.oss@gmail.com (Nicolae Rosia)
Date: Mon, 21 Nov 2016 12:03:03 +0200
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <20161121093144.GE23750@n2100.armlinux.org.uk>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
 <20161121092339.GA32509@dell> <20161121093144.GE23750@n2100.armlinux.org.uk>
Message-ID: <CAKP5S=28xVyNE=Q7hd2UbtOmT=12ayrcWM5m1OTvk5kGN5pZrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 11:31 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Passing data between drivers using *_set_drvdata() is a layering
> violation:
>
> 1. Driver data is supposed to be driver private data associated with
>    the currently bound driver.
> 2. The driver data pointer is NULL'd when the driver unbinds from the
>    device.  See __device_release_driver() and the
>    dev_set_drvdata(dev, NULL).
> 3. It will break with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled for a
>    similar reason to (2).
>
> So, do not pass data between drivers using *_set_drvdata() - any
> examples in the kernel already are founded on bad practice, are
> fragile, and are already broken for some kernel configurations.
After inspecting mfd_add_device, it seems that it creates a
platform_device which has the parent set to the driver calling the
function.
Isn't module unloading forbidden if there is a parent->child
relationship in place and you're removing the parent?
What should be the best practice to share data between drivers?
Reference counted data?
In the case of TWL, the twl-core is just a simple container for
regmaps - all other "sub devices" are using those regmaps to access
the I2C device's registers, it makes no sense to remove the parent
driver since it does *nothing*.
