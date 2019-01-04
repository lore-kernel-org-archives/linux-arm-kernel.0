Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D0BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DB4204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="facPct3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DB4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6YpBVDVOPkxx2ezr5FMjEfmBiHvHuhMpTULStR7jVFk=; b=facPct3lXz1y+y
	eRwJgcM/PVKMWKIC7+VqlTaasmL5WveLE+/Oh27aHYHGsNZuNAbwB8CGIW4Ragv+2dFE4/dQqUGOh
	A8efCbaEPAdkGyzFlDSPnrfm8Q8o1O4t6P+PKNBOa6YjvvdCOvL5a+MjP9p3q8zQIszO10OCjdf4U
	vx8WM8fv/YmcrJFu7fw9sL8p+6J9SDkBTbZ72gqZNF3mNwz/FZW1XT8Nzt6QWHbOrl6dKGQ0858h6
	wNBxW1x/hqGlaetxxmePMPs+Ni1UKngclx1XxuvlmuHAXlUvLOPtKdfXKF/e4cgypxMA40cQK6vVQ
	+G3BY91/B5E44eilE6/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfT2i-0007E7-TQ; Fri, 04 Jan 2019 17:13:56 +0000
Received: from gateway24.websitewelcome.com ([192.185.51.202])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfT2f-0007Dg-05
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 17:13:54 +0000
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway24.websitewelcome.com (Postfix) with ESMTP id 5E8D482B2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  4 Jan 2019 11:13:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id fT2dgpwD52PzOfT2dgVirz; Fri, 04 Jan 2019 11:13:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=34852 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gfT2c-000E6f-JY; Fri, 04 Jan 2019 11:13:50 -0600
Date: Fri, 4 Jan 2019 11:13:47 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/2] Fix NULL pointer dereference and use struct_size
Message-ID: <cover.1546621488.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfT2c-000E6f-JY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:34852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_091353_083416_68E5A586 
X-CRM114-Status: UNSURE (   6.20  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The first patch in this series fixes a potential NULL pointer
dereference by adding a NULL check. A tag for stable has been
added in this patch.

The second patch promotes the use of struct_size() in devm_kzalloc().

Both issues were detected with the help of Coccinelle.

Thanks

Gustavo A. R. Silva (2):
  ARM: integrator: impd1: fix NULL pointer dereference
  ARM: integrator: impd1: use struct_size() in devm_kzalloc()

 arch/arm/mach-integrator/impd1.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
