From: ludovic.Barre@st.com (Ludovic Barre)
Date: Wed, 7 Nov 2018 10:30:40 +0100
Subject: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
In-Reply-To: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

Refer to "4.15 set block count command" of sd specification:
Host needs to issue CMD12 if any error is detected in
the CMD18 and CMD25 operations.

In sbc case, the data->stop is fill by framework.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 82bab35..13fa640 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop || host->mrq->sbc) {
+		if (!data->stop || (host->mrq->sbc && !data->error))
 			mmci_request_end(host, data->mrq);
-		} else {
+		else
 			mmci_start_command(host, data->stop, 0);
-		}
 	}
 }
 
-- 
2.7.4
