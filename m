From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 4 Jul 2013 23:14:00 +0800
Subject: [PATCH] ASoC: wm8962: fix NULL pdata pointer
Message-ID: <1372950840-13393-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an error in merge commit 384b834 on conflict resolution which
causes the following NULL pdata pointer bug.

wm8962 0-001a: customer id 0 revision D
Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd = 80004000
[00000004] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0+ #1
task: bf870000 ti: bf874000 task.ti: bf874000
PC is at wm8962_probe+0x134/0x6c8
LR is at regmap_unlock_mutex+0x10/0x14
pc : [<80452100>]    lr : [<80304cf4>]    psr: a0000113
sp : bf875c98  ip : 00000000  fp : bf875cd4
r10: 00000000  r9 : bfb1830c  r8 : 80779bc4
r7 : 00000000  r6 : 00000001  r5 : bfbac010  r4 : bfb33e00
r3 : 80304ce4  r2 : 00000000  r1 : 00000001  r0 : fffffffb
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 1000404a  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0xbf874238)
Stack: (0xbf875c98 to 0xbf876000)
...

Fix the error by assigning pdata a correct pointer.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/wm8962.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b1dc7d4..e2de9ec 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3377,7 +3377,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct wm8962_pdata *pdata = dev_get_platdata(codec->dev);
+	struct wm8962_pdata *pdata = &wm8962->pdata;
 	int i, trigger, irq_pol;
 	bool dmicclk, dmicdat;
 
-- 
1.7.9.5
