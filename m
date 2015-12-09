From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 17:33:45 +0100
Subject: [PATCH] nwflash: use no_seek_end_llseek_size
Message-ID: <4235779.ynpqSv1Kc4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently introduced no_seek_end_llseek was wrong, it should
be no_seek_end_llseek_size:

drivers/char/nwflash.c: In function 'flash_llseek':
drivers/char/nwflash.c:280:8: error: too many arguments to function 'no_seek_end_llseek'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 00c1b53c0e61 ("new helpers: no_seek_end_llseek{,_size}()")

diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
index 362fb1e230e3..dbe598de9b74 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -277,7 +277,7 @@ static loff_t flash_llseek(struct file *file, loff_t offset, int orig)
 		printk(KERN_DEBUG "flash_llseek: offset=0x%X, orig=0x%X.\n",
 		       (unsigned int) offset, orig);
 
-	ret = no_seek_end_llseek(file, offset, orig, gbFlashSize);
+	ret = no_seek_end_llseek_size(file, offset, orig, gbFlashSize);
 	mutex_unlock(&flash_mutex);
 	return ret;
 }
