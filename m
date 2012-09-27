From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Thu, 27 Sep 2012 16:03:21 -0300
Subject: [PATCH v2 27/34] media: mx2_camera: remove cpu_is_xxx by using
 platform_device_id
In-Reply-To: <1348123547-31082-28-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <1348123547-31082-28-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120927160321.56420910@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Thu, 20 Sep 2012 14:45:40 +0800
Shawn Guo <shawn.guo@linaro.org> escreveu:

> It changes the driver to use platform_device_id rather than cpu_is_xxx
> to determine the controller type, and updates the platform code
> accordingly.
> 
> As the result, mach/hardware.h inclusion gets removed from the driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Tested-by: Javier Martin <javier.martin@vista-silicon.com>
> Cc: linux-media at vger.kernel.org
> ---
>  arch/arm/mach-imx/clk-imx25.c                   |    6 +-
>  arch/arm/mach-imx/clk-imx27.c                   |    6 +-
>  arch/arm/mach-imx/devices/devices-common.h      |    1 +
>  arch/arm/mach-imx/devices/platform-mx2-camera.c |   12 +--
>  drivers/media/video/mx2_camera.c                |   95 +++++++++++++++++------

As most of the changes are at drivers/media, and you got Arnd's ack, it makes sense
to merge it via my tree.

However, even after fixing the media patch (that got renamed on 3.6),
the patch doesn't apply:

$ quilt push
Applying patch patches/lmml_14534_v2_27_34_media_mx2_camera_remove_cpu_is_xxx_by_using_platform_device_id.patch
patching file arch/arm/mach-imx/clk-imx25.c
Hunk #1 succeeded at 232 (offset 1 line).
patching file arch/arm/mach-imx/clk-imx27.c
Hunk #1 succeeded at 223 (offset -1 lines).
Hunk #2 succeeded at 250 with fuzz 1 (offset -1 lines).
can't find file to patch at input line 82
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
|index 7f2698c..8112a1a 100644
|--- a/arch/arm/mach-imx/devices/devices-common.h
|+++ b/arch/arm/mach-imx/devices/devices-common.h
--------------------------
No file to patch.  Skipping patch.
1 out of 1 hunk ignored
can't find file to patch at input line 94
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff --git a/arch/arm/mach-imx/devices/platform-mx2-camera.c b/arch/arm/mach-imx/devices/platform-mx2-camera.c
|index 9ad5b2d..b88877d 100644
|--- a/arch/arm/mach-imx/devices/platform-mx2-camera.c
|+++ b/arch/arm/mach-imx/devices/platform-mx2-camera.c
--------------------------
No file to patch.  Skipping patch.
3 out of 3 hunks ignored
patching file drivers/media/platform/soc_camera/mx2_camera.c
Hunk #1 FAILED at 41.
Hunk #6 succeeded at 467 (offset 28 lines).
Hunk #7 succeeded at 499 (offset 28 lines).
Hunk #8 succeeded at 575 (offset 28 lines).
Hunk #9 succeeded at 584 (offset 28 lines).
Hunk #10 succeeded at 669 (offset 28 lines).
Hunk #11 succeeded at 688 (offset 28 lines).
Hunk #12 succeeded at 745 (offset 28 lines).
Hunk #13 succeeded at 868 (offset 28 lines).
Hunk #14 succeeded at 963 (offset 28 lines).
Hunk #15 succeeded at 1115 (offset 28 lines).
Hunk #16 succeeded at 1424 (offset 40 lines).
Hunk #17 succeeded at 1758 (offset 40 lines).
Hunk #18 succeeded at 1809 (offset 40 lines).
Hunk #19 succeeded at 1818 (offset 40 lines).
Hunk #20 succeeded at 1835 (offset 40 lines).
Hunk #21 succeeded at 1855 (offset 40 lines).
Hunk #22 succeeded at 1873 (offset 40 lines).
Hunk #23 succeeded at 1887 (offset 40 lines).
1 out of 23 hunks FAILED -- rejects in file drivers/media/platform/soc_camera/mx2_camera.c

It seems that it depends on some stuff that got merged via the arm tree.

Not sure what would the better way to handle that, as applying it via -arm
will likely generate conflicts when merging from both trees upstream.

If this change is not urgent, maybe it would be better to apply it after
the end of the merge window, via either one of the trees.

Arnd,

What do you think?

Regards,
Mauro
