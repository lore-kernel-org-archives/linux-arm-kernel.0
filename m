From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  4 Jun 2014 13:09:49 +0100
Subject: [PATCH 0/7] i2c: Relax mandatory I2C ID table passing
Message-ID: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

As previously discussed I believe it should be okay for an I2C device
driver _not_ supply an I2C ID table to match to.  The I2C subsystem
should be able to match via other means, such as via OF and/or ACPI
tables.  The blocking factor during our previous conversation was
to keep registering via sysfs up and running.  This set does that.

After thinking more deeply about the problem, it occurred to me that
any I2C device driver which issues an {of,acpi}_match)_device()
would also fail their probe().  Bolted on to this set is a new, more
generic way for these devices to match against any of the tables
which are present in the kernel today i.e. OF, ACPI and I2C.

NB: ACPI is not fully supported, but OF is.

I hope this ticks all of your boxes.

Kind regards,
Lee

 drivers/i2c/i2c-core.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/of/device.c             | 16 +++++++++++++++-
 include/acpi/platform/aclinux.h |  5 +++--
 include/linux/i2c.h             | 19 +++++++++++++++++++
 include/linux/match.h           | 40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 10 deletions(-)
