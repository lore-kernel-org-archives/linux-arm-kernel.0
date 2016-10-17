From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 12:44:04 -0700
Subject: [PATCH 3/5] staging/vchi: Fix some pointer math for 64-bit.
In-Reply-To: <20161017194406.1080-1-eric@anholt.net>
References: <20161017194406.1080-1-eric@anholt.net>
Message-ID: <20161017194406.1080-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These were throwing warnings on aarch64, and all are trivially
converted to longs.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 6 +++---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c     | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index c5255bc6c589..3c7165b34dab 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -121,7 +121,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 		return -ENOMEM;
 	}
 
-	WARN_ON(((int)slot_mem & (PAGE_SIZE - 1)) != 0);
+	WARN_ON(((unsigned long)slot_mem & (PAGE_SIZE - 1)) != 0);
 
 	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
 	if (!vchiq_slot_zero)
@@ -222,7 +222,7 @@ remote_event_signal(REMOTE_EVENT_T *event)
 int
 vchiq_copy_from_user(void *dst, const void *src, int size)
 {
-	if ((uint32_t)src < TASK_SIZE) {
+	if ((unsigned long)src < TASK_SIZE) {
 		return copy_from_user(dst, src, size);
 	} else {
 		memcpy(dst, src, size);
@@ -375,7 +375,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 	int run, addridx, actual_pages;
         unsigned long *need_release;
 
-	offset = (unsigned int)buf & (PAGE_SIZE - 1);
+	offset = (unsigned long)buf & (PAGE_SIZE - 1);
 	num_pages = (count + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	*ppagelist = NULL;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 93a6ac75791f..6862cbc0d7a9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1723,7 +1723,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 					min(64, size));
 		}
 
-		if (((unsigned int)header & VCHIQ_SLOT_MASK) + calc_stride(size)
+		if (((unsigned long)header & VCHIQ_SLOT_MASK) + calc_stride(size)
 			> VCHIQ_SLOT_SIZE) {
 			vchiq_log_error(vchiq_core_log_level,
 				"header %p (msgid %x) - size %x too big for "
@@ -2268,7 +2268,8 @@ get_conn_state_name(VCHIQ_CONNSTATE_T conn_state)
 VCHIQ_SLOT_ZERO_T *
 vchiq_init_slots(void *mem_base, int mem_size)
 {
-	int mem_align = (VCHIQ_SLOT_SIZE - (int)mem_base) & VCHIQ_SLOT_MASK;
+	int mem_align = (VCHIQ_SLOT_SIZE -
+			 (unsigned long)mem_base) & VCHIQ_SLOT_MASK;
 	VCHIQ_SLOT_ZERO_T *slot_zero =
 		(VCHIQ_SLOT_ZERO_T *)((char *)mem_base + mem_align);
 	int num_slots = (mem_size - mem_align)/VCHIQ_SLOT_SIZE;
-- 
2.9.3
