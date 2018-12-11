Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F92DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7902081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tYypjoWd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UgycLoZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7902081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:
	In-Reply-To:To:From:Subject:Mime-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o7zel3aD6dhLrcbelh4Sv9xNAFcmbuphRYJRICpa7eo=; b=tYypjoWdxCaPar
	uE2xUvGHHye2O6IHu+m6fqP04TWTvgws/jlhnCPaXRaD/vQ0+sKVLWLILZpCM6Cpu8MC/0nvQKFzq
	MJg4eLmKO/aeYy71OZB1BY3kmLNl4FAEZDpt0yY2iXuTEPA4GyHMUps4Ll80+ym38yasQ34sXEOMc
	qDfG7jhu+zT04+GLkCGCsG8BYWgSpJ5XBCXpvf9310petM/9eIHWiWb4AqdpeN7N/gTM2115NriSl
	sZ0ElHY2/1Cew64qvIPHdXrud/GZu2SX2vqfJMgunoLAhZaK/7KV1fiJ7k07AFkrygLSo6a+ao/Wd
	5NUtG9tssX+JbD1WpM+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWXTs-0007oV-Ae; Tue, 11 Dec 2018 02:09:04 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWXTo-0007nM-0m
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:09:02 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20181211020846epoutp047e454e83a7a11fb6ed15acef61ba42af~vJTmbd0Re3115331153epoutp04F
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:08:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20181211020846epoutp047e454e83a7a11fb6ed15acef61ba42af~vJTmbd0Re3115331153epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544494126;
 bh=JRYjBeYdAr7qUL3TVlzuVljrhnrxHB4n8DMePESxSno=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=UgycLoZ2WBNqwYg4EekVmDp5DcP8PFz4wMFm9ggziEdYIhRsTK2ncol47EcEiQ2hO
 aOUV0EqC9ak/e3pYYXOoTIXxSwGJcGc0qAdj3L83wCLIciUW1150C3BnZLVE9eQdop
 5XEnbxgUHQufG2X5xYlg0rYasQdRs2qk9unrbHSQ=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181211020843epcas1p13abbf3ec41f015f540f1c82417697d0e~vJTjS8gko0174601746epcas1p1v;
 Tue, 11 Dec 2018 02:08:43 +0000 (GMT)
X-AuditID: b6c32a39-ff9ff70000000fe0-e7-5c0f1c2bcb06
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.5B.04064.B2C1F0C5; Tue, 11 Dec 2018 11:08:43 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v3 1/5] devfreq: refactor set_target frequency function
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Lukasz Luba <l.luba@partner.samsung.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org"
 <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1544007956-28889-2-git-send-email-l.luba@partner.samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181211020842epcms1p759449289d0574d47847d2df4a1f8d482@epcms1p7>
Date: Tue, 11 Dec 2018 11:08:42 +0900
X-CMS-MailID: 20181211020842epcms1p759449289d0574d47847d2df4a1f8d482
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkl+LIzCtJLcpLzFFi42LZdljTQFdbhj/GoPEVq8XBrZoWG2esZ7XY
 vvEbq8X1L89ZLeYfOcdq0bx4PZvFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLWVP2MllsenyN
 1eLyrjlsFp97jzBazDi/j8li7ZG77BZLr19ksrh76ihQ++lLrBate4+wW7St/sBq8ebCPRYH
 cY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j4Ls9TB5b
 rrazePRtWcXosWL1d3aPz5vkAviism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
 lRTyEnNTbZVcfAJ03TJzgN5XUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugV
 J+YWl+al6yXn51oZGhgYmQIVJmRnHLm4ibXgMHPFlbYDLA2M/5m6GDk5JARMJD5NX8DSxcjF
 ISSwg1HictcHxi5GDg5eAUGJvzuEQUxhAW+J/kdhIOVCAkoSDTf3MYPYwgL6Eh0PtjGC2GwC
 uhJbN9wFGyMi0MgssWTPF1YQh1lgMpvErGcNbBDLeCVmtD9lgbClJbYv3wrWzQm04O7fzVA1
 ohI3V79lh7HfH5vPCGGLSLTeO8sMYQtKPPi5GyouJfHk7UKo+nqJ658XMYEslhCYwCjx+8Z/
 qIS+xKMrs8EW8Ar4SjTN/A7WzCKgKrH++np2kC8lBFwkGqZzgoSZBeQltr+dwwwSZhbQlFi/
 Sx8izCfx7msPK8wrO+Y9gYahmsSh3UugNslInJ6+EOpMD4k1//ewQ8L2MqPE6QcT2Scwys9C
 BO8sJNtmIWxbwMi8ilEstaA4Nz212LDAFDlGNzGCk7+W5Q7GY+d8DjEKcDAq8fBWtPHFCLEm
 lhVX5h5ilOBgVhLh1U3jjRHiTUmsrEotyo8vKs1JLT7EaAr080RmKdHkfGBmyiuJNzQ1MjY2
 tjAxNDM1NFQS530iNTdaSCA9sSQ1OzW1ILUIpo+Jg1OqgVHj2DwHkYXu+i9sAzc+UkqMfHdr
 R/3OM03Tg15ecJunH3U05rrVy1mxm48H5V5KadBcVavw/9cqfnGGCVwipwL2NU8yWi7z0Vv2
 3KMvdjevhtskr2r5nPazcnvze+tnRzm2Wsd84Gi/3zpnz1t3hnbPI9abWo3Kr3qU/Ss04hEq
 ue6u9veslK4SS3FGoqEWc1FxIgCXedRSFAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c
References: <1544007956-28889-2-git-send-email-l.luba@partner.samsung.com>
 <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c@epcms1p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_180900_411687_21F0951D 
X-CRM114-Status: GOOD (  18.65  )
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
Reply-To: myungjoo.ham@samsung.com
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "len.brown@intel.com" <len.brown@intel.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "anton@enomsg.org" <anton@enomsg.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "kgene@kernel.org" <kgene@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
 "ccross@android.com" <ccross@android.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> The refactoring is needed for the new client in devfreq: suspend.
> To avoid code duplication, move it to the new local function
> devfreq_set_target.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
