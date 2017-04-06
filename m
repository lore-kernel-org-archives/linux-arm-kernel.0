From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  6 Apr 2017 19:29:20 +0100
Subject: [PATCHv2 13/16] arm64: parking: fix type endianness
In-Reply-To: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1491503363-17731-14-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The read*{,_relaxed}() return a value of native CPU endianness,
swizzling the LE value they read from an __iomem pointer.

Thus it isn't correct to treat their return values as __le32 or __le64,
and we should use u32 and u64 respectively instead.

This makes sparse much happier, but should have no functional impact.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/acpi_parking_protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index e2c7399..b878b15 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -56,7 +56,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 {
 	struct acpi_madt_generic_interrupt *p = acpi_cpu_get_madt_gicc(cpu);
 	struct parking_protocol_mailbox __iomem *mailbox;
-	__le32 cpu_id;
+	u32 cpu_id;
 
 	/*
 	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
@@ -107,7 +107,7 @@ static void acpi_parking_protocol_cpu_postboot(void)
 {
 	int cpu = smp_processor_id();
 	struct parking_protocol_mailbox __iomem *mailbox;
-	__le64 entry_point;
+	u64 entry_point;
 
 	mailbox = per_cpu(mailboxes, cpu);
 
-- 
1.9.1
