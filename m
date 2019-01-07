Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D28A2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kv0ukPcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D28A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vy7KRDtpuIuyfXE8Po0x1SRiRMZIAghkQfNwilkS0lI=; b=kv0ukPcJWTv05R
	y5InhEJnYAKS5VrzMPyLnqKTeWlQmU8VqJ5UOh35uit+u0Mk8RzB6atgCXuNrMCAO+jpTOkeAE6s5
	oky+pTOoZmKq77tBAbgEMs0ZDYtsJ4oOhN7ALgHIdmIjw2lHDnoZ2ZtC25F88eWKvEtUZ+KhmX/h4
	ABBVqxhpBnO91FFkwxTdvyCDh/kPURP7N+sL2t10lnbj1ENaALIZvetbhNUE4+M5VK6KjGStFDdG+
	dlWqDqVUEOP1TUemLbJHCMCCxT5gjUfi8y+yTi1k9nNfUvfqBwjSyDPnuIHqgKKOIqDDBrn5nSDVh
	rCEXUUQP7TZwU6WQKRDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggeTl-0007Xf-GF; Mon, 07 Jan 2019 23:38:45 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggeTg-0007Wm-Js
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 23:38:42 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id DED4E813A;
 Mon,  7 Jan 2019 23:38:42 +0000 (UTC)
Date: Mon, 7 Jan 2019 15:38:33 -0800
From: Tony Lindgren <tony@atomide.com>
To: Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190107233833.GI5544@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_153840_693298_02F99A9A 
X-CRM114-Status: UNSURE (   6.05  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
over to using hrtimers") caused a regression on at least
omap5-uevm where 8250 UART rx wake no longer works. I have not
noticed this happening on others so far.

The devices I've tested all are using 8250 with dedicated
wakeirqs configured for the rx pin. I can see the interrupt
increase on omap5-uevm after some one or more keypresses,
but then nothing. It seems that the uart just falls back
asleep right away or something.

Any ideas what might be going wrong?

Regards,

Tony


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
