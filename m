From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 30 Nov 2017 16:21:13 -0800
Subject: SCPI regressions in v4.15-rc1 on Amlogic SoCs.
Message-ID: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

There's been a pretty major regression in v4.15-rc1 compared to v4.15
in SCPI causing warning splats on amlogic SoCs when cpufreq starts up
and tries to set the OPP for the first time[1].

I ran out of time to narrow it down further since there have been
quite a few changes since v4.14, but simply reverting
drivers/firmware/arm_scpi.c to its v4.14 state gets things working
again.

This has been happening for awhile, and we should've caught it sooner
in kernelCI.org, however this warning splat still allows the kernel to
finish booting, so it still resulted in a PASS for the boot test.
That combined with the fact that we've been tracking some other
regressions, we didn't notice it until now.

Also, is this the expected result for the pre-1.0 firmware:

    scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version

Kevin

[1] Here are a few boot logs from v4.15-rc1 with the splat:

https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxl-s905x-khadas-vim.html

https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxbb-p200.html

https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxl-s905d-p230.html
