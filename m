Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06700C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69FC218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kLsVdB+G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="scmDngJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69FC218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HrL686OS4uCe0zUu2i8bS/Jqo0axyBDb6yR9Z3SRVh8=; b=kLsVdB+GAuS2He
	19cMn62jKqkt/k9RvmRChmEJil6Qou2yRD1zwu6prjGjOGlP5aO7/LvU0RJpPqu+a83vDHu/fysYo
	Yyrz+b9a9+ST1Xgmrg9ILBOi6Y2YvOu2jp4pKY/t1hTH7lZVMQRxIHSsfMNUCgvJgkWXzbN8RN94P
	uNEtf43QIPeO0SpwEjZl7VR96tHUzcBMk8YBikd6B2UsrPeH8oFjwqEx64wvkl6sk6OS72aCTDKsw
	WmuaDUAdh5OggPTLIBSG8EFZhzPZMxKbYStncoK6nNy2J+81J2ZcgYBZ5LMku/x089S19Dskf9AA8
	q8f8V3br/ttFUfVKfkTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSHM-0004wu-15; Wed, 06 Feb 2019 18:50:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSH1-0004eB-I3
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:50:19 +0000
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91B23218EA;
 Wed,  6 Feb 2019 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549479015;
 bh=3t46eT5Yrb6Noi8SQIeBmbS6lxXqViI1PNv0G7IC1Mo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=scmDngJP0Kr1jv2Hb9PVSUeJUQ6evfPbRAo85safersvZF/qJ8Ehpeh7W0l07Dpo/
 GSD1xQK6YuFvXoGhv1uIDnBMqMdwCIwyKsaOywD6zKk6UhnxwDhSUQdHE9HtcXB1iJ
 hIt7M5DjeTswafLqp2HHMcF8lRL+WVSJOXIBvLVU=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 21/53] coresight: perf: Add "sinks" group to PMU directory
Date: Wed,  6 Feb 2019 15:48:31 -0300
Message-Id: <20190206184903.24054-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_105015_914389_9BB79354 
X-CRM114-Status: GOOD (  23.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Clark Williams <williams@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-s390@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Add a "sinks" directory entry so that users can see all the sinks
available in the system in a single place.  Individual sink are added
as they are registered with the coresight bus.

Committer tests:

Test built on a ubuntu 18.04 container with a cross build environment to
arm64, the new field is there, need to find a machine with this feature
to do further testing in the future.

  root@d15263e5734a:/git/perf# grep CORESIGHT /tmp/build/v5.0-rc2+/.config
  CONFIG_CORESIGHT=y
  CONFIG_CORESIGHT_LINKS_AND_SINKS=y
  CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
  CONFIG_CORESIGHT_CATU=y
  CONFIG_CORESIGHT_SINK_TPIU=y
  CONFIG_CORESIGHT_SINK_ETBV10=y
  CONFIG_CORESIGHT_SOURCE_ETM4X=y
  CONFIG_CORESIGHT_DYNAMIC_REPLICATOR=y
  CONFIG_CORESIGHT_STM=y
  CONFIG_CORESIGHT_CPU_DEBUG=m
  root@d15263e5734a:/git/perf#
  root@d15263e5734a:/git/perf# file /tmp/build/v5.0-rc2+/drivers/hwtracing/coresight/*.o
  .../coresight/coresight-catu.o:               ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-cpu-debug.mod.o:      ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-cpu-debug.o:          ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-dynamic-replicator.o: ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-etb10.o:              ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-etm-perf.o:           ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-etm4x-sysfs.o:        ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-etm4x.o:              ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-funnel.o:             ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-replicator.o:         ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-stm.o:                ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-tmc-etf.o:            ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-tmc-etr.o:            ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-tmc.o:                ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight-tpiu.o:               ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/coresight.o:                    ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  .../coresight/of_coresight.o:                 ELF 64-bit MSB relocatable, ARM aarch64, version 1 (SYSV), not stripped
  root@d15263e5734a:/git/perf#

  root@d15263e5734a:/git/perf# pahole -C coresight_device /tmp/build/v5.0-rc2+/drivers/hwtracing/coresight/coresight.o
  struct coresight_device {
          struct coresight_connection * conns;             /*     0     8 */
          int                        nr_inport;            /*     8     4 */
          int                        nr_outport;           /*    12     4 */
          enum coresight_dev_type    type;                 /*    16     4 */
          union coresight_dev_subtype subtype;             /*    20     8 */

          /* XXX 4 bytes hole, try to pack */

          const struct coresight_ops  * ops;               /*    32     8 */
          struct device              dev;                  /*    40  1408 */

          /* XXX last struct has 7 bytes of padding */

          /* --- cacheline 22 boundary (1408 bytes) was 40 bytes ago --- */
          atomic_t *                 refcnt;               /*  1448     8 */
          bool                       orphan;               /*  1456     1 */
          bool                       enable;               /*  1457     1 */
          bool                       activated;            /*  1458     1 */

          /* XXX 5 bytes hole, try to pack */

          struct dev_ext_attribute * ea;                   /*  1464     8 */

          /* size: 1472, cachelines: 23, members: 12 */
          /* sum members: 1463, holes: 2, sum holes: 9 */
          /* paddings: 1, sum paddings: 7 */
  };
  root@d15263e5734a:/git/perf#

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Link: http://lkml.kernel.org/r/20190131184714.20388-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 82 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.h  |  6 +-
 drivers/hwtracing/coresight/coresight.c       | 18 ++++
 include/linux/coresight.h                     |  7 +-
 4 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f21eb28b6782..cdbdb28dc175 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -14,6 +14,7 @@
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
 	.attrs  = etm_config_formats_attr,
 };
 
