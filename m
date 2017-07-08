From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Fri, 7 Jul 2017 19:33:30 -0500
Subject: [PATCH] watchdog: coh901327_wdt: constify watchdog_ops structure
Message-ID: <20170708003330.GA15374@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for watchdog_ops structures that are only stored in the ops field of
a watchdog_device structure. This field is declared const, so watchdog_ops
structures that have this property can be declared as const also.

This issue was detected using Coccinelle and the following semantic patch:

@r
disable optional_qualifier@
identifier i;
position p;
@@
static struct watchdog_ops i at p = { ... };

@ok@
identifier r.i;
struct watchdog_device e;
position p;
@@
e.ops = &i at p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct watchdog_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct watchdog_ops i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/watchdog/coh901327_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index 38dd60f0..4410337 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -218,7 +218,7 @@ static const struct watchdog_info coh901327_ident = {
 	.identity = DRV_NAME,
 };
 
-static struct watchdog_ops coh901327_ops = {
+static const struct watchdog_ops coh901327_ops = {
 	.owner = THIS_MODULE,
 	.start = coh901327_start,
 	.stop = coh901327_stop,
-- 
2.5.0
