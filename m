Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C039C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C61821726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sSIKIBsi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="drNM9kb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C61821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Jag7cuQ+QMUNystZ2ZHBNkRR6PVDXZbd9UCaThUXwAI=; b=sSIKIBsiKYcyER
	Bcr6vrbUzf0Y33A63NxcntjttiProqfq9h8TleEQVuyu2gOlmdOBJ2hNiTAVTRK17okql50BVHsMd
	bLxhw0z9IZ22qe+btJIfNQpa1zv9/5bXk45imUfE8mFE1FBgfC/u+d1hClVdLtYYHvbjQbd2tGbKQ
	aL4p4qUTuLo/g6CvubDxXHdXLuAOcXJbh2F3JbRXID9WxfyjtJuAHykbt8nIU0Cd4RyO+oRRakgni
	k35qHp1kCYj2muRNvOtwS5mA7saGPFCXVESeKUs3qPt/3E8BnHXv63zt7UqLMCj5ea9gBRJQmtSkC
	Yn+8hHPFA8B34lziMQzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxEx-0006Ln-D4; Tue, 22 Jan 2019 14:41:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxEt-0006LV-NQ
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:41:20 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7D92E20855;
 Tue, 22 Jan 2019 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548168079;
 bh=BFTnvXnAm5o3G6K0jtRw7dWn6GTmBURul6yM41En70k=;
 h=From:To:Cc:Subject:Date:From;
 b=drNM9kb2lNWdeg+G3bR6vPoSJcolXVMUITjyma/KZgi0Eloic232HTY1g1Il2HEqu
 oWgzqHFHP7HZ2prXbPx5y/feJXq2OYT8JgonwnKBOXsrrddugjIDS47wHx1Nv6wYam
 hSItg7yFaAhz6E9d7hQLk5umbpyEVOsGEgquNZLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/4] ARM: cleanup debugfs usage
Date: Tue, 22 Jan 2019 15:41:10 +0100
Message-Id: <20190122144114.9816-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_064119_775717_A5638914 
X-CRM114-Status: UNSURE (   8.79  )
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When calling debugfs code, there is no need to ever check the return
value of the call, as no logic should ever change if a call works
properly or not.  Fix up a bunch of x86-specific code to not care about
the results of debugfs

Greg Kroah-Hartman (4):
  arm64: dump: no need to check return value of debugfs_create functions
  arm: dump: no need to check return value of debugfs_create functions
  arm: omap1: no need to check return value of debugfs_create functions
  arm: omap2: no need to check return value of debugfs_create functions

 arch/arm/include/asm/ptdump.h   |  9 ++---
 arch/arm/mach-omap1/clock.c     | 63 +++++++--------------------------
 arch/arm/mach-omap1/pm.c        |  7 ++--
 arch/arm/mach-omap2/pm-debug.c  | 15 ++++----
 arch/arm/mm/dump.c              |  4 +--
 arch/arm/mm/ptdump_debugfs.c    |  8 ++---
 arch/arm64/include/asm/ptdump.h |  9 ++---
 arch/arm64/mm/dump.c            |  4 +--
 arch/arm64/mm/ptdump_debugfs.c  |  7 ++--
 9 files changed, 34 insertions(+), 92 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
