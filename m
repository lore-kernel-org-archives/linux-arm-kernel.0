From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Mon, 11 Apr 2016 11:38:38 +0300
Subject: [PATCH v3 1/6] dmaengine: qcom: bam_dma: fix dma free memory on remove
In-Reply-To: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1460363923-16296-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1460363923-16296-2-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building the driver as a module and when removing the already
inserted module gives below:

[ 1389.392788] Unable to handle kernel paging request at virtual address ffffffbdc000001c
[ 1389.421321] pgd = ffffffc02fa87000
[ 1389.447899] [ffffffbdc000001c] *pgd=0000000000000000, *pud=0000000000000000
[ 1389.460142] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[ 1389.466963] Modules linked in: qcom_bam_dma(-)
[ 1389.486608] CPU: 2 PID: 2442 Comm: rmmod Not tainted 4.2.0+ #407
[ 1389.493885] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[ 1389.501196] task: ffffffc035bae2c0 ti: ffffffc0368a8000 task.ti: ffffffc0368a8000
[ 1389.508566] PC is at __free_pages+0xc/0x40
[ 1389.515893] LR is at free_pages.part.93+0x30/0x38
[ 1389.523141] pc : [<ffffffc00016180c>] lr : [<ffffffc00016197c>] pstate: 80000145
[ 1389.530602] sp : ffffffc0368abc20
[ 1389.537931] x29: ffffffc0368abc20 x28: ffffffc0368a8000
[ 1389.549153] x27: 0000000000000000 x26: 0000000000000000
[ 1389.560412] x25: ffffffc000cb2000 x24: 0000000000000170
[ 1389.571530] x23: 0000000000000004 x22: ffffffc036bc5010
[ 1389.582721] x21: ffffffc036bc5010 x20: 0000000000000000
[ 1389.593981] x19: 0000000000000002 x18: 0000007fcbc8e8b0
[ 1389.605301] x17: 0000007f9b8226ec x16: ffffffc0002089e8
[ 1389.616647] x15: 0000007f9b8a0588 x14: 0ffffffffffffffc
[ 1389.628039] x13: 0000000000000030 x12: 0000000000000000
[ 1389.639436] x11: 0000000000000008 x10: ffffffc000ecc000
[ 1389.650872] x9 : ffffffc035bae2c0 x8 : ffffffc035bae9a8
[ 1389.662367] x7 : ffffffc035bae9a0 x6 : 0000000000000000
[ 1389.673906] x5 : ffffffbdc000001c x4 : 0000000080000000
[ 1389.685475] x3 : ffffffbdc0000000 x2 : 0000004080000000
[ 1389.697049] x1 : 0000000000000003 x0 : ffffffbdc0000000

The memory has been already freed by bam_free_chan() so fix this
by skiping already freed memory.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/dma/qcom/bam_dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d5e0a9c3ad5d..a486bc0f82e0 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1234,6 +1234,9 @@ static int bam_dma_remove(struct platform_device *pdev)
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
 		tasklet_kill(&bdev->channels[i].vc.task);
 
+		if (!bdev->channels[i].fifo_virt)
+			continue;
+
 		dma_free_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
 			    bdev->channels[i].fifo_virt,
 			    bdev->channels[i].fifo_phys);
-- 
1.7.9.5
