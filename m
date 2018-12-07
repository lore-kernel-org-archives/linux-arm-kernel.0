Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D39C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:15:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC862083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uv7d0loi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC862083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=28Kuxf9nC+JZWb+Ud/9mNhXCtqyLM8oN0vHijfqgSOE=; b=Uv7d0loiMZFbgL
	jAVl0J002S5DwUuH7QmDk24p7bQy19gi6xKiRNGc03I1Fu7sk1vqEwZgylxs9dHIN5Jry7+Rft/16
	jJGiUVDoOJ/wdDkXJLx3cIddsHh5bDUPumHAjgX9j9z4sJ3EPTk/y5VDs26y+stRU+aySecOnQumd
	YaSr3q/h0ucuaffiOoSCeFAypUvDZFg0Jf3aNMU6VocY4fc4xzXzsDaXjfWWES+QgOZqqa6NHf+ET
	FGRj9YOnb2//Yek1JfK39ZHl79H4W+GBjrt1p7BY92e9IEYWseAV7DIMr9EhRRMAv4oTJy8SaXbu7
	H27PHiSXg0qmjBYj+VgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDA6-0006uD-Ip; Fri, 07 Dec 2018 10:15:10 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDA1-0005ei-8J; Fri, 07 Dec 2018 10:15:07 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD678EBD;
 Fri,  7 Dec 2018 02:14:54 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC8F3F5AF;
 Fri,  7 Dec 2018 02:14:51 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH arm64/kexec] arm64: kexec_file: forbid kdump via
 kexec_file_load()
Date: Fri,  7 Dec 2018 10:14:39 +0000
Message-Id: <20181207101439.190918-1-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_021505_306950_1C0F8355 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: devicetree@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Will Deacon <will.deacon@arm.com>, bhsharma@redhat.com,
 Frank Rowand <frowand.list@gmail.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Howells <dhowells@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, prudo@linux.ibm.com,
 dyoung@redhat.com, David Miller <davem@davemloft.net>,
 Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that kexec_walk_memblock() can do the crash-kernel placement itself
architectures that don't support kdump via kexe_file_load() need to
explicitly forbid it.

We don't support this on arm64 until the kernel can add the elfcorehdr
and usable-memory-range fields to the DT. Without these the crash-kernel
overwrites the previous kernel's memory during startup.

Add a check to refuse crash image loading.

Signed-off-by: James Morse <james.morse@arm.com>
---

Context: http://lore.kernel.org/r/20181206155424.GA4422@arm.com

 arch/arm64/kernel/kexec_image.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 1ad1d5f8f024..07bf740bea91 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -47,6 +47,10 @@ static void *image_load(struct kimage *image,
 	struct kexec_segment *kernel_segment;
 	int ret;
 
+	/* We don't support crash kernels yet. */
+	if (image->type == KEXEC_TYPE_CRASH)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * We require a kernel with an unambiguous Image header. Per
 	 * Documentation/booting.txt, this is the case when image_size
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
