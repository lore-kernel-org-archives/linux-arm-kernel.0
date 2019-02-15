Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EF0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:50:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1E521B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dB0sj7d6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xwhLmUcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1E521B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mm3RFOnP6ZTFCGZZ8yZjW1S7c8C5wR1bD88yX/wXHJw=; b=dB0sj7d6n/4Tok
	+jnu4oJbQ+elhnUAdGgt6e+bZWhkpQSrBtxb/xyzG0ucf+ArI2G8HqYHg5JRftExXbLGvaIPxpbBZ
	kvs5omXmtyjCbqgT+x+y0sELnZjnJe0qpZFadQA/CPFKAWjctf9Rvam7ZhBS1u1nI4luaQzPugNuX
	f6cH1LcnIvU27+J3F2VhT8OKDn9lwYECSdIebmltBXFJfhABwBGdtNfDKtl9iWDrzdnWGbVRmLLVA
	vo9droH9XfhvtLhWbtyKBf/yS5C6U1fhazlPuoHn3yuKUqG6uWLBKQsRV0FmKmfDNq2zDUnBmqpHC
	E68nAy/pEiD8G9mry4tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRhq-0008AF-K1; Fri, 15 Feb 2019 00:50:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRg0-0005OA-JR
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:48:56 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8511A222A1;
 Fri, 15 Feb 2019 00:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191704;
 bh=6LdzrCVx8YqnpmPcRdemWeu0Aj6Lfc4MEov3VXtbxS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xwhLmUcpYFD23RrowCfeVr66BAmigTql/10xm+6AD7Rlx3E6d1mVK/YeawQok3boj
 t273uf9QOKK/WSVN8POqfY3zGjBbZ0V4LzsK7GOnzQ6FfaywWj5XeKYvEjNpKY+d3l
 tV7FUVmi7LbcxGHNtYUSzIfSrXcwxe6ICFJQioFI=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 35/43] perf cs-etm: Modularize auxtrace_buffer fetch function
Date: Thu, 14 Feb 2019 21:45:31 -0300
Message-Id: <20190215004539.23571-36-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164825_318649_264979E4 
X-CRM114-Status: GOOD (  14.71  )
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

Making the auxtrace_buffer fetch function modular so that it can be
called from different decoding context (timeless vs. non-timeless),
avoiding to repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-14-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f607bc58bd03..110804936fc3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1152,6 +1152,32 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 
 	return 0;
 }
+/*
+ * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
+ *			   if need be.
+ * Returns:	< 0	if error
+ *		= 0	if no more auxtrace_buffer to read
+ *		> 0	if the current buffer isn't empty yet
+ */
+static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+	if (!etmq->buf_len) {
+		ret = cs_etm__get_trace(etmq);
+		if (ret <= 0)
+			return ret;
+		/*
+		 * We cannot assume consecutive blocks in the data file
+		 * are contiguous, reset the decoder to force re-sync.
+		 */
+		ret = cs_etm_decoder__reset(etmq->decoder);
+		if (ret)
+			return ret;
+	}
+
+	return etmq->buf_len;
+}
 
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 				 struct cs_etm_packet *packet,
@@ -1591,18 +1617,9 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
-		if (!etmq->buf_len) {
-			err = cs_etm__get_trace(etmq);
-			if (err <= 0)
-				return err;
-			/*
-			 * We cannot assume consecutive blocks in the data file
-			 * are contiguous, reset the decoder to force re-sync.
-			 */
-			err = cs_etm_decoder__reset(etmq->decoder);
-			if (err != 0)
-				return err;
-		}
+		err = cs_etm__get_data_block(etmq);
+		if (err <= 0)
+			return err;
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
