Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E2FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9660921B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mQuIGxY5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDWsvz9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660921B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kpatllz4g4h56I1rDKDmIL7XwTe8nMb+K0aVNuFHeJ4=; b=mQuIGxY5mFIfA6
	khL+xz9/mHtHYNX3avqhCBeGLDn43Yeion5jy0tuBBaYhhmD5y+zSXPLUWMEIkL6kjUpNpLd4MqJa
	g/w/F2kYZBJLg5Xr3dKkoriM+csuDGj8KCsUJ6b38znfurdHF3iazZN3VQnf0uTGD7kTtG5bA6n4E
	JvzRV9cc8kbL9q58Dp95Bl7ofRMjSsg1zO+hjzCFXZ6hcLki+O98sg/a1O+kxJHj8WqnYEv9CoDmA
	0Wtv52HBSb51/UQcrD6vVnoeTaBu2/5QYSUPRvK5X1pN6qC4UhRtxNXDX4oF4CjUONBITdnRZZiWi
	480Od6p6TsW9uJLTHuNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRhV-00075f-9k; Fri, 15 Feb 2019 00:49:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRfw-0005Ip-8o
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:48:43 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BEDC21B68;
 Fri, 15 Feb 2019 00:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191699;
 bh=uluH9qSfxO6EQEq/VO78WgaeQTFAb4ZY5Ks+LwjnaMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FDWsvz9feKOzTn+FMPbyrODlbK8NOBPudaX396ldiJbDkBmE5QBGdHb4joUgl6YV7
 1U6Ayk2cglka4/1CMgFR9I0m723lXzR5TQYEvxJrXWYsYPyrMhJE2vtHdvOuhRj+dr
 pmRMnWXYiTA0Lz4gmjs70maH0eC7NofU319p+t3I=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 34/43] perf cs-etm: Modularize main packet processing loop
Date: Thu, 14 Feb 2019 21:45:30 -0300
Message-Id: <20190215004539.23571-35-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164820_717680_077E6E68 
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

Making the main packet processing loop modular so that it can be called
from different decoding context (timeless vs. non-timless), avoiding to
repeat code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-13-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 129 ++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cfa686fe223e..f607bc58bd03 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1519,6 +1519,72 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	return ret;
 }
 
+static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+		/* Process each packet in this chunk */
+		while (1) {
+			ret = cs_etm_decoder__get_packet(etmq->decoder,
+							 etmq->packet);
+			if (ret <= 0)
+				/*
+				 * Stop processing this chunk on
+				 * end of data or error
+				 */
+				break;
+
+			/*
+			 * Since packet addresses are swapped in packet
+			 * handling within below switch() statements,
+			 * thus setting sample flags must be called
+			 * prior to switch() statement to use address
+			 * information before packets swapping.
+			 */
+			ret = cs_etm__set_sample_flags(etmq);
+			if (ret < 0)
+				break;
+
+			switch (etmq->packet->sample_type) {
+			case CS_ETM_RANGE:
+				/*
+				 * If the packet contains an instruction
+				 * range, generate instruction sequence
+				 * events.
+				 */
+				cs_etm__sample(etmq);
+				break;
+			case CS_ETM_EXCEPTION:
+			case CS_ETM_EXCEPTION_RET:
+				/*
+				 * If the exception packet is coming,
+				 * make sure the previous instruction
+				 * range packet to be handled properly.
+				 */
+				cs_etm__exception(etmq);
+				break;
+			case CS_ETM_DISCONTINUITY:
+				/*
+				 * Discontinuity in trace, flush
+				 * previous branch stack
+				 */
+				cs_etm__flush(etmq);
+				break;
+			case CS_ETM_EMPTY:
+				/*
+				 * Should not receive empty packet,
+				 * report error.
+				 */
+				pr_err("CS ETM Trace: empty packet\n");
+				return -EINVAL;
+			default:
+				break;
+			}
+		}
+
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1544,64 +1610,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			if (err)
 				return err;
 
-			/* Process each packet in this chunk */
-			while (1) {
-				err = cs_etm_decoder__get_packet(etmq->decoder,
-								 etmq->packet);
-				if (err <= 0)
-					/*
-					 * Stop processing this chunk on
-					 * end of data or error
-					 */
-					break;
+			/*
+			 * Process each packet in this chunk, nothing to do if
+			 * an error occurs other than hoping the next one will
+			 * be better.
+			 */
+			err = cs_etm__process_decoder_queue(etmq);
 
-				/*
-				 * Since packet addresses are swapped in packet
-				 * handling within below switch() statements,
-				 * thus setting sample flags must be called
-				 * prior to switch() statement to use address
-				 * information before packets swapping.
-				 */
-				err = cs_etm__set_sample_flags(etmq);
-				if (err < 0)
-					break;
-
-				switch (etmq->packet->sample_type) {
-				case CS_ETM_RANGE:
-					/*
-					 * If the packet contains an instruction
-					 * range, generate instruction sequence
-					 * events.
-					 */
-					cs_etm__sample(etmq);
-					break;
-				case CS_ETM_EXCEPTION:
-				case CS_ETM_EXCEPTION_RET:
-					/*
-					 * If the exception packet is coming,
-					 * make sure the previous instruction
-					 * range packet to be handled properly.
-					 */
-					cs_etm__exception(etmq);
-					break;
-				case CS_ETM_DISCONTINUITY:
-					/*
-					 * Discontinuity in trace, flush
-					 * previous branch stack
-					 */
-					cs_etm__flush(etmq);
-					break;
-				case CS_ETM_EMPTY:
-					/*
-					 * Should not receive empty packet,
-					 * report error.
-					 */
-					pr_err("CS ETM Trace: empty packet\n");
-					return -EINVAL;
-				default:
-					break;
-				}
-			}
 		} while (etmq->buf_len);
 
 		if (err == 0)
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
