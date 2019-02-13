Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A181C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:57:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92D92175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CdJvMNC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D92175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4CB+Mx8TqOma3aaxC8cLEVhoPiCemxEt2OWd7VKoZoA=; b=CdJvMNC4CRWEXH
	4AP2k7Vj3hlfsH/sV3LlXf/+oJAjtNfl+9Ec932DM4zPIKnGQh1XNtOdsmZ3ps3lp77MKD6wFaA1P
	K6uMt9YCpkBMFlFych89FYmpVio9my3eJmNPCQtDlAaJ3npxxjdvJEffUZBKcz+Wj+fq1J6cxC2WU
	i8r9l7zak9h4KahmEmV9TnidYZMZOqfQa9M2SJ8RLFYP9qnYtP2U4cUwgo4xGmR7YAs4gV9E0F5sj
	99IyJ6rKRawa/6YFLkilZ+NqlUfK2uahuZTMuz0efnx8PhccRGt3fWR7JT3gWIanG+HfxxlN15BIY
	oe10z4sTdWMImmguEt7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtwup-0004YU-PK; Wed, 13 Feb 2019 15:57:39 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtwun-0004Y9-51
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 15:57:38 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1gtwui-0006BW-Lt; Wed, 13 Feb 2019 16:57:32 +0100
Date: Wed, 13 Feb 2019 16:57:32 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] arm: use a raw_spinlock_t in unwind
Message-ID: <20190213155732.73zyjtrgv5zruuvh@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-4-bigeasy@linutronix.de>
 <20190213084643.kesmhabdooqns2ze@linutronix.de>
 <CAK8P3a3o_k7qiWndWP40xWhxNEmB0e+6iHC0RtfpqAZBtqTLXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3o_k7qiWndWP40xWhxNEmB0e+6iHC0RtfpqAZBtqTLXQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_075737_341460_DF2A17EC 
X-CRM114-Status: UNSURE (   7.87  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-02-13 16:14:18 [+0100], Arnd Bergmann wrote:
> Patches 2/3 and 3/3 look good to me. Can you add them to
> https://www.arm.linux.org.uk/developer/patches/ ?
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Will do, thanks.

> Are there any other ARM specific RT patches that are not yet picked up?

No, not at the moment.

>         Arnd

Sebastian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
