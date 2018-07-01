From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Sun, 01 Jul 2018 11:01:21 +0200
Subject: Patch "clk: renesas: cpg-mssr: Stop using printk format %pCr" has
 been added to the 4.17-stable tree
Message-ID: <1530435681633@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    clk: renesas: cpg-mssr: Stop using printk format %pCr

to the 4.17-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     clk-renesas-cpg-mssr-stop-using-printk-format-pcr.patch
and it can be found in the queue-4.17 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From ef4b0be62641d296cf4c0ad8f75ab83ab066ed51 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 1 Jun 2018 11:28:19 +0200
Subject: clk: renesas: cpg-mssr: Stop using printk format %pCr

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ef4b0be62641d296cf4c0ad8f75ab83ab066ed51 upstream.

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Link: http://lkml.kernel.org/r/1527845302-12159-2-git-send-email-geert+renesas at glider.be
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
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable at vger.kernel.org # 4.5+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/renesas/renesas-cpg-mssr.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -258,8 +258,9 @@ struct clk *cpg_mssr_clk_src_twocell_get
 		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
 		       PTR_ERR(clk));
 	else
-		dev_dbg(dev, "clock (%u, %u) is %pC at %pCr Hz\n",
-			clkspec->args[0], clkspec->args[1], clk, clk);
+		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
+			clkspec->args[0], clkspec->args[1], clk,
+			clk_get_rate(clk));
 	return clk;
 }
 
@@ -326,7 +327,7 @@ static void __init cpg_mssr_register_cor
 	if (IS_ERR_OR_NULL(clk))
 		goto fail;
 
-	dev_dbg(dev, "Core clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	return;
 
@@ -392,7 +393,7 @@ static void __init cpg_mssr_register_mod
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	priv->smstpcr_saved[clock->index / 32].mask |= BIT(clock->index % 32);
 	return;


Patches currently in stable-queue which might be from geert+renesas at glider.be are

queue-4.17/lib-vsprintf-remove-atomic-unsafe-support-for-pcr.patch
queue-4.17/thermal-bcm2835-stop-using-printk-format-pcr.patch
queue-4.17/serial-sh-sci-use-spin_-try-lock_irqsave-instead-of-open-coding-version.patch
queue-4.17/clk-renesas-cpg-mssr-stop-using-printk-format-pcr.patch
