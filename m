From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Jul 2015 16:01:46 +0100
Subject: [PATCH v5] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <55A971C1.8090308@codeaurora.org>
References: <1428705191-15670-1-git-send-email-sboyd@codeaurora.org>
 <20150413134246.GS12732@n2100.arm.linux.org.uk>
 <557739AC.8000903@codeaurora.org>
 <20150610225744.GT7557@n2100.arm.linux.org.uk>
 <5578C427.1070100@codeaurora.org> <55A971C1.8090308@codeaurora.org>
Message-ID: <20150725150146.GA7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 02:21:05PM -0700, Stephen Boyd wrote:
> On 06/10/2015 04:11 PM, Stephen Boyd wrote:
> >On 06/10/2015 03:57 PM, Russell King - ARM Linux wrote:
> >>diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
> >>index 476092b86c6e..f2c4bf437ea7 100644
> >>--- a/arch/arm/mach-shmobile/common.h
> >>+++ b/arch/arm/mach-shmobile/common.h
> >>@@ -13,7 +13,8 @@ extern void shmobile_smp_boot(void);
> >>  extern void shmobile_smp_sleep(void);
> >>  extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
> >>  			      unsigned long arg);
> >>-extern int shmobile_smp_cpu_disable(unsigned int cpu);
> >>+extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
> >>+extern void shmobile_invalidate_start(void);
> >>
> >>which your original patch did not include.  The tree I'm applying to
> >>(-rc1) contains:
> >>
> >>extern int shmobile_smp_cpu_disable(unsigned int cpu);
> >>extern void shmobile_invalidate_start(void);
> >>
> >>there.  Hence git quite rightfully declines to apply the patch.
> >>
> >Thanks. Fixed.
> >
> 
> Sorry I just noticed that you applied 8392/1 instead of 8392/2 from the
> patch tracker. So shmobile_invalidate_start() came back.

Stephen,

8392/2 does _not_ apply:

$ pdb gitapply 8392/2
Patching 8392/2...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.521 2>&1 exited with non-zero status: 256
error: patch failed: arch/arm/mach-shmobile/common.h:13
error: arch/arm/mach-shmobile/common.h: patch does not apply

However, 8392/1 does:

$ pdb gitapply 8392/1
Patching 8392/1...
Checking in...
[misc e28678d7b83a] ARM: 8392/1: smp: Only expose /sys/.../cpuX/online if hotpluggable
 Author: Stephen Boyd <sboyd@codeaurora.org>
 10 files changed, 36 insertions(+), 16 deletions(-)

This is because your patch 8392/2 has this hunk:

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index afc60bad6fd6..f2c4bf437ea7 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -13,7 +13,7 @@ extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
                              unsigned long arg);
-extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern bool shmobile_smp_cpu_can_disable(unsigned int cpu);
 extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);

which states that shmobile_invalidate_start() must exist in the original
code.  In v4.2-rc1 and later kernels, there is no such line - here is
v4.2-rc1 and later contains from line 13 onwards:

 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);

The difference between your two patches is relatively minor:

8392/1 _adds_ shmobile_invalidate_start()
8392/2 _requires_ that shmobile_invalidate_start() exist

If you wish me to apply a patch which _neither_ requires _nor_ adds the
shmobile_invalidate_start() prototype, maybe you should send me a patch
to that effect?

> I thought it would automatically supersede the previous patch but it
> looks like it just sticks around?

It doesn't, because the /n thing was supposed to be for related patches
rather than automatic superseding of previous patches.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
