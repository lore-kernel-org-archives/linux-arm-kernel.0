From: eric.miao@linaro.org (Eric Miao)
Date: Wed, 23 Nov 2011 22:37:00 +0800
Subject: [PATCH] ASoC: skip resume of soc-audio devices without codecs
Message-ID: <1322059020-24305-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases where there is no working codec on the soc-audio devices,
and snd_soc_suspend() will skip such device when suspending. Yet its
counterpart snd_soc_resume() does not check this, causing complaints
about spinlock lockup:

[  176.726087] BUG: spinlock lockup on CPU#0, kworker/0:2/1067, d8ab82a8
[  176.732539] [<80014a14>] (unwind_backtrace+0x0/0xec) from [<805b3fc8>] (dump_stack+0x20/0x24)
[  176.741082] [<805b3fc8>] (dump_stack+0x20/0x24) from [<80322208>] (do_raw_spin_lock+0x118/0x158)
[  176.749882] [<80322208>] (do_raw_spin_lock+0x118/0x158) from [<805b7874>] (_raw_spin_lock_irqsave+0x5c/0x68)
[  176.759723] [<805b7874>] (_raw_spin_lock_irqsave+0x5c/0x68) from [<8002a020>] (__wake_up+0x2c/0x5c)
[  176.768781] [<8002a020>] (__wake_up+0x2c/0x5c) from [<804a6de8>] (soc_resume_deferred+0x3c/0x2b0)
[  176.777666] [<804a6de8>] (soc_resume_deferred+0x3c/0x2b0) from [<8004ee20>] (process_one_work+0x2e8/0x50c)
[  176.787334] [<8004ee20>] (process_one_work+0x2e8/0x50c) from [<8004fd08>] (worker_thread+0x1c8/0x2e0)
[  176.796566] [<8004fd08>] (worker_thread+0x1c8/0x2e0) from [<80053ec8>] (kthread+0xa4/0xb0)
[  176.804843] [<80053ec8>] (kthread+0xa4/0xb0) from [<8000ea70>] (kernel_thread_exit+0x0/0x8)

Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 sound/soc/soc-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5d3685..a25fa63 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -709,6 +709,12 @@ int snd_soc_resume(struct device *dev)
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	int i, ac97_control = 0;
 
+	/* If the initialization of this soc device failed, there is no codec
+	 * associated with it. Just bail out in this case.
+	 */
+	if (list_empty(&card->codec_dev_list))
+		return 0;
+
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
-- 
1.7.5.4
