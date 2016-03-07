From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 7 Mar 2016 10:30:06 -0500
Subject: [PATCH V14 8/9] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56DCFEE0.6080101@linaro.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-9-git-send-email-okaya@codeaurora.org>
 <56D08843.5020306@linaro.org> <56D7323B.4040100@codeaurora.org>
 <56D8C539.9000203@linaro.org> <56D91B0E.1080203@codeaurora.org>
 <56DCFEE0.6080101@linaro.org>
Message-ID: <56DD9E7E.6000406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/6/2016 11:09 PM, Eric Auger wrote:
>> #define module_vfio_reset_handler(compat, acpihid, reset)		\
>> > MODULE_ALIAS("vfio-reset:" acpihid? acpihid: compat);			\
>> > 
>> > This way, we'll create an alias with one of the provided strings.  
> What if you want to use vfio platform driver for HiDMA in dt mode? the
> HiDma reset module advertises both acpihid and dt compat support but an
> alias module will be created only for acpihid. Then I think we will not
> be able to load the reset module in dt mode with existing code.
> 

Right, it won't work. Now that we know what MODULE_ALIAS does, there is no
harm in doing this. I think we should do this.

#define module_vfio_reset_handler(compat, acpihid, reset)              \
MODULE_ALIAS("vfio-reset:" compat);                                    \
MODULE_ALIAS("vfio-reset:" acpihid);                                   \

If we prefer ACPI over DT, there is no guarantee that somebody can boot DT
kernel with ACPI kernel compilation option enabled.

If one of these are null, then the module alias will be "vfio-reset:"

Of course to make things prettier, we could use "NOT SUPPORTED" as a string
instead of NULL. then, the module alias will be vfio-reset: NOT SUPPORTED".

We could go one step further, and do.

#define module_vfio_reset_handler(compat, acpihid, reset) \
MODULE_ALIAS("vfio-reset: dt: " compat); \
MODULE_ALIAS("vfio-reset: acpi: " acpihid); \

and change the code below for this too.


> This could work however with some rework in vfio_platform_common.c. In
> vfio_platform_get_reset we should try to load the module using the
> acpihid if the module load using compat alias fails. In the look-up
> table we can find the acpihid corresponding to the dt compat.

I was planning to submit this for the next review. Still, I don't want to 
assume that acpihid is the only working option. Somebody can boot DT kernel.

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 42d7545..ba585ad 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -58,16 +58,30 @@ static vfio_platform_reset_fn_t vfio_platform_lookup_reset(const char *compat,
 	return reset_fn;
 }
 
-static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
+static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
 {
+	int rc;
+
 	vdev->reset = vfio_platform_lookup_reset(vdev->compat, vdev->acpihid,
 						 &vdev->reset_module);
-	if (!vdev->reset) {
-		request_module("vfio-reset:%s", vdev->compat);
-		vdev->reset = vfio_platform_lookup_reset(vdev->compat,
-							 vdev->acpihid,
-							 &vdev->reset_module);
-	}
+	if (vdev->reset)
+		return 0;
+
+	if (vdev->acpihid)
+		rc = request_module("vfio-reset:%s", vdev->acpihid);
+
+	if (rc && vdev->compat)
+		rc = request_module("vfio-reset:%s", vdev->compat);
+
+	if (rc)
+		return rc;
+
+	vdev->reset = vfio_platform_lookup_reset(vdev->compat, vdev->acpihid,
+						 &vdev->reset_module);
+	if (vdev->reset)
+		return 0;
+
+	return -ENODEV;
 }
 
 static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
@@ -620,7 +634,11 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
-	vfio_platform_get_reset(vdev);
+	ret = vfio_platform_get_reset(vdev);
+	if (ret) {
+		iommu_group_put(group);
+		return ret;
+	}
 
 	mutex_init(&vdev->igate);
  

Let me know what you think.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
