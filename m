Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8732C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9110C20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AoJHmi/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9110C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YC0eFL7lEa6d4Nkks+8vNk8Zlf2tqHN1YN8HJjHw298=; b=AoJHmi/7jsCRIJ
	UpMVU58p5wBtt0Jiq6ZwWxUi5tvja/c5Td+2au+P6Ug54z2RFgvWSvTDLac7Hu29f++PcY5ljBptm
	8FPjso5U8/YYCic/rbLxcnPnkb7rZgLoD7wIlu1NGRG2UTdABAWByH9n7CqNERjRJggjSr6gzl8BC
	mbn1IIwKoSwPeuKKFCGPhKaLw6F7uiMukbhJUkDd1jqoALyyZdgd8/F0FAUB9a324F8vP0vRVKexy
	hiAKUsSp9SglxGNF4Cn6HZzHh28IO4K0z6vJ5PROY7e3BSpN1EXInv/aoyCC9qZLL24AgEbSw+EeS
	F3RruXME/qMpyO/mRmIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHA9-000476-48; Fri, 21 Dec 2018 09:32:09 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaH9y-0003qb-DX
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 09:32:00 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A96E095207373;
 Fri, 21 Dec 2018 17:31:40 +0800 (CST)
Received: from [127.0.0.1] (10.40.57.36) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Fri, 21 Dec 2018
 17:31:35 +0800
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Will Deacon
 <Will.Deacon@arm.com>, "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 "Chengchuanning (Hisi-Turing)" <chengchuanning@hisilicon.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
From: Zhongmiao <zhongmiao@hisilicon.com>
Subject: question about broadcast invalidation and atc invalidation
Message-ID: <e33aad8d-ab12-e1c7-0b8b-85fe09260270@hisilicon.com>
Date: Fri, 21 Dec 2018 17:31:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
X-Originating-IP: [10.40.57.36]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_013158_691152_CEBDFBAC 
X-CRM114-Status: UNSURE (   4.16  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jean:
	Now Soft need to make sure build atc inv cmd to smmu after Execute 
"TLBI" (dvm sync). I don't think it's very reasonable. Why  Smmu The 
smmu automatically sends the inv atc command when smmu receive 
broadcast invalidation ?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
