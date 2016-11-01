From: mzoran@crowfest.net (Michael Zoran)
Date: Tue,  1 Nov 2016 08:21:14 -0700
Subject: [PATCH] staging: vc04_services: parse_rx_slots() - Fix compiler
 warning
Message-ID: <20161101152114.19394-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vc04_services contains a debug logging mechanism.  The log is
maintained in a shared memory area between the kernel and the
firmware.  Changing the sizes of the data in this area would
require a firmware change which is distributed independently
from the kernel binary.

One of the items logged is the address of received messages.
This address is a pointer, but the debugging slot used to store
the information is a 32 bit integer.

Luckily, this value is never interpreted by anything other
then debug tools and it is expected that a human debugging
the kernel interpret it.

This change adds a cast to long before the original cast
to int to silence the warning.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index f3e1000..c187719 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1619,7 +1619,7 @@ parse_rx_slots(VCHIQ_STATE_T *state)
 
 		header = (VCHIQ_HEADER_T *)(state->rx_data +
 			(state->rx_pos & VCHIQ_SLOT_MASK));
-		DEBUG_VALUE(PARSE_HEADER, (int)header);
+		DEBUG_VALUE(PARSE_HEADER, (int)(long)header);
 		msgid = header->msgid;
 		DEBUG_VALUE(PARSE_MSGID, msgid);
 		size = header->size;
-- 
2.10.2
