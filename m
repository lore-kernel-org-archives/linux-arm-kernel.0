From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 30 Sep 2014 14:46:56 +1000
Subject: linux-next: manual merge of the battery tree with the arm-soc tree
Message-ID: <20140930144656.35afeae4@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Today's linux-next merge of the battery tree got conflicts in
drivers/power/reset/Kconfig and drivers/power/reset/Makefile between
commit 0e545f57b708 ("power: reset: driver for the Versatile syscon
reboot") from the arm-soc tree and commit f0745f3696e8 ("power: reset:
Add restart functionality for STiH41x platforms") from the battery tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/power/reset/Kconfig
index 527a0f47ef44,a178e9c50a20..000000000000
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@@ -69,9 -59,16 +77,16 @@@ config POWER_RESET_MS
  	help
  	  Power off and restart support for Qualcomm boards.
  
+ config POWER_RESET_LTC2952
+ 	bool "LTC2952 PowerPath power-off driver"
+ 	depends on OF_GPIO && POWER_RESET
+ 	help
+ 	  This driver supports an external powerdown trigger and board power
+ 	  down via the LTC2952. Bindings are made in the device tree.
+ 
  config POWER_RESET_QNAP
  	bool "QNAP power-off driver"
 -	depends on OF_GPIO && POWER_RESET && PLAT_ORION
 +	depends on OF_GPIO && PLAT_ORION
  	help
  	  This driver supports turning off QNAP NAS devices by sending
  	  commands to the microcontroller which controls the main power.
@@@ -92,15 -89,13 +107,21 @@@ config POWER_RESET_SUN6
  	help
  	  Reboot support for the Allwinner A31 SoCs.
  
+ config POWER_RESET_ST
+ 	bool "ST restart power-off driver"
+ 	depends on POWER_RESET && ARCH_STI
+ 	help
+ 	  Power off and reset support for STMicroelectronics boards.
+ 
 +config POWER_RESET_VERSATILE
 +	bool "ARM Versatile family reboot driver"
 +	depends on ARM
 +	depends on MFD_SYSCON
 +	depends on OF
 +	help
 +	  Power off and restart support for ARM Versatile family of
 +	  reference boards.
 +
  config POWER_RESET_VEXPRESS
  	bool "ARM Versatile Express power-off and reset driver"
  	depends on ARM || ARM64
diff --cc drivers/power/reset/Makefile
index 73221009f2bf,ab8cd348a099..000000000000
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@@ -9,7 -9,7 +11,8 @@@ obj-$(CONFIG_POWER_RESET_LTC2952) += lt
  obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
  obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
  obj-$(CONFIG_POWER_RESET_SUN6I) += sun6i-reboot.o
+ obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
 +obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
  obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
  obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
  obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/262ef3c5/attachment.sig>
