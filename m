From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 24 Nov 2016 01:18:44 +0100
Subject: [PATCH] SCPI (pre-v1.0): fix reading sensor value
Message-ID: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
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

This patch introduces a separate function for reading the sensor value
on pre-v1.0 SCPI firmwares. I also tried initializing the "buf"
variable in scpi_sensor_get_value() but this didn't work (because we
request a 64bit payload from the SCPI firmware, but the firmware only
replies with a 32bit payload).

Martin Blumenstingl (1):
  firmware: arm_scpi: fix reading sensor values on pre-1.0 SCPI
    firmwares

 drivers/firmware/arm_scpi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.10.2
