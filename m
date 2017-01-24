From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Jan 2017 17:11:40 +0000
Subject: [PATCH] arm64: kernel: do not mark reserved memory regions as
 IORESOURCE_BUSY
Message-ID: <1485277900-22730-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory regions marked as NOMAP should not be used for general allocation
by the kernel, and should not even be covered by the linear mapping
(hence the name). However, drivers or other subsystems (such as ACPI)
that access the firmware directly may legally access them, which means
it is also reasonable for such drivers to claim them by invoking
request_resource(). Currently, this is prevented by the fact that arm64's
request_standard_resources() marks reserved regions as IORESOURCE_BUSY.

So drop the IORESOURCE_BUSY flag from these requests.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b051367e2149..888295e46b53 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -208,7 +208,7 @@ static void __init request_standard_resources(void)
 		res = alloc_bootmem_low(sizeof(*res));
 		if (memblock_is_nomap(region)) {
 			res->name  = "reserved";
-			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+			res->flags = IORESOURCE_MEM;
 		} else {
 			res->name  = "System RAM";
 			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-- 
2.7.4
