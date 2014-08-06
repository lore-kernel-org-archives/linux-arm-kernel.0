From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed,  6 Aug 2014 22:12:17 +0200
Subject: [PATCH 3/4] iio: fix error return code
Message-ID: <1407355938-10932-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Convert a zero return value on error to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if at p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
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
 drivers/iio/adc/xilinx-xadc-core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index fd2745c..196e269 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1201,12 +1201,16 @@ static int xadc_probe(struct platform_device *pdev)
 			goto err_device_free;
 
 		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-		if (IS_ERR(xadc->convst_trigger))
+		if (IS_ERR(xadc->convst_trigger)) {
+			ret = PTR_ERR(xadc->convst_trigger);
 			goto err_triggered_buffer_cleanup;
+		}
 		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
 			"samplerate");
-		if (IS_ERR(xadc->samplerate_trigger))
+		if (IS_ERR(xadc->samplerate_trigger)) {
+			ret = PTR_ERR(xadc->samplerate_trigger);
 			goto err_free_convst_trigger;
+		}
 	}
 
 	xadc->clk = devm_clk_get(&pdev->dev, NULL);
