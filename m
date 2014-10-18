From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:56:51 +0100
Subject: [PATCH 01/12] arm: kvm: fix CPU hotplug
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

On some platforms with no power management capabilities, the hotplug
implementation is allowed to return from a smp_ops.cpu_die() call as a
function return. Upon a CPU onlining event, the KVM CPU notifier tries
to reinstall the hyp stub, which fails on platform where no reset took
place following a hotplug event, with the message:

CPU1: smp_ops.cpu_die() returned, trying to resuscitate
CPU1: Booted secondary processor
Kernel panic - not syncing: unexpected prefetch abort in Hyp mode at: 0x80409540
unexpected data abort in Hyp mode at: 0x80401fe8
unexpected HVC/SVC trap in Hyp mode at: 0x805c6170

since KVM code is trying to reinstall the stub on a system where it is
already configured.

To prevent this issue, this patch adds a check in the KVM hotplug
notifier that detects if the HYP stub really needs re-installing when a
CPU is onlined and skips the installation call if the stub is already in
place, which means that the CPU has not been reset.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 7796051..45e5f67 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -808,7 +808,8 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
 	switch (action) {
 	case CPU_STARTING:
 	case CPU_STARTING_FROZEN:
-		cpu_init_hyp_mode(NULL);
+		if (__hyp_get_vectors() == hyp_default_vectors)
+			cpu_init_hyp_mode(NULL);
 		break;
 	}
 
-- 
2.1.1
