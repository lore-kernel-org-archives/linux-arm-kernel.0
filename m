From: matt@0xlab.org (Matt Hsu)
Date: Mon, 18 Apr 2011 13:48:34 +0800
Subject: [TuxOnIce-devel] [RFC PATCH] Current status, suspend-to-disk
	support on ARM
In-Reply-To: <alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
	<alpine.DEB.2.00.1104131020080.29883@localhost6.localdomain6>
	<201104132338.03003.rjw@sisk.pl>
	<alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
Message-ID: <BANLkTinroLCypX-iG0xGpnyxBk=P5TVtJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
>
> The last thing here in my setup that's obviously not correctly suspending /
> resuming is the OMAP display driver; I'm not the only one with that problem,
> Matt's previous report:
>
> http://blog.gmane.org/gmane.linux.swsusp.devel/month=20101201
>
> has the same thing, "omapdss DISPC error: SYNC_LOST, disabling LCD".
>
>
>     Hi FrankH,

    Above issue could be resolved by:

   - CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE=y
   - the following patch

diff --git a/drivers/video/omap2/dss/dispc.c
b/drivers/video/omap2/dss/dispc.c
index 8b3ac80..a188732 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2784,7 +2784,6 @@ static void dispc_error_worker(struct work_struct
*work)
                bool enable = false;

                DSSERR("SYNC_LOST, disabling LCD\n");

                for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
                        struct omap_overlay_manager *mgr;
                        mgr = omap_dss_get_overlay_manager(i);
@@ -2815,6 +2814,9 @@ static void dispc_error_worker(struct work_struct
*work)
                        if (enable)
                                manager->device->enable(manager->device);
                }
+
+               dispc_enable_lcd_out(false);
+               dispc_enable_lcd_out(true);

     Although this patch is somehow nasty, but it work anyway.

- Matt
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110418/b205e44d/attachment.html>
