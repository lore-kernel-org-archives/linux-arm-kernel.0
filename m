From: sasha.levin@oracle.com (Sasha Levin)
Date: Thu,  8 Nov 2012 15:23:06 -0500
Subject: [PATCH] ARM: kprobes: use BUG_ON where possible
In-Reply-To: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
Message-ID: <1352406191-14303-4-git-send-email-sasha.levin@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just use BUG_ON() instead of constructions such as:

	if (...)
		BUG()

A simplified version of the semantic patch that makes this transformation
is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@
- if (e) BUG();
+ BUG_ON(e);
// </smpl>

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/arm/kernel/kprobes-test.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 1862d8f..0fb370d 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -1212,8 +1212,7 @@ static int register_test_probe(struct test_probe *probe)
 {
 	int ret;
 
-	if (probe->registered)
-		BUG();
+	BUG_ON(probe->registered);
 
 	ret = register_kprobe(&probe->kprobe);
 	if (ret >= 0) {
-- 
1.7.10.4
