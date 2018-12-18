Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA4DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129B5218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vt+01/5e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFKnYZ3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129B5218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOXQo1SC7yuivC9FJW90n2ny3PwXj6foZXV/q856zQE=; b=Vt+01/5e6048bc
	acJuFt7J5wb3x++I78I409h/9QukzGpBKx08YJIguH2c4H8DfRIAL7iw3zFISW3Dx3R829V9inIw6
	qqimFYKYyZoDebGuJPNgQFWi5a7vnr1lclOUAZtFpfgRecN38Oz+U4Pj+o92xYnqKME/OsNRGGaJw
	whXyu63vwjwTeTTxRUbzIX8ab5bX+sQwEleezr8MxSnerkbrFBpYdLLHB0mXuqbsV/2cx1l6JQMS8
	sFTzOB/9T8WkGN52TBCikJ2QDOmjWTm8sNY4uKzAH3VsTlT8xojZImce+q1yw/7fI3VNj3iop3n9R
	DFPszSDzN0lKE1U8GVeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNZW-0003db-4H; Tue, 18 Dec 2018 22:10:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNZI-0003Su-Iz
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:10:26 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E462218A2;
 Tue, 18 Dec 2018 22:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545171019;
 bh=dsy2YhwR2nlv+p5/mn/YuJE3yOKcsU29OQ88s+1DFDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fFKnYZ3JN1bjXAUhFB788+4ZJO3vDbmCk519n9yd/4PobrnbVRldeDe0EOPKSTyJx
 MQMHSfpnnr0j5HMxSAtHFSTq0tHJPRKjBTVOFnMT5ZNrZxC5AlqzxtH30xWV0zPJt8
 p885XvKcnP4Mlu5s8qlYzkO4wDojUkgJo3EXl5WA=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 27/63] perf cs-etm: Avoid stale branch samples when flush
 packet
Date: Tue, 18 Dec 2018 19:06:57 -0300
Message-Id: <20181218220733.15839-28-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_141024_725312_E956EB31 
X-CRM114-Status: GOOD (  17.97  )
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
 Clark Williams <williams@redhat.com>, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

At the end of trace buffer handling, function cs_etm__flush() is invoked
to flush any remaining branch stack entries.  As a side effect, it also
generates branch sample, because the 'etmq->packet' doesn't contains any
new coming packet but point to one stale packet after packets swapping,
so it wrongly makes synthesize branch samples with stale packet info.

We could review below detailed flow which causes issue:

  Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
  Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c

  step 1: cs_etm__sample():
	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c

  step 2: flush packet in cs_etm__run_decoder():
	cs_etm__run_decoder()
	  `-> err = cs_etm__flush(etmq, false);
	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0

Packet1 and packet2 are two continuous packets, when packet2 is the new
coming packet, cs_etm__sample() generates branch sample for these two
packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
jump flow, thus we can see the first generated branch sample in step 1.
At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.

If packet2 is the last one packet in trace buffer, even there have no
any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
flush branch stack entries as expected, but it also generates branch
samples by taking 'etm->packet' as a new coming packet, thus the branch
jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
is the second sample which is generated in step 2.  So actually the
second sample is a stale sample and we should not generate it.

This patch introduces a new function cs_etm__end_block(), at the end of
trace block this function is invoked to only flush branch stack entries
and thus can avoid to generate branch sample for stale packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-3-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 789707bc4e9e..ffc4fe5c0b7e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1055,6 +1055,39 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	return err;
 }
 
+static int cs_etm__end_block(struct cs_etm_queue *etmq)
+{
+	int err;
+
+	/*
+	 * It has no new packet coming and 'etmq->packet' contains the stale
+	 * packet which was set at the previous time with packets swapping;
+	 * so skip to generate branch sample to avoid stale packet.
+	 *
+	 * For this case only flush branch stack and generate a last branch
+	 * event for the branches left in the circular buffer at the end of
+	 * the trace.
+	 */
+	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		/*
+		 * Use the address of the end of the last reported execution
+		 * range.
+		 */
+		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
+
+		err = cs_etm__synth_instruction_sample(
+			etmq, addr,
+			etmq->period_instructions);
+		if (err)
+			return err;
+
+		etmq->period_instructions = 0;
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1137,7 +1170,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-			err = cs_etm__flush(etmq);
+			err = cs_etm__end_block(etmq);
 	}
 
 	return err;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
