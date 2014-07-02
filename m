From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  2 Jul 2014 18:21:09 +0200
Subject: [PATCH 2/3] ARM: mvebu: disable I/O coherency on non-SMP situations
 on Armada 370/XP
In-Reply-To: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1404318070-8503-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling the hardware I/O coherency on Armada 370 and Armada XP
requires a certain number of conditions:

 - On Armada 370, the cache policy must be set to write-allocate.
 - On Armada XP, the cache policy must be set to write-allocate, the
   pages must be mapped with the shareable attribute, and the SMP bit
   must be set

Currently, on Armada XP, when CONFIG_SMP is enabled, those conditions
are met. However, when Armada XP is used in a !CONFIG_SMP kernel, none
of these conditions are met. With Armada 370, the situation is worse:
since the processor is single core, regardless of whether CONFIG_SMP
or !CONFIG_SMP is used, the cache policy will be set to write-back by
the kernel and not write-allocate.

Since solving this problem turns out to be quite complicated, and we
don't want to let users with a mainline kernel known to have
infrequent but existing data corruptions, this commit proposes to
simply disable hardware I/O coherency in situations where it is known
not to work.

And basically, the is_smp() function of the kernel tells us whether it
is OK to enable hardware I/O coherency or not, so this commit slightly
refactors the coherency_type() function to return
COHERENCY_FABRIC_TYPE_NONE when is_smp() is false, or the appropriate
type of the coherency fabric in the other case.

Thanks to this, the I/O coherency fabric will no longer be used at all
in !CONFIG_SMP configurations. It will continue to be used in
CONFIG_SMP configurations on Armada XP, Armada 375 and Armada 38x
(which are multiple cores processors), but will no longer be used on
Armada 370 (which is a single core processor).

In the process, it simplifies the implementation of the
coherency_type() function, and adds a missing call to of_node_put().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: e60304f8cb7bb545e79fe62d9b9762460c254ec2 ("arm: mvebu: Add hardware I/O Coherency support")
Cc: <stable@vger.kernel.org> # v3.8+
---
Obviously, there have been numerous changes between 3.8 and 3.16 on
the coherency code, so this patch will hardly apply on older versions
of the kernel, but we will provide backport versions when requested.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 477202f..2260a40 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -357,25 +357,34 @@ static int coherency_type(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
+	int type;
 
-	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);
-	if (np) {
-		int type = (int) match->data;
+	/*
+	 * The coherency fabric is needed:
+	 * - For coherency between processors on Armada XP, so only
+	 *   when SMP is enabled.
+	 * - For coherency between the processor and I/O devices, but
+	 *   this coherency requires many pre-requisites (write
+	 *   allocate cache policy, shareable pages, SMP bit set) that
+	 *   are only meant in SMP situations.
+	 *
+	 * Note that this means that on Armada 370, there is currently
+	 * no way to use hardware I/O coherency, because even when
+	 * CONFIG_SMP is enabled, is_smp() returns false due to the
+	 * Armada 370 being a single-core processor.
+	 */
+	if (!is_smp())
+		return COHERENCY_FABRIC_TYPE_NONE;
 
-		/* Armada 370/XP coherency works in both UP and SMP */
-		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
-			return type;
+	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);
+	if (!np)
+		return COHERENCY_FABRIC_TYPE_NONE;
 
-		/* Armada 375 coherency works only on SMP */
-		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_375 && is_smp())
-			return type;
+	type = (int) match->data;
 
-		/* Armada 380 coherency works only on SMP */
-		else if (type == COHERENCY_FABRIC_TYPE_ARMADA_380 && is_smp())
-			return type;
-	}
+	of_node_put(np);
 
-	return COHERENCY_FABRIC_TYPE_NONE;
+	return type;
 }
 
 int coherency_available(void)
-- 
2.0.0
