From: per.forlin@linaro.org (Per Forlin)
Date: Mon, 29 Aug 2011 15:35:59 +0200
Subject: [PATCH 2/2] mmc: mmci: simplify err check in mmci_post_request
In-Reply-To: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
Message-ID: <1314624959-4634-3-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error condition indicates that mmci_post_request() should cleanup
after the mmci_pre_request(). In this case the resources allocated by
device_prep_slave_sg() are freed by calling dmaengine_terminate_all().
dma_unmap_sg() should always be performed if the host_cookie is set.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/host/mmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 56e9a41..40e4c05 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -529,7 +529,7 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	if (chan) {
 		if (err)
 			dmaengine_terminate_all(chan);
-		if (err || data->host_cookie)
+		if (data->host_cookie)
 			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
 				     data->sg_len, dir);
 		mrq->data->host_cookie = 0;
-- 
1.7.4.1
