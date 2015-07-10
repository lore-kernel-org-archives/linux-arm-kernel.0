From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 10 Jul 2015 14:31:16 -0500
Subject: Build error with !CONFIG_SMP in v4.2-rc1 on arm multi_v7_defconfig
Message-ID: <55A01D84.8070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am seeing the following error when building v4.2-rc1 for arm with
multi_v7_defconfig with CONFIG_SMP=n:

 LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
drivers/built-in.o: In function `qcom_pm_collapse':
:(.text+0xaf44c): undefined reference to `qcom_scm_cpu_power_down'
drivers/built-in.o: In function `qcom_cpuidle_init':
:(.init.text+0x9508): undefined reference to `qcom_scm_set_warm_boot_addr'
make: *** [vmlinux] Error 1


It appears the calling functions in drivers/soc/qcom/spm.c get included by
CONFIG_QCOM_PM which is part of multi_v7_defconfig but the missing functions
from drivers/firmware/qcom_scm.c only get included by CONFIG_QCOM_SCM if SMP is
selected. I am not sure if the correct approach is to remove CONFIG_QCOM_PM from
multi_v7_defconfig or to remove 'if SMP' from CONFIG_QCOM_SCM, or something else
entirely. Thoughts?

Regards,
Dave
