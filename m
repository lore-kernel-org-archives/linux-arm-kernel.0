From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 11:10:27 +0200
Subject: [PATCH 1/3] reset: Add support for the Amlogic Meson GXBB Reset
 Controller
In-Reply-To: <20160520090448.GA19888@mephisto>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
 <20160520090448.GA19888@mephisto>
Message-ID: <573ED483.10101@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2016 11:04 AM, Carlo Caione wrote:
> On 20/05/16 10:27, Neil Armstrong wrote:
>> This patch adds the platform driver for the Amlogic Meson GXBB Reset
>> Controller.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/reset/Kconfig            |   6 ++
>>  drivers/reset/Makefile           |   1 +
>>  drivers/reset/reset-meson-gxbb.c | 129 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 136 insertions(+)
>>  create mode 100644 drivers/reset/reset-meson-gxbb.c
> 
> Do we really need to be that specific (-gxbb)? This driver looks generic
> and simple enough to be used for several Amlogic families. You are
> already differentiating between them with the include file defining the
> reset indexes for the SoC.

This is a good question, do the S805 have similar registers ? Same count and width ?
I no, it should need a rework to add a data structure per-SoC.

> 
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index df37212..4ac5c4d 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -12,5 +12,11 @@ menuconfig RESET_CONTROLLER
>>  
>>  	  If unsure, say no.
>>  
>> +config MESON_GXBB_RESET
>> +	tristate "Amlogic Meson GXBB Reset Driver"
>> +	depends on (ARCH_MESON && RESET_CONTROLLER)
>> +	help
>> +	  Build the Amlogic Meson GxBB reset driver.
>> +
>>  source "drivers/reset/sti/Kconfig"
>>  source "drivers/reset/hisilicon/Kconfig"
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index a1fc8ed..5ff83a1 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -3,6 +3,7 @@ obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
>>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>>  obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
>> +obj-$(CONFIG_MESON_GXBB_RESET) += reset-meson-gxbb.o
> 
> obj-$(CONFIG_ARCH_MESON) ?
> 
> [...]
>> +static const struct reset_control_ops meson_gxbb_reset_ops = {
>> +	.reset		= meson_gxbb_reset_reset,
>> +};
> 
> nit: unfortunate name :)
> 
> Any reason to not have also .assert / .deassert?

The registers seems write-only and does no retain the bit written, assert and deassert makes no sense in this case.

> 
> [...]
>> +static struct platform_driver meson_gxbb_reset_driver = {
>> +	.probe	= meson_gxbb_reset_probe,
>> +	.remove	= meson_gxbb_reset_remove,
>> +	.driver = {
>> +		.name		= "meson_gxbb_reset",
>> +		.of_match_table	= meson_gxbb_reset_dt_ids,
>> +	},
>> +};
>> +
>> +module_platform_driver(meson_gxbb_reset_driver);
> 
> No MODULE_AUTHOR, MODULE_LICENSE, etc... ?

What is the MODULE_LICENCE format for dual licensing ?

Thanks,
Neil
