From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Fri, 10 Feb 2012 16:21:11 +0100
Subject: [PATCH] cpufreq: get rid of remaining references to
 CONFIG_CPU_FREQ_DEBUG
In-Reply-To: <1320866225.27598.11.camel@x61.thuisdomein>
References: <1320866225.27598.11.camel@x61.thuisdomein>
Message-ID: <20120210152111.GB26589@comet.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 08:17:05PM +0100, Paul Bolle wrote:
> 0) Commit 2d06d8c49afdcc9bb35a85039fa50f0fe35bd40e ("[CPUFREQ] use
> dynamic debug instead of custom infrastructure") dropped config
> CPU_FREQ_DEBUG. But currently there are still two references to
> CONFIG_CPU_FREQ_DEBUG (both in arch/arm).

Thanks for noting this. These two instances can and should be updated
accordingly.

> 1) I've stared a bit at the (trivial) code still relying on
> CONFIG_CPU_FREQ_DEBUG but wasn't sure how it could be rewritten. Perhaps
> one of you does know how to do that.

Well, as we now use dynamic debug, we can use the generic debug calls used
througout the kernel ( pr_debug(...) ), and do not need to wrap the debug
message in an #ifdef . That's the whole story, actually. Russell, do you
want to take this through the ARM tree?

Best,
	Dominik

---
cpufreq: get rid of remaining references to CONFIG_CPU_FREQ_DEBUG

As noted by Paul Bolle <pebolle@tiscali.nl>, there are still two references
to CONFIG_CPU_FREQ_DEBUG which can and should be removed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index d95763d..872d96e 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -28,7 +28,6 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="console=tty1 root=/dev/mmcblk0p2 rootfstype=ext2 rootdelay=3 ip=192.168.0.202:192.168.0.200:192.168.0.200:255.255.255.0 debug"
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_DEBUG=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index bb5ce39..55b827f 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -97,10 +97,8 @@ static int tegra_update_cpu_speed(unsigned long rate)
 	for_each_online_cpu(freqs.cpu)
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
-#ifdef CONFIG_CPU_FREQ_DEBUG
-	printk(KERN_DEBUG "cpufreq-tegra: transition: %u --> %u\n",
+	pr_debug("cpufreq-tegra: transition: %u --> %u\n",
 	       freqs.old, freqs.new);
-#endif
 
 	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
 	if (ret) {
