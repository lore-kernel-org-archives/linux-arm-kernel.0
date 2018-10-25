From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 Oct 2018 17:29:35 +0200
Subject: [PATCH RFC 11/11] staging: bcm2835-camera: Add hint about possible
 faulty config
In-Reply-To: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1540481375-15952-12-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per default the GPU memory config of the Raspberry Pi isn't sufficient
for the camera usage. Even worse the bcm2835 camera driver doesn't provide a
helpful error message in this case. So let's add a hint to point the user
to the likely cause.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index cc2d993..bffd75d 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -1623,8 +1623,11 @@ int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
 	component = &instance->component[instance->component_idx];
 
 	ret = create_component(instance, component, name);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_err("%s: failed to create component %d (Not enough GPU mem?)\n",
+		       __func__, ret);
 		goto unlock;
+	}
 
 	/* ports info needs gathering */
 	component->control.type = MMAL_PORT_TYPE_CONTROL;
-- 
2.7.4
