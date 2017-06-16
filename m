From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Fri, 16 Jun 2017 14:28:24 +0300
Subject: [PATCH 3/4] firmware: tegra: Expose tegra_bpmp_mrq_return
In-Reply-To: <20170616112825.31025-1-mperttunen@nvidia.com>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
Message-ID: <20170616112825.31025-3-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose and export the tegra_bpmp_mrq_return function for use of drivers
outside the core BPMP driver. This function is used to reply to
messages originating from the BPMP, which is required in the thermal
driver.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 5 +++--
 include/soc/tegra/bpmp.h      | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 84e4c9a58a0c..72ffccd891f4 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -379,8 +379,8 @@ static struct tegra_bpmp_mrq *tegra_bpmp_find_mrq(struct tegra_bpmp *bpmp,
 	return NULL;
 }
 
-static void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel,
-				  int code, const void *data, size_t size)
+void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel, int code,
+			   const void *data, size_t size)
 {
 	unsigned long flags = channel->ib->flags;
 	struct tegra_bpmp *bpmp = channel->bpmp;
@@ -418,6 +418,7 @@ static void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel,
 		mbox_client_txdone(bpmp->mbox.channel, 0);
 	}
 }
+EXPORT_SYMBOL_GPL(tegra_bpmp_mrq_return);
 
 static void tegra_bpmp_handle_mrq(struct tegra_bpmp *bpmp,
 				  unsigned int mrq,
diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
index 13dcd44e91bb..179a3a0f4963 100644
--- a/include/soc/tegra/bpmp.h
+++ b/include/soc/tegra/bpmp.h
@@ -114,6 +114,8 @@ int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 			       struct tegra_bpmp_message *msg);
 int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
 			struct tegra_bpmp_message *msg);
+void tegra_bpmp_mrq_return(struct tegra_bpmp_channel *channel, int code,
+			   const void *data, size_t size);
 
 int tegra_bpmp_request_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
 			   tegra_bpmp_mrq_handler_t handler, void *data);
-- 
2.13.1
