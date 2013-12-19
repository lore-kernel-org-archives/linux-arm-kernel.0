From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:20 +0100
Subject: [PATCH 09/38] arm: mach-imx: add missing put_device calls
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-10-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/mach-imx/devices/devices.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
index 1b4366a..0b17c89 100644
--- a/arch/arm/mach-imx/devices/devices.c
+++ b/arch/arm/mach-imx/devices/devices.c
@@ -37,11 +37,14 @@ int __init mxc_device_init(void)
 	int ret;
 
 	ret = device_register(&mxc_aips_bus);
-	if (ret < 0)
+	if (ret < 0) {
+		put_device(&mxc_aips_bus);
 		goto done;
+	}
 
 	ret = device_register(&mxc_ahb_bus);
-
+	if(ret < 0)
+		put_device(&mxc_ahb_bus);
 done:
 	return ret;
 }
-- 
1.8.3.1