+static struct attribute *etm_config_sinks_attr[] = {
+	NULL,
+};
+
+static const struct attribute_group etm_pmu_sinks_group = {
+	.name   = "sinks",
+	.attrs  = etm_config_sinks_attr,
+};
+
 static const struct attribute_group *etm_pmu_attr_groups[] = {
 	&etm_pmu_format_group,
+	&etm_pmu_sinks_group,
 	NULL,
 };
 
@@ -479,6 +490,77 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
 	return 0;
 }
 
+static ssize_t etm_perf_sink_name_show(struct device *dev,
+				       struct device_attribute *dattr,
+				       char *buf)
+{
+	struct dev_ext_attribute *ea;
+
+	ea = container_of(dattr, struct dev_ext_attribute, attr);
+	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
+}
+
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{
+	int ret;
+	unsigned long hash;
+	const char *name;
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device *pdev = csdev->dev.parent;
+	struct dev_ext_attribute *ea;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return -EINVAL;
+
+	if (csdev->ea != NULL)
+		return -EINVAL;
+
+	if (!etm_perf_up)
+		return -EPROBE_DEFER;
+
+	ea = devm_kzalloc(pdev, sizeof(*ea), GFP_KERNEL);
+	if (!ea)
+		return -ENOMEM;
+
+	name = dev_name(pdev);
+	/* See function coresight_get_sink_by_id() to know where this is used */
+	hash = hashlen_hash(hashlen_string(NULL, name));
+
+	ea->attr.attr.name = devm_kstrdup(pdev, name, GFP_KERNEL);
+	if (!ea->attr.attr.name)
+		return -ENOMEM;
+
+	ea->attr.attr.mode = 0444;
+	ea->attr.show = etm_perf_sink_name_show;
+	ea->var = (unsigned long *)hash;
+
+	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
+				      &ea->attr.attr, "sinks");
+
+	if (!ret)
+		csdev->ea = ea;
+
+	return ret;
+}
+
+void etm_perf_del_symlink_sink(struct coresight_device *csdev)
+{
+	struct device *pmu_dev = etm_pmu.dev;
+	struct dev_ext_attribute *ea = csdev->ea;
+
+	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
+	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
+		return;
+
+	if (!ea)
+		return;
+
+	sysfs_remove_file_from_group(&pmu_dev->kobj,
+				     &ea->attr.attr, "sinks");
+	csdev->ea = NULL;
+}
+
 static int __init etm_perf_init(void)
 {
 	int ret;
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index da7d9336a15c..015213abe00a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -59,6 +59,8 @@ struct etm_event_data {
 
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
+int etm_perf_add_symlink_sink(struct coresight_device *csdev);
+void etm_perf_del_symlink_sink(struct coresight_device *csdev);
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	struct etm_event_data *data = perf_get_aux(handle);
@@ -70,7 +72,9 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 #else
 static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
 { return -EINVAL; }
-
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{ return -EINVAL; }
+void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
 static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 {
 	return NULL;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 2b0df1a0a8df..d7fa90be6f42 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 
+#include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 
 static DEFINE_MUTEX(coresight_mutex);
@@ -1167,6 +1168,22 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		goto err_out;
 	}
 
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		ret = etm_perf_add_symlink_sink(csdev);
+
+		if (ret) {
+			device_unregister(&csdev->dev);
+			/*
+			 * As with the above, all resources are free'd
+			 * explicitly via coresight_device_release() triggered
+			 * from put_device(), which is in turn called from
+			 * function device_unregister().
+			 */
+			goto err_out;
+		}
+	}
+
 	mutex_lock(&coresight_mutex);
 
 	coresight_fixup_device_conns(csdev);
@@ -1185,6 +1202,7 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
+	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
 	coresight_remove_conns(csdev);
 	device_unregister(&csdev->dev);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 46c67a764877..7b87965f7a65 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -154,8 +154,9 @@ struct coresight_connection {
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
  * @activated:	'true' only if a _sink_ has been activated.  A sink can be
-		activated but not yet enabled.  Enabling for a _sink_
-		happens when a source has been selected for that it.
+ *		activated but not yet enabled.  Enabling for a _sink_
+ *		appens when a source has been selected for that it.
+ * @ea:		Device attribute for sink representation under PMU directory.
  */
 struct coresight_device {
 	struct coresight_connection *conns;
@@ -168,7 +169,9 @@ struct coresight_device {
 	atomic_t *refcnt;
 	bool orphan;
 	bool enable;	/* true only if configured as part of a path */
+	/* sink specific fields */
 	bool activated;	/* true only if a sink is part of a path */
+	struct dev_ext_attribute *ea;
 };
 
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
