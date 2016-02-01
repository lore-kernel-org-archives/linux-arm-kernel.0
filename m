From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 20:32:32 +0100
Subject: [PATCH 1/2] clk: sunxi: delay protected clocks until arch initcall
In-Reply-To: <56A91245.3090706@collabora.co.uk>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1453385439-10154-2-git-send-email-emilio.lopez@collabora.co.uk>
 <20160127153722.GC4317@lukather> <56A91245.3090706@collabora.co.uk>
Message-ID: <20160201193232.GG4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 27, 2016 at 03:53:57PM -0300, Emilio L?pez wrote:
> Hi Maxime,
> 
> El 27/01/16 a las 12:37, Maxime Ripard escribi?:
> >Hi Emilio,
> >
> >On Thu, Jan 21, 2016 at 11:10:38AM -0300, Emilio L?pez wrote:
> >>Clocks are registered early on, and unused clocks get disabled on
> >>late initcall, so we can delay protecting important clocks a bit.
> >>If we do this too early, it may happen that some clocks are orphans
> >>and therefore enabling them may not work as intended. If we do this
> >>too late, a driver may reparent some clock and cause another important
> >>clock to be disabled as a byproduct.
> >>
> >>arch_initcall should be a good spot to do this, as clock drivers using
> >>the OF mechanisms will be all registered by then, and drivers won't
> >>have started probing yet.
> >>
> >>Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
> >>---
> >>  drivers/clk/sunxi/clk-sunxi.c | 22 ++++++++++++++++++----
> >>  1 file changed, 18 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> >>index 5ba2188..285e8ee 100644
> >>--- a/drivers/clk/sunxi/clk-sunxi.c
> >>+++ b/drivers/clk/sunxi/clk-sunxi.c
> >>@@ -1153,10 +1153,12 @@ static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_mat
> >>  	}
> >>  }
> >>
> >>+/* By default, don't protect any clocks */
> >>+static const char **protected_clocks __initdata;
> >>+static int protected_clocks_nr __initdata;
> >>+
> >>  static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
> >>  {
> >>-	unsigned int i;
> >>-
> >>  	/* Register divided output clocks */
> >>  	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
> >>
> >>@@ -1169,14 +1171,26 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
> >>  	/* Register mux clocks */
> >>  	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
> >>
> >>+	/* We shall protect these clocks when everything is ready */
> >>+	protected_clocks = clocks;
> >>+	protected_clocks_nr = nclocks;
> >>+}
> >>+
> >>+static int __init sunxi_init_clock_protection(void)
> >>+{
> >>+	unsigned int i;
> >>+
> >>  	/* Protect the clocks that needs to stay on */
> >>-	for (i = 0; i < nclocks; i++) {
> >>-		struct clk *clk = clk_get(NULL, clocks[i]);
> >>+	for (i = 0; i < protected_clocks_nr; i++) {
> >>+		struct clk *clk = clk_get(NULL, protected_clocks[i]);
> >>
> >>  		if (!IS_ERR(clk))
> >>  			clk_prepare_enable(clk);
> >>  	}
> >>+
> >>+	return 0;
> >>  }
> >>+arch_initcall(sunxi_init_clock_protection);
> >
> >You also need to filter that by the machine compatible in case you're
> >running it on a !sunxi SoC.
> 
> protected_clocks_nr will be 0 on a !sunxi machine, so this is effectively a
> noop there.

Ah, yes, good point.

> >Overall, I'm a bit skeptical about the approach. It doesn't really fix
> >everything, just hides it behind a curtain, and I'm pretty sure the
> >clocks not registered by this code would still be broken (the mod0
> >clocks for example).
> 
> This is only meant to solve the problems observed when trying to grab
> critical clocks before letting all the basic/OF clock types register. The
> actual clock trees are complete once all the built-in clock compatibles are
> probed, so this just pushes the protection after that point in time. The
> plan on the long term should be to use the CCF-built-in clock protection,
> once it's finished and merged, but it's not here yet.
> 
> Regarding your example, I'm not aware of any critical mod0 clocks (not that
> it should matter, as they won't be orphans either).

My bad, the A13 mbus clock is one. The A23 is one too.

Both of these are probed through CLK_OF_DECLARE, and use directly
clk_prepare_enable on the clock given back by clk_register, which
won't work in your case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/f9b58d28/attachment.sig>
