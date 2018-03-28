From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2018 15:44:44 +0200
Subject: [PATCH] thermal: exynos_tmu: avoid uninitialized variables
Message-ID: <20180328134520.1970967-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the initialization in the error case introduced
a compile-time warning:

drivers/thermal/samsung/exynos_tmu.c: In function 'temp_to_code':
drivers/thermal/samsung/exynos_tmu.c:304:9: error: 'temp_code' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  return temp_code;
         ^~~~~~~~~
drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_get_temp':
drivers/thermal/samsung/exynos_tmu.c:931:37: error: 'temp' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   *temp = code_to_temp(data, value) * MCELSIUS;

Let's assume the runtime warning is sufficient, and make it
return a well-defined number instead of unintialized data.

Fixes: 480b5bfc16e1 ("thermal: exynos: remove parsing of samsung, tmu_default_temp_offset property")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 2ec854851da1..7e351fffdaee 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -298,6 +298,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 		break;
 	default:
 		WARN_ON(1);
+		temp_code = 0;
 		break;
 	}
 
@@ -324,6 +325,7 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 		break;
 	default:
 		WARN_ON(1);
+		temp = 0;
 		break;
 	}
 
-- 
2.9.0
