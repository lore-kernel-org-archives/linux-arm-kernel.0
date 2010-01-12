From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 18:57:57 +0000
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089AAB@mi8nycmail19.Mi8.com>
References: <20100112121723.GC27771@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089AA3@mi8nycmail19.Mi8.com>
	<20100112173516.GE5633@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089AAB@mi8nycmail19.Mi8.com>
Message-ID: <20100112185757.GG5633@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 12:43:54PM -0500, H Hartley Sweeten wrote:
> You must have merged you patch first.  The removal of line 448:

No - the ep93xx was merged as a whole with the miscellaneous branch,
resulting in no conflicts.  Git is occasionally good with merging.

> -	int i;
> 
> Probably produced a one line fuzz for both patches.  Is everything ok still
> for those two patches?

$ diff -u <(pdb getpatch 5879/1) <(git diff-tree -u 346e34abb2c56695ee4bd6af924141c97a0babfb )
--- /proc/self/fd/63	2010-01-12 18:53:48.958011270 +0000
+++ /proc/self/fd/62	2010-01-12 18:53:48.981135820 +0000
@@ -1,13 +1,9 @@
--------------------------------------------------------------------------------
- arch/arm/mach-ep93xx/clock.c                    |   20 ++++++++++++--------
- arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    7 +++++--
- 2 files changed, 17 insertions(+), 10 deletions(-)
--------------------------------------------------------------------------------
+346e34abb2c56695ee4bd6af924141c97a0babfb
 diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
-index 1d0f9d8..f77c410 100644
+index 07a58d0..27e3351 100644
 --- a/arch/arm/mach-ep93xx/clock.c
 +++ b/arch/arm/mach-ep93xx/clock.c
-@@ -447,25 +447,29 @@ static int __init ep93xx_clock_init(void)
+@@ -449,25 +449,29 @@ static int __init ep93xx_clock_init(void)
  	u32 value;
  	int i;
  
@@ -44,7 +40,7 @@
 +	/* Initialize the pll2 derived clocks */
  	clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
  
- 	printk(KERN_INFO "ep93xx: PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
+ 	pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
 diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
 index d55194a..cd35912 100644
 --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h

So the only difference in the patch is the pr_info line.
