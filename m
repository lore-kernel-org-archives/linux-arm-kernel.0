From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:29 +0100
Subject: [PATCH 04/10] ARM: mvebu: ARM: mvebu: use
 of_find_matching_node_and_match() in coherency.c
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-5-git-send-email-thomas.petazzoni@free-electrons.com>
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
index 0c440c3..15b769d 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -147,14 +147,11 @@ static void __init armada_370_coherency_init(struct device_node *np)
 static int coherency_type(void)
 {
 	struct device_node *np;
+	const struct of_device_id *match;
 
-	np = of_find_matching_node(NULL, of_coherency_table);
+	np = of_find_matching_node_and_match(NULL, of_coherency_table, &match);
 	if (np) {
-                const struct of_device_id *match =
-                    of_match_node(of_coherency_table, np);
-		int type;
-
-		type = (int) match->data;
+		int type = (int) match->data;
 
 		pr_info("Initializing Coherency fabric\n");
 
-- 
1.8.3.2
