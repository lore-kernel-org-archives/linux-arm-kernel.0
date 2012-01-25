From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:27 +0100
Subject: [PATCH 6/6] ARM: SAMSUNG: Fix platform data setup for I2C adapter 0
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1327501407-1927-7-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common static default_i2c_data structure gets bus_num set by each
s3c_i2c?_set_platdata() call, except for s3c_i2c0_set_platdata(). Thus
if for instance s3c_i2c1_set_platdata() is called prior to
s3c_i2c0_set_platdata() the I2C0 controller has bus_num set to wrong value
of 1, i.e. the one from previous set_platdata call. Fix this by also setting
bus_num for I2C0.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/devs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 145580a..eed8de3 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -496,8 +496,10 @@ void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
 {
 	struct s3c2410_platform_i2c *npd;
 
-	if (!pd)
+	if (!pd) {
 		pd = &default_i2c_data;
+		pd->bus_num = 0;
+	}
 
 	npd = s3c_set_platdata(pd, sizeof(struct s3c2410_platform_i2c),
 			       &s3c_device_i2c0);
-- 
1.7.8.3
