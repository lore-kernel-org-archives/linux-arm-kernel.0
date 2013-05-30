From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 30 May 2013 15:33:02 -0700
Subject: build failure: linux-next: ARM defconfigs: imx_v4_v5, imx_v6_v7
Message-ID: <87fvx43xpd.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The SPI driver for IMX started failing in linux-next (next-20130530)
where the previous tag build fine.  Below is the build error[1],
followed by the the commit[2] that I think introduced the problem.  It
appears to be some missing (or extra) curly braces.

Full console build logs are here:
https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=imx_v4_v5_defconfig,label=kernel_cloud/64/console
https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=imx_v6_v7_defconfig,label=kernel_cloud/64/console

Kevin

[1]
/work/kernel/next/drivers/spi/spi-imx.c: In function ?spi_imx_setupxfer?:
/work/kernel/next/drivers/spi/spi-imx.c:703:2: warning: no return statement in function returning non-void [-Wreturn-type]
/work/kernel/next/drivers/spi/spi-imx.c: At top level:
/work/kernel/next/drivers/spi/spi-imx.c:705:9: error: expected ?=?, ?,?, ?;?, ?asm? or ?__attribute__? before ?->? token
/work/kernel/next/drivers/spi/spi-imx.c:707:2: error: expected identifier or ?(? before ?return?
/work/kernel/next/drivers/spi/spi-imx.c:708:1: error: expected identifier or ?(? before ?}? token
/work/kernel/next/drivers/spi/spi-imx.c: In function ?spi_imx_probe?:
/work/kernel/next/drivers/spi/spi-imx.c:783:2: warning: left shift count >= width of type [enabled by default]

[2]
commit 24778be20f87d5aadb19624fc768b3159fa43efc
Author: Stephen Warren <swarren@wwwdotorg.org>
Date:   Tue May 21 20:36:35 2013 -0600

    spi: convert drivers to use bits_per_word_mask
    
    Fill in the recently added spi_master.bits_per_word_mask field in as
    many drivers as possible. Make related cleanups, such as removing any
    redundant error-checking, or empty setup callbacks.
    
    Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
    Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
