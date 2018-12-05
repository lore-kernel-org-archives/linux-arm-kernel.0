Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD716C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954C020645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gTTyBsYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954C020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:From:
	Date:Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=R/VwOic3mcE0j30wggx0pkzDenJj2Ftgmgcs0gBuarY=; b=gTT
	yBsYxkWCn5wOBLIH0eUuidh8C/ZPAzDoQBRJouCjD3WVQ7gPCFZw+0sKQh4il5JiPkXPFCMucyok4
	/jFL6nuQyuWcSNRUivemXkP0xy6kWvFeVkIexR6PdZ8VkPj2FaSXWlKizS/RlDahbod6Ersm7tSfe
	6PbptXsM4JTH6eRC7QSDFu60ZyEmKv4dTGWFM+Kq7hrGeNA6P5hQdInrEYtcnMDC623nQsjn17Iks
	RkDAhRKAQqRMwMLQ3pK2RqnnPRtFIVYh41rRkyJLCAqbzlJN/xXwYosAAab6XANo62dr+tLaKyZAB
	oy/aQYdoU5fLKQtWjti+9l66yge5oxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbz6-0002nR-3s; Wed, 05 Dec 2018 18:33:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbz2-0002lQ-RA
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:33:18 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F367620645;
 Wed,  5 Dec 2018 18:33:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
 (envelope-from <rostedt@goodmis.org>)
 id 1gUbyp-0007ib-PE; Wed, 05 Dec 2018 13:33:03 -0500
Message-Id: <20181205174852.435233070@goodmis.org>
User-Agent: quilt/0.65
Date: Wed, 05 Dec 2018 12:48:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: arm64: Make ftrace_replace_code() schedulable
 for arm64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_103316_919280_268FB4AA 
X-CRM114-Status: UNSURE (   8.13  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, keescook@chromium.org,
 arnd@arndb.de, catalin.marinas@arm.com, will.deacon@arm.com,
 Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


This is a little more involved, and I would like to push this through my
tree. Can I get a reviewed-by/ack for the second (arm64) patch?

Anders, can you also test this to make sure that it fixes the issue you
see?

Thanks!

-- Steve


Steven Rostedt (VMware) (2):
      ftrace: Allow ftrace_replace_code() to be schedulable
      arm64: ftrace: Set FTRACE_SCHEDULABLE before ftrace_modify_all_code()

----
 arch/arm64/kernel/ftrace.c |  1 +
 include/linux/ftrace.h     |  1 +
 kernel/trace/ftrace.c      | 19 ++++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
