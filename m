Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CFBC5AE5E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA76720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZLGeqim";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZsfAJvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA76720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=NFQRio4N0/TaQTV4I7YiwyHYz/9D2TUHfqsbt30cP0Y=; b=cZLGeqimT5ST1zobgImBDMUyaI
	x9i3c7Zkk4SG6U1qKNU/yOKUuj+/BxnptvLWQjP7mSwoP7Yw0qL1+yR2o/DvDKhH867E8eEzaf+KP
	5ljgwPGBNLTmaRHPWFqmikfOhy0AdJninpX4Dte9rpw6aqHA/+NgO9zkiQ37db+zrQbNneMxhuzKC
	4HJMEuDnolcHvFmHqg30n+i9uRT5GkeL9s4TAb1JzLApL77wbKW30u3YjcnYXqvqu0MLDPaNa3R6k
	voPQmH9N6zdKiQvT41+rQyatHuxiM70VSAA6r3VCVE6kQ0WsIYnesw/EAtHh26otgkRKtNOAJjDXl
	n3aEQVmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkfhE-000300-V2; Sat, 19 Jan 2019 01:45:16 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkfgL-0001eg-01
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 01:44:23 +0000
Received: by mail-pf1-x443.google.com with SMTP id q1so7435974pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/5nYzCIEonlNYJwustO+jm4nIH/Vxt/bPuViPJ/LH/8=;
 b=EZsfAJvSkY0JpLAG58uwHeVgtm7PsF23KfAEWoyRjoyzJwjDTosNRAdCgkT313oLM8
 bzhOZZyiI66l6s8ZZuOQKuP90WeRlCjou5eGcYsbL1SK/DgAgJaGoXs38uiUKiSz+hia
 OAdOz9gvbXx6g7LU2+WzjLo4aXJBbuWIpgFmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/5nYzCIEonlNYJwustO+jm4nIH/Vxt/bPuViPJ/LH/8=;
 b=Md0xTqd2YEQj+kPcMJFOlQx2F9f5DEAuVf+wPNlxA5ZONkgqle7zkjj9ctijJAhtJm
 3dakLW/ugsMV1X8QAWONqWWI79ZsW4xrha39d/B5NnUlXfdtAnss3G/yOMof4A16mWd7
 rc9PyDUFuzK8IbhUJVWki0CTGy2RsoXZpxgL31zwQOdZMSyJr07vBTdtZTCVWr3sC3wL
 p/1sIdpMMw/ED7ZHcJvhmEKkAm5EF0zqdhRj5HexlFfKWjWCtR2DwYwNU/qaZNNjGaY0
 X1TK1NbuQvqOdBiRn2K+xiZkoCdj8QA/pkKq63ApsXpa9u5rx0N0NcpilDzBR+cX6/7K
 nU+A==
X-Gm-Message-State: AJcUukel7/hL6HUTI9CAgoPueLwyKkeA9KaLQr09mIwvY/aPUwU5M80u
 dH60G+BszxTv5H0uORUbJ3YQAA==
X-Google-Smtp-Source: ALg8bN7utYYHnDkIWUL0WAmsm4uj5ug1y+j9IQg8I7m/UCyn3g3sm+bsxjHulxXc3IgXcz5tLUdVoQ==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr21124099pfi.95.1547862260243; 
 Fri, 18 Jan 2019 17:44:20 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com.
 [50.116.3.24])
 by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 17:44:19 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Robert Walker <robert.walker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Coresight ML <coresight@lists.linaro.org>
Subject: [PATCH v6 4/8] perf cs-etm: Add exception number in exception packet
Date: Sat, 19 Jan 2019 09:43:43 +0800
Message-Id: <20190119014347.27441-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_174421_102675_DABD3AAE 
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
Cc: Leo Yan <leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When an exception packet comes, it contains the information for
exception number; the exception number indicates the exception types,
so from it we can know if the exception is taken for interrupt,
system call or other traps, etc.

This patch simply adds a field in cs_etm_packet struct, it records
exception number for exception packet that will then be used to
properly identify exception types to the perf synthesize mechanic.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e98ee49a1527..294efa76c9e3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
+		decoder->packet_buffer[i].exception_number = UINT32_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
+	decoder->packet_buffer[et].exception_number = UINT32_MAX;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
-{
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+{	int ret = 0;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+	packet->exception_number = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 23600e57a215..012b4728a46f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -46,6 +46,7 @@ struct cs_etm_packet {
 	u32 last_instr_type;
 	u32 last_instr_subtype;
 	u32 flags;
+	u32 exception_number;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
