Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4AFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0E9222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BRPeWUeF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvhgmoLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0E9222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fnZF0XWQBVNEz/XdpodgNoMw+28C/os6dzr2iDI193U=; b=BRPeWUeFScnJFM
	PJoqClox1+rNZHA5DTdKDGw6rroUM39YNE5kt8Z1x8p6/6a+tR2UDAC2ylQiV5b+j9xltd9pFbR8F
	o0a/jFcOpwNP1oBp8FaVVfaq3qn7QtEIdxn1RBtzDRuvCmcESWm8FNgbbRu/OeK2FU+glmKClHbyX
	DBnrmBX2+O6OxAT63lEnj5QVwU5VV5HU61olNE9Q75Ffog5zJaPpaOfOn+y9xALufJCAR2znbJsbG
	wl3AoFKZ9AB9pEb4F/GI+Tf0xcelEoU04OeNuAZzQ9CUGQGV6afERnUnBsjltNsTrl5mr8mjOmgTT
	G6IrLbjXJZYmOkLJ8MIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRg3-0005QI-UL; Fri, 15 Feb 2019 00:48:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfN-0004f2-Rk
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:47:51 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CBF36222D0;
 Fri, 15 Feb 2019 00:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191665;
 bh=59/Jn+pGlKT7JzKEMbIhX3CYYQrWCvYqFcJL9XeciIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FvhgmoLipdaH5yxlQDP9ynnnPY0u5qu5F3dhw/fttZ6B/bnoTDQcOyXeBsgKQY/+T
 j2kK7SlFj6CJDvVgYGrHLPBaPfCr8axPhuxoBe9wIGgDmmp9kn/qhc6lfU6Wbwe6yK
 A4yfOZakYbHAn1Ag7SA1DjExUIhCZWi+ZS7lrl88=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 27/43] perf cs-etm: Fix memory leak in error path
Date: Thu, 14 Feb 2019 21:45:23 -0300
Message-Id: <20190215004539.23571-28-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164745_998079_F43F5563 
X-CRM114-Status: GOOD (  12.40  )
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

Memory allocated for variable 't_params' isn't released properly in the
error path of function cs_etm_queue *cs_etm__alloc_queue() and
cs_etm__dump_event(), something this patch addresses.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-6-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3011c6cae531..aac07f950074 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -175,6 +175,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+
+	if (!t_params)
+		return;
+
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
@@ -206,14 +210,12 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
 					CS_ETM_OPERATION_PRINT))
-		return;
+		goto out_free;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!decoder)
-		return;
+		goto out_free;
 	do {
 		size_t consumed;
 
@@ -228,6 +230,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	} while (buffer_used < buffer->size);
 
 	cs_etm_decoder__free(decoder);
+
+out_free:
+	zfree(&t_params);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -379,7 +384,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 {
 	int i;
 	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params;
+	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
 	size_t szp = sizeof(struct cs_etm_packet);
 
@@ -461,8 +466,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!etmq->decoder)
 		goto out_free;
 
@@ -475,6 +478,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 					      cs_etm__mem_access))
 		goto out_free_decoder;
 
+	zfree(&t_params);
+
 	etmq->offset = 0;
 	etmq->period_instructions = 0;
 
@@ -483,6 +488,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
+	zfree(&t_params);
 	zfree(&etmq->event_buf);
 	zfree(&etmq->last_branch);
 	zfree(&etmq->last_branch_rb);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
