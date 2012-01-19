From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2012 01:57:45 -0200
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <20120119031726.GA2247@S2101-09.ap.freescale.net>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <20246.30805.391940.766120@ipc1.ka-ro>
 <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
 <20120119031726.GA2247@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5CeW08kb4q3UVbpQ1tfJPotoVWV9dD7ycokpEbp2a9mow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/1/19 Shawn Guo <shawn.guo@linaro.org>:

> My proposal is we need to clk_prepare_enable before clk_set_rate a clock
> if the clock is gated, and then clk_disable_unprepare the clock after
> clk_set_rate is done. ?This applies whatever codes that want to
> clk_set_rate a mxs clock.

So something like:

--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -809,6 +809,8 @@ int __init mx28_clocks_init(void)
        clk_prepare_enable(&xbus_clk);
        clk_prepare_enable(&emi_clk);
        clk_prepare_enable(&uart_clk);
+       clk_prepare_enable(&saif0_clk);
+       clk_prepare_enable(&saif1_clk);

        clk_set_parent(&lcdif_clk, &ref_pix_clk);
        clk_set_parent(&saif0_clk, &pll0_clk);
@@ -822,6 +824,8 @@ int __init mx28_clocks_init(void)
         */
        clk_set_rate(&saif0_clk, 24000000);
        clk_set_rate(&saif1_clk, 24000000);
+       clk_disable_unprepare(&saif0_clk);
+       clk_disable_unprepare(&saif1_clk);

        clkdev_add_table(lookups, ARRAY_SIZE(lookups));
---

didn't work on my tests (probe of mxs-saif fails with the same timeout message).

However if I use the clk_disable versions:

+       clk_disable(&saif0_clk);
+       clk_disable(&saif1_clk);

Then it works fine.

Regards,

Fabio Estevam
