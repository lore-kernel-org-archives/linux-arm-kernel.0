Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893ACC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F9D20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ixTRF/vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F9D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s5d5SeObqbRPCaficny8qm+9ftdGllsq1/p48QTZ+Jg=; b=ixTRF/vCi95qWN
	otUH0+tE8Gii/+dYE9oNn43CxowcDrES8qvOQSndyZUvOZD/B8sD6wCvuKMa8LUVLyJyQzSfTbeLw
	KUYkzd0ADyyu694dEvQ3WkfoxfsysOSzQTx29T3uekFzIq6WeIYrptXLyX7ILtEaSjivQCrdjuguF
	FCQtiW6kB/3rv1rLRGOYJmxJZzXtOQ8g2y0sBnnGkrQvZhf5hw+1R8+tm+ZBQkP4GOnQ7pIp/MYq8
	/Y3x72L58DBndVnMJPFpW+WY6uvy+Ho3s6T5oTI7U7P5VYCmbIcpi/K+E8G/YA5rBNsjLYCMxFdnQ
	i9e6yhBj9nvYeJFMrtxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTr5w-0004ui-0h; Mon, 03 Dec 2018 16:29:16 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTr5t-0004lg-FU
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:29:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9DB71682;
 Mon,  3 Dec 2018 08:29:00 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F943F59C;
 Mon,  3 Dec 2018 08:28:58 -0800 (PST)
Date: Mon, 3 Dec 2018 16:28:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] misc: vexpress: Off by one in vexpress_syscfg_exec()
Message-ID: <20181203162808.GA14028@e107155-lin>
References: <20181203145219.brmtuv26dj3vnc5y@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203145219.brmtuv26dj3vnc5y@kili.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_082913_518338_A47438F5 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: kernel-janitors@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Pawel Moll <pawel.moll@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 05:52:19PM +0300, Dan Carpenter wrote:
> The > comparison should be >= to prevent reading beyond the end of the
> func->template[] array.
> 
> (The func->template array is allocated in vexpress_syscfg_regmap_init()
> and it has func->num_templates elements.)
> 
> Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch, thanks for identifying and fixing this.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I assume Greg will pick this up, if not I will add this when I send
pull request next time(not sure when yet as I don't have anything for
v4.21)

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
