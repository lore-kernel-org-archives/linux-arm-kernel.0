From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 5 Jun 2017 18:10:30 +0800
Subject: [PATCH v1 2/4] coresight: add and remove panic callback for sink
In-Reply-To: <ed729e35-f5aa-cd03-410b-a6ad366b4170@arm.com>
References: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
 <1496500976-18362-3-git-send-email-leo.yan@linaro.org>
 <ed729e35-f5aa-cd03-410b-a6ad366b4170@arm.com>
Message-ID: <20170605101029.GC8682@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 10:24:41AM +0100, Suzuki K Poulose wrote:
> On 03/06/17 15:42, Leo Yan wrote:
> >If the sink device has panic callback function, add the panic callback
> >node for coresight panic dump list when the sink device is enabled;
> >also cleanup the node when the sink device is disabled.
> >
> >Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >---
> > drivers/hwtracing/coresight/coresight.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >
> >diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> >index 0c37356..5928886 100644
> >--- a/drivers/hwtracing/coresight/coresight.c
> >+++ b/drivers/hwtracing/coresight/coresight.c
> >@@ -138,6 +138,13 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
> > 			if (ret)
> > 				return ret;
> > 		}
> >+
> >+		/* Add kernel panic callback */
> >+		if (sink_ops(csdev)->panic_cb) {
> >+			ret = coresight_add_panic_cb(csdev);
> >+			if (ret)
> >+				return ret;
> >+		}
> > 		csdev->enable = true;
> > 	}
> >
> >@@ -149,6 +156,10 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
> > static void coresight_disable_sink(struct coresight_device *csdev)
> > {
> > 	if (atomic_dec_return(csdev->refcnt) == 0) {
> >+		/* Remove kernel panic callback */
> >+		if (sink_ops(csdev)->panic_cb)
> >+			coresight_del_panic_cb(csdev);
> >+
> > 		if (sink_ops(csdev)->disable) {
> > 			sink_ops(csdev)->disable(csdev);
> > 			csdev->enable = false;
> >
> 
> Just a thought, instead of adding/deleting every time the sink is enabled,
> could we add/del the device once for-ever and let the panic_cb decide to dump
> it based on whether the device was active or not ?

Yeah, we can check 'if (drvdata->mode == CS_MODE_DISABLED)' and
directly bail out if the module is disabled for panic dumping. Will
fix with this way.

Thanks,
Leo Yan
