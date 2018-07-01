From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun,  1 Jul 2018 18:20:55 +0200
Subject: [PATCH 4.17 031/220] thermal: bcm2835: Stop using printk format %pCr
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
Message-ID: <20180701160909.632858221@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bd2a07f71a1e2e198f8a30cb551d9defe422d83d upstream.

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by printing the variable that already holds the clock rate.
Note that calling clk_get_rate() is safe here, as the code runs in task
context.

Link: http://lkml.kernel.org/r/1527845302-12159-3-git-send-email-geert+renesas at glider.be
To: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>
To: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc at vger.kernel.org
Cc: linux-clk at vger.kernel.org
Cc: linux-pm at vger.kernel.org
Cc: linux-serial at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: stable at vger.kernel.org # 4.12+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/broadcom/bcm2835_thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -213,8 +213,8 @@ static int bcm2835_thermal_probe(struct
 	rate = clk_get_rate(data->clk);
 	if ((rate < 1920000) || (rate > 5000000))
 		dev_warn(&pdev->dev,
-			 "Clock %pCn running at %pCr Hz is outside of the recommended range: 1.92 to 5MHz\n",
-			 data->clk, data->clk);
+			 "Clock %pCn running at %lu Hz is outside of the recommended range: 1.92 to 5MHz\n",
+			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */
 	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
