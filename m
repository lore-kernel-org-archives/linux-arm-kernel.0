Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF64CC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5320D2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ud8RwtnI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m70DW2pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5320D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h2QDSvvI4uF+5/r9KEWZHcy2POUthvn9pu2SpzfjI9o=; b=Ud8RwtnIGunUMs
	SAOU+avBd0NXf9+b4q24EFlfKlTS49QKn3Ro4t+b7fkDCjoWCXhVdm8b8wB7hABEdUWrEZjrcMchA
	I7XaAZ8aJAmmRbNHVLv8zct0fpjEBzHm6kove6AMpol0scyJh8aGqpLXfQE/8VkJcdzRleNUzz9cI
	ry2DSRBTLpJYzt7dqrtfus6phHXoFt4lfCrPtJufM6SCSa/5YKI3dtVTM3zhSsZtkmf0SEBVvKf46
	ytS/ZFYGiibjyr3vOUm+hgxFUZfoW5mwBYqHLmWn/LYitCUpJrPL4V7A1z7lAMRlWECQVKji237rw
	Mx3aSzOw4ewJkcllwIMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1ES-0005eB-R8; Thu, 06 Dec 2018 21:30:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1E1-0005BS-5s
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:30:27 +0000
Received: from quaco.ghostprotocols.net
 (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC12D2146F;
 Thu,  6 Dec 2018 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544131814;
 bh=kalhg6BjUEjBPqLkTfeR+KzRWOd6nI7iVDMjU7Q3CVY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m70DW2pC6bPZ592di+g/wcojEcCo/kprhHr6LR5Y4Q2N17h18V9kfAxSsesxFE9G8
 IQcVoaCBq7hSJ0txUeYjMa4UZlmQ1fwRM5rFThuc0t5+kcA3RmckMOqV4hq5RkNUc/
 /v/cBJqznzYXJnC/pnp/a7g1BmguezcpBDL215Qk=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 57/75] perf cs-etm: Add configuration for ETMv3 trace protocol
Date: Thu,  6 Dec 2018 18:25:44 -0300
Message-Id: <20181206212602.20474-58-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_133025_262000_91C349B8 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Clark Williams <williams@redhat.com>, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch deals with the proper initialisation of configuration
parameters for the ETMv3 trace protocol in order to properly handle
packets generated by tracers following this specification.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1543955944-10042-2-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  8 +++
 tools/perf/util/cs-etm.c                      | 54 ++++++++++++++-----
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 9351bd10d864..6b5525410a43 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -53,6 +53,13 @@ struct cs_etm_queue;
 typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u64,
 				  size_t, u8 *);
 
+struct cs_etmv3_trace_params {
+	u32 reg_ctrl;
+	u32 reg_trc_id;
+	u32 reg_ccer;
+	u32 reg_idr;
+};
+
 struct cs_etmv4_trace_params {
 	u32 reg_idr0;
 	u32 reg_idr1;
@@ -65,6 +72,7 @@ struct cs_etmv4_trace_params {
 struct cs_etm_trace_params {
 	int protocol;
 	union {
+		struct cs_etmv3_trace_params etmv3;
 		struct cs_etmv4_trace_params etmv4;
 	};
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 48ad217bf0df..76e509c32a28 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -114,15 +114,28 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+						      __perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
@@ -352,15 +365,28 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free;
 
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+							__perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
