From: repk@triplefau.lt (Remi Pommarel)
Date: Sun, 10 Jan 2016 13:30:14 +0100
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
 <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
Message-ID: <20160110123014.GA1764@cruxbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 01:17:17PM +0100, Martin Sperl wrote:
> > 
> > Presumably just making the code not rely on having a define for the
> > number of clocks would deal with the problem (eg, using ARRAY_SIZE
> > internally).
> ARRAY_SIZE would work fine, but the code is: 
> 
> #include <dt-bindings/clock/bcm2835.h>
> ...
> struct bcm2835_cprman {
> 	struct device *dev;
> 	void __iomem *regs;
> 	spinlock_t regs_lock;
> 	const char *osc_name;
> 
> 	struct clk_onecell_data onecell;
> 	struct clk *clks[BCM2835_CLOCK_COUNT];
> };
> ...
> static int bcm2835_clk_probe(struct platform_device *pdev)
> {
> ...
> 	clks[BCM2835_PLLA_CORE] =
> 		bcm2835_register_pll_divider(cprman, &bcm2835_plla_core_data);
> ...
>         clks[BCM2835_CLOCK_PCM] =
>                 bcm2835_register_clock(cprman, &bcm2835_clock_pcm_data);
> ...
> }
> 
> So the Array size is defined by the dt-bindings.
> 
> What you propose is a major change to the clock framework, so I would
> hope that Eric (the original author of this clock-driver) would address
> it.
> 
> Maybe someone has a better idea for a pattern to use to achieve 
> the required while maintaining ?synchronization? between defines
> inside the dt-binding and the driver.
> 

Why not just get rid of BCM2835_CLOCK_COUNT and use an internal clock
count ? Something like the patch attached at the end of the mail. This
has the downside to be more careful when adding a new clock.

If it is not ok, I could try to modify the clk driver to use Mark's
solution if you want.

Regards,

-- 
Remi

--------------------------------->8---------------------------------------
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 015e687..f558c5b 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -281,6 +281,8 @@
 #define LOCK_TIMEOUT_NS                100000000
 #define BCM2835_MAX_FB_RATE    1750000000u
 
+#define BCM2835_CLOCK_MAX BCM2835_CLOCK_PCM
+
 struct bcm2835_cprman {
        struct device *dev;
        void __iomem *regs;
@@ -288,7 +290,7 @@ struct bcm2835_cprman {
        const char *osc_name;
 
        struct clk_onecell_data onecell;
-       struct clk *clks[BCM2835_CLOCK_COUNT];
+       struct clk *clks[BCM2835_CLOCK_MAX + 1];
 };
 
 static inline void cprman_write(struct bcm2835_cprman *cprman, u32 reg, u32 val)
