From: cmaiolino28@gmail.com (Carlos Maiolino)
Date: Tue, 24 Jul 2018 10:32:17 +0200
Subject: [PATCH] staging/vc04_services: Use __user annotation for user-space
 pointers
Message-ID: <20180724083217.20921-1-cmaiolino28@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix several sparse warnings regarding different address space
assignments, like example below, by properly annotating pointers
expected to carry user space addresses.

warning: incorrect type in argument 1 (different address spaces)
Signed-off-by: Carlos Maiolino <cmaiolino28@gmail.com>
---

I'm not subscribed to the list, so, please, CC me on any reply.
Thanks a lot.

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 4 ++--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index bc05c69383b8..42f471471e57 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1648,8 +1648,8 @@ vchiq_compat_ioctl_queue_message(struct file *file,
 				 unsigned int cmd,
 				 unsigned long arg)
 {
-	VCHIQ_QUEUE_MESSAGE_T *args;
-	struct vchiq_element *elements;
+	VCHIQ_QUEUE_MESSAGE_T __user *args;
+	struct vchiq_element __user *elements;
 	struct vchiq_queue_message32 args32;
 	unsigned int count;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 9f859953f45c..1776fab41e40 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -50,7 +50,7 @@ typedef struct {
 typedef struct {
 	unsigned int handle;
 	unsigned int count;
-	const struct vchiq_element *elements;
+	const struct vchiq_element __user *elements;
 } VCHIQ_QUEUE_MESSAGE_T;
 
 typedef struct {
-- 
2.14.3
