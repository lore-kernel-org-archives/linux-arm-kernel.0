From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:55 +0800
Subject: [PATCH 18/45] arm64: cpufeature: __this_cpu_has_cap() shouldn't stop
 early
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-19-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

commit edf298cfce47 upstream.
Alex Shi rewrite this commit on func this_cpu_has_cap(). The following commit
log is still meaningful.

    this_cpu_has_cap() tests caps->desc not caps->matches, so it stops
    walking the list when it finds a 'silent' feature, instead of
    walking to the end of the list.

    Prior to v4.6's 644c2ae198412 ("arm64: cpufeature: Test 'matches' pointer
    to find the end of the list") we always tested desc to find the end of
    a capability list. This was changed for dubious things like PAN_NOT_UAO.
    v4.7's e3661b128e53e ("arm64: Allow a capability to be checked on
    single CPU") added this_cpu_has_cap() using the old desc style test.

CC: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/futex.h | 1 +
 arch/arm64/kernel/cpufeature.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 1943cf6..718140a 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -20,6 +20,7 @@
 
 #include <linux/futex.h>
 #include <linux/uaccess.h>
+#include <linux/compiler.h>
 
 #include <asm/errno.h>
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3a129d4..fcb67e0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1063,8 +1063,8 @@ bool this_cpu_has_cap(unsigned int cap)
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = arm64_features; caps->desc; caps++)
-		if (caps->capability == cap && caps->matches)
+	for (caps = arm64_features; caps->matches; caps++)
+		if (caps->capability == cap)
 			return caps->matches(caps, SCOPE_LOCAL_CPU);
 
 	return false;
-- 
2.7.4
