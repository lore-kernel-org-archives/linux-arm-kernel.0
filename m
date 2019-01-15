Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30CEC20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="onvtPvAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CEC20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zsdspuRII//A/+r94EoJv4qwWXcT1ovyUIPHfRngH98=; b=onvtPvAKMjfXdS
	S6kvR5HohXsw6LDXP+81fRFWqtafVHtY4y6mrfLP/ESq5Z2U4tHR12H7pJ0bwxndrNLEkgixhyLnq
	csWU0J7F3rbvNkxzdPSHExzSZjsOETIjdYa4b2Jig06eP7YpPh7fM8qbFdBzySAXySswa1o8v0V38
	q5hLZIa4vko42+aD3gBkVvc1qOxMcSfHdwvuPrrpg+SffWaoA+lcy2BCoqebNqSRa/gGJP/CwFalp
	dLyB+tKpex69GDNnSYKRR4qQh+GX3S155JxrtmnGPAx2lMiuNXY8HuriuE+ebli3B+TZikxyg6l+C
	uMk/1i/sZ/IMbu5X1dBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPCe-0003oY-U8; Tue, 15 Jan 2019 13:56:28 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPCc-0003o0-8B
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:56:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC4C9EBD;
 Tue, 15 Jan 2019 05:56:25 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92123F70D;
 Tue, 15 Jan 2019 05:56:23 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 01/24] kernel: Standardize vdso_datapage
Date: Tue, 15 Jan 2019 13:55:16 +0000
Message-Id: <20190115135539.24762-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115135539.24762-1-vincenzo.frascino@arm.com>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_055626_294811_7F245D0D 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In an effort to unify the common code for managing the vdso library in
between all the architectures that support it, this patch tries to
provide a common format for the vdso datapage.

As a result of this, this patch generalized the data structures in vgtod.h
from x86 private includes to general includes (include/vdso).

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 include/vdso/datapage.h

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..e88678f918e5
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/time.h>
+
+#define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
+			 BIT(CLOCK_MONOTONIC)		| \
+			 BIT(CLOCK_MONOTONIC_RAW)	| \
+			 BIT(CLOCK_BOOTTIME)		| \
+			 BIT(CLOCK_TAI))
+#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
+			 BIT(CLOCK_MONOTONIC_COARSE))
+
+/*
+ * There is one vdso_timestamp object in vvar for each vDSO-accelerated
+ * clock_id. For high-resolution clocks, this encodes the time
+ * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * the actual time.
+ *
+ * To be noticed that nsec is left-shifted by vdso_data.shift.
+ */
+struct vdso_timestamp {
+	u64 sec;
+	u64 nsec;
+};
+
+/*
+ * vdso_data will be accessed by 32 and 64 bit code at the same time
+ * so we should be careful before modifying this structure.
+ */
+struct vdso_data {
+	u32 seq;		/* Timebase sequence counter */
+
+	s32 clock_mode;
+	u64 cycle_last;		/* Timebase at clocksource init */
+	u64 mask;		/* Clocksource mask (mono = raw) */
+	u32 mult;		/* Clocksource multiplier */
+	u32 shift;		/* Clocksource shift (mono = raw) */
+
+	struct vdso_timestamp basetime[VDSO_BASES];
+
+	s32 tz_minuteswest;	/* Timezone definitions */
+	s32 tz_dsttime;
+	u32 use_syscall;
+	u32 __reserved;
+};
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_DATAPAGE_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
