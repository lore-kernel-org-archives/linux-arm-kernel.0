From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 14 May 2012 18:51:16 +1000
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20120514185116.fcde1a3be2fbaae3c4b5f279@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/video/omap2/displays/panel-taal.c between commit 9c3d5eb71b1f
("OMAP: DSS2: Remove suspicous and unused TAAL regulator API usage") from
the omap_dss2 tree and commit 3acc797c1db2 ("OMAPDSS: Taal: move reset
gpio handling to taal driver") from the arm-soc tree.

Just context changes. I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/video/omap2/displays/panel-taal.c
index 3053399,b2dd88b..0000000
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@@ -992,8 -1082,13 +1001,11 @@@ err_gpio
  	if (bldev != NULL)
  		backlight_device_unregister(bldev);
  err_bl:
+ 	if (gpio_is_valid(panel_data->reset_gpio))
+ 		gpio_free(panel_data->reset_gpio);
+ err_rst_gpio:
  	destroy_workqueue(td->workqueue);
  err_wq:
 -	free_regulators(panel_config->regulators, panel_config->num_regulators);
 -err_reg:
  	kfree(td);
  err:
  	return r;
@@@ -1030,6 -1125,12 +1042,9 @@@ static void __exit taal_remove(struct o
  	/* reset, to be sure that the panel is in a valid state */
  	taal_hw_reset(dssdev);
  
 -	free_regulators(td->panel_config->regulators,
 -			td->panel_config->num_regulators);
 -
+ 	if (gpio_is_valid(panel_data->reset_gpio))
+ 		gpio_free(panel_data->reset_gpio);
+ 
  	kfree(td);
  }
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120514/aba3be8b/attachment.sig>
