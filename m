Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A984C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2C421841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K6qLbiUg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D79b95lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2C421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vIDhgl5+kBJXN/kzsVCK8sGvkKe2ghAud6vTPwmfnbo=; b=K6qLbiUgdEXoYZ
	R/KcnqLe44xqXUbf+PzwpgvlPO9uSDYAk4CtIPhUrGdjopBWXnNIRdThbqlJwWxRTlNPWQcpDe0Fq
	/9pZyCHCNosmXq2LZ9rZAErbm/JcwHBaENwWDrvUeRyW3hPSXWCEgR8ui7sGIiXnzLOYhDgIlbO92
	q6DSpgTvae9bsEt7CdJTfokHyuQ44F5QjSD4WsMIgPvYAuCumJJ1jkDo5TPRgpcFnyN9+rHLWC/zR
	W7p07Weadq9WGL4VTTWC+L0gD0/VlfI6a9uvAcTjSG5zr/qcoFuyyQlHi18OlzRZvmTJBiCJjFSzf
	h0FZeUm7yTr7vq2yoU6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyNfI-0004bJ-S7; Mon, 25 Feb 2019 21:19:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyNfE-0004aG-Tl
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 21:19:54 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C885B2183F;
 Mon, 25 Feb 2019 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551129592;
 bh=YUA0NAqmVtkBKSYlkXPjO0Lb2GyBoJPbuDomsv30lj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D79b95lwrdHXRR/ro8D7xj4z/FVvokLVTMY2nbmok636Zkev14kVWVrhuqcw4GSpI
 zb4820AILDFSsFKGCIE5kH/8jkvadP3E2F3CI/42y3xP+oJK8sNpss2CtVDPkp82Ho
 Z7w066b9L4dLZoGYtF1vdkW7BBR5XMMGW/i3Za7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 001/152] ARM: 8834/1: Fix: kprobes: optimized kprobes
 illegal instruction
Date: Mon, 25 Feb 2019 22:09:53 +0100
Message-Id: <20190225195043.761067800@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_131952_978162_78A52E0F 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
 William Cohen <wcohen@redhat.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c upstream.

commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
FORTIFY_SOURCE") introduced a regression in optimized kprobes. It
triggers "invalid instruction" oopses when using kprobes instrumentation
through lttng and perf. This commit was introduced in kernel v4.20, and
has been backported to stable kernels 4.19 and 4.14.

This crash was also reported by Hongzhi Song on the redhat bugzilla
where the patch was originally introduced.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
Link: https://bugs.lttng.org/issues/1174
Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com

Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org> # v4.14+
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct
 	}
 
 	/* Copy arch-dep-instance from template. */
-	memcpy(code, (unsigned char *)optprobe_template_entry,
+	memcpy(code, (unsigned long *)&optprobe_template_entry,
 			TMPL_END_IDX * sizeof(kprobe_opcode_t));
 
 	/* Adjust buffer according to instruction. */



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
