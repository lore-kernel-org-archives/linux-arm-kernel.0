Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:01:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5B72086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1BO8Wm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5B72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gGF5W685pMMYuxBrfKlM+d4owd88EL2NZHhePXjAA/s=; b=i1BO8Wm4g0hlgKUnCyAQBFhXmW
	YLtfNHEaq/HAMDDJpkDxErTYNJrgOG9D+PmnrpnrRRrNpoGc6uWvixK6NByZ6BE2Dm4SMqNnEUDnm
	1cCV+uJxhv5dZMipybku20uqGxPVXjptylBlC1xFJHpM37KJ27emsT22yl2ylbWkSgiX9hGd+Po4r
	WaFFFNLTkGziSPGW5lh7fvIzqM5Ml+ckemaNOksfXZSjhSB96LQSpi0Z6sYRJgCXvgQQrulZoxHdv
	JtWBXV2dsVD6M3nrdSks+dA+dUdYoLuT4GuDmD87h3BeF0ej0d7O0m6ruFYFK1MD4qtJY0d7yjNQY
	vUS36IBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWaO-0006bF-H6; Fri, 18 Jan 2019 16:01:36 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWZW-0006PV-Gg
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:00:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E4F41596;
 Fri, 18 Jan 2019 08:00:42 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AACE33F557;
 Fri, 18 Jan 2019 08:00:39 -0800 (PST)
From: Andrew Murray <andrew.murray@arm.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] kconfig.h: abstract empty functions with STUB_UNLESS macro
Date: Fri, 18 Jan 2019 16:00:28 +0000
Message-Id: <1547827230-55132-2-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_080042_555172_4F9DB94C 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: rjw@rjwysocki.net, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Steven Price <Steven.Price@arm.com>, Grant Likely <Grant.Likely@arm.com>,
 Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

A common pattern found in header files is a function declaration dependent
on a CONFIG_ option being enabled, followed by an empty function for when
that option isn't enabled. This can often take up a lot of space and impact
code readability.

Let's introduce the following STUB_UNLESS macro:

STUB_UNLESS(CONFIG_FOO, [body], prototype)

This evaluates to 'prototype' prepended with 'extern' if CONFIG_FOO is set
to 'y'. Otherwise it will evaluate to 'prototype' prepended with 'static
inline' followed by an empty function body. Where optional argument 'body'
then 'body' will be used as the function body, intended to allow for simple
return statements.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/linux/kconfig.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index cc8fa10..216a27f 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -12,6 +12,7 @@
 
 #define __ARG_PLACEHOLDER_1 0,
 #define __take_second_arg(__ignored, val, ...) val
+#define __take_fourth_arg(__ignored, __ignored2, __ignored3, val, ...) val
 
 /*
  * The use of "&&" / "||" is limited in certain expressions.
@@ -70,4 +71,34 @@
  */
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
 
+
+
+/*
+ * Allow for __stub to be overloaded by making the second argument optional
+ */
+#define __stub_overload(...)		__take_fourth_arg(__VA_ARGS__, \
+					__stub_body, __stub_void)(__VA_ARGS__)
+#define __stub_body(option, body, ptype) __stub(option, body, ptype)
+#define __stub_void(option, ptype)	__stub(option, , ptype)
+
+/*
+ * Using the same trick as __defined we use the config option to conditionally
+ * expand to an extern function declaration or a static stub function.
+ */
+#define __stub(option, body, ptype)	___stub( \
+					__ARG_PLACEHOLDER_##option, body, ptype)
+#define ___stub(arg1_or_junk, body, ptype) __take_second_arg( \
+		arg1_or_junk __extern_ptype(ptype), __static_ptype(body, ptype))
+#define __static_ptype(body, ptype)	static inline ptype { body; }
+#define __extern_ptype(ptype)		extern ptype
+
+/*
+ * STUB_UNLESS(CONFIG_FOO, [body], prototype) evaluates to 'prototype' prepended
+ * with 'extern' if CONFIG_FOO is set to 'y'. Otherwise it will evaluate to
+ * 'prototype' prepended with 'static inline' followed by an empty function
+ * body. Where optional argument 'body' is present then 'body' will be used
+ * as the function body, intended to allow for simple return statements.
+ */
+#define STUB_UNLESS(...) __stub_overload(__VA_ARGS__)
+
 #endif /* __LINUX_KCONFIG_H */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
