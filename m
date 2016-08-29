From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:27 +0100
Subject: [PATCH 16/33] pcmcia: soc_common: switch to a per-socket cpufreq
 notifier
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkt-0000nG-Fl@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to a per-socket cpufreq notifier rather than a global notifier.
This allows each socket to be self-contained.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/soc_common.c | 77 ++++++++++++++-------------------------------
 drivers/pcmcia/soc_common.h |  3 ++
 2 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 128d8611f39a..c8111807a6aa 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -750,50 +750,15 @@ static struct pccard_operations soc_common_pcmcia_operations = {
 };
 
 
-static LIST_HEAD(soc_pcmcia_sockets);
-static DEFINE_MUTEX(soc_pcmcia_sockets_lock);
-
 #ifdef CONFIG_CPU_FREQ
-static int
-soc_pcmcia_notifier(struct notifier_block *nb, unsigned long val, void *data)
+static int soc_common_pcmcia_cpufreq_nb(struct notifier_block *nb,
+	unsigned long val, void *data)
 {
-	struct soc_pcmcia_socket *skt;
+	struct soc_pcmcia_socket *skt = container_of(nb, struct soc_pcmcia_socket, cpufreq_nb);
 	struct cpufreq_freqs *freqs = data;
-	int ret = 0;
-
-	mutex_lock(&soc_pcmcia_sockets_lock);
-	list_for_each_entry(skt, &soc_pcmcia_sockets, node)
-		if (skt->ops->frequency_change)
-			ret += skt->ops->frequency_change(skt, val, freqs);
-	mutex_unlock(&soc_pcmcia_sockets_lock);
-
-	return ret;
-}
-
-static struct notifier_block soc_pcmcia_notifier_block = {
-	.notifier_call	= soc_pcmcia_notifier
-};
 
-static int soc_pcmcia_cpufreq_register(void)
-{
-	int ret;
-
-	ret = cpufreq_register_notifier(&soc_pcmcia_notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
-	if (ret < 0)
-		printk(KERN_ERR "Unable to register CPU frequency change "
-				"notifier for PCMCIA (%d)\n", ret);
-	return ret;
-}
-fs_initcall(soc_pcmcia_cpufreq_register);
-
-static void soc_pcmcia_cpufreq_unregister(void)
-{
-	cpufreq_unregister_notifier(&soc_pcmcia_notifier_block,
-		CPUFREQ_TRANSITION_NOTIFIER);
+	return skt->ops->frequency_change(skt, val, freqs);
 }
-module_exit(soc_pcmcia_cpufreq_unregister);
-
 #endif
 
 void soc_pcmcia_init_one(struct soc_pcmcia_socket *skt,
@@ -813,19 +778,21 @@ EXPORT_SYMBOL(soc_pcmcia_init_one);
 
 void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt)
 {
-	mutex_lock(&soc_pcmcia_sockets_lock);
 	del_timer_sync(&skt->poll_timer);
 
 	pcmcia_unregister_socket(&skt->socket);
 
+#ifdef CONFIG_CPU_FREQ
+	if (skt->ops->frequency_change)
+		cpufreq_unregister_notifier(&skt->cpufreq_nb,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+
 	soc_pcmcia_hw_shutdown(skt);
 
 	/* should not be required; violates some lowlevel drivers */
 	soc_common_pcmcia_config_skt(skt, &dead_socket);
 
-	list_del(&skt->node);
-	mutex_unlock(&soc_pcmcia_sockets_lock);
-
 	iounmap(skt->virt_io);
 	skt->virt_io = NULL;
 	release_resource(&skt->res_attr);
@@ -867,10 +834,6 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 		goto out_err_5;
 	}
 
-	mutex_lock(&soc_pcmcia_sockets_lock);
-
-	list_add(&skt->node, &soc_pcmcia_sockets);
-
 	/*
 	 * We initialize default socket timing here, because
 	 * we are not guaranteed to see a SetIOMap operation at
@@ -891,14 +854,23 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 
 	skt->status = soc_common_pcmcia_skt_state(skt);
 
+#ifdef CONFIG_CPU_FREQ
+	if (skt->ops->frequency_change) {
+		skt->cpufreq_nb.notifier_call = soc_common_pcmcia_cpufreq_nb;
+
+		ret = cpufreq_register_notifier(&skt->cpufreq_nb,
+						CPUFREQ_TRANSITION_NOTIFIER);
+		if (ret < 0)
+			dev_err(skt->socket.dev.parent,
+				"unable to register CPU frequency change notifier for PCMCIA (%d)\n",
+				ret);
+	}
+#endif
+
 	ret = pcmcia_register_socket(&skt->socket);
 	if (ret)
 		goto out_err_7;
 
-	add_timer(&skt->poll_timer);
-
-	mutex_unlock(&soc_pcmcia_sockets_lock);
-
 	ret = device_create_file(&skt->socket.dev, &dev_attr_status);
 	if (ret)
 		goto out_err_8;
@@ -906,15 +878,12 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	return ret;
 
  out_err_8:
-	mutex_lock(&soc_pcmcia_sockets_lock);
 	del_timer_sync(&skt->poll_timer);
 	pcmcia_unregister_socket(&skt->socket);
 
  out_err_7:
 	soc_pcmcia_hw_shutdown(skt);
  out_err_6:
-	list_del(&skt->node);
-	mutex_unlock(&soc_pcmcia_sockets_lock);
 	iounmap(skt->virt_io);
  out_err_5:
 	release_resource(&skt->res_attr);
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 18a6df5ca374..f66e2fb1f33f 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -75,6 +75,9 @@ struct soc_pcmcia_socket {
 
 	unsigned int		irq_state;
 
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	cpufreq_nb;
+#endif
 	struct timer_list	poll_timer;
 	struct list_head	node;
 };
-- 
2.1.0
