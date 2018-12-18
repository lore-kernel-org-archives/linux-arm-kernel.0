Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25868C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:11:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2366218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Paofax39";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owzfmzw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2366218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yni2vU1GbVQP+uFqCkt73HRqRu5I1swpUNvGDp2nkKY=; b=Paofax39wwCaUY
	DyIPIcTRRvDAx53dukPIGTSA69vrB+D+cRYLP764nQb98sCKKQVAELzkwyoOnHF9zVXkFkGf4srVr
	ayMGQ4mrl6Cxg50Lye4mF7NHNI8B0WFAxExswvojm0hqZ1CjNV9v4Hwboa3MOmOba4gITKjQP/17P
	outtdX8008UmGVA6cbEm9/ZKGwkn5UW4XePxz6At4PTSSsPKGGZf5vCv+dYsIIvs7eQqxRvZWf8ie
	BdzgiGrhB24wq3IJBIIkUWbmJaoVaEaoDziAP6bNRiBFc0oEAFCvSQQL6T4vz4wnKdIFHmwWrsaoh
	yLluFe7/RYgsLAeby+dA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNZp-0003yg-8s; Tue, 18 Dec 2018 22:10:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNZY-0003cu-MI
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:10:47 +0000
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A577218A2;
 Tue, 18 Dec 2018 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545171036;
 bh=SqmRLABnXNmbqu4cRZLHpt48Y33TI7BUDq8tMlrlags=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Owzfmzw1OqM47NqixnWgc+qsT0AnMzzXFjRi9+n1rKID8+SMcTf6EbWqu4XlB3g10
 sgF3NW8dpgnRRlRDSGGZHJLKsqG51MJC3BufYPoScnHE+978Cdj5ct1gotJSi+ov3V
 qmHlMJL9REwLeo3aCxkBf4OmErMSP2yoJdlMwgFY=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 29/63] perf cs-etm: Refactor enumeration cs_etm_sample_type
Date: Tue, 18 Dec 2018 19:06:59 -0300
Message-Id: <20181218220733.15839-30-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_141042_375729_4C2C5A08 
X-CRM114-Status: GOOD (  10.58  )
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

The values in enumeration cs_etm_sample_type are defined with setting
bit N for each packet type, this is not suggested in the usual case.

This patch refactor cs_etm_sample_type by converting from bit shifting
values to continuous numbers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-5-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index b295dd2b8292..3819a04a2c27 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,9 +23,9 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
-	CS_ETM_EMPTY = 0,
-	CS_ETM_RANGE = 1 << 0,
-	CS_ETM_TRACE_ON = 1 << 1,
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
+	CS_ETM_TRACE_ON,
 };
 
 enum cs_etm_isa {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
