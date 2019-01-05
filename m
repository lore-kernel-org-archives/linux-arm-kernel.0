Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA97C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:52:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5989621871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KvQm02qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5989621871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=smoOltSrVAMsSVCDsDh35uGy33TeGhGtymuq210GrLI=; b=KvQm02qtdfqjqE
	SR0M3/roUnUD856BifPLApn8bJKcvRMn+GvSc2NuqsSaulig4+sW+H4bGsoZJsq3c5MoZrXpg3mbJ
	Ot94a8XWSURNMTEbxMfXZH3M/hjw/1Bg2r+gYmYXFQgClOUMXprJlZAU8q9J7/PmEDAZH3/OjlFlR
	TLR90ulwm5V+TxIOVO5Xx3MyBvggXQgBfeYm+tXrRLSngH6NFtMtVYUayvep9n496+rHQi4a5zlxe
	ce2N91kt2unn2p23RhKd4X3qqmB/zEQAhXjxw8suJeoZSO5yLkJKMbCXJnqn6Oj/vc5eizDAFUIZC
	hen2++b7JwEwCoJW+Fpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfetF-0007j6-3r; Sat, 05 Jan 2019 05:52:57 +0000
Received: from gateway31.websitewelcome.com ([192.185.143.38])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfetC-0007i7-As
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 05:52:55 +0000
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id AF2205A4C61
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  4 Jan 2019 23:52:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id fet9gcK1H2qH7fet9gHvzh; Fri, 04 Jan 2019 23:52:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46910 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gfet8-004M4L-5N; Fri, 04 Jan 2019 23:52:50 -0600
Date: Fri, 4 Jan 2019 23:52:46 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 0/2] Fix NULL pointer dereference and use struct_size
Message-ID: <cover.1546667177.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gfet8-004M4L-5N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46910
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_215254_418652_88284668 
X-CRM114-Status: UNSURE (   6.26  )
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
added for this patch.

The second patch promotes the use of struct_size() in devm_kzalloc().

Both issues were detected with the help of Coccinelle.

Thanks

Changes in v2:
 - Fix bug in patch 2/2 reported by kbuild test robot.

Gustavo A. R. Silva (2):
  ARM: integrator: impd1: fix NULL pointer dereference
  ARM: integrator: impd1: use struct_size() in devm_kzalloc()

 arch/arm/mach-integrator/impd1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
