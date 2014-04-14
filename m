From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:47:02 +0200
Subject: [PATCH v3 04/10] ARM: mvebu: ARM: mvebu: use
 of_find_matching_node_and_match() in coherency.c
In-Reply-To: <1397483228-25625-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483228-25625-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483228-25625-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the mach-mvebu coherency code, instead of using
of_find_matching_node() and then of_match_node(), directly use the
of_find_matching_node_and_match() which does both at once.

We take this opportunity to also simplify the initialization of the
"type" variable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 296cf14..862100f 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -148,14 +148,11 @@ static void __init armada_370_coherency_init(struct device_node *np)
 static int coherency_type(void)
 {
 	struct device_node *np;
+	const struct of_device_id *match;
 
-	np = of_find_matching_node(NULL, of_coherency_table);
+	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);
 	if (np) {
-		const struct of_device_id *match =
-			of_match_node(of_coherency_table, np);
-		int type;
-
-		type = (int) match->data;
+		int type = (int) match->data;
 
 		/* Armada 370/XP coherency works in both UP and SMP */
 		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
-- 
1.8.3.2
