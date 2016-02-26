From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 16:36:05 +0900
Subject: [RESPIN 2/6] drivers: memory: Add support for exynos SROM driver
In-Reply-To: <56CFFDF0.9040107@samsung.com>
References: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
 <1456389222-12738-3-git-send-email-pankaj.dubey@samsung.com>
 <56CFFDF0.9040107@samsung.com>
Message-ID: <56D00065.6030507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.02.2016 16:25, Krzysztof Kozlowski wrote:
> On 25.02.2016 17:33, Pankaj Dubey wrote:
>> This patch adds Exynos SROM controller driver which will handle
>> save restore of SROM registers during S2R.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> [p.fedin at samsung.com: tested on SMDK5410]
>> Tested-by: Pavel Fedin <p.fedin@samsung.com>
>> Signed-off-by: Kukjin Kim <kgene@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  drivers/memory/Kconfig               |   1 +
>>  drivers/memory/Makefile              |   1 +
>>  drivers/memory/samsung/Kconfig       |  12 +++
>>  drivers/memory/samsung/Makefile      |   1 +
>>  drivers/memory/samsung/exynos-srom.c | 175 +++++++++++++++++++++++++++++++++++
>>  drivers/memory/samsung/exynos-srom.h |  51 ++++++++++
>>  6 files changed, 241 insertions(+)
>>  create mode 100644 drivers/memory/samsung/Kconfig
>>  create mode 100644 drivers/memory/samsung/Makefile
>>  create mode 100644 drivers/memory/samsung/exynos-srom.c
>>  create mode 100644 drivers/memory/samsung/exynos-srom.h
>>
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index 6f31546..bcb1982 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -114,6 +114,7 @@ config JZ4780_NEMC
>>  	  the Ingenic JZ4780. This controller is used to handle external
>>  	  memory devices such as NAND and SRAM.
>>  
>> +source "drivers/memory/samsung/Kconfig"
>>  source "drivers/memory/tegra/Kconfig"
>>  
>>  endif
>> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
>> index 1c46af5..d100e40 100644
>> --- a/drivers/memory/Makefile
>> +++ b/drivers/memory/Makefile
>> @@ -16,4 +16,5 @@ obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
>>  obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
>>  obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
>>  
>> +obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>>  obj-$(CONFIG_TEGRA_MC)		+= tegra/
>> diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
>> new file mode 100644
>> index 0000000..c2cd45e
>> --- /dev/null
>> +++ b/drivers/memory/samsung/Kconfig
>> @@ -0,0 +1,12 @@
>> +config SAMSUNG_MC
>> +	bool "SAMSUNG Exynos Memory Controller support" if COMPILE_TEST
>> +	default y
>> +	depends on ARCH_EXYNOS

These two are not needed and they introduce issues (when COMPILE_TEST it
should not depend on exynos and should not be in such case enabled by
default).

>> +	help
>> +	  This driver supports the Memory Controller (MC) hardwares found on
>> +	  SAMSUNG Exynos SoCs.
>> +
> 
> if SAMSUNG_MC
> 
>> +config EXYNOS_SROM
>> +	bool

bool should be described with COMPILE_TEST

>> +	depends on (ARM && ARCH_EXYNOS && PM) || ((ARM || ARM64) && COMPILE_TEST)
> 
> (ARM && ARCH_EXYNOS && PM) || COMPILE_TEST
> 
> You don't need to limit compile testing to ARM/ARM64.
> 

So overall it should be like:

config SAMSUNG_MC
	bool "Samsung Exynos Memory Controller support" if COMPILE_TEST
	help
	  Support for the Memory Controller (MC) devices found on
	  Samsung Exynos SoCs.

if SAMSUNG_MC

config EXYNOS_SROM
	bool "Exynos SROM controller driver" if COMPILE_TEST
	depends on (ARM && ARCH_EXYNOS && PM) || COMPILE_TEST

endif
