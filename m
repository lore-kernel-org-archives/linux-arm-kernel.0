Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52207C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:42:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2139C217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hZJFkdUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2139C217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BtGQETzQ0yTuvipR3TrfHFayX5TLrREvFAOqf/p6nJc=; b=hZJFkdUkzlRf8J
	C2+kQpxnA9VSm0hP8yU5F89HwjMdaQrrc/ubSau+GeGe1IQrt19g6KKp4E9rfXN1EewadPRSo2gtP
	kosU9Luir0FXS4/m0K3bUdYd3l9I6x8dcfgrtM08NStDTbLtR/p5foeA06AKrhAjmomqhxH5/B7ND
	okNEN68YsBp1c8LSmnlDNaPX8wg+P6f5f3WaeyOmIp52/vB/f9JOkEWMCMsQgJGPE3zN+3iZdFD7v
	Ujq/C/jHxqKFYM3f4jT7OlFnZ3N3IerO1jaRubPH44+MOvAHObjmauDQCQ2a7fAMK2mJcUje8ZsrJ
	sMGDC1V8yU8y8yox99bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWSE-00012h-Ty; Tue, 12 Feb 2019 11:42:22 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWSA-00010i-Cw; Tue, 12 Feb 2019 11:42:19 +0000
X-UUID: 57ae352bf6664662b5ed2e2d71aaf744-20190212
X-UUID: 57ae352bf6664662b5ed2e2d71aaf744-20190212
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <mars.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1374599261; Tue, 12 Feb 2019 03:42:16 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 03:42:14 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 19:42:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 12 Feb 2019 19:42:00 +0800
From: Mars Cheng <mars.cheng@mediatek.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/1] tracing: Fix event_trace_printk loss on printk_format.
Date: Tue, 12 Feb 2019 19:41:57 +0800
Message-ID: <1549971717-4693-1-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 06594692839B4E64C47D721B1963D00E961641334FFE7C874C63EAD4120692B22000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_034218_449525_85E8CC6D 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Andress Kuo <andress.kuo@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
 linux-kernel@vger.kernel.org, Mars Cheng <mars.cheng@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Andress Kuo <andress.kuo@mediatek.com>

If fmt on event_trace_printk is not a constant, It means that something not
guaranteed, so the compiler optimizes the fmt out, and then the
__trace_printk_fmt section is not filled. if __trace_printk_fmt is not
filled, the kernel will not allocate the special buffers needed for the
event_trace_printk() and then not shown in the file output
sys/kernel/debug/tracing/print_formats.

Adding a "__used" to the variable in the __trace_printk_fmt section on
event_trace_printk() will keep it around, even though it is set to NULL.
This will keep the string from being printed in the
sys/kernel/debug/tracing/printk_formats section.

We can also refer to commit 3debb0a9ddb1 ("tracing: Fix trace_printk()
to print when not using bprintk()")that it had similar issue on path of
trace_printk().

Signed-off-by: Andress Kuo <andress.kuo@mediatek.com>
Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 include/linux/trace_events.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731..26bd7c4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -551,7 +551,7 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 	__trace_printk_check_format(fmt, ##args);			\
 	tracing_record_cmdline(current);				\
 	if (__builtin_constant_p(fmt)) {				\
-		static const char *trace_printk_fmt			\
+		static const char *trace_printk_fmt __used		\
 		  __attribute__((section("__trace_printk_fmt"))) =	\
 			__builtin_constant_p(fmt) ? fmt : NULL;		\
 									\
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
