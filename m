Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C29C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD61208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PHTGWHIo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Hg8r6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD61208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TocJbc9CwBF0EFkoWkozyFsp7fVpmUGcL7aaOn2jw3s=; b=PHTGWHIofvjYvP
	4cjR8RV5HXWjzFPb0DZtfcyDDYQIlDNHimNPmbJK9Aq9QVSAe7apNGqpLPDAwHWjQmCTptJSYNUhV
	VeulNNCuMiDZIMkyx1wMTMenHsAiJX4rPY2zPZPat3BW/iGoXJZ7MRdIDHgZf/rYP1QoB3EMFQyqC
	yVKMp7SZOzbiMeWYWRssSbUC2XINoWxfbvHc8YJLV30hcaNYJphJyFVeAGnluu2Ouygcn6WRgBoyP
	4Zmk8Xrr6upfUpB6VjMsgsvtPmr6lWSb/FrPVZF23dHq2t9Yo0P9NC33jD0SlrYUY5b0e69ItPb4w
	jsapk+fACAkAG8E9+8eQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1ED-0005L2-H2; Thu, 06 Dec 2018 21:30:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1E1-0005BW-5t
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:30:27 +0000
Received: from quaco.ghostprotocols.net
 (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7BC342082B;
 Thu,  6 Dec 2018 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544131819;
 bh=AIgtURRIhEtOHGMPeP9Ir9TKedr2M3hpVEkium/Fg/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q6Hg8r6VTSfoLnBybixm90UGNO4cVzUJ7BVfM4ph3qucuwDpmQzuHDr7ARfgdF0wc
 mNpslVs/nHanGa3vC5s1qUm4Hcs4ua+RZo9eXE8OjN4J9yqZMRC4/xSdVX3nFmL9E3
 9RcmUqN2Y4SnfEUTKpXWyJ6cNRN8tA/+xENFlLmg=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 58/75] perf cs-etm: Add support for ETMv3 trace decoding
Date: Thu,  6 Dec 2018 18:25:45 -0300
Message-Id: <20181206212602.20474-59-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_133025_261471_38A9AA52 
X-CRM114-Status: GOOD (  10.25  )
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
 Clark Williams <williams@redhat.com>, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Add support for the creation of packet printer and decoder for the ETMv3
trace architecture.  That way traces generated by tracers adhering to
that trace protocol can be handled properly by the perf infrastructure.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1543955944-10042-3-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 5efb616bd609..952d1f43f3fa 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -116,6 +116,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
 	return 1;
 }
 
+static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
+					    ocsd_etmv3_cfg *config)
+{
+	config->reg_idr = params->etmv3.reg_idr;
+	config->reg_ctrl = params->etmv3.reg_ctrl;
+	config->reg_ccer = params->etmv3.reg_ccer;
+	config->reg_trc_id = params->etmv3.reg_trc_id;
+	config->arch_ver = ARCH_V7;
+	config->core_prof = profile_CortexA;
+
+	return 0;
+}
+
 static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 					     ocsd_etmv4_cfg *config)
 {
@@ -237,10 +250,16 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 					  struct cs_etm_decoder *decoder)
 {
 	const char *decoder_name;
+	ocsd_etmv3_cfg config_etmv3;
 	ocsd_etmv4_cfg trace_config_etmv4;
 	void *trace_config;
 
 	switch (t_params->protocol) {
+	case CS_ETM_PROTO_ETMV3:
+		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
+		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		trace_config = &config_etmv3;
+		break;
 	case CS_ETM_PROTO_ETMV4i:
 		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
 		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
@@ -427,11 +446,17 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 					struct cs_etm_decoder *decoder)
 {
 	const char *decoder_name;
+	ocsd_etmv3_cfg config_etmv3;
 	ocsd_etmv4_cfg trace_config_etmv4;
 	void *trace_config;
 	u8 csid;
 
 	switch (t_params->protocol) {
+	case CS_ETM_PROTO_ETMV3:
+		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
+		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		trace_config = &config_etmv3;
+		break;
 	case CS_ETM_PROTO_ETMV4i:
 		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
 		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
