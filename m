From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Sep 2013 10:13:56 +0200
Subject: [PATCH v2] [media] marvell-ccic: simplify and fix clk handling
 (a bit)
In-Reply-To: <A63A0DC671D719488CD1A6CD8BDC16CF4AB6BB9AAD@SC-VEXCH4.marvell.com>
References: <1380048167-13729-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380049187-16036-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130925011520.1fa24013@lwn.net>
 <A63A0DC671D719488CD1A6CD8BDC16CF4AB6BB9AAD@SC-VEXCH4.marvell.com>
Message-ID: <20130926081356.GA6314@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Libin,

On Wed, Sep 25, 2013 at 07:47:19PM -0700, Libin Yang wrote:
> In the clk enable and prepare function, we will check the NULL
> pointer. So it should be no problem.
I'm not sure what you mean here and unfortunately your quoting style
makes your statement appear without context.

	if (... && !IS_ERR(cam->mipi_clk)) {
		if (cam->mipi_clk)
			devm_clk_put(mcam->dev, cam->mipi_clk);
		cam->mipi_clk = NULL;
	}

might work in your setup, but it's wrong usage of the clk API. There is
no reason NULL couldn't be a valid clk pointer. Moreover I cannot find a
place in that driver that calls prepare and/or enable for the mipi_clk.
(BTW, calling clk_get_rate on a disabled clk is another thing you
shouldn't do.)

> For the mipi_clk, it is shared between other components, so we put the clk it we don't use it.
There should be no problem if >1 driver holds a reference to the
clock. It's clk_disable (+ maybe clk_unprepare) you should call when you
don't need it any more. (But even having >1 driver enabling a clk isn't
a problem ...)

> >> This patch fixes all but the last issue in this list. This patch
> >> doesn't introduce new reasons for not building, but there are already
> >> several bulid problems.
> >
> >Care to report those?
Sure:

	  CC      drivers/media/platform/marvell-ccic/mmp-driver.o
	drivers/media/platform/marvell-ccic/mmp-driver.c: In function 'mmpcam_calc_dphy':
	drivers/media/platform/marvell-ccic/mmp-driver.c:264:15: error: 'struct mmp_camera_platform_data' has no member named 'dphy3_algo'
	drivers/media/platform/marvell-ccic/mmp-driver.c:265:7: error: 'DPHY3_ALGO_PXA910' undeclared (first use in this function)
	drivers/media/platform/marvell-ccic/mmp-driver.c:265:7: note: each undeclared identifier is reported only once for each function it appears in
	drivers/media/platform/marvell-ccic/mmp-driver.c:269:8: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c:270:17: error: 'struct mmp_camera_platform_data' has no member named 'lane_clk'
	drivers/media/platform/marvell-ccic/mmp-driver.c:271:16: error: 'struct mmp_camera_platform_data' has no member named 'lane_clk'
	drivers/media/platform/marvell-ccic/mmp-driver.c:273:7: error: 'DPHY3_ALGO_PXA2128' undeclared (first use in this function)
	drivers/media/platform/marvell-ccic/mmp-driver.c:277:8: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c:278:17: error: 'struct mmp_camera_platform_data' has no member named 'lane_clk'
	drivers/media/platform/marvell-ccic/mmp-driver.c:279:16: error: 'struct mmp_camera_platform_data' has no member named 'lane_clk'
	drivers/media/platform/marvell-ccic/mmp-driver.c:308:7: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c:312:104: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c:312:120: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c:312:136: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c: In function 'mmpcam_probe':
	drivers/media/platform/marvell-ccic/mmp-driver.c:385:24: error: 'struct mmp_camera_platform_data' has no member named 'mclk_min'
	drivers/media/platform/marvell-ccic/mmp-driver.c:386:24: error: 'struct mmp_camera_platform_data' has no member named 'mclk_src'
	drivers/media/platform/marvell-ccic/mmp-driver.c:387:24: error: 'struct mmp_camera_platform_data' has no member named 'mclk_div'
	drivers/media/platform/marvell-ccic/mmp-driver.c:388:24: error: 'struct mmp_camera_platform_data' has no member named 'bus_type'
	drivers/media/platform/marvell-ccic/mmp-driver.c:389:20: error: 'struct mmp_camera_platform_data' has no member named 'dphy'
	drivers/media/platform/marvell-ccic/mmp-driver.c:391:20: error: 'struct mmp_camera_platform_data' has no member named 'lane'

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
