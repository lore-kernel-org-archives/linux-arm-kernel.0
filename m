From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 26 May 2017 10:12:43 +0000
Subject: [PATCH v9 6/7] LPC: Add the ACPI LPC support
In-Reply-To: <201705261155.i7TAp44f%fengguang.wu@intel.com>
References: <1495712248-5232-7-git-send-email-gabriele.paoloni@huawei.com>
 <201705261155.i7TAp44f%fengguang.wu@intel.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A6CABE@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> Hi zhichang.yuan,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.12-rc2 next-20170525]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gabriele-Paoloni/LPC-
> legacy-ISA-I-O-support/20170526-033719
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `lpc_host_io_setup':
> >> hisi_lpc.c:(.text+0x252): undefined reference to
> `acpi_set_logic_pio_resource'
>    drivers/built-in.o: In function `acpi_scan_init':
>    (.init.text+0x6742): undefined reference to
> `acpi_indirectio_scan_init'

I believe the problem is in patch 4/7

config HISILICON_LPC
	bool "Support for ISA I/O space on Hisilicon Hip0X"
	depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
                                         ^^^^^^^^^^^^

the COMPILE_TEST above allowing HISILICON_LPC also for other architectures. 
I think we can remove "|| COMPILE_TEST"...I will fix it in v10

Gab

+	select LOGIC_PIO
+	select INDIRECT_PIO
+	help
+	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
+	  on Hisilicon Hip0X SoC.

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
