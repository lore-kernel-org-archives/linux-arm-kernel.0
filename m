From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 15 Jan 2015 22:29:58 +0100
Subject: [PATCHv1 0/3] rtc: Abracon AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC chip
 support
Message-ID: <cover.1421356414.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, 

I fixed unhandled error case for devm_request_threaded_irq() and came w/
a simple solution to get a single return path in probe function:

   err:
   	if (ret && data && data->irq)
   		device_init_wakeup(dev, false);
   	return ret;
   }

  
Changes since v0:
  - fixed unhandled error case for devm_request_threaded_irq()
  - enforced a common error return path in _probe()

For those who missed v0:

This series adds support for Abracon AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC 
chip. Unlike many RTC chips, it includes an internal oscillator which 
spares room on the PCB. It also has some interesting features, like 
battery low detection (which the driver in this series supports). The 
only small "limitation" (mainly due to what RTC subsystem expects from 
RTC chips) is the fact that its alarm is accurate to the second. This 
series provides a solution (described below) for that limitation using 
another mechanism of the chip. 

I decided to split support between three different patches for 
this v0: 

- Patch 1/3: it simply references Abracon Corporation in vendor-prefixes 
  documentation file. As Abracon has no NASDAQ ticker symbol; I have 
  decided to use "abcn" (I initially started my work w/ "ab" but later 
  changed for "abcn" which looked more meaningful) 
- Patch 2/3: it adds initial support for the chip and provides the 
  ability to read/write time and also read/write alarm. As the alarm 
  the chip provides is accurate to the minute, the support provided 
  by this patch also has this limitation (e.g. UIE mode is not 
  supported). 
- Patch 3/3: the chip supports a watchdog timer which can be used to 
  extend the alarm mechanism in patch 2/3 in order to provide support 
  for alarms under one minute (e.g. support UIE mode). In practice, 
  the logic I implemented is to use the watchdog timer for alarms which 
  are at most 4 minutes in the future and use the common alarm mechanism 
  for alarms which are set to larger values. With that additional patch 
  the device fully passes the rtctest.c program. 

I decided to split the driver between two patches (2 and 3 of 3) in 
order to ease review: patch 2 should be pretty straightforward to read 
for someone familiar w/ RTC subsystem. Patch 3 only extends what is in 
patch 2 regarding alarms. If you prefer a single patch in a v1, do not 
hesitate to ask. 

The set currently applies on top of 3.19-rc4 but I can rebase it against 
something else if you prefer. 

Arnaud Ebalard (3):
  of: add vendor prefix for Abracon Corporation
  rtc: Add support for Abracon AB-RTCMC-32.768kHz-B5ZE-S3 I2C RTC chip
  rtc: rtc-ab-b5ze-s3: Add sub-minute alarm support

 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/rtc/Kconfig                                |   11 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-ab-b5ze-s3.c                       | 1035 ++++++++++++++++++++
 5 files changed, 1049 insertions(+)
 create mode 100644 drivers/rtc/rtc-ab-b5ze-s3.c

-- 
2.1.1
