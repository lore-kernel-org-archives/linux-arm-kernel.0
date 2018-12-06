Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87C820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GRJx9d9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87C820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D/zwdQ39VZ6cIgKmPiHkhuaI+PXRDrmWituFoqihaDk=; b=GRJx9d9Kyklt33
	v8GpdE6YFYVbyyCz0j0dwvxV+ZCCia0TyDJbqDHxeQnqjSrMszhFuiB7Z5EQZDFGCOXbEG35G9gUT
	fseHlXuro7nJwpO5eX5+/V+bOgm4rQg/3MEKzbGxMdrnPNxnPkAhRiH0WQsfM7FpSNbfon/lZql5z
	4uT/5wIYICo48khO8wzKyJ/FRp/veSDYJhNiX7kB36Q/uIs4v+OmizDiZd7hcsowX5qmfeedLBc2W
	ihHi36OdNWIUQTNn2DhKr6lmGcJJQhTRXkE87k0wqZogdXXQ8+jhr4/Y/+0tDLvJpzsNOEKxUILUl
	euPdFvxKaCk4WoJW6n6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwLV-00049C-GS; Thu, 06 Dec 2018 16:17:49 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwLS-0003yN-9q
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:17:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979FA80D;
 Thu,  6 Dec 2018 08:17:35 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 EC1773F5AF; Thu,  6 Dec 2018 08:17:32 -0800 (PST)
Date: Thu, 6 Dec 2018 16:17:30 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 14/25] arm64: KVM/mm: Move SEA handling behind a
 single 'claim' interface
Message-ID: <20181206161730.GM54495@arrakis.emea.arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-15-james.morse@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203180613.228133-15-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_081746_344466_5A7C653F 
X-CRM114-Status: GOOD (  14.52  )
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
Cc: Tony Luck <tony.luck@intel.com>, Fan Wu <wufan@codeaurora.org>,
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:06:02PM +0000, James Morse wrote:
> To split up APEIs in_nmi() path, the caller needs to always be
> in_nmi(). Add a helper to do the work and claim the notification.
> 
> When KVM or the arch code takes an exception that might be a RAS
> notification, it asks the APEI firmware-first code whether it wants
> to claim the exception. A future kernel-first mechanism may be queried
> afterwards, and claim the notification, otherwise we fall through
> to the existing default behaviour.
> 
> The NOTIFY_SEA code was merged before considering multiple, possibly
> interacting, NMI-like notifications and the need to consider kernel
> first in the future. Make the 'claiming' behaviour explicit.
> 
> Restructuring the APEI code to allow multiple NMI-like notifications
> means any notification that might interrupt interrupts-masked
> code must always be wrapped in nmi_enter()/nmi_exit(). This will
> allow APEI to use in_nmi() to use the right fixmap entries.
> 
> Mask SError over this window to prevent an asynchronous RAS error
> arriving and tripping 'nmi_enter()'s BUG_ON(in_nmi()).
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
