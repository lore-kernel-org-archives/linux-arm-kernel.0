From: neko@genesi-usa.com (Matt Sealey)
Date: Wed, 20 Oct 2010 15:51:07 -0500
Subject: [patch 8/9] efikamx: add spi nor support
In-Reply-To: <877hhciw9g.fsf@lechat.rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205301.326830829@rtp-net.org>
	<20101020112659.GK2562@matterhorn.lan>
	<AANLkTi=a75BNTitznSU6QQ+5mSvwYicsftPvgMKWzZ-z@mail.gmail.com>
	<877hhciw9g.fsf@lechat.rtp-net.org>
Message-ID: <574B9ABF-D975-4B13-9A89-6F062D7BA754@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I like "u-boot" better as it's descriptive. If we flash a different firmware it might be redboot or aura or barebox or openbios and the partitioning should reflect that... Hopefully based on a device tree or residual data from the firmware itself. For now, "u-boot" is okay in my book

Matt Sealey
Product Development Analyst
Genesi USA, Inc.

On Oct 20, 2010, at 12:55 PM, Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> wrote:

> Matt Sealey <matt@genesi-usa.com> writes:
> 
>> On Wed, Oct 20, 2010 at 6:26 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>>> On 10 Oct 19, Arnaud Patard wrote:
>>>> On efikamx, uboot is stored on a nor spi flash. Add support for it
>>>> 
>>>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>>>> Index: linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c
>>>> ===================================================================
>>>> --- linux-2.6.orig/arch/arm/mach-mx5/board-mx51_efikamx.c     2010-10-16 14:21:24.000000000 +0200
>>>> +++ linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c  2010-10-16 15:34:12.000000000 +0200
>>>> @@ -24,6 +24,8 @@
>>>>  #include <linux/delay.h>
>>>>  #include <linux/io.h>
>>>>  #include <linux/fsl_devices.h>
>>>> +#include <linux/spi/flash.h>
>>>> +#include <linux/spi/spi.h>
>>>> 
>>>>  #include <mach/common.h>
>>>>  #include <mach/hardware.h>
>>>> @@ -52,6 +54,9 @@
>>>> 
>>>>  #define EFIKAMX_POWER_KEY    (1*32+31)
>>>> 
>>>> +#define EFIKAMX_SPI_CS0              (3*32+24)
>>>> +#define EFIKAMX_SPI_CS1              (3*32+25)
>>> 
>>> It is just a style thing, but could you make this (3*32 + 24). Makes it
>>> easier on the eyes to read "4th gpio bank, 24th pin"
>> 
>> Better yet:
>> 
>> #define GPIO_BANK(n) ((n-1)*32)
>> ..
>> #define EFIKAMX_SPI_CS0 (GPIO_BANK(4) + 24).
>> 
>> It'll get compiled to a constant and is more readable, right? :D
> 
> you can even imagine something like
> #define MX51_GPIO(x,y)         ((x-1) + y)
> 
> Anyway, imho it should be a different patch because if we're going this
> way all imx51 machines files would deserve the same change.
> 
>> 
>>>>  /* the pci ids pin have pull up. they're driven low according to board id */
>>>>  #define MX51_PAD_PCBID0      IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>>>>  #define MX51_PAD_PCBID1      IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>>>> @@ -99,6 +104,14 @@
>>>> 
>>>>       /* power key */
>>>>       MX51_PAD_PWRKEY,
>>>> +
>>>> +     /* spi */
>>>> +     MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI,
>>>> +     MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
>>>> +     MX51_PAD_CSPI1_SS0__GPIO_4_24,
>>>> +     MX51_PAD_CSPI1_SS1__GPIO_4_25,
>>>> +     MX51_PAD_CSPI1_RDY__ECSPI1_RDY,
>>>> +     MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
>>>>  };
>>>> 
>>>>  /* Serial ports */
>>>> @@ -252,6 +265,47 @@
>>>>       },
>>>>  };
>>>> 
>>>> +static struct mtd_partition mx51_efikamx_spi_nor_partitions[] = {
>>>> +     {
>>>> +      .name = "u-boot",
>>> 
>>> "bootloader" ?
>> 
>> "firmware" :)
> 
> please, reach an agreement with Amit. I don't want to be blocked by such
> a thing :)
> 
> Arnaud
