Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322E92087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nmjo00WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322E92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s/LpqicPFk0eUZhRH13w+QoDcyfci9IVwoTco8kMWeA=; b=nmjo00WRovIGc8
	QVawiAungzYz7Ou3BW97sMgOrWDYgOPBj1p7VQrM9oyaYrZarP2VOt3VT3D4NIp2caX/L6TwyM3e7
	umSWCgMLC/FAuRQkOl2rReMyTxfQXTsMUB2GTiKg2darrkR8U4K6L2UeYiv7VljT204J8MXXFe0Q3
	4GJnohePqsbdl3GMYQ30yGwe7mMAXQQ/Mo1Zy/z1QzrfDJ790pdHGBgkP86pAqY/n37z2zeRF/kev
	pqc8a1+I6dOH2A0qKwXlPdMaw6HZAEZC4Ss2i7BshKvXVhlhp4YXlfjiDCgHU591gH5ax5Pa33X1W
	ksh7/FDTW/i9dg87smpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhli-0005ki-00; Mon, 04 Feb 2019 17:10:50 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhkf-0003Lj-Pi
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 17:09:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FC9B15BE;
 Mon,  4 Feb 2019 09:09:45 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CABDA3F589;
 Mon,  4 Feb 2019 09:09:43 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com,
	mark.rutland@arm.com
Subject: [PATCH 3/5] perf/arm-ccn: Fix CPU hotplug race avoidance
Date: Mon,  4 Feb 2019 17:09:06 +0000
Message-Id: <d1118e5694694ee40d2e784b2af8745f2d1dce0a.1549299188.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1549299188.git.robin.murphy@arm.com>
References: <cover.1549299188.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_090946_329776_594D12A4 
X-CRM114-Status: GOOD (  20.68  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: suzuki.poulose@arm.com, peterz@infradead.org, bigeasy@linutronix.de,
 linux-kernel@vger.kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Like arm-cci, arm-ccn has the same issue where disabling preemption to
avoid races between registering the PMU device and the hotplug notifier
can lead to those operations taking mutexes in an invalid context. Fix
it the same way by disabling hotplug instead of preemption. Since we
only ever associate the PMU instance with a single CPU, we can also take
the opportunity to slightly simplify the hotplug handling to track just
that CPU number instead of a full cpumask.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-ccn.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e02f19..8629893a9ef6 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -167,7 +167,7 @@ struct arm_ccn_dt {
 
 	struct hrtimer hrtimer;
 
-	cpumask_t cpu;
+	unsigned int cpu;
 	struct hlist_node node;
 
 	struct pmu pmu;
@@ -559,7 +559,7 @@ static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
 {
 	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
 
-	return cpumap_print_to_pagebuf(true, buf, &ccn->dt.cpu);
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ccn->dt.cpu));
 }
 
 static struct device_attribute arm_ccn_pmu_cpumask_attr =
@@ -762,7 +762,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	 * mitigate this, we enforce CPU assignment to one, selected
 	 * processor (the one described in the "cpumask" attribute).
 	 */
-	event->cpu = cpumask_first(&ccn->dt.cpu);
+	event->cpu = ccn->dt.cpu;
 
 	node_xp = CCN_CONFIG_NODE(event->attr.config);
 	type = CCN_CONFIG_TYPE(event->attr.config);
@@ -1218,15 +1218,15 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	struct arm_ccn *ccn = container_of(dt, struct arm_ccn, dt);
 	unsigned int target;
 
-	if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
+	if (cpu != dt->cpu)
 		return 0;
 	target = cpumask_any_but(cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		return 0;
 	perf_pmu_migrate_context(&dt->pmu, cpu, target);
-	cpumask_set_cpu(target, &dt->cpu);
+	dt->cpu = target;
 	if (ccn->irq)
-		WARN_ON(irq_set_affinity_hint(ccn->irq, &dt->cpu) != 0);
+		WARN_ON(irq_set_affinity_hint(ccn->irq, cpumask_of(dt->cpu)));
 	return 0;
 }
 
@@ -1301,11 +1301,12 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	}
 
 	/* Pick one CPU which we will use to collect data from CCN... */
-	cpumask_set_cpu(get_cpu(), &ccn->dt.cpu);
+	cpus_read_lock();
+	ccn->dt.cpu = smp_processor_id();
 
 	/* Also make sure that the overflow interrupt is handled by this CPU */
 	if (ccn->irq) {
-		err = irq_set_affinity_hint(ccn->irq, &ccn->dt.cpu);
+		err = irq_set_affinity_hint(ccn->irq, cpumask_of(ccn->dt.cpu));
 		if (err) {
 			dev_err(ccn->dev, "Failed to set interrupt affinity!\n");
 			goto error_set_affinity;
@@ -1316,14 +1317,14 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	if (err)
 		goto error_pmu_register;
 
-	cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
-					 &ccn->dt.node);
-	put_cpu();
+	cpuhp_state_add_instance_nocalls_cpuslocked(CPUHP_AP_PERF_ARM_CCN_ONLINE,
+						    &ccn->dt.node);
+	cpus_read_unlock();
 	return 0;
 
 error_pmu_register:
 error_set_affinity:
-	put_cpu();
+	cpus_read_unlock();
 error_choose_name:
 	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
 	for (i = 0; i < ccn->num_xps; i++)
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
