From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Nov 2016 11:43:34 +0100
Subject: [PATCH 2/2] soc: ti: knav_qmss_queue: replace IS_ERR_OR_NULL by IS_ERR
In-Reply-To: <1479293014-18811-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1479293014-18811-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1479293014-18811-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

knav_queue_open always returns an ERR_PTR value, never NULL.  This can be
confirmed by unfolding the function calls and conforms to the function's
documentation.  Thus, replace IS_ERR_OR_NULL by IS_ERR in error checks.

The change is made using the following semantic patch:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
statement S;
@@

x = knav_queue_open(...);
if (
-   IS_ERR_OR_NULL
+   IS_ERR
    (x)) S
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

The patches in this series are completely independent of each other, except
for having been made from the same specification.

 drivers/soc/ti/knav_qmss_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index b73e353..d90df84 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -777,7 +777,7 @@ void *knav_pool_create(const char *name,
 	}
 
 	pool->queue = knav_queue_open(name, KNAV_QUEUE_GP, 0);
-	if (IS_ERR_OR_NULL(pool->queue)) {
+	if (IS_ERR(pool->queue)) {
 		dev_err(kdev->dev,
 			"failed to open queue for pool(%s), error %ld\n",
 			name, PTR_ERR(pool->queue));
