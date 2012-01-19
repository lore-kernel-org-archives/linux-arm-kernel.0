From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2012 02:44:46 -0200
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <20120119042047.GB2247@S2101-09.ap.freescale.net>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <20246.30805.391940.766120@ipc1.ka-ro>
 <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
 <20120119031726.GA2247@S2101-09.ap.freescale.net>
 <CAOMZO5CeW08kb4q3UVbpQ1tfJPotoVWV9dD7ycokpEbp2a9mow@mail.gmail.com>
 <20120119042047.GB2247@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5CtgriCCCoZ+7nr9ddSfbdwsUMqEZCbsXJS2yuPqhdEfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/19 Shawn Guo <shawn.guo@linaro.org>:

> As far as I know, mxs-saif driver also has one clk_set_rate() being
> called with the clock gated.

Yes, correct. Is this a good fix?

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index dccfb37..c5a29a8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -124,6 +124,8 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
         *
         * If MCLK is not used, we just set saif clk to 512*fs.
         */
+       clk_prepare_enable(master_saif->clk);
+
        if (master_saif->mclk_in_use) {
                if (mclk % 32 == 0) {
                        scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
@@ -133,6 +135,7 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
                        ret = clk_set_rate(master_saif->clk, 384 * rate);
                } else {
                        /* SAIF MCLK should be either 32x or 48x */
+                       clk_disable_unprepare(master_saif->clk);
                        return -EINVAL;
                }
        } else {
@@ -140,6 +143,8 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
                scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
        }

+       clk_disable_unprepare(master_saif->clk);
+
        if (ret)
                return ret;


Regards,

Fabio Estevam
