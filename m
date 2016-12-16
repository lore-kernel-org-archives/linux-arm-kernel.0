From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 16 Dec 2016 16:18:53 -0300
Subject: [PATCH v2] ARM: dts: Add missing CPU frequencies for
 Exynos5422/5800
In-Reply-To: <10512254.nyUcL0zgTP@amdc3058>
References: <10512254.nyUcL0zgTP@amdc3058>
Message-ID: <65cc16b3-4252-6933-96c8-621e3b694707@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bartlomiej,

On 12/15/2016 08:55 AM, Bartlomiej Zolnierkiewicz wrote:
> Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
> (for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
> cooling maps to account for new OPPs.
> 
> Since new OPPs are not available on all Exynos5422/5800 boards modify
> dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
> Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.
> 
> Tested on Odroid-XU3 and XU3 Lite.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Ben Gamari <ben@smart-cactus.org>
> Cc: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - added comments about limitations of SoC revisions used by Odroid-XU3 Lite and
>   Peach Pi boards (suggested by Javier)
> - removed redundant opp_a7_14 label
> - added Arjun to Cc:
> 
> Javier, could you test it on Peach Pi board?
> 

I've tested this patch on my Peach Pi by setting the CPUFreq governor to
performance and checking that the current scaling frequency was 2.0 GHz:

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq 
2000000
2000000
2000000
2000000
1400000
1400000
1400000
1400000

I ran the machine for hours and it didn't became unstable. Also installed
the stress [0] tool and setting the governor to ondemand, I executed:

$ stress --cpu 8

For about 30 minutes, the current frequencies were again the maximum and
had no issues.

Finally, I tested some devices that are under the INT rail (MFC and GSC)
by using the following GStreamer pipeline:

$ gst-launch-1.0 filesrc location=test-1080p.mp4 ! qtdemux ! h264parse ! \
  v4l2video5dec ! v4l2video7convert capture-io-mode=dmabuf ! kmssink

Again, the system keeps working correctly. So I think it's safe to say:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

I can't provide a Reviewed-by since is still not clear to me if these OPP
values are correct or not due the ChromiumOS tree using higher voltages.

FWIW, the chip ID block information on my Exynos5800 Peach Pi is:

Exynos: CPU[EXYNOS5800] CPU_REV[0x1] PKG_ID[0x350c82f8] AUX_INFO[0x4d]

[0]: http://people.seas.harvard.edu/~apw/stress/

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
