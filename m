Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDC7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DF420665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o6f6Shms";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9tKqR5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DF420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o6LFHn0drHzT2zcrzt8DS9dJenMf2Rj742WXZobkuPM=; b=o6f6ShmsgzG7oa
	vTCJ3fRjE4gAKO/EKLRkZ9VRde6L4N8qZD1ciyAFQDmXEnQx0fZ4Ue6gRuCR+NKBgGTqGd1z77csh
	hSscB0oUkcWsOkB3ndaPvVj3fANGTnIx8PPjw0B2HLcm1yUe/HVCYob6iZAVKTf6VNRWIrXpJaIMV
	yepTlAPcIU/vCgmbM9zT/4xGq36GKZ4FUpAqmWZGjJgpqlWtzr/cUEDDFaSHTuhUnodYPhr4uDax+
	fqhihu6a7Gya+jL+RwQMmDA7srGedbOZyrQVKp5hFTDvgewvF2Sx3UGDz/NSDYUkF0q6V/3B8b713
	IsGdeyDv7lx2fepSNv2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggx3o-00079M-5U; Tue, 08 Jan 2019 19:29:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggx3k-00078w-80
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 19:29:09 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BFE64217D9;
 Tue,  8 Jan 2019 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546975747;
 bh=/eMAqon4sbmlcoffqcqn6Vd+qXRrh/+GdEtfmQfROh0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j9tKqR5EBFr1xGE7iLKNH+LXKVszxYiP2ifk1ltczLsj3qDJCKIdJDkS1pbmkZzxd
 TsC7tBz31yoPeIZ4qEUedIXoHh2PnR2/hoIWiUnmCk9bRWKGHlxvMhBdAm7Hcf35Dw
 Oa4jS1ozQZnbDFQQLC0hJySwCmM5/o94c2Ts14zo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 093/117] perf cs-etm: Correct packets swapping in
 cs_etm__flush()
Date: Tue,  8 Jan 2019 14:26:01 -0500
Message-Id: <20190108192628.121270-93-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_112908_298935_40C7170C 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Sasha Levin <sashal@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Leo Yan <leo.yan@linaro.org>, Namhyung Kim <namhyung@kernel.org>,
 Robert Walker <robert.walker@arm.com>, Jiri Olsa <jolsa@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 43fd56669c28cd354e9228bdb58e4bca1c1a8b66 ]

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not swap
packets if without option '--itrace=il' to generate last branch entries;
thus for this case the 'prev_packet' doesn't point to the correct
previous packet and the stale packet still will be used to generate
sequential sample.  Thus if dump trace with 'perf script' command we can
see the incorrect flow with the stale packet's address info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so can
save correct content to 'prev_packet'.  Finally this can fix the wrong
program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 73430b73570d..c2f0c92623f0 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1005,7 +1005,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
