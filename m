From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 7 Sep 2012 10:58:49 +0800
Subject: [PATCH v3 1/3] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <5049252D.9000802@wwwdotorg.org>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-2-git-send-email-shawn.guo@linaro.org>
 <5049252D.9000802@wwwdotorg.org>
Message-ID: <20120907025847.GI26709@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 04:35:25PM -0600, Stephen Warren wrote:
> I believe this patch is causing issues initializing PCI-Express on Tegra.
> 
> In next-20120906, I cold-booted 10 times. 3 times, PCIe initialized OK,
> and 7 times, the driver timed out in arch/arm/mach-tegra/pcie.c function
> tegra_pcie_check_link(). With this patch reverted, another 10 cold boot
> attempts all succeeded just fine. Similarly, the regression appeared in
> next-20120905, and I isolated it to arch/arm/kernel/, and this is the
> only patch in that directory between next-20120904 and next-20120905.
> 
> Do you have any idea what the problem might be?
> 
> Looking at the timestamps in dmesg in the failing case, the driver is
> waiting the expected (per pcie.c driver code) 1.2 seconds before giving
> up on the port, although I suppose if the kernel's idea of real-time is
> off, then the dmesg log timestamps might be off too.

Just for identifying the problem, can you test the following change to
see if it fixes the failure.

Regards,
Shawn

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index ceb52db..a3bbdc9 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -247,5 +247,5 @@ static void __exit tegra_cpufreq_exit(void)
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
 MODULE_DESCRIPTION("cpufreq driver for Nvidia Tegra2");
 MODULE_LICENSE("GPL");
-module_init(tegra_cpufreq_init);
+late_init(tegra_cpufreq_init);
 module_exit(tegra_cpufreq_exit);
