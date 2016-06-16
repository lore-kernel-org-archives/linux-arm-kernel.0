From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 16 Jun 2016 16:15:28 +0100
Subject: [PATCH] arm64: Kconfig: select PM for ARCH_VEXPRESS
Message-ID: <1466090128-24425-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linux AMBA bus framework probes the peripheral IDs when adding the
AMBA devices very early on the boot. Generally they are on APB bus and
just require APB clocks to be on even when most of the core logic of the
IP is powered down.

However on Juno, the entire debugsys domain needs to be ON to access
even the coresight components' CID/PID registers and hence broken by
design. Accessing those while debugsys power domain is off will lead to
the bridge stalling the transactions instead of returning the slave error.

Further, the AMBA framework can't deal with !CONFIG_PM case: it ignores
the error and proceeds to access the device region. It was suggested to
always enable CONFIG_PM in order to handle this scenario.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

Hi ARM-SoC team,

The discussion on this happened on linux-pm list[1]. This is need on
Juno once we introduce coresight components in the DT. With !CONFIG_PM,
the board stalls on boot and hence this patch is needed. This shouldn't
change any thing in the defconfig as couple of other platforms already
do the same. It's needed in case all other ARCH_* configs are disabled.

Without this, we need a dirty trick in the DT[2] to handle !CONFIG_PM.

Can you please pick this for v4.8 ?

Regards,
Sudeep

[1] http://marc.info/?l=linux-pm&m=146607608629880&w=2
[2] https://marc.info/?l=linux-arm-kernel&m=146522896503670&w=2

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05859ae..8983ab14c9ca 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -160,6 +160,7 @@ config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_VERSATILE
+	select PM
 	select POWER_RESET_VEXPRESS
 	select VEXPRESS_CONFIG
 	help
--
2.7.4
