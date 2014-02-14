From: naresh.kamboju@linaro.org (Naresh Kamboju)
Date: Fri, 14 Feb 2014 14:32:47 +0530
Subject: How to get the Linux kernel coverage data on ARM arch when I run LTP
 test?
Message-ID: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Sorry for the wide distribution:

According to LTP page info,
http://ltp.sourceforge.net/coverage/gcov.php
http://ltp.sourceforge.net/coverage/lcov.php

My question is
How to get kernel coverage when I run LTP test?

Since we do not have direct GCOV support on ARM I have enabled ( just
for experiment)

$ git diff  kernel/gcov/Kconfig
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index d4da55d..fceac85 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -35,7 +35,7 @@ config GCOV_KERNEL
 config GCOV_PROFILE_ALL
        bool "Profile entire Kernel"
        depends on GCOV_KERNEL
-       depends on SUPERH || S390 || X86 || PPC || MICROBLAZE
+       depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
        default n
        ---help---
        This options activates profiling for the entire kernel.

I have enabled below kernel config and built the kernel.
CONFIG_GCOV_KERNEL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y

of course I have disabled gcov on below folders and files, because
since it is an experiment i would like to be on safe side
- arch/arm/mm/
- arch/arm/kernel/
- arch/arm/boot/
- arch/arm/boot/compressed/
- arch/arm/boot/bootp/
- arch/arm/boot/dts

Arndale booted with this configuration successfully.
Took more than 65 seconds to finish boot.

gcov related files are found under /sys/ similer to X86 machine.
And  gcov supporting files filename.gcda are having links to kernel source
root at linaro-developer:~# ls /sys/kernel/debug/gcov/
reset  tmp
root at linaro-developer:~#

root at linaro-developer:~# ls /sys/kernel/debug/gcov/tmp/
linux-linaro-3.13-2014.01
root at linaro-developer:~# ls
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/
arch  block  crypto  drivers  fs  init  ipc  kernel  lib  mm  security  virt
root at linaro-developer:~# ls
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/time.* -l
-rw------- 1 root root 0 Jan  1  1970
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/time.gcda
lrwxrwxrwx 1 root root 0 Jan  1  1970
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/time.gcno
-> /tmp/linux-linaro-3.13-2014.01/kernel/time.gcno
root at linaro-developer:~#

Source are placed under /tmp/
root at linaro-developer:/tmp/linux-linaro-3.13-2014.01# ls  kernel/time.* -l
-rw-rw-r-- 1 linaro linaro  19233 Jan 24  2014 kernel/time.c
-rw-rw-r-- 1 linaro linaro  12768 Feb 13  2014 kernel/time.gcno
-rw-rw-r-- 1 linaro linaro 136444 Feb 13  2014 kernel/time.o
root at linaro-developer:/tmp/linux-linaro-3.13-2014.01#


root at linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov kernel/gcov/base.c -o
 /sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gcov/
File 'kernel/gcov/base.c'
Lines executed:43.18% of 44
Creating 'base.c.gcov'

root at linaro-developer:/tmp/linux-linaro-3.13-2014.01#

The above experiment gives coverage of a single file base.c when i run
gcov manually.
Is there any way to get Linux kernel coverage of all files after
running LTP test cases ?

Thanks in advance.

Best regards
Naresh Kamboju
