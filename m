Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C569C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2981A2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lTH0QKw3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2EfoCCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2981A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=VGYxG/XnVhhMvBZH6vvK+XfCW2pcz/OMHGltzZ29xT0=; b=lTH
	0QKw34UHC08MXCEdUC87QVhOg9IxoPMSZj8c1fFFqJcZnXGdoz0EFLC0zbUlBwIbQnqVi6OnkvtcJ
	WEaQEGNK+l/S47zoIi15Yd0b7BSL8QmDN337ElPb1SAPadR2t8MmfyTqe4haHQWH2SMNOBUk/L4th
	hQSRVfxfkz8/JDFRB8ULxhyux0DrBO0Wg+yRVkEBB39J/phdvpIq5ZVvDCBh2iHyLu3+Fh7HrhTrB
	snhMQZ3W0gikaXLzbDXmwrKdLTyoZ6u+Cn50QTC4SKaQ7rXW1m5YE5w5iM3BVZR0oSc3dXJyG/Zv+
	UqXKIPNeappTNjhjO7/5SqOYAGQD60A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHJl-0007oy-OT; Mon, 10 Dec 2018 08:53:33 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHJi-0007n5-B5
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 08:53:32 +0000
Received: by mail-wr1-x441.google.com with SMTP id j10so9559291wru.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=RhEccwMmtKbXni8WbCuC9MbU3ATtmsHEMgXp+M5cHn4=;
 b=k2EfoCCtoFQYVyLkCyTr/cgGYJ6VG6uJxyLicesF9OiSZTkOpWQ9j/3g7JWAfjgo81
 F0vCCvVfUryNVdqFjFquN7AhOKy1eGmrA9uCXlsI7I1NZ0aoDUh0SJORtrtF2NsCpX74
 VwCCXZbPEdw/xXZWISF3wyB/Oq/qsJ1/O/MV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RhEccwMmtKbXni8WbCuC9MbU3ATtmsHEMgXp+M5cHn4=;
 b=lRVsxLtxN506ZOnJGl9sQn7JKzU6asLRh23dh4pTcn3hEYS8WfYXQ/6dLbD4Yu25m8
 5mGkRTukE8H4bUf5IpJsGwebfhkmfaHlWgOBYGaWZ2Rt5F7siFddzLzSY43G19itrRVe
 BS1XnfTrZ30W1kZE3Dp9FzvkbA63273HsFIadHwZomoHTVdWvV6fHEDVZOHcpWOQaYlC
 yYu0JDVtoffxgcyKKWiKPh5wdOr2RFDDLD9yLBGOyDH3QxrxFtn8V9pOXNnm6+c2B8PG
 DLr+SPIgthz++bmpXVuijiiQyytnTMH5pZ3uWdiQSyaJjR5F+Yzi+BK5sVZ0ybg1n6QH
 kHKQ==
X-Gm-Message-State: AA+aEWatZ3hdxhoUzmWQgFylVDjFNWy2xnVXWT5UBlM4opXqg/YusSVP
 9Ck7sMJZ7mIeZsp7na7WlvW90Q==
X-Google-Smtp-Source: AFSGD/VCjboe0d+yOjjsW9h9Lv0AQhytmN5DOMp9jJoPhw+QGsX3xLQxfAW+w4I47E2Fcngyod9ulw==
X-Received: by 2002:a05:6000:14f:: with SMTP id
 r15mr9732610wrx.53.1544431998293; 
 Mon, 10 Dec 2018 00:53:18 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 00:53:17 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v2 0/6] perf cs-etm: Correct packets handling
Date: Mon, 10 Dec 2018 16:52:55 +0800
Message-Id: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_005330_380810_F5E32524 
X-CRM114-Status: GOOD (  12.52  )
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

perf cs-etm module converts decoder elements to packets and then we have
more context crossing packets to generate synthenize samples, finally
perf tool can faciliate samples for statistics and report the results.

This patch series is to address several issues found related with
packets handling and samples generation when worked firstly on branch
sample flags support for Arm CoreSight trace data, so this patch series
is dependency for sample flags setting, will send another dedicated
patch series for sample flags later.

In this patch series, the first two patches are mainly to fix issues in
cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
and this can fix the wrong branch sample caused by the missed packets
swapping; patch 0002 is to fix the wrong samples generation with stale
packets at the end of trace block.

Patch 0003 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
a more general packet type to present trace discontinuity, so it can be
used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
elements.

Patch 0004 is used to support NO_SYNC packet, otherwise the trace
decoding cannot reflect the tracing discontinuity caused by NO_SYNC
packet.

Patch 0005 is used to support EO_TRACE packet, which also introduces
the tracing discontinuity at the end of trace and we should save last
trace data for it.

Patch 0006 is used to generate branch sample for exception packets.

This patch series is applied on the acme's perf/core branch [1] with
latest commit 4085fed6373f ("perf trace: Add ordered processing");
Since Rob's patch 'perf: Support for Arm A32/T32 instruction sets in
CoreSight trace' has been merged into perf/core branch, this patch
series can directly be applied onto perf/core branch.

With applying the dependency patch, this patch series has been tested
for branch samples dumping with below command on Juno board:

  # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Changes from v1:
* Synced the consistent code in patch 0001 for condition checking.
* Introduced new function cs_etm__end_block() for flushing packet
  at the end of trace block.
* Added new patch 0003 to rename CS_ETM_TRACE_ON to
  CS_ETM_DISCONTINUITY.
* Used the same one packet type CS_ETM_DISCONTINUITY for all
  trace discontinuity (include support TRACE_ON/EO_TRACE/NO_SYNC
  packets).
* Removed tracking exception number patch, which will be added in
  sample flag patch series.


Leo Yan (6):
  perf cs-etm: Correct packets swapping in cs_etm__flush()
  perf cs-etm: Avoid stale branch samples when flush packet
  perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
  perf cs-etm: Treat NO_SYNC element as trace discontinuity
  perf cs-etm: Treat EO_TRACE element as trace discontinuity
  perf cs-etm: Generate branch sample for exception packet

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 40 +++++++++----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++--
 tools/perf/util/cs-etm.c                        | 77 ++++++++++++++++++++++---
 3 files changed, 102 insertions(+), 25 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
