Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF85E20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3Q9wC1M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="klSJzvWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF85E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=za1/4A+7Mil4N9HeGWWLJ2Y+p8IKp/Ib88HAafAHKOM=; b=L3Q9wC1MsYPQVN
	BNNXKmBLNdPu59cU4GpQ4dLqg2soKPGU5eWWuk3CTeulA17wQNR0p6ZnUomXPLByigSWIxODWzE5f
	fEqQLYaUtn6mw2QUWtXdAlPWFqLFesgsZkEQExfBCKJJkW6jp62gciTOzvMgPpL/l5WkLrIGXckq9
	4msQOYJrwf8AIu+AFHA/RBwsUEhkK+Z3+dAbrByANSDq+OMsWHL6Nr695iuZCVesXkpcuHiGP/hXv
	yBkZIK/vLmzEnx6iQ1HPDg0OiZmZaxIUDOf36/MCDXmLkckkyw9g/JktC6PjtOomOBa7bF9CjKj+2
	JqnyfiJ4yHAox/mNhONA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYmaE-0001qa-MI; Mon, 17 Dec 2018 06:40:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYmaB-0001pw-VV
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 06:40:53 +0000
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp
 [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2023E20675;
 Mon, 17 Dec 2018 06:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545028841;
 bh=UmiQsNgEMM6zxKlasX/6ZUpXyg006ccYbXxMb3MykwI=;
 h=From:To:Cc:Subject:Date:From;
 b=klSJzvWekAgM1fHQG9ZMQkPWga6Jpzltj5XWzvhpyn8boj68f4oL2C3mrRWds6UsS
 yPF+iH6h4reiRTTrCZb8c3zJ1y+FOihm+z4WCnl8mfK8PU58Ij9Xs27R0J3Kcx0Swu
 1ZlngzOwntLuVmW0NhTPMOhhhZFTPoUd/xyxQJWM=
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/3] arm64: kprobes: Fix blacklist checking on arm64
Date: Mon, 17 Dec 2018 15:40:17 +0900
Message-Id: <154502881646.30629.9938335052821665530.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_224052_031626_24EF3639 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "David A . Long" <dave.long@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

Here is a short series about fixing kprobe blacklist checking on
arm64.

I found that some blacklist checking code were mis-placed in
arch_prepare_kprobe() and arch_within_kprobe_blacklist().
Some sub-function (instruction-level) accept/decline check
should be done in arch_prepare_kprobe() and that should not
be in the blacklist. Also, all function (symbol) level check
must be done by blacklist.

For arm64, it checks the extable entry address in blacklist
and exception/irqentry function in arch_prepare_kprobe().
Moreover, RODATA check is unneeded since kernel/kprobes.c
already ensures the probe address is in kernel-text area.

Thank you,

---

Masami Hiramatsu (3):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist


 arch/arm64/kernel/probes/kprobes.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--
Signature

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
