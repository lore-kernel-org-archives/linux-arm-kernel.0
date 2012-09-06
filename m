From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 16:35:25 -0600
Subject: [PATCH v3 1/3] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <1344577046-14847-2-git-send-email-shawn.guo@linaro.org>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <5049252D.9000802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2012 11:37 PM, Shawn Guo wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
> arch has different per-cpu loops_per_jiffy definition.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I believe this patch is causing issues initializing PCI-Express on Tegra.

In next-20120906, I cold-booted 10 times. 3 times, PCIe initialized OK,
and 7 times, the driver timed out in arch/arm/mach-tegra/pcie.c function
tegra_pcie_check_link(). With this patch reverted, another 10 cold boot
attempts all succeeded just fine. Similarly, the regression appeared in
next-20120905, and I isolated it to arch/arm/kernel/, and this is the
only patch in that directory between next-20120904 and next-20120905.

Do you have any idea what the problem might be?

Looking at the timestamps in dmesg in the failing case, the driver is
waiting the expected (per pcie.c driver code) 1.2 seconds before giving
up on the port, although I suppose if the kernel's idea of real-time is
off, then the dmesg log timestamps might be off too.
