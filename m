From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 23:41:14 +0200
Subject: [PATCH] cpufreq: bit.LITTLE needs cpufreq table
Message-ID: <3453738.rxYxRehmQz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like a lot of the other cpufreq drivers, this one needs to
select CONFIG_CPU_FREQ_TABLE to avoid a build error like

built-in.o: In function `bL_cpufreq_set_target':
cpufreq/arm_big_little.c:71: undefined reference to `cpufreq_frequency_table_target'
built-in.o: In function `bL_cpufreq_verify_policy':
cpufreq/arm_big_little.c:55: undefined reference to `cpufreq_frequency_table_verify'
built-in.o: In function `bL_cpufreq_init':
cpufreq/arm_big_little.c:170: undefined reference to `cpufreq_frequency_table_cpuinfo'
cpufreq/arm_big_little.c:178: undefined reference to `cpufreq_frequency_table_get_attr'
built-in.o:(.data+0x5a80c): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d3f2c6b..d1486d4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -5,6 +5,7 @@
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
 	depends on ARM_CPU_TOPOLOGY && PM_OPP && HAVE_CLK
+	select CPU_FREQ_TABLE
 	help
 	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
 
