From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 30 Oct 2012 16:16:59 +0000
Subject: vexpress issues in next-20121029
In-Reply-To: <508EE610.9050703@wwwdotorg.org>
References: <508EE610.9050703@wwwdotorg.org>
Message-ID: <1351613819.6199.14.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, 2012-10-29 at 20:24 +0000, Stephen Warren wrote:
> 1) At compile-time: v2m_timer_init() and v2m_dt_timer_init() reference
> functions vexpress_clk_init() and vexpress_clk_of_init() respectively,
> which don't appear anywhere in the source tree.

There was a glitch between clk-next and arm-soc - it should be fine
starting with next-20121030.

> 2) With those calls commented out, I find that
> vexpress_sysreg_init_leds() is device_initcall, and so executes even
> when not running on vexpress HW. This crashes on Tegra (which I have
> converted to single-zImage locally).

Uh, how stupid of me! I have to finally get used to the new
multi-platform-kernel reality... Sorry about it - a quick workaround
would be:

8<----------------------------
diff --git a/drivers/mfd/vexpress-sysreg.c
b/drivers/mfd/vexpress-sysreg.c
index 059d6b1..99e89a8 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -474,7 +474,6 @@ static int __init vexpress_sysreg_init(void)
 }
 core_initcall(vexpress_sysreg_init);
 
-
 #if defined(CONFIG_LEDS_CLASS)
 
 struct vexpress_sysreg_led {
@@ -526,6 +525,9 @@ static int __init vexpress_sysreg_init_leds(void)
 	struct vexpress_sysreg_led *led;
 	int i;
 
+	if (!vexpress_sysreg_base)
+		return 0;
+
 	/* Clear all user LEDs */
 	writel(0, vexpress_sysreg_base + SYS_LED);
 
8<----------------------------

while I'm improving the situation by better means.

Sorry about this and thanks for letting me know!

Pawe?
