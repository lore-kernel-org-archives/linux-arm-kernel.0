From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 1 Dec 2017 08:08:25 +0100
Subject: SCPI regressions in v4.15-rc1 on Amlogic SoCs.
In-Reply-To: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
References: <CAOi56cXCBAJO6iOONTENqGdm9kE+t4fGYgTENupzkRgHjJfykw@mail.gmail.com>
Message-ID: <9754d389-1dd4-e189-6c8f-c725d049dea8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.12.2017 um 01:21 schrieb Kevin Hilman:
> Hi Sudeep,
> 
> There's been a pretty major regression in v4.15-rc1 compared to v4.15
> in SCPI causing warning splats on amlogic SoCs when cpufreq starts up
> and tries to set the OPP for the first time[1].
> 
Thanks for the report. Strange enough, it works perfectly fine on my
Odroid-C2, see below log part from latest next kernel.

Your log seems to indicate that due to deferred probing something is
not done in the right order.
Can you bisect the issue? I'd assume that it's commit 931cf0c53e69
("firmware: arm_scpi: pre-populate dvfs info in scpi_probe").

Rgds, Heiner

[    0.034293] soc soc0: Amlogic Meson GXBB (S905) Revision 1f:0 (c:1) Detected
[    0.036666] c81004c0.serial: ttyAML0 at MMIO 0xc81004c0 (irq = 13, base_baud = 1500000) is a meson_uart
[    0.606914] console [ttyAML0] enabled
[    0.615031] loop: module loaded
[    0.616117] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    0.643406] ledtrig-cpu: registered to indicate activity on CPUs
[    0.644047] meson-sm: secure-monitor enabled
[    0.648156] hidraw: raw HID events driver (C) Jiri Kosina
[    0.653572] platform-mhu c883c404.mailbox: Platform MHU Mailbox registered
[    0.660439] NET: Registered protocol family 17
[    0.665031] registered taskstats version 1
[    0.668689] Loading compiled-in X.509 certificates
[    0.678049] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    0.712946] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
[    0.715600] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
[    0.719245] arm_big_little: bL_cpufreq_register: Registered platform driver: scpi
[    0.727344] mmc0: new HS400 MMC card at address 0001
[    0.729179] hctosys: unable to open rtc device (rtc0)
[    0.729355] USB_OTG_PWR: disabling
[    0.729358] TFLASH_VDD: disabling
[    0.729361] TF_IO: disabling
[    0.747230] mmcblk0: mmc0:0001 DJNB4R 116 GiB
[    0.752588] mmcblk0boot0: mmc0:0001 DJNB4R partition 1 4.00 MiB
[    0.757220] mmcblk0boot1: mmc0:0001 DJNB4R partition 2 4.00 MiB
[    0.762274] mmcblk0rpmb: mmc0:0001 DJNB4R partition 3 4.00 MiB, chardev (249:0)
[    0.770243]  mmcblk0: p1
[    0.781732] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)


> I ran out of time to narrow it down further since there have been
> quite a few changes since v4.14, but simply reverting
> drivers/firmware/arm_scpi.c to its v4.14 state gets things working
> again.
> 
> This has been happening for awhile, and we should've caught it sooner
> in kernelCI.org, however this warning splat still allows the kernel to
> finish booting, so it still resulted in a PASS for the boot test.
> That combined with the fact that we've been tracking some other
> regressions, we didn't notice it until now.
> 
> Also, is this the expected result for the pre-1.0 firmware:
> 
>     scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
> 
> Kevin
> 
> [1] Here are a few boot logs from v4.15-rc1 with the splat:
> 
> https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxl-s905x-khadas-vim.html
> 
> https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxbb-p200.html
> 
> https://storage.kernelci.org/mainline/master/v4.15-rc1/arm64/defconfig/lab-baylibre-seattle/boot-meson-gxl-s905d-p230.html
> 
