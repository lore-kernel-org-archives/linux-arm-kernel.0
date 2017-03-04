From: linux@roeck-us.net (Guenter Roeck)
Date: Sat,  4 Mar 2017 07:02:11 -0800
Subject: [PATCH v3 2/2] ARM: OMAP2+: Release device node after it is no longer
 needed.
In-Reply-To: <1488639731-8047-1-git-send-email-linux@roeck-us.net>
References: <1488639731-8047-1-git-send-email-linux@roeck-us.net>
Message-ID: <1488639731-8047-2-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device node returned by of_find_node_by_name() needs to be released
after it is no longer needed to avoid a device node leak.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Split patch into two parts

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 44b5f9bbdde6..042e460f4aa4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3193,15 +3193,20 @@ int __init omap3xxx_hwmod_init(void)
 
 	if (h_sham && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "sham")) {
 		r = omap_hwmod_register_links(h_sham);
-		if (r < 0)
+		if (r < 0) {
+			of_node_put(bus);
 			return r;
+		}
 	}
 
 	if (h_aes && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "aes")) {
 		r = omap_hwmod_register_links(h_aes);
-		if (r < 0)
+		if (r < 0) {
+			of_node_put(bus);
 			return r;
+		}
 	}
+	of_node_put(bus);
 
 	/*
 	 * Register hwmod links specific to certain ES levels of a
-- 
2.7.4
