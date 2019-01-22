Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA46EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:18:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9567E20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YegRVgAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9567E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4FavYZqPcNGQvWTOxCgLnFrm2gtlDLKA78Upm6Bw4s0=; b=YegRVgAs306CJ9tcMvFAxhAXi
	WlyiOg3GhhSE67+u3X03dL3lQFTcYaDLiKUHbFqhSLhXhMWwK1mhtQtgjYaVRs3GuWR9nktDNBm27
	wYVEVx4G/dUvQkPdtRhwTr1CmkWq5QDJrk2AoWJW6gnPIMmoayR9+37aweCbE2fW272bd9xBSRtda
	bUtU4S8pQlJr54a1ZRN+HbKF9hvNRPoDoljWb8QyC63zf8u2SmjTd9OFLA+Rvy9B+E1b6ei2Pn3+Z
	a58DpohQWj+X31aznmL61FVUtG5bDjQztA/8PtoCJ6HmvkXWG/Zdsdaax4ZXpN9pF0vQWggULKt4B
	F/Q8vbdlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwss-0003Kj-8o; Tue, 22 Jan 2019 14:18:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwso-0003K5-UG
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:18:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9327EBD;
 Tue, 22 Jan 2019 06:18:30 -0800 (PST)
Received: from [10.37.10.44] (unknown [10.37.10.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 645E33F614;
 Tue, 22 Jan 2019 06:18:29 -0800 (PST)
Subject: Re: [PATCH 1/4] KVM: arm/arm64: extract duplicated code to own
 function
To: andrew.murray@arm.com, christoffer.dall@arm.com, marc.zyngier@arm.com
References: <1548154197-5470-1-git-send-email-andrew.murray@arm.com>
 <1548154197-5470-2-git-send-email-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7206aebe-0c12-70a5-4a83-0fa0c0b3fcd7@arm.com>
Date: Tue, 22 Jan 2019 14:20:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1548154197-5470-2-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_061830_985728_D78125A5 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/22/2019 10:49 AM, Andrew Murray wrote:
> Let's reduce code duplication by extracting common code to its own
> function.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
