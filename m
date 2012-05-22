From: padma.kvr@gmail.com (padma venkat)
Date: Tue, 22 May 2012 18:05:20 +0530
Subject: [PATCH 00/10] spi: s3c64xx: add support for device tree
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAAgF-BeU9_dgmNyjZBx5QARbv=qU==2qBCfD3ggabE608fRG7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, May 9, 2012 at 3:34 AM, Thomas Abraham <thomas.abraham@linaro.org>
wrote:
> This patch series adds device tree based discovery support for Samsung's
> s3c64xx compatible spi controller. This is mainly tested for Exynos4210
> and Exynos5250 with onboard spi nor flash device.
>
> This patch series is based on Linux 3.4-rc5 with the following two
> patch series applied.
>
> [1]
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg10494.html
>    [PATCH 00/20] ARM: Samsung: Add support for Exynos5250 Rev1.0
>
> [2]
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg09640.html
>    [PATCH 0/6] S3C24XX: Add support for HSSPI on S3C2416/S3C2443
>
> Thomas Abraham (10):
>  spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ macro
>  spi: s3c64xx: move controller information into driver data
>  ARM: Samsung: Remove spi hardware controller information from platform
data
>  ARM: Samsung: Remove pdev pointer paremeter from spi gpio setup functions
>  ARM: Samsung: Update the device names for spi clock lookup
>  ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata function
>  spi: s3c64xx: Remove the 'set_level' callback from controller data
>  ARM: Exynos4: Fix the incorrect hierarchy of spi controller bus clock
>  ARM: Exynos5: Add spi clock support
>  spi: s3c64xx: add device tree support
>
> .../devicetree/bindings/spi/spi-samsung.txt        |  113 +++++
>  arch/arm/mach-exynos/clock-exynos4.c               |   66 ++-
>  arch/arm/mach-exynos/clock-exynos5.c               |   98 ++++
>  arch/arm/mach-exynos/include/mach/regs-clock.h     |    4 +
>  arch/arm/mach-exynos/setup-spi.c                   |   33 +--
>  arch/arm/mach-s3c24xx/clock-s3c2416.c              |    2 +-
>  arch/arm/mach-s3c24xx/clock-s3c2443.c              |    2 +-
>  arch/arm/mach-s3c24xx/common-s3c2443.c             |    4 +-
>  arch/arm/mach-s3c24xx/setup-spi.c                  |   10 +-
>  arch/arm/mach-s3c64xx/clock.c                      |   20 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
>  arch/arm/mach-s3c64xx/setup-spi.c                  |   19 +-
>  arch/arm/mach-s5p64x0/clock-s5p6440.c              |   12 +-
>  arch/arm/mach-s5p64x0/clock-s5p6450.c              |   12 +-
>  arch/arm/mach-s5p64x0/setup-spi.c                  |   21 +-
>  arch/arm/mach-s5pc100/clock.c                      |   30 +-
>  arch/arm/mach-s5pc100/setup-spi.c                  |   30 +--
>  arch/arm/mach-s5pv210/clock.c                      |   14 +-
>  arch/arm/mach-s5pv210/setup-spi.c                  |   21 +-
>  arch/arm/plat-samsung/devs.c                       |   50 +--
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |   31 +-
>  drivers/spi/spi-s3c64xx.c                          |  467
+++++++++++++++++---
>  22 files changed, 753 insertions(+), 308 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
>
>
After applying this patchset, there is a build warning in the boot log.
Below is the warning..

------------[ cut here ]------------
WARNING: at drivers/base/dd.c:257 driver_probe_device+0x1ac/0x218()
Modules linked in:
[<c00159fc>] (unwind_backtrace+0x0/0xfc) from [<c0023e5c>]
(warn_slowpath_common+0x54/0x64)
[<c0023e5c>] (warn_slowpath_common+0x54/0x64) from [<c0023e88>]
(warn_slowpath_null+0x1c/0x24)
[<c0023e88>] (warn_slowpath_null+0x1c/0x24) from [<c02b6670>]
(driver_probe_device+0x1ac/0x218)
[<c02b6670>] (driver_probe_device+0x1ac/0x218) from [<c02b6768>]
(__driver_attach+0x8c/0x90)
[<c02b6768>] (__driver_attach+0x8c/0x90) from [<c02b4ddc>]
(bus_for_each_dev+0x54/0x80)
[<c02b4ddc>] (bus_for_each_dev+0x54/0x80) from [<c02b564c>]
(bus_add_driver+0x1f4/0x2c0)
[<c02b564c>] (bus_add_driver+0x1f4/0x2c0) from [<c02b6d5c>]
(driver_register+0x78/0x180)
[<c02b6d5c>] (driver_register+0x78/0x180) from [<c00085f8>]
(do_one_initcall+0x34/0x180)
[<c00085f8>] (do_one_initcall+0x34/0x180) from [<c069139c>]
(kernel_init+0x114/0x1c0)
[<c069139c>] (kernel_init+0x114/0x1c0) from [<c000ffec>]
(kernel_thread_exit+0x0/0x8)
---[ end trace 6227d56b6a736442 ]---
m25p80 spi1.0: found w25q80, expected w25x80
m25p80 spi1.0: w25q80 (1024 Kbytes)
2 ofpart partitions found on MTD device spi1.0
Creating 2 MTD partitions on "spi1.0":
0x000000000000-0x000000040000 : "U-Boot"
0x000000040000-0x000000100000 : "Kernel"

Thanks&Regards
Padma
> --
> To unsubscribe from this list: send the line "unsubscribe
linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/3337f002/attachment-0001.html>
