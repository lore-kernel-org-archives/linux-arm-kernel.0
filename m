From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Jul 2013 14:29:14 +0800
Subject: ASoC: wm8962: NULL pdata pointer
Message-ID: <20130704062913.GC14617@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

I'm running next-20130703 and seeing the following NULL pointer bug.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80004000
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0-next-20130703 #6
task: bf870000 ti: bf874000 task.ti: bf874000
PC is at wm8962_probe+0x140/0x6b4
...

It seems to me that it's caused by a merge error in 384b834.  And the
change below can remove the problem.

Shawn

---8<----

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b1dc7d4..e2de9ec 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3377,7 +3377,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 {
        int ret;
        struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-       struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+       struct wm8962_pdata *pdata = &wm8962->pdata;
        int i, trigger, irq_pol;
        bool dmicclk, dmicdat;
