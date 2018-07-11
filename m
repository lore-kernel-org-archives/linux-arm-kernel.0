From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:39 +0100
Subject: [PATCHv5 04/21] arm64: kill change_cpacr()
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-5-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have sysreg_clear_set(), we can use this instead of
change_cpacr().

Note that the order of the set and clear arguments differs between
change_cpacr() and sysreg_clear_set(), so these are flipped as part of
the conversion. Also, sve_user_enable() redundantly clears
CPACR_EL1_ZEN_EL0EN before setting it; this is removed for clarity.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 84c68b14f1b2..a98a7f96aff1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,23 +159,14 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
-static void change_cpacr(u64 val, u64 mask)
-{
-	u64 cpacr = read_sysreg(CPACR_EL1);
-	u64 new = (cpacr & ~mask) | val;
-
-	if (new != cpacr)
-		write_sysreg(new, CPACR_EL1);
-}
-
 static void sve_user_disable(void)
 {
-	change_cpacr(0, CPACR_EL1_ZEN_EL0EN);
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
 }
 
 static void sve_user_enable(void)
 {
-	change_cpacr(CPACR_EL1_ZEN_EL0EN, CPACR_EL1_ZEN_EL0EN);
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
 }
 
 /*
-- 
2.11.0
