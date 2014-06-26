From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 26 Jun 2014 12:42:26 -0700
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <20140626151756.GU32514@n2100.arm.linux.org.uk>
References: <53A2AE11.2050208@gmail.com> <53A2BE94.2010308@gmail.com>
 <53A7A579.4010702@gmail.com>
 <CAGa+x85H510fNGTXJHGYfQybRa2FGgg2NyCgJ8rmjJ6TE7GNbA@mail.gmail.com>
 <53A9B99F.4040806@codeaurora.org> <53A9FBB5.60709@codeaurora.org>
 <53AABCF5.4050403@gmail.com> <53AB45D1.90909@codeaurora.org>
 <53ABC13C.8030908@gmail.com>
 <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
 <20140626151756.GU32514@n2100.arm.linux.org.uk>
Message-ID: <53AC77A2.4090207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/26/2014 8:17 AM, Russell King - ARM Linux wrote:
> On Thu, Jun 26, 2014 at 07:59:19AM -0700, Kevin Hilman wrote:
>> I agree that the u-boot bug needs to be fixed, and FWIW, I updated my
>> u-boot and haven't seen the boot failure yet after several boots with
>> next-20140625.
>>
>> That being said, since it's not always feasible/practical to update
>> u-boot, and when it comes down to it, this is still a kernel
>> regression, we should also fix the kernel to sanity check the values
>> coming from u-boot, like it was doing before.
> 
> It wasn't sanity checking the values (there is some sanity checking,
> but the sanity checking doesn't catch this).
> 
> What caught it was that the kernel was configured to only look at the
> first 8 of the 12 meminfo entries with ATAGs.  Since we no longer have
> that limit, all meminfo entries are now looked at (since the kernel
> doesn't need the limit.)
> 
> We could add back a soft-limit on the number of meminfo entries, but
> this has to be platform specific.  Another entry to go into the
> mach_info structures?
> 

This is the least bad option I've come up with. It brings back
early_init_dt_add_memory_arch so we can use arm_add_memory and stop
adding memory if it reaches an upper threshold. I was debating setting
the default at 12 or 8 but setting at 12 seems like it would involve the
fewest platform changes.

Thanks,
Laura

----8<----
>From 1a5265fd178fea0da432fa9d49ce28e78bd25e04 Mon Sep 17 00:00:00 2001
From: Laura Abbott <lauraa@codeaurora.org>
Date: Thu, 26 Jun 2014 11:23:44 -0700
Subject: [PATCH] arm: Add back maximum bank limit

Commit 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76
(ARM: 8025/1: Get rid of meminfo) dropped the upper bound on
the number of memory banks that can be added as there was no
technical need in the kernel. It turns out though, some bootloaders
(specifically the arndale-octa exynos boards) may pass invalid memory
information and rely on the kernel to not parse this data. This is a
bug in the bootloader but we still need to work around this.
Re-introduce a maximum bank limit per board to prevent invalid banks
from being passed to the kernel.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/mach/arch.h |  8 ++++++--
 arch/arm/kernel/devtree.c        |  4 ++++
 arch/arm/kernel/setup.c          | 16 ++++++++++++++++
 arch/arm/mach-exynos/exynos.c    |  1 +
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 060a75e..2a436ac 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -40,6 +40,8 @@ struct machine_desc {
 	unsigned int		video_start;	/* start of video RAM	*/
 	unsigned int		video_end;	/* end of video RAM	*/
 
+	unsigned int		bank_limit;	/* maximum number of memory
+						 * banks to add */
 	unsigned char		reserve_lp0 :1;	/* never has lp0	*/
 	unsigned char		reserve_lp1 :1;	/* never has lp1	*/
 	unsigned char		reserve_lp2 :1;	/* never has lp2	*/
@@ -85,7 +87,8 @@ static const struct machine_desc __mach_desc_##_type	\
  __used							\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= MACH_TYPE_##_type,		\
-	.name		= _name,
+	.name		= _name,			\
+	.bank_limit	= 12,
 
 #define MACHINE_END				\
 };
@@ -95,6 +98,7 @@ static const struct machine_desc __mach_desc_##_name	\
  __used							\
  __attribute__((__section__(".arch.info.init"))) = {	\
 	.nr		= ~0,				\
-	.name		= _namestr,
+	.name		= _namestr,			\
+	.bank_limit	= 12,
 
 #endif
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index e94a157..ea9ce92 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -27,6 +27,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	arm_add_memory(base, size);
+}
 
 #ifdef CONFIG_SMP
 extern struct of_cpu_method __cpu_method_of_table[];
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8a16ee5..3ab94d1 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -629,11 +629,26 @@ void __init dump_machine_table(void)
 		/* can't use cpu_relax() here as it may require MMU setup */;
 }
 
+static unsigned int bank_cnt;
+static unsigned int max_cnt;
+
 int __init arm_add_memory(u64 start, u64 size)
 {
 	u64 aligned_start;
 
 	/*
+	 * Some buggy bootloaders rely on the old meminfo behavior of not adding
+	 * more than n banks since anything past that may contain invalid data.
+	 */
+	if (bank_cnt >= max_cnt) {
+		pr_crit("Max banks too low, ignoring memory at 0x%08llx\n",
+			(long long)start);
+		return -EINVAL;
+	}
+
+	bank_cnt++;
+
+	/*
 	 * Ensure that start/size are aligned to a page boundary.
 	 * Size is appropriately rounded down, start is rounded up.
 	 */
@@ -879,6 +894,7 @@ void __init setup_arch(char **cmdline_p)
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
+	max_cnt = mdesc->bank_limit;
 
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f38cf7c..91283fd 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -350,4 +350,5 @@ DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
 	.dt_compat	= exynos_dt_compat,
 	.restart	= exynos_restart,
 	.reserve	= exynos_reserve,
+	.bank_limit     = 8,
 MACHINE_END
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
