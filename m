Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06286C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C944520989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJxc7zx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C944520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ybZBwLKCt1RGpfkt9iwe39YAfAD2QrgVYVNkcDFD1I=; b=EJxc7zx/ATgwrD
	zPZUSdEuPghsTHmEfpzQUaG1uJeWukZjPzH7eW6EmLHLSqiK3js6+U9iTcyV7Zn4kMz6gximRH/Je
	zETkzKbeTXyy4oYrPcIZDMteyqfRLNTb78mQUUX2LD3YDhd449NsClFNHCC3bdV0Z4oR641Ir4yjl
	zjvStmBkD9BrhsWmFjFMmZ1fsoe5dp9rK6zIlpc+9qGJrtSE02r60B1f3SsqZgsH7fAbU/Y1HsUUJ
	2zgaxO2A/UZbBBFGjbDguwX3bDJdZCGj77mhpE5OYE60iWId3z7D3O3D14OZmYVuU0YhAZGDfNydf
	riqXCINapgzyt3RhAUgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPW9-0001Ye-Ay; Thu, 29 Nov 2018 16:50:21 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPW6-0000mW-DX
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:50:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECACA78;
 Thu, 29 Nov 2018 08:50:07 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20FB13F59C;
 Thu, 29 Nov 2018 08:50:05 -0800 (PST)
Date: Thu, 29 Nov 2018 16:49:57 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_get_platform_device_domain()
 uninitialized pointer value
Message-ID: <20181129164957.GA637@e107981-ln.cambridge.arm.com>
References: <20181129095559.26007-1-lorenzo.pieralisi@arm.com>
 <c16634d2-b6b7-1251-8b31-82fef94da3e2@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c16634d2-b6b7-1251-8b31-82fef94da3e2@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_085018_460166_3416A0B3 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>, linux-acpi@vger.kernel.org,
 Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 07:34:40PM +0800, Hanjun Guo wrote:
> On 2018/11/29 17:55, Lorenzo Pieralisi wrote:
> > Running the Clang static analyzer on IORT code detected the following
> > error:
> > 
> > Logic error: Branch condition evaluates to a garbage value
> > 
> > in
> > 
> > iort_get_platform_device_domain()
> > 
> > If the named component associated with a given device has no IORT
> > mappings, iort_get_platform_device_domain() exits its MSI mapping loop
> > with msi_parent pointer containing garbage, which can lead to erroneous
> > code path execution.
> 
> Not sure if we have such use cases that named component associated with
> a given device has no IORT mappings, but this patch still make sense to
> me,

Yes, it is to make the kernel more robust against questionable (but valid)
firmware bindings.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
