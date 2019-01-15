Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC3C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58F820896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NLnjYO14";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JaNuXyhK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f73yPWZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58F820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/i9/IM/5WvCZsAs5dBisYxsN+66pomXC0frIXB71MKM=; b=NLnjYO14ES7fs5rBMx9ntx7ptb
	hQdZfNIUzAKQzpeZD+WrGUn3rMxLuK/udlcFVBFVDOkEqaDXcXLSf7XEwog4a2v1I4V32Dohpr7Sk
	wrTOpjwgBQPiCYRnetwA6YGRpuvbV0soauqtHeYp/4JIE9TrYTN7DIa3sgZ/DsKAUkgya207LJS9W
	ZInr2YWPz3CCllayCk216Pw3NXn3V8MYpOsQaT5CazsgHztuht0VGuPxWhfwa3ovqEgE5nxZahK7B
	cZrGlwyZNRmATWqCo2HOrQKnUWhetMUme5UhzVfazkrzhcP5flm02oLXAgN7Xy0dvcaEXZU65gEvu
	oqT+CuUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXoq-0005SM-3z; Tue, 15 Jan 2019 23:08:28 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXoT-00058R-HX
 for linux-arm-kernel@bombadil.infradead.org; Tue, 15 Jan 2019 23:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yP2FasSJHEKUvmhM1NueUcXAVpTqjNNg1l20bnmEqxo=; b=JaNuXyhKpOyEOyDh46xbUFK1H
 6QwOIZ+15g5FEvjL5WBe51OAh/zSyIOyh//LehQNHFOc6jYbCQjwXgGOpAWiLNWpmzo27Oekzrwp9
 3gtiyq998OmhmIByhUyWJ8gg3EjOBC42dtxyjTkWTBt5pF1PZd4HoTYgY620tNDXUxsk6q6pufFP9
 K/O6ftme1l9B+HUbn20N89owgWXJvdae2+tPnENnounnX07p2aya+k0MXvYWYdr+ZVbr6sBfLD6yT
 svRK8JSFf8hKGXY8eRPnVu70pRT+IsmXyBJD0afqqJInzSHOlP5jp0xt+0Sr2KiSC9u9+JJoJAV6r
 HCD1pkZvQ==;
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXoN-0006JV-Hh
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:08:01 +0000
Received: by mail-pf1-x442.google.com with SMTP id i12so2027610pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yP2FasSJHEKUvmhM1NueUcXAVpTqjNNg1l20bnmEqxo=;
 b=f73yPWZGnexRNZGn6npQodSzy1FwWsuGGI8atkevYafdxTj9Bgi4zFdrGmQ9dxEQk1
 AjFqAi50+sW9npyd2KpsXn/7W1Z+IqbOoib12qDYV8QkulSU9i3YJ4kZ0sAK46GlJ59r
 FSe5TOBJyCwUmmxcqca3cyPUZxjllYob/RUpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yP2FasSJHEKUvmhM1NueUcXAVpTqjNNg1l20bnmEqxo=;
 b=Z854IR+JpAYOSUd9Ffq/q8vJDYfJabZKTzcnm9TlC1s+4U1F1oazwzQfH4mRICoxmD
 g+HEdbw9MPs6xnPZaGkGOOqTcQE6uPAfcwMAjml/dvFPdQBwmpDlWkIVSk6jkF3LU6Rj
 lNkyJdL/kp8IRPbt4aaIiNw24/uYJrzllI0AFXAkwJH/Sg/uIUgyUhdC6eDP8VZwOeSE
 uzUuvoEHjd31lkAT9JbUo8k/pMxjN3Yk6CTqi+H10DutA4bE3rdwvjWaDu6Gt+/t1VVt
 /+SolPV/t3IfuKwZHhLu+jF4VtttJncTZ/GGy/4GmZTQASTa7yue/xmwAXuijLN87+Pg
 hwcQ==
X-Gm-Message-State: AJcUukeypoIj6+deidDKPTIAYkSu2mcYAIxta57h3lIdY3SoJ7Q8iE6o
 K44sPItzs+Z8KGZa24on1Hb1cQ==
X-Google-Smtp-Source: ALg8bN7j3gB8hbQAeB9GZ/VnFp3JiYHJ5uAHxY+4709KtpQtbdU7shOV3SgBgQbCLc55/XW4tVkLKw==
X-Received: by 2002:a63:413:: with SMTP id 19mr5881392pge.7.1547593671526;
 Tue, 15 Jan 2019 15:07:51 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id h19sm4985928pfn.114.2019.01.15.15.07.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:07:50 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org,
	peterz@infradead.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 3/7] coresight: Use event attributes for sink selection
Date: Tue, 15 Jan 2019 16:07:38 -0700
Message-Id: <20190115230742.13730-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230742.13730-1-mathieu.poirier@linaro.org>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_180759_604630_BB593350 
X-CRM114-Status: GOOD (  24.01  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, suzuki.poulose@arm.com,
 alexander.shishkin@linux.intel.com, will.deacon@arm.com,
 heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ast@kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com,
 schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch uses the information conveyed by perf_event::attr::config2
to select a sink to use for the session.  That way a sink can easily be
selected to be used by more than one source, something that isn't currently
possible with the sysfs implementation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++------
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 drivers/hwtracing/coresight/coresight.c       | 39 +++++++++++++++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 292bd409a68c..685d16001d0b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -201,18 +201,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
 
-	/*
-	 * In theory nothing prevent tracers in a trace session from being
-	 * associated with different sinks, nor having a sink per tracer.  But
-	 * until we have HW with this kind of topology we need to assume tracers
-	 * in a trace session are using the same sink.  Therefore go through
-	 * the coresight bus and pick the first enabled sink.
-	 *
-	 * When operated from sysFS users are responsible to enable the sink
-	 * while from perf, the perf tools will do it based on the choice made
-	 * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
-	 */
-	sink = coresight_get_enabled_sink(true);
+	/* First get the selected sink from user space. */
+	sink = coresight_get_sink_by_id(event->attr.config2);
+	if (!sink)
+		sink = coresight_get_enabled_sink(true);
 	if (!sink || !sink_ops(sink)->alloc_buffer)
 		goto err;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 579f34943bf1..071bb98d358f 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
 struct coresight_device *coresight_get_enabled_sink(bool reset);
+struct coresight_device *coresight_get_sink_by_id(u64 id);
 struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 526f122a38ee..7e2ce0beb2a0 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/stringhash.h>
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
@@ -541,6 +542,44 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+static int coresight_sink_by_id(struct device *dev, void *data)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+	unsigned long hash;
+
+	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		/*
+		 * See function etm_perf_sink_name_show() to know where this
+		 * comes from.
+		 */
+		hash = hashlen_hash(hashlen_string(NULL, dev_name(dev)));
+
+		if (hash == (*(unsigned long *)data))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * coresight_get_sink_by_id - returns the sink that matches the id
+ * @id: Id of the sink to match
+ *
+ * The name of a sink is unique, whether it is found on the AMBA bus or
+ * otherwise.  As such the hash of that name can easily be used to identify
+ * a sink.
+ */
+struct coresight_device *coresight_get_sink_by_id(u64 id)
+{
+	struct device *dev = NULL;
+
+	dev = bus_find_device(&coresight_bustype, NULL, &id,
+			      coresight_sink_by_id);
+
+	return dev ? to_coresight_device(dev) : NULL;
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
