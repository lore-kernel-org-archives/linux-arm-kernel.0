Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C870C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3772021736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uw0q8mb6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUAJKTGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3772021736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EgDkpfciM9thHghkM3w8H1W6sVw5ZPCLfaEIKkSUkZg=; b=Uw0q8mb6pwWV1V
	DqehE+KY0MQ3chDSj9kja/0zX2oEieh+z27aq+e99X6K/e+X9UQJMcBp5Y4PXafbGONuDu75Auyah
	/HCozipeyC+Sg1BgmfSK7l3Nq7lgTLk/gBtFryBySNZNqU73M4E+XtMcuQXVZaBXENLcUFRhhbav9
	OQ54e1iiOBxZq760eL86o3pCzdLT7Od19jAizz1PcZJ9Zg1OWA9OKpFbqYdgtfdMHXMBHnLF+J9CP
	bER0DS8C/pSDRjVEWGLeduHvyfBs7I/UdtzFi6VjSgrsSA5WI5QxfibfOQztWHh4xrGc8X/LzU1na
	FsUkkgGMyDXFECrXNBjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2jJ-0002xr-9N; Mon, 28 Jan 2019 08:57:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2jE-0002vD-1b
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:57:18 +0000
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 262042148E;
 Mon, 28 Jan 2019 08:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548665834;
 bh=n+Fxqs+Towa5iZSUn5jShD0wmvGhwDOjCCRws252b/g=;
 h=From:To:Cc:Subject:Date:From;
 b=kUAJKTGQaJIK+uzekWTRZfzPw+yTHa9bVHE52j48Z9Bn3+Z4J44vdLSaogqPIr9uX
 6wqYNs8fD21xyco1u0WGkfGK02f9rU54bYcWbxiPdFYsTtYVnJqwipP1h69VRp0ymO
 EC27BtoRP5wWqO+I7NC2angzhI464/7Np4/FfRoc=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 0/3] crypto: crct10dif assembly cleanup and optimizations
Date: Mon, 28 Jan 2019 00:50:42 -0800
Message-Id: <20190128085045.6504-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_005716_109800_2BD17304 
X-CRM114-Status: UNSURE (   7.32  )
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
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The x86, arm, and arm64 asm implementations of crct10dif are very
difficult to understand partly because many of the comments, labels, and
macros are named incorrectly: the lengths mentioned are usually off by a
factor of two from the actual code.  Many other things are unnecessarily
convoluted as well, e.g. there are many more fold constants than
actually needed and some aren't fully reduced.

This series therefore cleans up all these implementations to be much
more maintainable.  I also made some small optimizations where I saw
opportunities, resulting in slightly better performance.

This is based on top of the pending patches from Ard Biesheuvel.

Eric Biggers (3):
  crypto: x86/crct10dif-pcl - cleanup and optimizations
  crypto: arm/crct10dif-ce - cleanup and optimizations
  crypto: arm64/crct10dif-ce - cleanup and optimizations

 arch/arm/crypto/crct10dif-ce-core.S     | 546 +++++++--------
 arch/arm/crypto/crct10dif-ce-glue.c     |   2 +-
 arch/arm64/crypto/crct10dif-ce-core.S   | 496 +++++++-------
 arch/arm64/crypto/crct10dif-ce-glue.c   |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S  | 848 +++++++++---------------
 arch/x86/crypto/crct10dif-pclmul_glue.c |   3 +-
 6 files changed, 794 insertions(+), 1105 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
