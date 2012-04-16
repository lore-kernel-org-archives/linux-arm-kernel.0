From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Apr 2012 17:13:25 +0100
Subject: [PATCH v3 1/6] ARM: local timers: reserve local_timer_register() to
 SMP
In-Reply-To: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1334592810-4382-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running an SMP_ON_UP enabled kernel on UP, or with nosmp
passed to the kernel, we want to be able to detect that a local
timer is not going to be used (local timers are only used on
SMP platforms), so we could register it as a global timer instead.

Return -ENXIO when the above case is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/smp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index addbbe8..11c4148 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -454,6 +454,9 @@ static struct local_timer_ops *lt_ops;
 #ifdef CONFIG_LOCAL_TIMERS
 int local_timer_register(struct local_timer_ops *ops)
 {
+	if (!is_smp() || !setup_max_cpus)
+		return -ENXIO;
+
 	if (lt_ops)
 		return -EBUSY;
 
-- 
1.7.7.1
