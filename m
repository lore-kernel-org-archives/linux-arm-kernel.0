From: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 04 Oct 2009 16:08:59 +0100
Subject: [RFC PATCH 02/10] PCMCIA: soc_common: provide single socket
	add/remove functionality
In-Reply-To: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <cd358c89ab62b747ea4c5120e96ca489d90ddc95.1253722954.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out the functionality for adding and removing a single
socket, thereby allowing SoCs to individually register each
socket.  The advantage of this approach is that SoCs can then
extend soc_pcmcia_socket as they wish.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/soc_common.c |  230 +++++++++++++++++++++++--------------------
 drivers/pcmcia/soc_common.h |    3 +-
 2 files changed, 125 insertions(+), 108 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 38c5484..8938608 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -573,7 +573,7 @@ void soc_pcmcia_enable_irqs(struct soc_pcmcia_socket *skt,
 EXPORT_SYMBOL(soc_pcmcia_enable_irqs);
 
 
-LIST_HEAD(soc_pcmcia_sockets);
+static LIST_HEAD(soc_pcmcia_sockets);
 static DEFINE_MUTEX(soc_pcmcia_sockets_lock);
 
 #ifdef CONFIG_CPU_FREQ
@@ -618,158 +618,174 @@ module_exit(soc_pcmcia_cpufreq_unregister);
 
 #endif
 
-int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
-				struct skt_dev_info *sinfo)
+void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt)
 {
-	struct soc_pcmcia_socket *skt;
-	int ret, i;
-
 	mutex_lock(&soc_pcmcia_sockets_lock);
+	del_timer_sync(&skt->poll_timer);
 
-	/*
-	 * Initialise the per-socket structure.
-	 */
-	for (i = 0; i < sinfo->nskt; i++) {
-		skt = &sinfo->skt[i];
+	pcmcia_unregister_socket(&skt->socket);
 
-		skt->socket.ops = &soc_common_pcmcia_operations;
-		skt->socket.owner = ops->owner;
-		skt->socket.dev.parent = dev;
+	flush_scheduled_work();
 
-		init_timer(&skt->poll_timer);
-		skt->poll_timer.function = soc_common_pcmcia_poll_event;
-		skt->poll_timer.data = (unsigned long)skt;
-		skt->poll_timer.expires = jiffies + SOC_PCMCIA_POLL_PERIOD;
+	skt->ops->hw_shutdown(skt);
 
-		skt->dev	= dev;
-		skt->ops	= ops;
+	soc_common_pcmcia_config_skt(skt, &dead_socket);
 
-		ret = request_resource(&iomem_resource, &skt->res_skt);
-		if (ret)
-			goto out_err_1;
+	list_del(&skt->node);
+	mutex_unlock(&soc_pcmcia_sockets_lock);
 
-		ret = request_resource(&skt->res_skt, &skt->res_io);
-		if (ret)
-			goto out_err_2;
+	iounmap(skt->virt_io);
+	skt->virt_io = NULL;
+	release_resource(&skt->res_attr);
+	release_resource(&skt->res_mem);
+	release_resource(&skt->res_io);
+	release_resource(&skt->res_skt);
+}
+EXPORT_SYMBOL(soc_pcmcia_remove_one);
 
-		ret = request_resource(&skt->res_skt, &skt->res_mem);
-		if (ret)
-			goto out_err_3;
+int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
+{
+	int ret;
 
-		ret = request_resource(&skt->res_skt, &skt->res_attr);
-		if (ret)
-			goto out_err_4;
+	init_timer(&skt->poll_timer);
+	skt->poll_timer.function = soc_common_pcmcia_poll_event;
+	skt->poll_timer.data = (unsigned long)skt;
+	skt->poll_timer.expires = jiffies + SOC_PCMCIA_POLL_PERIOD;
 
-		skt->virt_io = ioremap(skt->res_io.start, 0x10000);
-		if (skt->virt_io == NULL) {
-			ret = -ENOMEM;
-			goto out_err_5;
-		}
+	ret = request_resource(&iomem_resource, &skt->res_skt);
+	if (ret)
+		goto out_err_1;
 
-		list_add(&skt->node, &soc_pcmcia_sockets);
+	ret = request_resource(&skt->res_skt, &skt->res_io);
+	if (ret)
+		goto out_err_2;
 
-		/*
-		 * We initialize default socket timing here, because
-		 * we are not guaranteed to see a SetIOMap operation at
-		 * runtime.
-		 */
-		ops->set_timing(skt);
+	ret = request_resource(&skt->res_skt, &skt->res_mem);
+	if (ret)
+		goto out_err_3;
 
-		ret = ops->hw_init(skt);
-		if (ret)
-			goto out_err_6;
+	ret = request_resource(&skt->res_skt, &skt->res_attr);
+	if (ret)
+		goto out_err_4;
 
-		skt->socket.features = SS_CAP_STATIC_MAP|SS_CAP_PCCARD;
-		skt->socket.resource_ops = &pccard_static_ops;
-		skt->socket.irq_mask = 0;
-		skt->socket.map_size = PAGE_SIZE;
-		skt->socket.pci_irq = skt->irq;
-		skt->socket.io_offset = (unsigned long)skt->virt_io;
+	skt->virt_io = ioremap(skt->res_io.start, 0x10000);
+	if (skt->virt_io == NULL) {
+		ret = -ENOMEM;
+		goto out_err_5;
+	}
 
-		skt->status = soc_common_pcmcia_skt_state(skt);
+	mutex_lock(&soc_pcmcia_sockets_lock);
 
-		ret = pcmcia_register_socket(&skt->socket);
-		if (ret)
-			goto out_err_7;
+	list_add(&skt->node, &soc_pcmcia_sockets);
 
-		WARN_ON(skt->socket.sock != i);
+	/*
+	 * We initialize default socket timing here, because
+	 * we are not guaranteed to see a SetIOMap operation at
+	 * runtime.
+	 */
+	skt->ops->set_timing(skt);
 
-		add_timer(&skt->poll_timer);
+	ret = skt->ops->hw_init(skt);
+	if (ret)
+		goto out_err_6;
 
-		ret = device_create_file(&skt->socket.dev, &dev_attr_status);
-		if (ret)
-			goto out_err_8;
-	}
+	skt->socket.ops = &soc_common_pcmcia_operations;
+	skt->socket.features = SS_CAP_STATIC_MAP|SS_CAP_PCCARD;
+	skt->socket.resource_ops = &pccard_static_ops;
+	skt->socket.irq_mask = 0;
+	skt->socket.map_size = PAGE_SIZE;
+	skt->socket.pci_irq = skt->irq;
+	skt->socket.io_offset = (unsigned long)skt->virt_io;
 
-	dev_set_drvdata(dev, sinfo);
-	ret = 0;
-	goto out;
+	skt->status = soc_common_pcmcia_skt_state(skt);
 
-	do {
-		skt = &sinfo->skt[i];
+	ret = pcmcia_register_socket(&skt->socket);
+	if (ret)
+		goto out_err_7;
+
+	add_timer(&skt->poll_timer);
+
+	mutex_unlock(&soc_pcmcia_sockets_lock);
+
+	ret = device_create_file(&skt->socket.dev, &dev_attr_status);
+	if (ret)
+		goto out_err_8;
+
+	return ret;
 
-		device_remove_file(&skt->socket.dev, &dev_attr_status);
  out_err_8:
-		del_timer_sync(&skt->poll_timer);
-		pcmcia_unregister_socket(&skt->socket);
+	mutex_lock(&soc_pcmcia_sockets_lock);
+	del_timer_sync(&skt->poll_timer);
+	pcmcia_unregister_socket(&skt->socket);
 
  out_err_7:
-		flush_scheduled_work();
+	flush_scheduled_work();
 
-		ops->hw_shutdown(skt);
+	skt->ops->hw_shutdown(skt);
  out_err_6:
- 		list_del(&skt->node);
-		iounmap(skt->virt_io);
+	list_del(&skt->node);
+	mutex_unlock(&soc_pcmcia_sockets_lock);
+	iounmap(skt->virt_io);
  out_err_5:
-		release_resource(&skt->res_attr);
+	release_resource(&skt->res_attr);
  out_err_4:
-		release_resource(&skt->res_mem);
+	release_resource(&skt->res_mem);
  out_err_3:
-		release_resource(&skt->res_io);
+	release_resource(&skt->res_io);
  out_err_2:
-		release_resource(&skt->res_skt);
+	release_resource(&skt->res_skt);
  out_err_1:
-		i--;
-	} while (i > 0);
 
-	kfree(sinfo);
-
- out:
-	mutex_unlock(&soc_pcmcia_sockets_lock);
 	return ret;
 }
