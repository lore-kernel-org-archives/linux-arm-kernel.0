Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8014EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:49:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2E321B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTNJP7Hr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e72BZIGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2E321B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SyB/CYTjdJqpsJWqcrUINXB86L0z8qDRMmVP8vFZLOk=; b=iTNJP7HrONJ1K/
	k1pQjkepV05hfPkFeeoLgfybnmrNk5SbPSxPEWmrfl7PyoFPbuo24Eh+rliq4w5wb2V8zYt/GMTaE
	eI1+kXMReSmbnFDPJyQIu67LcSyapIdSwUCKAx1vGxxS6Kq17/snUg8rcnbgnKWJ7s7XJ0dxFatHn
	k4zuWbME+R4VWKfX20y26bitayJSk/klQTbPL/1nIOeQt+hroOPVuOErP4sfi2Sjzn3XYSwv3ucqi
	mXKE7flv860S0iukfuVQRKbh+MacPlec6lHogvZ2ksBJm19n3mJlXQSwtL8r0Nx7dqw52AhmFxKw5
	b13pX9Ri7XvfS0VKJwCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRh9-0006bo-Nb; Fri, 15 Feb 2019 00:49:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfl-0005Ao-TH
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:48:22 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BAD992229F;
 Fri, 15 Feb 2019 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191689;
 bh=affK4b/PCwwi/0OzGgt/0BGbFx9bsHYZODJ1S0APJ6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e72BZIGsRw+tm7wPo8UVjIAc14G4puOItICNlfO+JBrIIKz+VYlvkheEHMLUGIRQJ
 Q40JPAGZP8psQSMM5BNmOIWAJPv7wH3oh8EFCg8vomKWTeeyWGYSMrRkNCRelGzSXZ
 yuY0Bv5UaKkDxcFwo/0sj1XQvG8dtGLpWk5d2/YE=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 32/43] perf cs-etm: Make cs_etm__run_decoder() queue
 independent
Date: Thu, 14 Feb 2019 21:45:28 -0300
Message-Id: <20190215004539.23571-33-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164810_522909_365D354C 
X-CRM114-Status: GOOD (  14.91  )
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

This patch makes decoding of auxtrace buffer centered around a struct
cs_etm_queue.  This eliminates surperflous variables and is a precursor
for work that simplifies the main decoder loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-11-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ---
 tools/perf/util/cs-etm.c                      | 52 +++++++++----------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 663309486784..3ab11dfa92ae 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -15,13 +15,6 @@
 
 struct cs_etm_decoder;
 
-struct cs_etm_buffer {
-	const unsigned char *buf;
-	size_t len;
-	u64 offset;
-	u64 ref_timestamp;
-};
-
 enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d2de898ea68..d2c90b369e7c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -76,6 +76,8 @@ struct cs_etm_queue {
 	size_t last_branch_pos;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
+	const unsigned char *buf;
+	size_t buf_len, buf_used;
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
@@ -683,7 +685,7 @@ static int cs_etm__inject_event(union perf_event *event,
 
 
 static int
-cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
+cs_etm__get_trace(struct cs_etm_queue *etmq)
 {
 	struct auxtrace_buffer *aux_buffer = etmq->buffer;
 	struct auxtrace_buffer *old_buffer = aux_buffer;
@@ -697,7 +699,7 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	if (!aux_buffer) {
 		if (old_buffer)
 			auxtrace_buffer__drop_data(old_buffer);
-		buff->len = 0;
+		etmq->buf_len = 0;
 		return 0;
 	}
 
@@ -717,13 +719,11 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	if (old_buffer)
 		auxtrace_buffer__drop_data(old_buffer);
 
-	buff->offset = aux_buffer->offset;
-	buff->len = aux_buffer->size;
-	buff->buf = aux_buffer->data;
+	etmq->buf_used = 0;
+	etmq->buf_len = aux_buffer->size;
+	etmq->buf = aux_buffer->data;
 
-	buff->ref_timestamp = aux_buffer->reference;
-
-	return buff->len;
+	return etmq->buf_len;
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
@@ -1493,24 +1493,23 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_buffer buffer;
-	size_t buffer_used, processed;
+	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
-		buffer_used = 0;
-		memset(&buffer, 0, sizeof(buffer));
-		err = cs_etm__get_trace(&buffer, etmq);
-		if (err <= 0)
-			return err;
-		/*
-		 * We cannot assume consecutive blocks in the data file are
-		 * contiguous, reset the decoder to force re-sync.
-		 */
-		err = cs_etm_decoder__reset(etmq->decoder);
-		if (err != 0)
-			return err;
+		if (!etmq->buf_len) {
+			err = cs_etm__get_trace(etmq);
+			if (err <= 0)
+				return err;
+			/*
+			 * We cannot assume consecutive blocks in the data file
+			 * are contiguous, reset the decoder to force re-sync.
+			 */
+			err = cs_etm_decoder__reset(etmq->decoder);
+			if (err != 0)
+				return err;
+		}
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
@@ -1518,14 +1517,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			err = cs_etm_decoder__process_data_block(
 				etmq->decoder,
 				etmq->offset,
-				&buffer.buf[buffer_used],
-				buffer.len - buffer_used,
+				&etmq->buf[etmq->buf_used],
+				etmq->buf_len,
 				&processed);
 			if (err)
 				return err;
 
 			etmq->offset += processed;
-			buffer_used += processed;
+			etmq->buf_used += processed;
+			etmq->buf_len -= processed;
 
 			/* Process each packet in this chunk */
 			while (1) {
@@ -1585,7 +1585,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					break;
 				}
 			}
-		} while (buffer.len > buffer_used);
+		} while (etmq->buf_len);
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
