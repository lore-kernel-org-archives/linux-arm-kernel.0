From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 30 Sep 2013 17:43:47 +0300
Subject: [PATCH v3] runtime PM support for I2C adapter devices
Message-ID: <1380552228-23329-1-git-send-email-mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is third revision of the patch. The previous version can be found
here: 
	http://lwn.net/Articles/566234/

It was pointed out that the previous solution was not good for the existing
devices for several reasons:
 - The I2C adapter is powered on before client ->probe() is called. This
   causes problems with some devices.
 - The I2C adapter is kept powered on if any of its children are active.

However, for ACPI enumerated devices we need to have parent child
relationship so that the runtime PM core can power on the adapter device if
any of its children become active.

In this version we still enable runtime PM for the I2C adapter device but
only for devices that are enumerated from ACPI. The existing drivers should
continue to work as they do today.

I combined patches [1/9] and [2/9] from the previous version and added
checks for ACPI_HANDLE(). I hope Aaron and Lv are OK with this.

I didn't include changes to the SPI bus (the $subject is changed again to
reflect that) because we don't need to change the existing drivers anymore.
If this approach is accepted we can do the same for the SPI bus as well.

Mika Westerberg (1):
  i2c: enable runtime PM for I2C adapter devices enumerated from ACPI

 drivers/i2c/i2c-core.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

-- 
1.8.4.rc3
