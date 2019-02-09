Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9750C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E57218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P+9rroBw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lGGiXXUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E57218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dLxtLGwLKFHeQBE+A/z4gHhp877xPIzgc+k//7piktE=; b=P+9rroBwN44QOB
	DYbwGi1bixKWWoNBVvhUMAAPM68q76SpToMIVtVWqwlHJyw/liCUGK9T/VtqXdyrEqsF8IpUfe3Mr
	Vz91kLmclSJK7fsGzy/mBBvaH0+KM/8k4LAF/eFxllnzSSLe8Z9ao+sifmyDEQHctW1xou5KCg85P
	CKsZckrAUULImC+KgkavFFyfZ6JdxGxhN0+9jmLNaakt7XTr8WoUiItk5/F+h0ybj/h0lyDKv8YlL
	NmEeWYJxyFUpXvYmzAnmxYfmCPc6rJ0+ddp27czeJ9pv52OG1IkP6Kqf638BxpfZdp0RfnfF9RjXj
	g02w0nVukKfW87oJ/www==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsbkN-0004vL-SI; Sat, 09 Feb 2019 23:09:19 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsbkK-0004tN-8i
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 23:09:17 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 9982E5C24EB;
 Sun, 10 Feb 2019 00:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1549753754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrAPW/N746G+3mkN2kaRzvoA3N5aYGgPiNo+V6l9Z30=;
 b=lGGiXXUotnFH793oxVQ4ybMrzshMJMglKRUdXE3D9vcuToSJOLCAiPqjxdp9q+eDiBI1if
 /Z+M3ofjZf2mk2R+boRjXkQs0rGRFdpNQOMiaAnaBC9gpxxP8hjP3QchpWfaIbcqM6D0Mi
 SWU8OgsjheQFNawMH4splFnwpauTXhI=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v2 1/5] ARM: use unified assembler in macros
Date: Sun, 10 Feb 2019 00:08:58 +0100
Message-Id: <8d47f3b81158fb75ce1a4013d90c00c3ea5dde66.1549753425.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549753425.git.stefan@agner.ch>
References: <cover.1549753425.git.stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_150916_460317_4C1C6BB7 
X-CRM114-Status: GOOD (  11.90  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, julien.thierry@arm.com,
 ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com,
 natechancellor@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use unified assembler syntax (UAL) in macros. Divided syntax is
considered deprecated. This will also allow to build the kernel
using LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Remove excessive null tokens

 arch/arm/lib/copy_from_user.S | 2 +-
 arch/arm/lib/copy_to_user.S   | 2 +-
 arch/arm/lib/memcpy.S         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 0d4c189c7f4f..6a3419e2c6d8 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -91,7 +91,7 @@
 	.endm
 
 	.macro str1b ptr reg cond=al abort
-	str\cond\()b \reg, [\ptr], #1
+	strb\cond \reg, [\ptr], #1
 	.endm
 
 	.macro enter reg1 reg2
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 97a6ff4b7e3c..c7d08096e354 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -49,7 +49,7 @@
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
-	ldr\cond\()b \reg, [\ptr], #1
+	ldrb\cond \reg, [\ptr], #1
 	.endm
 
 #ifdef CONFIG_CPU_USE_DOMAINS
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 64111bd4440b..4a6997bb4404 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -30,7 +30,7 @@
 	.endm
 
 	.macro ldr1b ptr reg cond=al abort
-	ldr\cond\()b \reg, [\ptr], #1
+	ldrb\cond \reg, [\ptr], #1
 	.endm
 
 	.macro str1w ptr reg abort
@@ -42,7 +42,7 @@
 	.endm
 
 	.macro str1b ptr reg cond=al abort
-	str\cond\()b \reg, [\ptr], #1
+	strb\cond \reg, [\ptr], #1
 	.endm
 
 	.macro enter reg1 reg2
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
