From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 17:13:09 +0200
Subject: [PATCH 5/6] ARM: imx: select CPU_FREQ_TABLE when needed
In-Reply-To: <1345648390-4234-1-git-send-email-arnd@arndb.de>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
Message-ID: <1345648390-4234-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX cpufreq implementation uses the CPU_FREQ_TABLE helpers,
so it needs to select that code to be built. This problem has
apparently existed since the i.MX cpufreq code was first merged
in v3.6.37.

Building IMX without CPU_FREQ_TABLE results in:

arch/arm/plat-mxc/built-in.o: In function `mxc_cpufreq_exit':
arch/arm/plat-mxc/cpufreq.c:173: undefined reference to `cpufreq_frequency_table_put_attr'
arch/arm/plat-mxc/built-in.o: In function `mxc_set_target':
arch/arm/plat-mxc/cpufreq.c:84: undefined reference to `cpufreq_frequency_table_target'
arch/arm/plat-mxc/built-in.o: In function `mxc_verify_speed':
arch/arm/plat-mxc/cpufreq.c:65: undefined reference to `cpufreq_frequency_table_verify'
arch/arm/plat-mxc/built-in.o: In function `mxc_cpufreq_init':
arch/arm/plat-mxc/cpufreq.c:154: undefined reference to `cpufreq_frequency_table_cpuinfo'
arch/arm/plat-mxc/cpufreq.c:162: undefined reference to `cpufreq_frequency_table_get_attr'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Yong Shen <yong.shen@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: stable at vger.kernel.org
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..84b5a0c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2150,6 +2150,7 @@ source "drivers/cpufreq/Kconfig"
 config CPU_FREQ_IMX
 	tristate "CPUfreq driver for i.MX CPUs"
 	depends on ARCH_MXC && CPU_FREQ
+	select CPU_FREQ_TABLE
 	help
 	  This enables the CPUfreq driver for i.MX CPUs.
 
-- 
1.7.10
