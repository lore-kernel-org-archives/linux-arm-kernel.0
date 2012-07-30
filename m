From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 30 Jul 2012 12:53:14 +1000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20120730125314.8bad3b71a8e727b892a47590@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/watchdog/orion_wdt.c between commit 0dd6e4847ed8 ("watchdog:
orion_wdt: Convert driver to watchdog core") from Linus' tree and commit
1e7bad0f5b91 ("ARM: Orion: DTify the watchdog timer") from the arm-soc
tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/watchdog/orion_wdt.c
index a73bea4,1531e02..0000000
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@@ -23,7 -24,8 +23,8 @@@
  #include <linux/io.h>
  #include <linux/spinlock.h>
  #include <linux/clk.h>
 +#include <linux/err.h>
+ #include <linux/of.h>
  #include <mach/bridge-regs.h>
  
  /*
@@@ -189,9 -292,16 +190,15 @@@ static int __devexit orion_wdt_remove(s
  
  static void orion_wdt_shutdown(struct platform_device *pdev)
  {
 -	if (test_bit(WDT_IN_USE, &wdt_status))
 -		orion_wdt_disable();
 +	orion_wdt_stop(&orion_wdt);
  }
  
+ static const struct of_device_id orion_wdt_of_match_table[] __devinitdata = {
+ 	{ .compatible = "marvell,orion-wdt", },
+ 	{},
+ };
+ MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
+ 
  static struct platform_driver orion_wdt_driver = {
  	.probe		= orion_wdt_probe,
  	.remove		= __devexit_p(orion_wdt_remove),
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120730/af0badb4/attachment.sig>
