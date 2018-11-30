Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6434EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:21:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355BB2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eyp+mqAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355BB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NE/cknJxbKxBwE2zCm4KCw14+5t3z7c7iUe1nCdHt+E=; b=Eyp+mqAvnBm++o
	2uPwSlxP1epqLW8SYfLcqbxEqTQGtO3f3SjQh1LK3Ivt2gB1tC8FxjwaRwjGA5dCSN/GE/0cSSx+P
	g4IBAEzl/wT18qx+jOVza9SSLHz17MizbKrDSLLlDWd63FoywugV245HHHGqsLHJH29V4xmWKfuj4
	dsOHD4r8kJCGnyEvqJu3bmGjGwsfGcNK4Sbqhe6yQ1o3QuOTtX8RPh3Xyi95Mj6Pg3S855JyfKHl0
	gE0lHmnVxRPvbLST5ZPwdwlh9IFsH/DuNVN8MTgNzWggssjZHMXRlHOOBTEyOFJ/TLGhiqqMiqrhg
	9WuXIvSOwDGJ7LWSkODg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSij7-0002wF-KJ; Fri, 30 Nov 2018 13:21:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSij1-0002uZ-E9
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:20:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B256CA78;
 Fri, 30 Nov 2018 05:20:44 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8167F3F5A0;
 Fri, 30 Nov 2018 05:20:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 4D43B1AE12D3; Fri, 30 Nov 2018 13:21:03 +0000 (GMT)
Date: Fri, 30 Nov 2018 13:21:03 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_get_platform_device_domain()
 uninitialized pointer value
Message-ID: <20181130132102.GC9000@arm.com>
References: <20181129095559.26007-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129095559.26007-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_052055_590446_137BB25F 
X-CRM114-Status: GOOD (  19.23  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Patrick Bellasi <patrick.bellasi@arm.com>, linux-acpi@vger.kernel.org,
 Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 09:55:59AM +0000, Lorenzo Pieralisi wrote:
> Running the Clang static analyzer on IORT code detected the following
> error:
> 
> Logic error: Branch condition evaluates to a garbage value
> 
> in
> 
> iort_get_platform_device_domain()
> 
> If the named component associated with a given device has no IORT
> mappings, iort_get_platform_device_domain() exits its MSI mapping loop
> with msi_parent pointer containing garbage, which can lead to erroneous
> code path execution.
> 
> Initialize the msi_parent pointer, fixing the bug.
> 
> Fixes: d4f54a186667 ("ACPI: platform: setup MSI domain for ACPI based
> platform device")
> Reported-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Looks like one for 4.20.

Will

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 2a361e22d38d..70f4e80b9246 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -700,7 +700,7 @@ static void iort_set_device_domain(struct device *dev,
>   */
>  static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
>  {
> -	struct acpi_iort_node *node, *msi_parent;
> +	struct acpi_iort_node *node, *msi_parent = NULL;
>  	struct fwnode_handle *iort_fwnode;
>  	struct acpi_iort_its_group *its;
>  	int i;
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
