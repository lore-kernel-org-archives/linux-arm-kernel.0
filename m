From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 11 Aug 2015 14:35:00 +0530
Subject: [PATCH v3] Add continuous sampling with IIO buffers for Vybrid
Message-ID: <cover.1439283162.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch adds support for continuous sampling provided by the
ADC block on Vybrid by leveraging the IIO triggered buffers
infrastructure.

The patch has been tested on Colibri VF50 and VF61 on shawn's
tree for-next branch with the patches [1] and [2] applied.

The below script was used for testing.

#!/bin/sh
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage8_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage9_en
echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_temp_en
echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en
echo 0 > /sys/bus/iio/devices/iio_sysfs_trigger/add_trigger
/home/root/generic_buffer -n 4003b000.adc -t sysfstrig0 -l 512 -c 10
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_timestamp_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_temp_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage8_en
echo 0 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage9_en

Feedback and comments are most welcome.

Changes since v2:
1. Fix the wrong buffer size for statically allocated buffer
2. Drop the use of .address field from the iio_chan_spec
3. Use iio_buffer_enabled call inside the lock
4. Drop wrapper function around iio_trigered_* function calls
5. Drop Kconfig select of sysfs trigger
6. Drop Kconfig select IIO_TRIGGER as it is already selected by
IIO_TRIGGERED_BUFFER

Changes since v1:
1. Use a fixed size buffer instead of kmalloc allocated during update
scan mode
2. Remove a write to read only register ADC_HS (COCO bit)

Version 2 patch can be found here
http://www.gossamer-threads.com/lists/linux/kernel/2235178

Version 1 patch can be found here
http://www.spinics.net/lists/linux-iio/msg20053.html

[1]. https://lkml.org/lkml/2015/5/27/350
[2]. https://lkml.org/lkml/2015/7/14/395

Thanks & Regards,
Sanchayan Maity.

Sanchayan Maity (1):
  iio: adc: vf610: Add IIO buffer support for Vybrid ADC

 drivers/iio/adc/Kconfig     |   2 +
 drivers/iio/adc/vf610_adc.c | 102 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 7 deletions(-)

-- 
2.5.0
