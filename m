From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 13 May 2014 13:55:25 -0400 (EDT)
Subject: [PATCH v6 0/5] MCPM backend for Exynos5420
In-Reply-To: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <alpine.LFD.2.11.1405131325060.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 May 2014, Abhilash Kesavan wrote:

> This is v6 of the series adding MCPM backend support for SMP secondary boot
> and core switching on Samsung's Exynos5420. The patches are based on the mcpm
> support added for Exynos5420 in the Chromium kernel repository here:
> https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-3.8
> 
> The patches have been prepared on Kukjin Kim's for-next branch and tested on
> SMDK5420 EVT1 as well as an exynos5420 based chromebook (peach-pit) using the
> "/dev/b.L_switcher" user interface. Secondary core boot-up has also been tested
> on both the boards.

OK... Now it is time for real testing.  :-)

The /dev/b.L_switcher interface tests the switcher.  Here you really 
want to hammer the MCPM functionalities and especially your backend code 
as hard as possible.  I therefore recommend the following test script:

---------- >8
#!/bin/bash

echo 0 >/sys/kernel/bL_switcher/active
sleep 1

pids=
for cpu in /sys/devices/system/cpu/cpu?/online; do
  { cpu_nr=${cpu:27:1}
    while true; do
      echo 1 > $cpu 2> /dev/null
      sleep .00$RANDOM
      val1=$(cat $cpu)
      echo 0 > $cpu 2> /dev/null
      sleep .00$RANDOM
      val0=$(cat $cpu)
      [ "$val1" = "1" -a "$val0" = "0" ] && echo -n $cpu_nr
    done
  } &
  pids="$pids $!"
done

trap "kill $pids; echo" 0 15
wait $pids
---------- >8

Leave this running for a couple hours making sure you see all CPU 
numbers being printed.  The printing order will be random, but each CPU 
number should continuously appear.


Nicolas
