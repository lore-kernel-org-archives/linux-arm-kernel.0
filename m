From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 28 Jan 2016 14:26:01 -0700
Subject: [PATCH net-next 37/40] net: fec: add events device file
In-Reply-To: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1454016364-30985-38-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is for debug purposes. If a receive interrupt
is lost, writing to this file can recover the FEC.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 11968a9..00c9b7e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3273,6 +3273,53 @@ fec_enet_get_queue_num(struct platform_device *pdev, int *num_tx, int *num_rx)
 
 }
 
+static ssize_t fec_show_events(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int qid;
+	int complete_cnt[] = {0, 0, 0};
+
+	for (qid = 0; qid < fep->num_rx_queues; qid++) {
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[qid];
+		struct bufdesc *bdp = rxq->bd.cur;
+
+		do {
+			unsigned status = bdp->cbd_sc;
+
+			if (status & BD_ENET_RX_EMPTY)
+				break;
+			complete_cnt[qid]++;
+			bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+		} while (bdp != rxq->bd.cur);
+	}
+	return sprintf(buf, "%08x %08x %08x %08x %d %d %d\n", fep->events,
+			fep->last_ievents,
+			readl(fep->hwp + FEC_IEVENT),
+			readl(fep->hwp + FEC_IMASK),
+			complete_cnt[0], complete_cnt[1], complete_cnt[2]);
+}
+
+static ssize_t fec_set_events(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	unsigned long events;
+
+	/* Disable the RX/TX interrupt */
+	writel(FEC_NAPI_IMASK, fep->hwp + FEC_IMASK);
+	if (!kstrtoul(buf, 16, &events))
+		fep->events |= events;
+	napi_schedule(&fep->napi);
+	netif_wake_queue(fep->netdev);
+	return count;
+}
+
+static DEVICE_ATTR(events, 0644, fec_show_events, fec_set_events);
+
 static int
 fec_probe(struct platform_device *pdev)
 {
@@ -3451,6 +3498,9 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
+	ret = device_create_file(&pdev->dev, &dev_attr_events);
+	if (ret)
+		dev_err(&pdev->dev, "Error creating fec sysfs file(%d)\n", ret);
 	ret = register_netdev(ndev);
 	if (ret)
 		goto failed_register;
@@ -3470,6 +3520,7 @@ fec_probe(struct platform_device *pdev)
 	return 0;
 
 failed_register:
+	device_remove_file(&pdev->dev, &dev_attr_events);
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
@@ -3496,6 +3547,7 @@ fec_drv_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	device_remove_file(&pdev->dev, &dev_attr_events);
 	cancel_work_sync(&fep->tx_timeout_work);
 	fec_ptp_stop(pdev);
 	unregister_netdev(ndev);
-- 
2.5.0
