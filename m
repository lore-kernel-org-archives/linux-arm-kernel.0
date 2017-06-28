From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:58:07 +0200
Subject: [PATCH] arm64: fix endianness annotation in acpi_parking_protocol.c
Message-ID: <20170628145807.24631-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here both variables 'cpu_id' and 'entry_point' are read via
read[lq]_relaxed(), from a little-endian annotated pointer
and then used as a native endian value.

This is correct since the read[lq]() family of function
internally do a little-to-native endian conversion.

But in this case, it is wrong to declare these variable as
little-endian since there are native ones.

Fix this by changing the declaration of these variables
as 'u32' or 'u64' instead of '__le32' / '__le64'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/kernel/acpi_parking_protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index f35e80aad..98a20e587 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -71,7 +71,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 {
 	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
 	struct parking_protocol_mailbox __iomem *mailbox;
-	__le32 cpu_id;
+	u32 cpu_id;
 
 	/*
 	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
@@ -123,7 +123,7 @@ static void acpi_parking_protocol_cpu_postboot(void)
 	int cpu = smp_processor_id();
 	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
 	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
-	__le64 entry_point;
+	u64 entry_point;
 
 	entry_point = readq_relaxed(&mailbox->entry_point);
 	/*
-- 
2.13.0
