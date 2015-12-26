From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Dec 2015 16:28:46 +0100
Subject: [PATCH 7/7] soc: ti: fix error return code
In-Reply-To: <1451143726-28195-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1451143726-28195-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1451143726-28195-8-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return a negative error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/soc/ti/knav_qmss_queue.c |    1 +
 drivers/soc/ti/wkup_m3_ipc.c     |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8c03a80..b401a28 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1787,6 +1787,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 	regions =  of_get_child_by_name(node, "descriptor-regions");
 	if (!regions) {
 		dev_err(dev, "descriptor-regions not specified\n");
+		ret = -ENODEV;
 		goto err;
 	}
 	ret = knav_queue_setup_regions(kdev, regions);
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 8823cc8..5bb3760 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -459,6 +459,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
 	if (IS_ERR(task)) {
 		dev_err(dev, "can't create rproc_boot thread\n");
+		ret = PTR_ERR(task);
 		goto err_put_rproc;
 	}
 
