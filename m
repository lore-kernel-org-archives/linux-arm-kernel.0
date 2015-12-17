From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Dec 2015 22:00:45 +0000
Subject: BUG: SDHCI fails to DMA-unmap, and other warnings
In-Reply-To: <20151217215140.GK8644@n2100.arm.linux.org.uk>
References: <20151217215140.GK8644@n2100.arm.linux.org.uk>
Message-ID: <20151217220045.GA27072@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And another one:

"mmcblk0: retrying because a re-tune was needed"

static int mmc_blk_err_check(struct mmc_card *card,
                             struct mmc_async_req *areq)
{
...
        if (brq->data.error) {
                if (need_retune && !brq->retune_retry_done) {
                        pr_info("%s: retrying because a re-tune was needed\n",
                                req->rq_disk->disk_name);
                        brq->retune_retry_done = 1;
                        return MMC_BLK_RETRY;

This looks like it'll spam the kernel log regularly if MMC/SD is used
heavily with a UHS card, which (iirc) requires regular retunes.  Why is
this message at info level, and not debug level?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
