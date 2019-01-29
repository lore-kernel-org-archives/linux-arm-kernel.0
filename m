Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC21C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:19:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6289A20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g+tDdq+T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tuz7be0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:
	In-Reply-To:To:From:Subject:Mime-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XtuEwid2G/pd3n6aj4IHGJet3DSmaEVTIrtuYevEbew=; b=g+tDdq+TAOM6N3
	PdV1M2BT76CjqW5GAnVlLgZQMA5PiY/rU6gYjSqETF3wjh0GF9rWFj6fjB2YoikS3B9MKGKRoWB7U
	MMz6AsB4r11eS5EPD2zjCrx4Ev41gUY8fZdlEuVrf6qFq2FeDugkDNw2yDRm6c2ylQDj4gPR3GWPS
	HjW92BE6g4DW3G9WdeMXvw+wgEifIw0o59xECLAQvvfh/mAzXjgR7kdoPmidZpLh+GHwumI1P/ocE
	wzb+XV0c1v/h1ORwMDHCDMLwciMVHy77AZtOunlxEInk5mlSBvn3ArhCqo++Vmq0Xrf9LbzU6VzlX
	Qtde5JdkPLICvmY6J5sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goOby-0005du-2z; Tue, 29 Jan 2019 08:19:14 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goOao-0005Ya-Cd
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 08:18:13 +0000
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20190129081759epoutp019e92a2b2c58da57bc40ea7aea9fa4e71~_Q88ymtpU0134301343epoutp01I
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 08:17:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20190129081759epoutp019e92a2b2c58da57bc40ea7aea9fa4e71~_Q88ymtpU0134301343epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548749879;
 bh=Lap3XF/zuD/GvbLv0QytfXAXvTHVQDX9QALbPssZsFU=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=tuz7be0k2BgsRKDqbMi4cJwt/K3Hfb6F6STDnc5D8zN/qLWP7Fpvz//bz0xG4XLB0
 1DKRr1HF+X3PHuCQMyrjdEdxkaNuiH31ic+wtiUwWRwdnG2uVBOMyzGLDwDNsKC6am
 wXUGkY/ndwrzhnHk8OzI5pEMnS+n27VXFev9IeeM=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190129081755epcas1p18b8fc9355a39f9f1c684510aeb15f77f~_Q85zfS2C1782117821epcas1p1e;
 Tue, 29 Jan 2019 08:17:55 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-a0-5c500c2f1609
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 14.2A.04074.F2C005C5; Tue, 29 Jan 2019 17:17:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 3/3] devfreq: add mediatek cci devfreq
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545@epcms1p4>
Date: Tue, 29 Jan 2019 17:17:50 +0900
X-CMS-MailID: 20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA12TaUxTWRiGPb29C441hxb1BB2n3qgTTEp7rYUDijHKmBtFbXR+TGZQvIEb
 IF3TW4y7jWJQRnEjURApGoyInSCVzV0rElRE0QhuJQaZjAtqJlQTgltL22j89573vOd7vrMx
 hLKLimfyrU7RYRXMLDVa3nQtIVGjHWPM1HUPqnBz3QsSv/Ql4J7AfyR2t3aS+MPTYRm+vXWA
 xt7n3SS+f66Cwve3dQE8uLsV4OM9XTK8tVCPO27dI/H2i600PuhX4vr3/DzIeyo9gD9b7qd5
 b+1Oin/afYHiz1Rv4QtvXJbzDQ+K5HxJQy3gB72TjTF/mubkiUKO6FCL1mxbTr41N41dvCJr
 QZYhScdpuBSczKqtgkVMY9MzjJqF+ebgFlj1GsFcELSMgiSx2rlzHLYCp6jOs0nONFa055jt
 KfZESbBIBdbcxGybJZXT6WYagsHVprwz/Scpu59cu7vqHuECj+XFIIZBcBY6XdJHFoPRjBK2
 ABRwu+hiwDAKGIs+tahCGRVMRa+b3bKQVkIWuR5dIsK+Fu141gRCmoIa1HjaLw/ViYMVMtTu
 qxkZEHCYQEWBK3SYpkCHiv6NkCei5hONIASLgUvQQI0UtsehR6fe0FH9rs0NwjoObe+9TYR1
 LHo2dB5Eyxwq/RIpuQH17eoiQlwECwGqLWuShSe0qOPIDSqkFUHWjqG2EYAcTkPd7fWRTDry
 tPeMAAj4C2p+U0GEeiNgAqo7p42276ofpn/UBByL3r7fRUb9lsr+SMnpyHe+OpKfhG4dPBrp
 n0euhlfyvWBK+bejLv8OXP4NXAWIWjBetEuWXFHi7Nz3t+sFI895hqEFlHZm+ABkADtGoaOW
 ZSpJYY20zuIDiCHYOAU3HLQUOcK69aLDluUoMIuSDxiC+99HxI/LtgU/h9WZxRlm6vV6PItL
 MnAcO0FRN29BphLmCk7RJIp20RFdJ2Ni4l2graOz1Jscu0evqJ7f1rMxMJB0k2+3matqNP+s
 XKRij95cylSaHpd5NvU69rlSh/73W46tMvZnPOxtFa9fkq2tLjHt/xxIv9qHnlT8/evUUfRf
 jcn0hQOL3MV/bHarP2Yml/4+abnKteziq6E7ZYd3zjbepT1Hfmv8+exP61Pe8fvTG1i5lCdw
 MwiHJHwFWVZd5eQDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190129063600epcas2p255b062c64f22555692ff895634ea4eb0
References: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190129063600epcas2p255b062c64f22555692ff895634ea4eb0@epcms1p4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_001802_824365_2D271855 
X-CRM114-Status: GOOD (  21.00  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
 "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

>From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
>
>For big/little cpu cluster architecture,
>not only CPU frequency, but CCI frequency will also affect performance.
>
>Little cores and cci share the same buck in Mediatek mt8183 IC,
>so we add a CCI devfreq which will get notification when buck voltage
>is changed, then CCI devfreq can set cci frequency as high as possible.
>
>Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>

Please correct the coding style first in the .c file.

- empty last line?
- inconsistent indentation (line26? match the first lines for all variable declarations OR don't match them at all)
- Need proper boilerplate and try to comply with C89.

Cheers,
MyungJoo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
