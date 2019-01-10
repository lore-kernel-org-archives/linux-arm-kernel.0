Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC94C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3A3214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBCSkBuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3A3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SU6ZUylWTB4m0hxsh/pTDYtdMrdTGkU5Ve3kHGMxXE0=; b=VBCSkBuuCWmvwv
	c3aNtulLgrtGtlTCKcmps+jTsOyvvEYZ9CjmsnnbNiBv5kpae4KeUc7n7+Kqr7JMoRQcXxblicsuA
	6CA857vJ+kK2/xbyroB3mUJDQrmP7D2gawHWxwl8e+HCPwbIGrZfOgo7M+h13hslXC7ImYqVjiIHq
	9vCZ65i4wCmuSxKbyB82ltR6OpkhQqZI9RaoNxNFc6MtVwTZEKn/ZVZGB9Vj0eR3bzofS8P9tyFVK
	2tCWmSs0ZqlSjTd7gM0RAbUJsXE9p1/LaFuxQP2hkZA0u77LSWN2uZpm83eiBF9RonN55VswYukhG
	12fufrcBZ6WUuZdj7pog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghb73-00021Y-6w; Thu, 10 Jan 2019 14:15:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghb6z-0001wW-Oi
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:15:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD351596;
 Thu, 10 Jan 2019 06:15:09 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 215663F5AF;
 Thu, 10 Jan 2019 06:15:07 -0800 (PST)
Date: Thu, 10 Jan 2019 14:15:03 +0000
From: Will Deacon <will.deacon@arm.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/2] arm64: mm: make use of new memblocks_present() helper
Message-ID: <20190110141503.GA31328@fuggles.cambridge.arm.com>
References: <20190109202100.6968-1-logang@deltatee.com>
 <20190109202100.6968-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109202100.6968-3-logang@deltatee.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_061509_819516_5B73D9AE 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Stephen Bates <sbates@raithlin.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 01:21:00PM -0700, Logan Gunthorpe wrote:
> Cleanup the arm64_memory_present() function seeing it's very
> similar to other arches.
> 
> memblocks_present() is a direct replacement of arm64_memory_present()
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/init.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Did you want us to take this via the arm64 tree?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
