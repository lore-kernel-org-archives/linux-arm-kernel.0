From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Mon, 5 May 2014 18:55:11 +0000
Subject: [BUG] at91: rtc: Uinterruptable sleep state on hwclock -w -u
Message-ID: <55cab9fba2ea4eed8f73591b37cc874b@BLUPR05MB037.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am using a variant of the 3.10 kernel on an Atmel AT91SAM9G25.  Specifically, I am using https://github.com/linux4sam/linux-at91/tree/linux-3.10-at91 HEAD revision with some of my own device tree patches to enable/disable peripherals for my system.  I am experiencing a problem that I believe I have tracked down to the AT91 rtc driver, but I am looking for confirmation on the issue I am seeing.  If I call "hwclock -w -u" at the same time in multiple processes, sometimes one of the instances will enter an uninterruptable sleep and access of the RTC will fail until there is a system reboot.  I've traced it down to an ioctl call that does not return, which leads me to believe there is an issue in the AT91 RTC driver.

Step to reproduce:
Run two instances of the following test script in the background:
----------
#!/bin/sh
i=0
while [ 1 ]; do
  strace -f -o /home/root/hwclock_output_"$$_$i".txt /sbin/hwclock -w -u
  : $((i++))
  sleep 1;
done
----------
On my system, eventually one instance of the hwclock call will enter an uninterruptable sleep; usually happens within a few minutes.  If I print out the strace output file for the hung process using cat, the last line shows something similar to the following:

3084  ioctl(3, RTC_SET_TIME, {tm_sec=45, tm_min=40, tm_hour=17, tm_mday=5, tm_mon=4, tm_year=114, ...}

which is an incomplete printout of the ioctl system call.  If this occurs, then any call to hwclock fails until the system is rebooted.  I do not have any other hardware for testing, so I am unsure if this problem can be reproduced on other architectures.  Let me know if you need more detailed information.

Regards,
Bryan
