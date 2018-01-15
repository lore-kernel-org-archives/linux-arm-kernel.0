From: james.morse@arm.com (James Morse)
Date: Mon, 15 Jan 2018 19:38:54 +0000
Subject: [PATCH v6 01/13] arm64: cpufeature: __this_cpu_has_cap() shouldn't
 stop early
In-Reply-To: <20180115193906.30053-1-james.morse@arm.com>
References: <20180115193906.30053-1-james.morse@arm.com>
Message-ID: <20180115193906.30053-2-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this_cpu_has_cap() tests caps->desc not caps->matches, so it stops
walking the list when it finds a 'silent' feature, instead of
walking to the end of the list.

Prior to v4.6's 644c2ae198412 ("arm64: cpufeature: Test 'matches' pointer
to find the end of the list") we always tested desc to find the end of
a capability list. This was changed for dubious things like PAN_NOT_UAO.
v4.7's e3661b128e53e ("arm64: Allow a capability to be checked on
single CPU") added this_cpu_has_cap() using the old desc style test.

CC: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
So far only ARM64_HAS_SYSREG_GIC_CPUIF and errata use this_cpu_has_cap(),
all the errata have descriptions, and the GIC_CPUIF feature is first in
the list, so its not possible to hit this with mainline. I don't think
this should go to stable - this is not intended as a fix.

 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9ef84d0def9a..d88cd0e88606 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1303,8 +1303,8 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = cap_array; caps->desc; caps++)
-		if (caps->capability == cap && caps->matches)
+	for (caps = cap_array; caps->matches; caps++)
+		if (caps->capability == cap)
 			return caps->matches(caps, SCOPE_LOCAL_CPU);
 
 	return false;
-- 
2.15.1
