From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Wed, 26 Sep 2012 16:54:06 +0530
Subject: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
 suspend/resume
In-Reply-To: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
Message-ID: <1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI functional clock must be disalble/enable in non RTPM suspend/resume
hooks. Currently it is only done for RTPM cases.

This patch add support to disable/enbale clock for conventional
suspend/resume calls.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/spi/spi-pl022.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f2a80ff..09fb09e 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2310,6 +2310,8 @@ static int pl022_suspend(struct device *dev)
 	}
 
 	dev_dbg(dev, "suspended\n");
+	clk_disable(pl022->clk);
+
 	return 0;
 }
 
@@ -2318,6 +2320,12 @@ static int pl022_resume(struct device *dev)
 	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int ret;
 
+	ret = clk_enable(pl022->clk);
+	if (ret) {
+		dev_err(dev, "could not enable SSP/SPI bus clock\n");
+		return ret;
+	}
+
 	/* Start the queue running */
 	ret = spi_master_resume(pl022->master);
 	if (ret)
-- 
1.7.10
