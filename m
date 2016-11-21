From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Nov 2016 09:31:45 +0000
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <20161121092339.GA32509@dell>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
 <20161121092339.GA32509@dell>
Message-ID: <20161121093144.GE23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 09:23:39AM +0000, Lee Jones wrote:
> It's common place to pass shared resources such as 'regmap' though
> device data.  You can find many examples of *__set_drvdata throughout
> the kernel.

Passing data between drivers using *_set_drvdata() is a layering
violation:

1. Driver data is supposed to be driver private data associated with
   the currently bound driver.
2. The driver data pointer is NULL'd when the driver unbinds from the
   device.  See __device_release_driver() and the
   dev_set_drvdata(dev, NULL).
3. It will break with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled for a
   similar reason to (2).

So, do not pass data between drivers using *_set_drvdata() - any
examples in the kernel already are founded on bad practice, are
fragile, and are already broken for some kernel configurations.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
