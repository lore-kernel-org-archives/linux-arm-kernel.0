From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 18:55:53 +0100
Subject: [PATCH] clk: sunxi-ng: sun6i: Fix enable bit offset for hdmi-ddc
 module clock
In-Reply-To: <1487110855.7145.46.camel@settrans.net>
References: <20170214022332.13326-1-wens@csie.org>
 <1487110855.7145.46.camel@settrans.net>
Message-ID: <20170216175553.epqbtjdazj76tjyu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bob,

On Tue, Feb 14, 2017 at 10:20:55PM +0000, Bob Ham wrote:
> On Tue, 2017-02-14 at 10:23 +0800, Chen-Yu Tsai wrote:
> > The enable bit offset for the hdmi-ddc module clock is wrong. It is
> > pointing to the main hdmi module clock enable bit.
> > 
> > Reported-by: Bob Ham <rah@settrans.net>
> > Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> > Cc: stable at vger.kernel.org # 4.9.x-
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > 
> > Hi Bob,
> > 
> > Can you try this patch and see if it fixes your HDMI issue?
> > With the kernel running without "clk_ignore_unused" that is.
> 
> Hi Chen-Yu,
> 
> Unfortunately, that doesn't fix it; I get the same behaviour as without
> clk_ignore_unused.

can you apply that patch and give us your kernel boot logs?

Thanks!

------8<---------
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 820a939fb6bb..0a23b03ea393 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -773,7 +773,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 	if (core->enable_count)
 		goto unlock_out;

-	if (core->flags & CLK_IGNORE_UNUSED)
+	printk("Ignoring %s\n", core->name);
+
+	if (true)
 		goto unlock_out;

 	/*
-------8<-------

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/6977311a/attachment.sig>
