Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A27FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:55:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBBB20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZV7EHQ7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBBB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7+JXOY60+hcQKKEFR0HIMYSJEqH3ur5N/aInM2OA2ys=; b=ZV7EHQ7oDSqSxo
	DktRVjZFvH0ZyZaKi4jrpbJQMW0O/7fOtUqpBH3Tu0Lk+/n8PYGxmYzATQgURY16/p3gAaB73la0j
	JEe9fhhGjvyZXVYeQaKFnIjfx2U7kyBQqLLMr9H0PF269UjsQpwnUQLFtLAFMlRB8TqzMUm5cY1Wt
	8nlIYaSnAg7cJGGRhQ3yRmmQ/D0u71/Fo6QIo5jz9HYNLTEwlUJb2pUIofGlvWYniXt/A9s9zHY+v
	V/nBux5NnU7VpCYt5SX0SUBdT1R+iGrMZnT9H850cD++/X0o5R56f9FXojlAIxmHt6LlBCAsye10R
	hTzD+28ofCDT1wkEX5Jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcXzz-0002nh-B6; Thu, 27 Dec 2018 15:55:03 +0000
Received: from smtp3-g21.free.fr ([2a01:e0c:1:1599::12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcXzv-0002lp-0J
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 15:55:01 +0000
Received: from [192.168.108.68] (unknown [213.36.7.13])
 (Authenticated sender: marc.w.gonzalez)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 402D413F8B1;
 Thu, 27 Dec 2018 16:54:21 +0100 (CET)
Subject: Re: [PATCH v1] scsi: ufs: Use explicit access size in ufshcd_dump_regs
To: Vinayak Holikatti <vinholikatti@gmail.com>,
 Joao Pinto <jpinto@synopsys.com>
References: <3bf7ea8e-4cf2-1f9b-7f46-15609dfcad19@free.fr>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA52659@hasmsx108.ger.corp.intel.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <9ae9debe-5621-a729-e254-dbf1728dea99@free.fr>
Date: Thu, 27 Dec 2018 16:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA52659@hasmsx108.ger.corp.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_075459_198000_7E99433F 
X-CRM114-Status: UNSURE (   7.47  )
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
Cc: SCSI <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 MSM <linux-arm-msm@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>,
 "Winkler, Tomas" <tomas.winkler@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13/12/2018 23:34, Winkler, Tomas wrote:

> On 11/12/2018 15:18, Marc Gonzalez wrote:
> 
>> Fixes: ba80917d9932d ("scsi: ufs: ufshcd_dump_regs to use memcpy_fromio")
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>
> LGTM

Vinayak, Joao,

What do you think?

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
