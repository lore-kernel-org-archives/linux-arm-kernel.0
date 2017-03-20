From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Mar 2017 17:48:23 +0000
Subject: [PATCH v2 12/18] arm64: arch_timer: Make workaround methods optional
In-Reply-To: <20170320174829.28182-1-marc.zyngier@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
Message-ID: <20170320174829.28182-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all errata need to workaround all access types. Allow them to
be optional.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 58572d38e9db..d46cf21e8b80 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -61,8 +61,9 @@ extern const struct arch_timer_erratum_workaround *timer_unstable_counter_workar
 #define arch_timer_reg_read_stable(reg) 		\
 ({							\
 	u64 _val;					\
-	if (needs_unstable_timer_counter_workaround())		\
-		_val = timer_unstable_counter_workaround->read_##reg();\
+	if (needs_unstable_timer_counter_workaround() &&		\
+	    timer_unstable_counter_workaround->read_##reg)		\
+		_val = timer_unstable_counter_workaround->read_##reg();	\
 	else						\
 		_val = read_sysreg(reg);		\
 	_val;						\
-- 
2.11.0
