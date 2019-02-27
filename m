Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:38:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A6720449
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dQ90iw/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A6720449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYf7ezjeyzJ0Za9bTaKeP+zyX6hGQNqhprM5XW9atyk=; b=dQ90iw/mg3W0cQ
	leEk7erfVslIHlG1u3VMwOE89IdM+UIU+c+GrCH/83xuU/L5Zeg5JtooTJMJb8YYXnX4dAtuxxVc8
	tNED2etyUKep3yw6v1D5p4f0R8B2FjhCPO+u1L6vTGBknRDbn5+RIfFa/Uqjg3OjEz5EEcaIcKN6R
	IadYWaf7KbfMz+zBlrqTgU+lW56oemBOYYn/abCh2b71hxzE5iCwS4yYf4J2fzK/1HHw5SF0l4Lve
	YNzRzP8meVNo3P/5LU5mmw2D7vt1PmxMZSXYW28Tg6w9FZp6DTB3h1aCl2eKajFxy5Xd1dWdEHwiv
	a5LEV7ZlZXKeWYYGTbPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz46R-0006OU-2q; Wed, 27 Feb 2019 18:38:47 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz46O-0006OD-Du
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 18:38:46 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 157C214010634;
 Wed, 27 Feb 2019 10:38:38 -0800 (PST)
Date: Wed, 27 Feb 2019 10:38:37 -0800 (PST)
Message-Id: <20190227.103837.668255833945043179.davem@davemloft.net>
To: steven.price@arm.com
Subject: Re: [PATCH v3 20/34] sparc: mm: Add p?d_large() definitions
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190227170608.27963-21-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-21-steven.price@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 27 Feb 2019 10:38:38 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_103844_466271_E85190AA 
X-CRM114-Status: UNSURE (   8.44  )
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
Cc: Mark.Rutland@arm.com, x86@kernel.org, arnd@arndb.de,
 ard.biesheuvel@linaro.org, peterz@infradead.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, mingo@redhat.com, bp@alien8.de,
 luto@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 james.morse@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 kan.liang@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Steven Price <steven.price@arm.com>
Date: Wed, 27 Feb 2019 17:05:54 +0000

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For sparc, we don't support large pages, so add stubs returning 0.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Sparc does support large pages on 64-bit, just not at this level.  It
would be nice if the commit message was made more accurate.  Other than
that:

Acked-by: David S. Miller <davem@davemloft.net>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
