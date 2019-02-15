Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0515222DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QxduBTnk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZh3fjwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0515222DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x28atpgrOfMJi8KvNEjVydmYH1kLiHnUfsjs3cF4Zkc=; b=QxduBTnkflIdKR
	QEj5SMQDfMosyBxldTrpwK2eeR1df7rhBZa3BEsavFc6Me9C99NN6EW3t1pAJJ6wu1Q49GSwUtEDp
	Qp03q3rAmv2UGGLots2zzvYE0PV/g69LI+Hc8FzY242/gwWCHNvSQwpFVfMHfXoEulin5d9De9hdK
	2jCsyUn2kwGJ5bgsZhxE8dRPAGlfkeV7L4AjxYWJ3T/h+o1/S+nVIOh6/1q2q6H1RG4+Z1r6wjjjJ
	QWbW9oGo1VKGBjs2ml/0hCwrp1BOrh5okXyB+/npvkx1i+HbsTmRdsMIHL9bplU4KrqarcejRGkfO
	EwnnmBcLp/9w8mTo6oIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRgE-0005gh-UZ; Fri, 15 Feb 2019 00:48:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfS-0004jf-3K
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:48:03 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E8A0222A1;
 Fri, 15 Feb 2019 00:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191669;
 bh=/f1RVlzt5D9FDbtr4L+5gYEmFOntVdiHPghg0jfpF/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dZh3fjwPGFGyWW5zTnZOskn26phaXLztbNWy9A7aZcSICakp/Ko6fV0hZfuRSAnbt
 SGcvbZm6PgNCwcxZJ5jMI6mZMSRNzPzIO6BtmYPoQhVvSXRDmIOYWV8a6j1O260V0C
 ZGat4s5J7/dTvS/NmWu49q1Wy96DolOTCHQhV7t0=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 28/43] perf cs-etm: Introducing function
 cs_etm__init_trace_params()
Date: Thu, 14 Feb 2019 21:45:24 -0300
Message-Id: <20190215004539.23571-29-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164750_876056_BE3E1DEA 
X-CRM114-Status: GOOD (  13.53  )
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
 Suzuki K Poulouse <suzuki.poulose@arm.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The trace parameter initialisation code is repeated in two different
places, something that bloats the file and can lead to errors.  This
is fixed by introducing a helper function and calling the right
protocol initialisation code when required.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-7-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 112 +++++++++++++++++++--------------------
 tools/perf/util/cs-etm.h |   4 +-
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aac07f950074..f3a6dfaf3026 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,57 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx,
+					  u32 etmidr)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
+	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
+}
+
+static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
+	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
+	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
+	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
+	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
+	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
+	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+}
+
+static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
+				     struct cs_etm_auxtrace *etm)
+{
+	int i;
+	u32 etmidr;
+	u64 architecture;
+
+	for (i = 0; i < etm->num_cpu; i++) {
+		architecture = etm->metadata[i][CS_ETM_MAGIC];
+
+		switch (architecture) {
+		case __perf_cs_etmv3_magic:
+			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
+			break;
+		case __perf_cs_etmv4_magic:
+			cs_etm__set_trace_param_etmv4(t_params, etm, i);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
 				       enum cs_etm_decoder_operation mode)
@@ -161,7 +212,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
-	int i, ret;
+	int ret;
 	const char *color = PERF_COLOR_BLUE;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params *t_params;
@@ -179,33 +230,8 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		return;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-						      __perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
@@ -382,7 +408,6 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 						unsigned int queue_nr)
 {
-	int i;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
@@ -431,33 +456,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-							__perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index d76126e0e3d0..0e97c196147a 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -105,8 +105,8 @@ struct intlist *traceid_list;
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
 
-static const u64 __perf_cs_etmv3_magic   = 0x3030303030303030ULL;
-static const u64 __perf_cs_etmv4_magic   = 0x4040404040404040ULL;
+#define __perf_cs_etmv3_magic 0x3030303030303030ULL
+#define __perf_cs_etmv4_magic 0x4040404040404040ULL
 #define CS_ETMV3_PRIV_SIZE (CS_ETM_PRIV_MAX * sizeof(u64))
 #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
