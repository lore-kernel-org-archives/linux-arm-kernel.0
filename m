Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F71C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:55:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B16020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oAs0jNvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B16020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6IxUbT3OqfNgQnxXI28nxTAMdWUmPO7FufR9Z2VsuQI=; b=oAs0jNvHBLA1Lm
	RbbWiMwDwCWCUDE6rM2KVMAoRQ3NxB/qSgSJ+9UTT5maIl3Q5YT2cA5ivMJ1C9QkJlOyWxtRLhDFG
	NCuW/5Lq4mUhYazitUv+LZO1edtG2brUyQAw8HwUzMM6ocY8rF7f80k8GfRQcn1C6Q76uoUh6acd/
	j6FYCVXyVOMpLrzv1jMOn66ENJYUAbiA/M9eQbY1SkmEWLu1zhBQsjXDaNU788o6+PIbzUE8pE7YV
	Opuc4nEu6saStEEvt0dowkFQofDBXcATOcpd9cBDkaaaXmoPQFyaJveqHZcJCKy28Fzuae+KR1Tcy
	Y0Lf/fFnw+3FfF2G/XZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX9ep-00004s-J3; Wed, 12 Dec 2018 18:54:55 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX9eb-0008IU-5H; Wed, 12 Dec 2018 18:54:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 919C5AEE4;
 Wed, 12 Dec 2018 18:54:25 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vchiq: fix completion routines & semaphores
Date: Wed, 12 Dec 2018 19:51:32 +0100
Message-Id: <20181212185136.6620-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_105441_458744_0F37EFF8 
X-CRM114-Status: UNSURE (   7.79  )
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
Cc: stefan.wahren@i2se.com, devel@driverdev.osuosl.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, eric@anholt.net,
 linux-rpi-kernel@lists.infradead.org,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

As pointed out by Arnd Bergman[1] there where some issues on how I
converted semaphores to completion routines. I wasn't aware of a
macro override happening in vchiq_killable.h, which was changing
down_interruptible()'s meaning.

This patch changes all completions so they use the proper APIs and gets
rid of vchiq_killable.h. I took into account Arnd's commit to avoid
merge conflicts.

[1] https://www.spinics.net/lists/arm-kernel/msg694422.html
===

Nicolas Saenz Julienne (3):
  staging: vchiq: switch to wait_for_completion_killable
  staging: vchiq_2835_arm: quit using custom down_interruptible()
  staging: vchiq: delete vchiq_killable.h

 .../interface/vchiq_arm/vchiq_2835_arm.c      |  3 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 22 ++++----
 .../interface/vchiq_arm/vchiq_connected.c     |  1 -
 .../interface/vchiq_arm/vchiq_core.c          | 22 ++++----
 .../interface/vchiq_arm/vchiq_killable.h      | 55 -------------------
 .../interface/vchiq_arm/vchiq_util.c          |  7 +--
 6 files changed, 24 insertions(+), 86 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_killable.h

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
