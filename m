From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Dec 2016 22:14:31 +0100
Subject: [PATCH v3] SCPI (pre-v1.0): fix reading sensor value
In-Reply-To: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
References: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161211211432.13252-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I observed the following "strange" value when trying to read the SCPI
temperature sensor on my Amlogic GXM S912 device:
$ cat /sys/class/hwmon/hwmon0/temp1_input
6875990994467160116

The value reported by the original kernel (Amlogic vendor kernel, after
a reboot obviously) was 53C.
The Amlogic SCPI driver only uses a single 32bit value to read the
sensor value, instead of two. After stripping the upper 32bits from
above value gives "52" as result, which is basically identical to
what the vendor kernel reports.
I also compared this with the value shown by u-boot (since there's
less delay between "reboot to u-boot" compared to "reboot from mainline
kernel to vendor kernel") and the temperature reported by u-boot always
matches the lower 32bits of the value from scpi-hwmon temp1_input.

Changes since v2:
- use simplified approach from Sudeep Holla which is similar to v1
  but avoids duplicate code by adding a simple
  "if (scpi_info->is_legacy)" to scpi_sensor_get_value() instead of
  duplicating the logic

Changes since v1:
- zero out the rx_buf before reading the mbox buffer (see long
  description above) instead of introducing a separate legacy command
  for reading the sensor value
- added patch 2/2 which validates the payload lengths (so nobody can
  read or write data beyond rx_buf or tx_buf). This optional and patch
  1/2 can be applied without it

Martin Blumenstingl (1):
  firmware: arm_scpi: fix reading sensor values on pre-1.0 SCPI
    firmwares

 drivers/firmware/arm_scpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.10.2
