From: zyy@motorola.com (Yuanyuan Zhong)
Date: Wed,  2 Oct 2013 16:59:47 -0500
Subject: [PATCH] arm: vfp: always clear vfp_current_hw_state when forcing
 reload
Message-ID: <1380751187-11257-1-git-send-email-zyy@motorola.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current thread trying to clear the held vfp state may not be
the owner of hw state. For example,
	Core0			Core1
				Thread1 uses VFP.
				  Thread1 vfpstate.hard.cpu = 1.
				  vfp_current_hw_state[1] points to Thread1
				    vfpstate.
	Going to suspend.
	Freeze Thread1.
				Thread1 is switched out.
				VFP HW registers saved to Thread1 vfpstate.
	Core0 disables Core1.
				Stopper thread calls vfp_force_reload().
				Stopper thread vfpstate.hard.cpu = NR_CPUS.
				...
				(No PM notifier for non-idle path. So
				  vfp_pm_suspend() is NOT called on Core1.)
				...
				Core1 is off and VFP HW registers are lost.
	...
	Core0 enables Core1.
	Core0 thaw Thread1.
	Thread1 migrate to Core1
	  before using VFP.
				Thread1 starts using VFP.
				Now we have vfp_current_hw_state[1] points
				  to Thread1 vfpstate. And Thread1 has
				  vfpstate.hard.cpu = 1.
				Thread1 does not need to reload saved vfpstate
				  to VFP HW.
				Thread1 continues running using corrupted VFP
				HW register.
This change fixes above gap by always clearing vfp_current_hw_state when
vfp_force_reload() is called.

Signed-off-by: Yuanyuan Zhong <zyy@motorola.com>
---
 arch/arm/vfp/vfpmodule.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 52b8f40..5f132c0 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -84,6 +84,7 @@ static void vfp_force_reload(unsigned int cpu, struct thread_info *thread)
 	}
 #ifdef CONFIG_SMP
 	thread->vfpstate.hard.cpu = NR_CPUS;
+	vfp_current_hw_state[cpu] = NULL;
 #endif
 }
 
-- 
1.7.10.4
