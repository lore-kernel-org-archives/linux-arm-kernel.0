Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D24E20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHcqJRyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D24E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rXlhwwffiycaumdquhrOt66iR2+YwSwxwbA8CaPpALk=; b=eHcqJRyqzD9mp4oVunQf9fFAGV
	YEUTB3u/ByO+A9hVhMzS/YwZrOVlimo9gdvMcx+M4QgHfqQ5XSip44vpLgKlUbvplmSn9HNT75IRD
	SS4n/ltMLj0sJIxgpBLKQBImZv7VuVFBzEq1b2bbmy3yu9yScI/hIVQv4Bqe4wbAnxf2nuJLMKFuv
	PWEr30hLOZPw/m/kGYMxGWeNcqhRcEZN1y/Z4irLGnRrbtJTR0GnmUZNYU+4RM2/rWS0+cnFCQ0O2
	zngm7IcfHPPsDxGkFb/97asNptcWstklv5/NUjesU8azUIIZfPIc+Cwx2c4Rgr2CW6EVv7bqTZeUP
	rfZf3uaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXJQ-0000sf-94; Fri, 18 Jan 2019 16:48:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXI7-00086P-0C
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:46:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C9C80D;
 Fri, 18 Jan 2019 08:46:46 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08B8E3F7BE;
 Fri, 18 Jan 2019 08:46:44 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 5/8] arm64/sve: Implement helper to flush SVE registers
Date: Fri, 18 Jan 2019 16:46:07 +0000
Message-Id: <20190118164610.8123-6-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190118164610.8123-1-julien.grall@arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_084647_238015_24EE1B6E 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, Julien Grall <julien.grall@arm.com>,
 alex.bennee@linaro.org, Dave.Martin@arm.com, Daniel.Kiss@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Introduce a new helper that will zero all SVE registers but the first
128-bits of each vector.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/include/asm/fpsimd.h       |  3 +++
 arch/arm64/include/asm/fpsimdmacros.h | 19 +++++++++++++++++++
 arch/arm64/kernel/entry-fpsimd.S      |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index dd1ad3950ef5..fa2439205c35 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -79,6 +79,9 @@ static inline void *sve_pffr(struct thread_struct *thread)
 extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
+
+extern void sve_flush_live(void);
+
 extern unsigned int sve_get_vl(void);
 
 struct arm64_cpu_capabilities;
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 5e291d9c1ba0..a41ab337bf42 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -175,6 +175,13 @@
 		| ((\np) << 5)
 .endm
 
+/* PFALSE P\np.B */
+.macro _sve_pfalse np
+	_sve_check_preg \np
+	.inst	0x2518e400			\
+		| (\np)
+.endm
+
 .macro __for from:req, to:req
 	.if (\from) == (\to)
 		_for__body %\from
@@ -209,6 +216,18 @@
 921:
 .endm
 
+/* Preserve the first 128-bits of Znz and zero the rest. */
+.macro _sve_flush_z nz
+	_sve_check_zreg \nz
+	mov	v\nz\().16b, v\nz\().16b
+.endm
+
+.macro sve_flush
+ _for n, 0, 31, _sve_flush_z	\n
+ _for n, 0, 15, _sve_pfalse	\n
+		_sve_wrffr	0
+.endm
+
 .macro sve_save nxbase, xpfpsr, nxtmp
  _for n, 0, 31,	_sve_str_v	\n, \nxbase, \n - 34
  _for n, 0, 15,	_sve_str_p	\n, \nxbase, \n - 16
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 12d4958e6429..17121a51c41f 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -57,4 +57,11 @@ ENTRY(sve_get_vl)
 	_sve_rdvl	0, 1
 	ret
 ENDPROC(sve_get_vl)
+
+/* Zero all SVE registers but the first 128-bits of each vector */
+ENTRY(sve_flush_live)
+	sve_flush
+	ret
+ENDPROC(sve_flush_live)
+
 #endif /* CONFIG_ARM64_SVE */
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
