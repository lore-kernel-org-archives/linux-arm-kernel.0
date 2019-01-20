Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27027C636A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:04:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD2D20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 15:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eWrEKayv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="vGvz/A4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD2D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:From:Date:
	MIME-Version:Subject:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=heqHxmRRF7LbbAC1R/qYtUMTN4PhG8ySU/G98DLKcBY=; b=eWrEKayvAsvKPerVKpNy5aQ5l
	dSLn1UtRqRPjPKMuuYizRhQjb47Ieoluq+tGVIiU1Rtzuu5sA5NzGEWBbhX+ZDA8b24X+wDDy77Dm
	quGFF8ELIYGe2SualgDnPr5X4ZQXTsUR1PGlBRNIgp0oVjuIAMij0lh0WpyF/QsHN3lkfvadSEcpO
	bhx25iL089H0q1Jo8nABiWGZL4Wk2FQGwKXpsazJso0IJCH2cJoBKDC7WSNI8vF1Fq7xvwIx5OhVf
	/x8JYAGSFHWr3N3LfVbIgdO9llk7rW9IPxWpAVPGq91n5vjC0qZfGSlLaGwtd0OR6MVcQLJGdFT3k
	pFVw+Dq7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glEe9-0001Wq-Ok; Sun, 20 Jan 2019 15:04:25 +0000
Received: from node.akkea.ca ([192.155.83.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glEe6-0001WS-KY
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 15:04:24 +0000
Received: by node.akkea.ca (Postfix, from userid 33)
 id 722E14E204B; Sun, 20 Jan 2019 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1547996662; bh=DxYXAu0vuWUECNVXh5x1ydx8O/cp3oY+010U6gpDSpM=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References;
 b=vGvz/A4Ei8hE7wjFL7BPvVzaD6wQvvXm2JRnyRQWBmeHEu8LvSRg9nNmKPPlZSxvv
 TsgF70gA+Dgb4pd58l3V2wDvIyLSZRr9b1mrv9fYUdfa5Xe0JoVk419WOuU6WT1bp9
 gjT9RI3tlea8huUsWHlAWi8S8PzkojMf4rhMrl/0=
To: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 1/3] dma: imx-sdma: fix NULL pointer de-reference
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Date: Sun, 20 Jan 2019 08:04:22 -0700
From: Angus Ainslie <angus@akkea.ca>
In-Reply-To: <CAEnQRZDzvmn-6YyoQRrWbkbH8d1ej8aFE1wFAiXQtqzHxyW2eA@mail.gmail.com>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190120023150.17138-2-angus@akkea.ca>
 <CAEnQRZDzvmn-6YyoQRrWbkbH8d1ej8aFE1wFAiXQtqzHxyW2eA@mail.gmail.com>
Message-ID: <1bd1b8ad44dc8e1cd65e73111764b94e@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_070422_672272_8E99476F 
X-CRM114-Status: UNSURE (   7.15  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, dmaengine@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-20 02:54, Daniel Baluta wrote:
> On Sun, Jan 20, 2019 at 4:34 AM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> 
>> On the imx8mq I get NULL pointer de-deference errors if the device
>> isn't passed in during allocation.
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> 
> Hi Angus,
> 
> I have already sent a fix for this:
> 
> https://patchwork.kernel.org/patch/10758203/

Sorry, I missed that. I'll drop it for V3.

Angus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
