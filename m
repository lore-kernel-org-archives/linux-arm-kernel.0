Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8787AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6EE2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mHSXXSK5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEZ9c/YO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6EE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXRmlR7inaGniB+zezH+SxeKpuWzvZkxXHLNWkx68nk=; b=mHSXXSK5D2Lhwx
	2GYX73Ml4o/NI8DheGg53amPoM0TuBA7b4IJFP8mTlaiXCmBlRyQ9LE8iOIo5I45I/YPiHHErplIE
	Y93ShslyIzSZXBaC9jmZto+ugwwQ06yF9NUrbxM753+bFRMpfH/c+FdRZDTdQ+Aap6H+V50I7hikJ
	V/SC34uzhmr7kYIaVHBTMMCreFSR7hfnqCiRQki9PiwFxsCywTrHCG0ozDHhUtrp6YjoOr6yH8aF1
	L3PozffVqHEYKmcYHiE4KN7cs6HrITA6ZFsllzuPaIdZjTB0tr+PygNDipYMXbygjrJ5nWKsEvCZM
	/G/PhYIKaQGc7gDqch0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grSL9-00008g-TO; Wed, 06 Feb 2019 18:54:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grSIB-0005lv-BL
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:52:11 +0000
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 983A2218D9;
 Wed,  6 Feb 2019 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549479086;
 bh=XhtmITiRFeYN57RPQnAu2Cbh3Wk96kMmWOimwywIUQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qEZ9c/YOOgb+s4ktXIoxQVSYdzVVUg8n0+fI3g74z004Hu+odAvoGBRPZmVOh13hv
 81tTQZ5O19GaBmnIhx5lVCG+MRkGPqbRuZLCFY8Ea5le70PQ1m1fMfaC9NkPJhhPZw
 93hWKwpX1u3esxBaBAwf1sWHutjRxxkg0HctM+Cw=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 40/53] perf cs-etm: Change tuple from traceID-CPU# to
 traceID-metadata
Date: Wed,  6 Feb 2019 15:48:50 -0300
Message-Id: <20190206184903.24054-41-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_105128_144450_BA1C4ECC 
X-CRM114-Status: GOOD (  17.10  )
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
 Clark Williams <williams@redhat.com>,
 coresight ml <coresight@lists.linaro.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

If packet processing wants to know the packet is bound with which ETM
version, it needs to access metadata to decide that based on metadata
magic number; but we cannot simply to use CPU logic ID number as index
to access metadata sequential array, especially when system have
hotplugged off CPUs, the metadata array are only allocated for online
CPUs but not offline CPUs, so the CPU logic number doesn't match with
its index in the array.

This patch is to change tuple from traceID-CPU# to traceID-metadata,
thus it can use the tuple to retrieve metadata pointer according to
traceID.

For safe accessing metadata fields, this patch provides helper function
cs_etm__get_cpu() which is used to return CPU number according to
traceID; cs_etm_decoder__buffer_packet() is the first consumer for this
helper function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-6-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  8 +++---
 tools/perf/util/cs-etm.c                      | 26 ++++++++++++++-----
 tools/perf/util/cs-etm.h                      |  9 ++++++-
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 294efa76c9e3..cdd38ffd10d2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -305,14 +305,12 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 			      enum cs_etm_sample_type sample_type)
 {
 	u32 et = 0;
-	struct int_node *inode = NULL;
+	int cpu;
 
 	if (decoder->packet_count >= MAX_BUFFER - 1)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	/* Search the RB tree for the cpu associated with this traceID */
-	inode = intlist__find(traceid_list, trace_chan_id);
-	if (!inode)
+	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	et = decoder->tail;
@@ -322,7 +320,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 
 	decoder->packet_buffer[et].sample_type = sample_type;
 	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
+	decoder->packet_buffer[et].cpu = cpu;
 	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
 	decoder->packet_buffer[et].instr_count = 0;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1aa29633ce77..a5497a761db7 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -97,6 +97,20 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
+int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
+{
+	struct int_node *inode;
+	u64 *metadata;
+
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return -EINVAL;
+
+	metadata = inode->priv;
+	*cpu = (int)metadata[CS_ETM_CPU];
+	return 0;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -252,7 +266,7 @@ static void cs_etm__free(struct perf_session *session)
 	cs_etm__free_events(session);
 	session->auxtrace = NULL;
 
-	/* First remove all traceID/CPU# nodes for the RB tree */
+	/* First remove all traceID/metadata nodes for the RB tree */
 	intlist__for_each_entry_safe(inode, tmp, traceid_list)
 		intlist__remove(traceid_list, inode);
 	/* Then the RB tree itself */
@@ -1519,9 +1533,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				    0xffffffff);
 
 	/*
-	 * Create an RB tree for traceID-CPU# tuple. Since the conversion has
-	 * to be made for each packet that gets decoded, optimizing access in
-	 * anything other than a sequential array is worth doing.
+	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
+	 * has to be made for each packet that gets decoded, optimizing access
+	 * in anything other than a sequential array is worth doing.
 	 */
 	traceid_list = intlist__new(NULL);
 	if (!traceid_list) {
@@ -1587,8 +1601,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 			err = -EINVAL;
 			goto err_free_metadata;
 		}
-		/* All good, associate the traceID with the CPU# */
-		inode->priv = &metadata[j][CS_ETM_CPU];
+		/* All good, associate the traceID with the metadata pointer */
+		inode->priv = metadata[j];
 	}
 
 	/*
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 37f8d48179ca..fb5fc6538b7f 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -53,7 +53,7 @@ enum {
 	CS_ETMV4_PRIV_MAX,
 };
 
-/* RB tree for quick conversion between traceID and CPUs */
+/* RB tree for quick conversion between traceID and metadata pointers */
 struct intlist *traceid_list;
 
 #define KiB(x) ((x) * 1024)
@@ -69,6 +69,7 @@ static const u64 __perf_cs_etmv4_magic   = 0x4040404040404040ULL;
 #ifdef HAVE_CSTRACE_SUPPORT
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
+int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
 #else
 static inline int
 cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
@@ -76,6 +77,12 @@ cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
 {
 	return -1;
 }
+
+static inline int cs_etm__get_cpu(u8 trace_chan_id __maybe_unused,
+				  int *cpu __maybe_unused)
+{
+	return -1;
+}
 #endif
 
 #endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
