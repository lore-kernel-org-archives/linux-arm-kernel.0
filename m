From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 27 Jan 2016 16:55:25 -0800
Subject: MTK mt8173-evb: mainline unstable, and big-endian boot failures
Message-ID: <CAOi56cVDbkAJEDWy3+DV63a=UuD7nqpUu8X7e-OjtWM-4dj_-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've been meaning to report this for awhile, but finally getting around to it.

In kernelci.org, the mt8173-evb board has been rather unstable with
mainline and linux-next lately.  A look a the history of boots in
kernelci.org with various trees[1] shows that it's failing to boot
quite a lot.

It seems to be pretty stable up through v4.4 but
unreliable/unpredictable in v4.5-rc1 and lots of places in between.
It's hard to bisect because it doesn't reliably fail, but when it does
fail to finish booting, it's typically after it reaches a shell, and
trying to run various simple shell commands fails to complete, like
this example from next-20160125[2].

To me this suggests possibly an issue with the idle driver where
characters might be getting lost on the serial console, which causes
the automated boot scripts to fail because the shell is still waiting
for the command to be finished.

Also, a separate issue, I've also noticed that builds with
CONFIG_CPU_BIG_ENDIAN=y have been failing to boot since early in the
merge window[3].  For the big-endian failures, the last lines in the
boot log are always:

[...]
[    0.518078] usbcore: registered new interface driver usbhid
[    0.518780] usbhid: USB HID core driver
[    0.520295] NET: Registered protocol family 17
[    0.520934] 9pnet: Installing 9P2000 support
[    0.521549] Key type dns_resolver registered
[    0.524558] registered taskstats version 1

and in a successfull boot (e.g. little-endian) this is the followed by:

[    0.525458] hctosys: unable to open rtc device (rtc0)
[    0.533128] usb_vbus: disabling
[    0.534117] ALSA device list:
[    0.534497]   No soundcards found.
[    0.535423] Freeing unused kernel memory: 696K (ffffffc0008fa000 -
ffffffc0009a8000)

I have yet to debug this any further, but still wanted to report it in
case anyone else has the time to debug it further.

Thanks,

Kevin

[1] http://kernelci.org/boot/mt8173-evb/
[2] http://storage.kernelci.org/next/next-20160125/arm64-defconfig/lab-khilman/boot-mt8173-evb.html
[3] http://kernelci.org/boot/mt8173-evb/job/mainline/kernel/v4.5-rc1/defconfig/defconfig+CONFIG_CPU_BIG_ENDIAN=y/lab/lab-khilman/?_id=56a5812b59b514bed8fa5dc0
