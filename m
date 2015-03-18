From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:03 +0000
Subject: [PATCH 04/13] ARM: at91: setup.c: use endian agnostic IO functions
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the endian agnostic IO accessors in setup.c to avoid issues if
running on an big endian capable cpu

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
---
 arch/arm/mach-at91/setup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 4e58bc9..7bf81fd 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -46,7 +46,7 @@ static void __init soc_detect(u32 dbgu_base)
 {
 	u32 cidr, socid;
 
-	cidr = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
+	cidr = readl_relaxed(AT91_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
 	socid = cidr & ~AT91_CIDR_VERSION;
 
 	switch (socid) {
@@ -96,7 +96,7 @@ static void __init soc_detect(u32 dbgu_base)
 		break;
 
 	case ARCH_ID_SAMA5:
-		at91_soc_initdata.exid = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
+		at91_soc_initdata.exid = readl_relaxed(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
 		if (at91_soc_initdata.exid & ARCH_EXID_SAMA5D3) {
 			at91_soc_initdata.type = AT91_SOC_SAMA5D3;
 		}
@@ -121,7 +121,7 @@ static void __init soc_detect(u32 dbgu_base)
 
 	/* sub version of soc */
 	if (!at91_soc_initdata.exid)
-		at91_soc_initdata.exid = __raw_readl(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
+		at91_soc_initdata.exid = readl_relaxed(AT91_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
 
 	if (at91_soc_initdata.type == AT91_SOC_SAM9G45) {
 		switch (at91_soc_initdata.exid) {
@@ -183,12 +183,12 @@ static void __init alt_soc_detect(u32 dbgu_base)
 	u32 cidr, socid;
 
 	/* SoC ID */
-	cidr = __raw_readl(AT91_ALT_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
+	cidr = readl_relaxed(AT91_ALT_IO_P2V(dbgu_base) + AT91_DBGU_CIDR);
 	socid = cidr & ~AT91_CIDR_VERSION;
 
 	switch (socid) {
 	case ARCH_ID_SAMA5:
-		at91_soc_initdata.exid = __raw_readl(AT91_ALT_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
+		at91_soc_initdata.exid = readl_relaxed(AT91_ALT_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
 		if (at91_soc_initdata.exid & ARCH_EXID_SAMA5D3) {
 			at91_soc_initdata.type = AT91_SOC_SAMA5D3;
 		} else if (at91_soc_initdata.exid & ARCH_EXID_SAMA5D4) {
@@ -204,7 +204,7 @@ static void __init alt_soc_detect(u32 dbgu_base)
 
 	/* sub version of soc */
 	if (!at91_soc_initdata.exid)
-		at91_soc_initdata.exid = __raw_readl(AT91_ALT_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
+		at91_soc_initdata.exid = readl_relaxed(AT91_ALT_IO_P2V(dbgu_base) + AT91_DBGU_EXID);
 
 	if (at91_soc_initdata.type == AT91_SOC_SAMA5D4) {
 		switch (at91_soc_initdata.exid) {
-- 
2.1.4
