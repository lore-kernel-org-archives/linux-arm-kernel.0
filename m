From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 Jan 2012 00:18:53 -0200
Subject: [PATCH] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <20246.30805.391940.766120@ipc1.ka-ro>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
 <20246.30805.391940.766120@ipc1.ka-ro>
Message-ID: <CAOMZO5B3qRowaQ9c_=pyykvp5x5f2nTgticV0tCcHGAYD007MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 5:44 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

> Now you are doing clk_enable()'s business in clk_set_rate().
> The same result could be achieved by calling clk_enable() prior to
> clk_set_rate(). clk_set_rate() could simply return an error code, if
> the clock is not enabled.

Ok, understood.

Your suggestion below works fine:

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5d68e41..c697b4a 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -809,6 +809,8 @@ int __init mx28_clocks_init(void)
 	clk_prepare_enable(&xbus_clk);
 	clk_prepare_enable(&emi_clk);
 	clk_prepare_enable(&uart_clk);
+	clk_prepare_enable(&saif0_clk);
+	clk_prepare_enable(&saif1_clk);

 	clk_set_parent(&lcdif_clk, &ref_pix_clk);
 	clk_set_parent(&saif0_clk, &pll0_clk);

Or also the patch below instead:

--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -814,15 +814,6 @@ int __init mx28_clocks_init(void)
        clk_set_parent(&saif0_clk, &pll0_clk);
        clk_set_parent(&saif1_clk, &pll0_clk);

-       /*
-        * Set an initial clock rate for the saif internal logic to work
-        * properly. This is important when working in EXTMASTER mode that
-        * uses the other saif's BITCLK&LRCLK but it still needs a basic
-        * clock which should be fast enough for the internal logic.
-        */
-       clk_set_rate(&saif0_clk, 24000000);
-       clk_set_rate(&saif1_clk, 24000000);
-
        clkdev_add_table(lookups, ARRAY_SIZE(lookups));
---

Shawn,

I saw your comments about the need for clk_set_rate, so it looks like
it is not safe to remove it.

Can Lothar's suggestion be accepted?

In your previous reply you seemed to prefer a solution at mxs-saif.c,
but if we need to keep the clk_set_rate for saif, then we
need the clk_prepare_enable for saif clk. I am a bit unsure of what
your proposal is.

Regards,

Fabio Estevam
