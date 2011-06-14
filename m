From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 14 Jun 2011 15:32:41 -0500
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <201106141610.42700.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
	<201106030956.43174.heiko@sntech.de>
	<BANLkTi=YvSL_yzku6v3tsJaaLTL=fBXShg@mail.gmail.com>
	<201106141610.42700.heiko@sntech.de>
Message-ID: <BANLkTimzxUQnVn5VC8EOaJeHq=wifUhZ4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tue, Jun 14, 2011 at 9:10 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Andrei,
>
> Am Dienstag 14 Juni 2011 schrieb Andrei Warkentin:
>> I recently came back from vacation (which is why I didn't pitch in
>> before). Has there been any further update on this? I want to exclude
>> my EMMC partitioning changes as the possible culprit here.
>
> nope, no updates yet. The flood also only starts when udev wants to
> create its device nodes, meaning the initial detection seems not to
> produce this problem
>
> But when I disable the whole boot partition stuff, it works as before
> without irq storms.
>
> As there don't seem to exist reports from other emmc users about this
> I guess the problem lays somewhere between the boot-partitions-patch
> and the sdhci-s3c driver (for s3c2416 at least).
>
> As my knowledge about the whole mmc-subsystem is quite spare I also
> don't really know where to start looking for the culprit yet.

Alright. Curious. Can you let me know what eMMC device you are
connecting to the controller? What is the eMMC revision?

Can you also apply the following and let me know the results? This
adds an error message if the partition switch fails, and forces the
device to ALWAYS switch back to main user area after every completed
RQ.

>>>>>>>>>>>> start
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 71da564..74e1029 100755
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -450,9 +450,12 @@ static inline int mmc_blk_part_switch(struct
mmc_card *card,
                ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
                                 EXT_CSD_PART_CONFIG, card->ext_csd.part_config,
                                 card->ext_csd.part_time);
-               if (ret)
+               if (ret) {
+                       printk(KERN_ERR ">>> error switching to part_type %d\n",
+                              md->part_type);
                        return ret;
-}
+               }
+       }

        main_md->part_curr = md->part_type;
        return 0;
@@ -964,6 +967,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
struct request *req)
        }

 out:
+
+       /* Switch to main_md (type = 0) */
+       ret = mmc_blk_part_switch(card, (struct mmc_blk_data *)
mmc_get_drvdata(card));
+       if (ret) {
+               ret = 0;
+       }
+
        mmc_release_host(card->host);
        return ret;
 }
>>>>>>>>>>>>>>>> end

I am curious about the results. Here is another thing to try out. This
forces a switch to user area (main partition) every time blk resume is
invoked -

>>>>>>>>>>>>>>>>>>> start
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 71da564..f7be8f7 100755
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1318,6 +1318,7 @@ static int mmc_blk_suspend(struct mmc_card
*card, pm_message_t state)

 static int mmc_blk_resume(struct mmc_card *card)
 {
+       int ret;
        struct mmc_blk_data *part_md;
        struct mmc_blk_data *md = mmc_get_drvdata(card);

@@ -1325,10 +1326,13 @@ static int mmc_blk_resume(struct mmc_card *card)
                mmc_blk_set_blksize(md, card);

                /*
-                * Resume involves the card going into idle state,
-                * so current partition is always the main one.
+                * Force main user area on resume. Technically
+                * card should have switched itself during reset.
                 */
-               md->part_curr = md->part_type;
+               ret = mmc_blk_part_switch(card, md);
+               if (ret)
+                       return ret;
+
                mmc_queue_resume(&md->queue);
                list_for_each_entry(part_md, &md->part, part) {
                        mmc_queue_resume(&part_md->queue);
>>>>>>>>>>>>>>>>>>> end

Thanks for helping tracking this down,
A
