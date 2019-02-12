Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3D1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:44:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0865121773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bwW+fw2g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq2FDpp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0865121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QUvhZTceWVuoY1cgiJibrYOTmz5UjZzrOgylr36X4qs=; b=bwW+fw2gdB5uii
	8zwpPITdPnMEh91gH+z8vxgs8/JScK4jKrNWQ7QJUrqVrjdqxOTZajgje/k9h2DI4Xy8/QpqsL1ku
	ijlR4/drK8tj2abFE45csN6ig9NZ7myANO6ZfA5VK/k7tNNTvtLnUdmovOAkney4EB6LYimeCfV5r
	avvj9lDAWVQhZQIaYeofui23KCdaWfaVVCbPwsmtOYdOafS0bIGhejm7a8gnEdDP09US10bi1KW5i
	+/njVQHzZM2Ovm7H3wkBG6aNIPCzpJF5ozW10RanCUVmw4dGsdmDh0uj5GDlcM33qNpe5cOoj3N5X
	ULo/sKx5SNZq+YNPh4MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtaEL-0006X2-Dv; Tue, 12 Feb 2019 15:44:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtaEI-0006We-Gw
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:44:16 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F181721773;
 Tue, 12 Feb 2019 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549986254;
 bh=sozzUq5udjjfXAJamYZwgE+8GtztlIavIM+cKXa/iww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pq2FDpp7szFKKhOQOARBg/KLBThPob7NRfIWGjhiTSrZY8G5t95BsRivD9gYI+Tgn
 c+VGDTH51gvD8Z06pnanuUcrq80oRbnn5OTNr2lPE2vHiZeVf4BfcQFbopH16Sd8PL
 jyyCK53ztWZFzMtPg2fkC2kn18C6EuwHyo1sdT/w=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 2/4] arm64: kprobes: Remove unneeded RODATA check
Date: Wed, 13 Feb 2019 00:43:51 +0900
Message-Id: <154998623104.21869.15264079902544102514.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_074414_671823_E513536D 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "David A . Long" <dave.long@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove unneeded RODATA check from arch_prepare_kprobe().

Since check_kprobe_address_safe() already ensured that
the probe address is in kernel text, we don't need to
check whether the address in RODATA or not. That must
be always false.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 9989ec9baa11..bd06b4b13fa9 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -91,8 +91,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
-	extern char __start_rodata[];
-	extern char __end_rodata[];
 
 	if (probe_addr & 0x3)
 		return -EINVAL;
@@ -106,10 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (search_exception_tables(probe_addr))
 		return -EINVAL;
 
-	if (probe_addr >= (unsigned long) __start_rodata &&
-	    probe_addr <= (unsigned long) __end_rodata)
-		return -EINVAL;
-
 	/* decode instruction */
 	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
 	case INSN_REJECTED:	/* insn not supported */


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
