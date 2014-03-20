From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 08:56:55 +0100
Subject: please revert: regulator: dbx500: use seq_puts() instead of
 seq_printf()
Message-ID: <6651295.YIkvtDO9zo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch has shown up in linux-next yesterday, breaking a randconfig
build:

commit d5d2ced88dc2690cf28fd531c83a53f0ba132f27
Author: Jingoo Han <jg1.han@samsung.com>
Date:   Wed Feb 26 10:21:01 2014 +0900

    regulator: dbx500: use seq_puts() instead of seq_printf()
    
    For a constant format without additional arguments, use seq_puts()
    instead of seq_printf(). Also, it fixes the following checkpatch
    warning.
    
      WARNING: Prefer seq_puts to seq_printf
    
    Signed-off-by: Jingoo Han <jg1.han@samsung.com>
    Signed-off-by: Mark Brown <broonie@linaro.org>

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index f111dfb..3dd1096 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -97,10 +97,10 @@ static int ux500_regulator_power_state_cnt_print(struct seq_file *s, void *p)
        int err;
 
        /* print power state count */
-       err = seq_printf(s, "ux500-regulator power state count: %i\n",
-               power_state_active_get());
+       err = seq_puts(s, "ux500-regulator power state count: %i\n",
+                       power_state_active_get());
        if (err < 0)
-               dev_err(dev, "seq_printf overflow\n");
+               dev_err(dev, "seq_puts overflow\n");
 
        return 0;
 }

drivers/regulator/dbx500-prcmu.c:103:4: error: too many arguments to function 'seq_puts'

The other half of the patch is ok though.

	Arnd
