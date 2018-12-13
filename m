Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C2C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:26:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0414720811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GL7Anfe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0414720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4uB6v7ETZ7WKQsYTB2LQOHxju6GSmMXUVux0mo6VIek=; b=GL7Anfe5KKghTL
	YY0teQfkoVJOn3cUyh2k4ESolDjbVXg8QQRPvNs4JGen1+Q8AFk3oPVW6R9BgwqoyPHdijWqWmxJ4
	yLvm0y9JNY1lO4lsrD/A0ubdhaZ5B2HAHc9LclcHIp1ctn1YWUlKQ2iahUme3wGTV+Fc4l7C4hS93
	/lPXxd5Co6RQaNVyt2u+ml8D6HZS+VbER3Ip8GDYGBfQOy292cqZTWzRWNCnB9Omu4l5JlBlPNu5X
	M8wMP93jiWN7p7h8AiRuFVCCasUNTp27wEn9SKTMqCNn5K+mfr+HUPuPq1d8evf+jXjfv9edLKNhB
	dimJupD3TDqK+F6h0Aew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXEp2-0004o1-5d; Thu, 13 Dec 2018 00:25:48 +0000
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXEoy-0004nN-Gz
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 00:25:46 +0000
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym01.jp.fujitsu.com with smtp
 id 1c51_5db0_a93f9905_bde4_4c77_8ea2_1f0d5d0cb546;
 Thu, 13 Dec 2018 09:25:26 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 97352AC00C2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 09:25:25 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id 8715C692658;
 Thu, 13 Dec 2018 09:25:24 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0352.000; Thu, 13 Dec 2018
 09:25:24 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Will Deacon' <will.deacon@arm.com>
Subject: RE: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
 huge_ptep_set_access_flags
Thread-Topic: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
 huge_ptep_set_access_flags
Thread-Index: AQHUUEGThB/6TLUQoEOVWBm28eC58KVDBEGQ//+sv4CAOaJdkA==
Date: Thu, 13 Dec 2018 00:25:23 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A271CE8@G01JPEXMBKW03>
References: <20180919174437.1866-1-steve.capper@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A031841@G01JPEXMBKW03>
 <20181106171436.GB28592@brain-police>
In-Reply-To: <20181106171436.GB28592@brain-police>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_162544_837565_B9DAD449 
X-CRM114-Status: GOOD (  11.07  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, 'Steve Capper' <steve.capper@arm.com>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Will Deacon

> Probably best to test the version that landed in mainline, as I think we
> went through a few revisions of this:
Sorry for late.

I did test on linux-4.18, but even without
your patch, test program has been passed.
The test program links some libraries, and the
libraries's version is different from linux-4.18
environment and linxu-4.16 environment which I
found this problem.

I backport commits as below to linux-4.16,
and my test program passed.

Thanks a lot for your help.

commit 469ed9d823b7d240d6b9574f061ded7c3834c167 
and
commit 031e6e6b4e1277e76e73a6ab209095ad9bf3ce52

Test environment
CPU: A64FX
Kernel version: v4.16.0

Tested-by: Lei Zhang <zhang.lei@jp.fujitsu.com>

Best Regards,
Lei, Zhang
zhang.lei@jp.fujitsu.com


> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Wednesday, November 07, 2018 2:15 AM
> To: Zhang, Lei/張 雷
> Cc: 'Steve Capper'; linux-arm-kernel@lists.infradead.org;
> catalin.marinas@arm.com
> Subject: Re: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
> huge_ptep_set_access_flags
> 
> Hi Lei Zhang,
> 
> On Tue, Nov 06, 2018 at 01:16:01PM +0000, Zhang, Lei wrote:
> > Sorry to late.
> > Thanks for your patch, and I will test your patch.
> 
> Probably best to test the version that landed in mainline, as I think we
> went through a few revisions of this:
> 
> http://git.kernel.org/linus/031e6e6b4e12
> 
> Thanks!
> 
> Will



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
