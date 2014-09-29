From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Sep 2014 16:28:55 +0200
Subject: [PATCH] [media] pt3: remove bogus module_is_live() check
Message-ID: <6460819.BmnhuA22YH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new pt3 driver checks the module reference for presence
before dropping it, which fails to compile when modules
are disabled:

media/pci/pt3/pt3.c: In function 'pt3_attach_fe':
media/pci/pt3/pt3.c:433:6: error: implicit declaration of function 'module_is_live' [-Werror=implicit-function-declaration]
      module_is_live(pt3->adaps[i]->i2c_tuner->dev.driver->owner))

As far as I can tell however, this check is not needed at all, because
the module will not go away as long as pt3 is holding a reference on
it. Also the previous check for NULL pointer is not needed at all,
because module_put has the same check.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/media/pci/pt3/pt3.c b/drivers/media/pci/pt3/pt3.c
index 90f86ce7a001..39305f07dc2e 100644
--- a/drivers/media/pci/pt3/pt3.c
+++ b/drivers/media/pci/pt3/pt3.c
@@ -429,14 +429,10 @@ static int pt3_attach_fe(struct pt3_board *pt3, int i)
 
 err_tuner:
 	i2c_unregister_device(pt3->adaps[i]->i2c_tuner);
-	if (pt3->adaps[i]->i2c_tuner->dev.driver->owner &&
-	    module_is_live(pt3->adaps[i]->i2c_tuner->dev.driver->owner))
-		module_put(pt3->adaps[i]->i2c_tuner->dev.driver->owner);
+	module_put(pt3->adaps[i]->i2c_tuner->dev.driver->owner);
 err_demod:
 	i2c_unregister_device(pt3->adaps[i]->i2c_demod);
-	if (pt3->adaps[i]->i2c_demod->dev.driver->owner &&
-	    module_is_live(pt3->adaps[i]->i2c_demod->dev.driver->owner))
-		module_put(pt3->adaps[i]->i2c_demod->dev.driver->owner);
+	module_put(pt3->adaps[i]->i2c_demod->dev.driver->owner);
 	return ret;
 }
 
