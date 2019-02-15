Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB332229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HM+aoo7O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8H1QGzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB332229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H+qv+6Ffv3PxWWnyXGbBsFfRiPsN/EkTTMkxgq5qEhw=; b=HM+aoo7OxwZEtI
	YJdDPlV+LEAqITQoI+3II0JtggQpBMfQEQLJnGum37fI5Yat6KD3LDazJIJ7irGkNZ3tLYHa406js
	N66R21G4pVCQdm1g5rehHZNHgyC/GuvblzytSYJPToWIH2JtCR9g7M/nQIhsa2Jniy40hO5/wzC4Y
	2NxoC9YHWJgySsQcTwXocyxUnI2+aEIMRaFIhrnQGi4vaF8dq7wnOOKVbFI7cJv16QPFiIAWeBhsd
	qGjWcphrkGcT6ijktyDjySey6sd0a+fYiiHxYppJGzuuGHOg3cH6xEIDQO4/voivZxmyS+sSBl73x
	bBsvlzAG/LzXqgf5pnMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRft-0005G4-Ca; Fri, 15 Feb 2019 00:48:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfJ-0004al-IR
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:47:46 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8039F2229F;
 Fri, 15 Feb 2019 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191661;
 bh=fbyBVb3RzYOoCKxaDHT5y2hX46bmgahi6LOZy34ChAI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e8H1QGzGRd25kFXby/MbzT65rJrqOkxLv4j3lJaJ6FkqtGWi+BicdKJogzrmHIs2F
 6whSfFhd0YHSt2FJPU5LSX0664waxpwPAoPSehhyAxSDLB62Ld0uebSy97uJ6BPGsT
 76uatpJge5ylizx7yRvdplFK7As6PVOXBXoQFtV0=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 26/43] perf cs-etm: Introducing function
 cs_etm_decoder__init_dparams()
Date: Thu, 14 Feb 2019 21:45:22 -0300
Message-Id: <20190215004539.23571-27-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164741_938383_116AE1D5 
X-CRM114-Status: GOOD (  11.08  )
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

Introducing function cs_etm_decoder__init_dparams() to avoid repeating
code at two different places.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-5-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                      | 41 +++++++++++++------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7e6a8850be4a..663309486784 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -105,9 +105,10 @@ enum {
 	CS_ETM_PROTO_PTM,
 };
 
-enum {
+enum cs_etm_decoder_operation {
 	CS_ETM_OPERATION_PRINT = 1,
 	CS_ETM_OPERATION_DECODE,
+	CS_ETM_OPERATION_MAX,
 };
 
 int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f396fee9bb95..3011c6cae531 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,28 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
+				       struct cs_etm_queue *etmq,
+				       enum cs_etm_decoder_operation mode)
+{
+	int ret = -EINVAL;
+
+	if (!(mode < CS_ETM_OPERATION_MAX))
+		goto out;
+
+	d_params->packet_printer = cs_etm__packet_dump;
+	d_params->operation = mode;
+	d_params->data = etmq;
+	d_params->formatted = true;
+	d_params->fsyncs = false;
+	d_params->hsyncs = false;
+	d_params->frame_aligned = true;
+
+	ret = 0;
+out:
+	return ret;
+}
+
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
@@ -182,12 +204,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_PRINT;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
+	if (cs_etm__init_decoder_params(&d_params, NULL,
+					CS_ETM_OPERATION_PRINT))
+		return;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
@@ -436,13 +455,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_DECODE;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
-	d_params.data = etmq;
+	if (cs_etm__init_decoder_params(&d_params, etmq,
+					CS_ETM_OPERATION_DECODE))
+		goto out_free;
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