-EXPORT_SYMBOL(soc_common_drv_pcmcia_probe);
+EXPORT_SYMBOL(soc_pcmcia_add_one);
 
-int soc_common_drv_pcmcia_remove(struct device *dev)
+int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
+				struct skt_dev_info *sinfo)
 {
-	struct skt_dev_info *sinfo = dev_get_drvdata(dev);
-	int i;
+	struct soc_pcmcia_socket *skt;
+	int ret, i;
 
-	dev_set_drvdata(dev, NULL);
+	/*
+	 * Initialise the per-socket structure.
+	 */
+	for (i = ret = 0; i < sinfo->nskt; i++) {
+		skt = &sinfo->skt[i];
 
-	mutex_lock(&soc_pcmcia_sockets_lock);
-	for (i = 0; i < sinfo->nskt; i++) {
-		struct soc_pcmcia_socket *skt = &sinfo->skt[i];
+		skt->socket.owner = ops->owner;
+		skt->socket.dev.parent = dev;
 
-		del_timer_sync(&skt->poll_timer);
+		skt->dev	= dev;
+		skt->ops	= ops;
 
-		pcmcia_unregister_socket(&skt->socket);
+		ret = soc_pcmcia_add_one(skt);
+		if (ret)
+			break;
 
-		flush_scheduled_work();
+		WARN_ON(skt->socket.sock != i);
+	}
 
-		skt->ops->hw_shutdown(skt);
+	if (ret) {
+		while (--i >= 0)
+			soc_pcmcia_remove_one(&sinfo->skt[i]);
+		kfree(sinfo);
+	} else {
+		dev_set_drvdata(dev, sinfo);
+	}
 
-		soc_common_pcmcia_config_skt(skt, &dead_socket);
+	return ret;
+}
+EXPORT_SYMBOL(soc_common_drv_pcmcia_probe);
 
-		list_del(&skt->node);
-		iounmap(skt->virt_io);
-		skt->virt_io = NULL;
-		release_resource(&skt->res_attr);
-		release_resource(&skt->res_mem);
-		release_resource(&skt->res_io);
-		release_resource(&skt->res_skt);
-	}
-	mutex_unlock(&soc_pcmcia_sockets_lock);
+int soc_common_drv_pcmcia_remove(struct device *dev)
+{
+	struct skt_dev_info *sinfo = dev_get_drvdata(dev);
+	int i;
+
+	dev_set_drvdata(dev, NULL);
+
+	for (i = 0; i < sinfo->nskt; i++)
+		soc_pcmcia_remove_one(&sinfo->skt[i]);
 
 	kfree(sinfo);
 
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 290e143..51c72ba 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -135,7 +135,8 @@ extern void soc_pcmcia_enable_irqs(struct soc_pcmcia_socket *skt, struct pcmcia_
 extern void soc_common_pcmcia_get_timing(struct soc_pcmcia_socket *, struct soc_pcmcia_timing *);
 
 
-extern struct list_head soc_pcmcia_sockets;
+void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt);
+int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 
 extern int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops, struct skt_dev_info *sinfo);
 extern int soc_common_drv_pcmcia_remove(struct device *dev);
-- 
1.6.2.5
