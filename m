From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:48:03 +0200
Subject: [PATCH RFC 08/18] staging: vchiq_core: remove unnecessary safety
 checks in vchiq_init_state
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-9-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vchiq_init_state() checks the initial contents of slot_zero are correct.
These are set in vchiq_init_slots(), using the same hard-coded defaults
as the checks. Both functions are called sequentially and Video Core
isn't yet aware of the slot's address. There is no way the contents of
slot_zero changed in between functions, making the checks useless.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_core.c          | 59 -------------------
 1 file changed, 59 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 34a892011296..dee5ea7bfe4f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2170,65 +2170,6 @@ vchiq_init_state(VCHIQ_STATE_T *state, VCHIQ_SLOT_ZERO_T *slot_zero)
 		return VCHIQ_ERROR;
 	}
 
-	/* Check the input configuration */
-
-	if (slot_zero->magic != VCHIQ_MAGIC) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("Invalid VCHIQ magic value found.");
-		vchiq_loud_error("slot_zero=%pK: magic=%x (expected %x)",
-			slot_zero, slot_zero->magic, VCHIQ_MAGIC);
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if (slot_zero->version < VCHIQ_VERSION_MIN) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("Incompatible VCHIQ versions found.");
-		vchiq_loud_error("slot_zero=%pK: VideoCore version=%d (minimum %d)",
-			slot_zero, slot_zero->version, VCHIQ_VERSION_MIN);
-		vchiq_loud_error("Restart with a newer VideoCore image.");
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if (VCHIQ_VERSION < slot_zero->version_min) {
-		vchiq_loud_error_header();
-		vchiq_loud_error("Incompatible VCHIQ versions found.");
-		vchiq_loud_error("slot_zero=%pK: version=%d (VideoCore minimum %d)",
-			slot_zero, VCHIQ_VERSION, slot_zero->version_min);
-		vchiq_loud_error("Restart with a newer kernel.");
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if ((slot_zero->slot_zero_size != sizeof(VCHIQ_SLOT_ZERO_T)) ||
-		 (slot_zero->slot_size != VCHIQ_SLOT_SIZE) ||
-		 (slot_zero->max_slots != VCHIQ_MAX_SLOTS) ||
-		 (slot_zero->max_slots_per_side != VCHIQ_MAX_SLOTS_PER_SIDE)) {
-		vchiq_loud_error_header();
-		if (slot_zero->slot_zero_size != sizeof(VCHIQ_SLOT_ZERO_T))
-			vchiq_loud_error("slot_zero=%pK: slot_zero_size=%d (expected %d)",
-				slot_zero, slot_zero->slot_zero_size,
-				(int)sizeof(VCHIQ_SLOT_ZERO_T));
-		if (slot_zero->slot_size != VCHIQ_SLOT_SIZE)
-			vchiq_loud_error("slot_zero=%pK: slot_size=%d (expected %d)",
-				slot_zero, slot_zero->slot_size,
-				VCHIQ_SLOT_SIZE);
-		if (slot_zero->max_slots != VCHIQ_MAX_SLOTS)
-			vchiq_loud_error("slot_zero=%pK: max_slots=%d (expected %d)",
-				slot_zero, slot_zero->max_slots,
-				VCHIQ_MAX_SLOTS);
-		if (slot_zero->max_slots_per_side != VCHIQ_MAX_SLOTS_PER_SIDE)
-			vchiq_loud_error("slot_zero=%pK: max_slots_per_side=%d (expected %d)",
-				slot_zero, slot_zero->max_slots_per_side,
-				VCHIQ_MAX_SLOTS_PER_SIDE);
-		vchiq_loud_error_footer();
-		return VCHIQ_ERROR;
-	}
-
-	if (VCHIQ_VERSION < slot_zero->version)
-		slot_zero->version = VCHIQ_VERSION;
-
 	local = &slot_zero->slave;
 	remote = &slot_zero->master;
 
-- 
2.19.1
