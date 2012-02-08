From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed,  8 Feb 2012 12:13:26 +0200
Subject: [PATCH 1/2] arm: orion5x: use native hex2bin()
Message-ID: <1328696007-27538-1-git-send-email-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mach-orion5x/dns323-setup.c |   40 ++-------------------------------
 arch/arm/mach-orion5x/tsx09-common.c |   35 ++---------------------------
 2 files changed, 6 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 91b0f47..9eec294 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -172,37 +172,6 @@ static struct mv643xx_eth_platform_data dns323_eth_data = {
 	.phy_addr = MV643XX_ETH_PHY_ADDR(8),
 };
 
-/* dns323_parse_hex_*() taken from tsx09-common.c; should a common copy of these
- * functions be kept somewhere?
- */
-static int __init dns323_parse_hex_nibble(char n)
-{
-	if (n >= '0' && n <= '9')
-		return n - '0';
-
-	if (n >= 'A' && n <= 'F')
-		return n - 'A' + 10;
-
-	if (n >= 'a' && n <= 'f')
-		return n - 'a' + 10;
-
-	return -1;
-}
-
-static int __init dns323_parse_hex_byte(const char *b)
-{
-	int hi;
-	int lo;
-
-	hi = dns323_parse_hex_nibble(b[0]);
-	lo = dns323_parse_hex_nibble(b[1]);
-
-	if (hi < 0 || lo < 0)
-		return -1;
-
-	return (hi << 4) | lo;
-}
-
 static int __init dns323_read_mac_addr(void)
 {
 	u_int8_t addr[6];
@@ -224,14 +193,11 @@ static int __init dns323_read_mac_addr(void)
 	}
 
 	for (i = 0; i < 6; i++)	{
-		int byte;
+		int rc;
 
-		byte = dns323_parse_hex_byte(mac_page + (i * 3));
-		if (byte < 0) {
+		rc = hex2bin(&addr[i], mac_page + (i * 3), 1);
+		if (rc < 0)
 			goto error_fail;
-		}
-
-		addr[i] = byte;
 	}
 
 	iounmap(mac_page);
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index c9abb8f..e65b528f 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -52,41 +52,13 @@ struct mv643xx_eth_platform_data qnap_tsx09_eth_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
 };
 
-static int __init qnap_tsx09_parse_hex_nibble(char n)
-{
-	if (n >= '0' && n <= '9')
-		return n - '0';
-
-	if (n >= 'A' && n <= 'F')
-		return n - 'A' + 10;
-
-	if (n >= 'a' && n <= 'f')
-		return n - 'a' + 10;
-
-	return -1;
-}
-
-static int __init qnap_tsx09_parse_hex_byte(const char *b)
-{
-	int hi;
-	int lo;
-
-	hi = qnap_tsx09_parse_hex_nibble(b[0]);
-	lo = qnap_tsx09_parse_hex_nibble(b[1]);
-
-	if (hi < 0 || lo < 0)
-		return -1;
-
-	return (hi << 4) | lo;
-}
-
 static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
 {
 	u_int8_t addr[6];
 	int i;
 
 	for (i = 0; i < 6; i++) {
-		int byte;
+		int rc;
 
 		/*
 		 * Enforce "xx:xx:xx:xx:xx:xx\n" format.
@@ -94,10 +66,9 @@ static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
 		if (addr_str[(i * 3) + 2] != ((i < 5) ? ':' : '\n'))
 			return -1;
 
-		byte = qnap_tsx09_parse_hex_byte(addr_str + (i * 3));
-		if (byte < 0)
+		rc = hex2bin(&addr[i], addr_str + (i * 3), 1);
+		if (rc < 0)
 			return -1;
-		addr[i] = byte;
 	}
 
 	printk(KERN_INFO "tsx09: found ethernet mac address ");
-- 
1.7.9
