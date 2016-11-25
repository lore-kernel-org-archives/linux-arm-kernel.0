From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 01:54:30 +0100
Subject: [PATCH v2 0/2] SCPI (pre-v1.0): fix reading sensor value
In-Reply-To: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
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

Version 1 of this series introduced a separate function for reading the
sensor value on pre-v1.0 SCPI firmwares. I also tried initializing the
"buf" variable in scpi_sensor_get_value() but this didn't work (because
we request a 64bit payload from the SCPI firmware, but the firmware only
replies with a 32bit payload).

Version 2 is different as it does not require a "legacy implementation"
for scpi_sensor_get_value(). Instead the rx_buf is zeroed out before
reading the buffer from the mailbox. This works fine as well, since the
sensor_value.hi_val field was added after sensor_value.lo_val (meaning
it is backwards compatible, as long as hi_val is all zeroes on
pre-v1.0 SCPI firmwares).
A small benefit we get from this: we are now able to handle all
commands where new fields are introduced at the end of receive buffer
(which might be relevant also for future SCPI implementations - but
this is pure speculation).
I did not remove the memset(buf, 0, len) in scpi_process_cmd() because
I am not sure if there are v1.0 SCPI firmwares out there which respond
that X bytes are available in the rx_buf while it actually writes more
data (X + n where n > 0 bytes) than indicated.


Changes since v1:
- zero out the rx_buf before reading the mbox buffer (see long
  description above) instead of introducing a separate legacy command
  for reading the sensor value
- added patch 2/2 which validates the payload lengths (so nobody can
  read or write data beyond rx_buf or tx_buf). This optional and patch
  1/2 can be applied without it


Martin Blumenstingl (2):
  firmware: arm_scpi: zero RX buffer before requesting data from the
    mbox
  firmware: arm_scpi: check the payload length in scpi_send_message

 drivers/firmware/arm_scpi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.10.2
