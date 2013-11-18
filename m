From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Nov 2013 11:55:43 +0100
Subject: [PATCH 1/3] arm: delete __cpuinit/__CPUINIT usage from all ARM
 users
In-Reply-To: <1384771703-25741-2-git-send-email-francesco.virlinzi@st.com>
References: <1384771703-25741-1-git-send-email-francesco.virlinzi@st.com>
 <1384771703-25741-2-git-send-email-francesco.virlinzi@st.com>
Message-ID: <5289F22F.2010007@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 11:48 AM, Francesco VIRLINZI wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
> 
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
> 
> Note that some harmless section mismatch warnings may result, since
> notify_cpu_starting() and cpu_up() are arch independent (kernel/cpu.c)
> and are flagged as __cpuinit  -- so if we remove the __cpuinit from
> the arch specific callers, we will also get section mismatch warnings.
> As an intermediate step, we intend to turn the linux/init.h cpuinit
> related content into no-ops as early as possible, since that will get
> rid of these warnings.  In any case, they are temporary and harmless.
> 
> This removes all the ARM uses of the __cpuinit macros from C code,
> and all __CPUINIT from assembly code.  It also had two ".previous"
> section statements that were paired off against __CPUINIT
> (aka .section ".cpuinit.text") that also get removed here.
> 
> [1] https://lkml.org/lkml/2013/5/20/589
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Conflicts:
> 
> 	arch/arm/common/mcpm_platsmp.c
> 	arch/arm/include/asm/arch_timer.h
> 	arch/arm/kernel/head-common.S
> 	arch/arm/kernel/head-nommu.S
> 	arch/arm/kernel/perf_event_cpu.c
> 	arch/arm/kernel/psci_smp.c
> 	arch/arm/kernel/smp.c
> 	arch/arm/lib/delay.c
> 	arch/arm/mach-exynos/platsmp.c
> 	arch/arm/mach-highbank/platsmp.c
> 	arch/arm/mach-imx/platsmp.c
> 	arch/arm/mach-keystone/platsmp.c
> 	arch/arm/mach-msm/platsmp.c
> 	arch/arm/mach-mvebu/coherency.c
> 	arch/arm/mach-mvebu/headsmp.S
> 	arch/arm/mach-mvebu/platsmp.c
> 	arch/arm/mach-omap2/omap-headsmp.S
> 	arch/arm/mach-omap2/omap-smp.c
> 	arch/arm/mach-prima2/headsmp.S
> 	arch/arm/mach-prima2/platsmp.c
> 	arch/arm/mach-shmobile/headsmp-scu.S
> 	arch/arm/mach-shmobile/headsmp.S
> 	arch/arm/mach-shmobile/smp-emev2.c
> 	arch/arm/mach-shmobile/smp-r8a7779.c
> 	arch/arm/mach-shmobile/smp-sh73a0.c
> 	arch/arm/mach-socfpga/headsmp.S
> 	arch/arm/mach-socfpga/platsmp.c
> 	arch/arm/mach-spear/generic.h
> 	arch/arm/mach-spear/platsmp.c
> 	arch/arm/mach-sti/platsmp.c
> 	arch/arm/mach-tegra/platsmp.c
> 	arch/arm/mach-tegra/pm.c
> 	arch/arm/mach-ux500/platsmp.c
> 	arch/arm/mach-zynq/common.h
> 	arch/arm/mach-zynq/headsmp.S
> 	arch/arm/mach-zynq/platsmp.c

What's this?
Probably incorrect setup of git send-email.

Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/428e84b0/attachment.sig>
