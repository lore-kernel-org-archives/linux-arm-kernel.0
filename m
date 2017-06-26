From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Mon, 26 Jun 2017 15:16:25 +0200
Subject: [PATCH] arm64: use readq() instead of readl() to read 64bit
 entry_point
Message-ID: <20170626131625.79059-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here the entrypoint, declared as a 64 bit integer, is read from
a pointer to 64bit integer but the read is done via readl_relaxed()
which is for 32bit quantities.

All the high bits will thus be lost which change the meaning
of the test against zero done later.

Fix this by using readq_relaxed() instead as it should be for
64bit quantities.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---

!!! Warning !!!
   I don't have the HW to test this, nor have I read the ACPI specs.
   This is only compile tested.
---
 arch/arm64/kernel/acpi_parking_protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index 1f5655cd9..f35e80aad 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -125,7 +125,7 @@ static void acpi_parking_protocol_cpu_postboot(void)
 	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
 	__le64 entry_point;
 
-	entry_point = readl_relaxed(&mailbox->entry_point);
+	entry_point = readq_relaxed(&mailbox->entry_point);
 	/*
 	 * Check if firmware has cleared the entry_point as expected
 	 * by the protocol specification.
-- 
2.13.0
