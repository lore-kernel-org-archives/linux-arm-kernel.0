Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4CC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E6220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AEsdagyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E6220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Eorzp1GVbGvewX+mCWsmVpSrcuLJacyId1qC/6mH238=; b=AEs
	dagyZklq3F3Ye86EyjLxjxguY3cGs73egngPz0w9dpDkkzMGgAbR1xHFMzNs3pcCFevVT0oLZsMxx
	DBd9Wru2/7wRRQcEw9aLH7yWCu1F4z8YpRIxSD+aY76vM9agigULjF2scESNqkZwjYPV5xrRoMopK
	iC0WBz53WdqSPy6hwjRXYwoXEq+GuvY015RZyIXMYXDCzIHHQ2ZUlsdoH76/9VEtBbeuf+GbNe4dF
	lfBh4SjfgyzVoA7wBjoWbNPo+xu1yjq/rk9TXUhKtgyVjZFRuMOAGJ4CZTlPRVH8U0aomGKCBFRXp
	rBLRpjCyRtUmAbtng0sGN5FteR2tcvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgWD-0002ct-65; Wed, 19 Dec 2018 18:24:29 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgW2-0002IW-2Z
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:24:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55F1CA78;
 Wed, 19 Dec 2018 10:24:06 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36AFC3F59C;
 Wed, 19 Dec 2018 10:24:04 -0800 (PST)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] System-wide mute of hotplug lockdep during init
Date: Wed, 19 Dec 2018 18:23:14 +0000
Message-Id: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_102418_186154_44FD9925 
X-CRM114-Status: UNSURE (   7.80  )
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
Cc: mark.rutland@arm.com, cai@gmx.us, marc.zyngier@arm.com,
 daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, peterz@infradead.org,
 longman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In [1] Peter had a suggestion to broadly mute hotplug lockdep warnings during
init instead of going after every single warning and wrapping them with
cpus_read_{lock, unlock}(). This is implemented in [PATCH 1/2].

[PATCH 2/2] is a logical follow-up as [PATCH 1/2] is the generalized version
of the reverted patch.

[1]: https://lore.kernel.org/lkml/1543877121-4098-1-git-send-email-cai@gmx.us/#t

Valentin Schneider (2):
  cpu/hotplug: Mute hotplug lockdep during init
  Revert "sched/core: Take the hotplug lock in sched_init_smp()"

 kernel/cpu.c        | 9 +++++++++
 kernel/sched/core.c | 5 +----
 2 files changed, 10 insertions(+), 4 deletions(-)

--
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
