Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F1FC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:02:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF6220848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9qhFWJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF6220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7F+/AqyPcNwa8Zpw2s4fITkLEd7aWhxf9BolT6AsE0M=; b=W9qhFWJUb45ogp
	EovVKcQ7ZCsObadWvSmR/HNGjkzIaM6Buk4gM/L8mu5SvFU3CSOyxnl32xVsq9IfjgK89LG6QWXF8
	1O8zFKUu6Cu8e5nt1ScSKCLvV20Hc21zDzP2sMBIYpl7omU2BQwaP/mYoQ0AqK6TqsWkPFFKwDgpJ
	22r6J4gXLyS9PrYyjNrXjJUEjUHkhGOtxGT6Yx/JtlXLbuPxLfp7KIGeGGZyp4WHbMAaaNB8fO4ef
	lDmaN0tZWJpAOL/N8OUGrhqmtNosOb6F7z0nTx3zv2npS4xyoyaWToyS3ieDJApn3P7A3iC8huZsn
	4v/eDrtF/bW8JYaXeeBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqgH-0000VK-DW; Mon, 03 Dec 2018 16:02:45 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqgB-0000UX-LZ
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:02:44 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 223F430832E8;
 Mon,  3 Dec 2018 16:02:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E8F194BA;
 Mon,  3 Dec 2018 16:02:27 +0000 (UTC)
Date: Mon, 3 Dec 2018 17:02:25 +0100
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 02/12] KVM: arm/arm64: Factor out hypercall handling from
 PSCI code
Message-ID: <20181203160225.4vhoe4slwyyx2mlw@kamzik.brq.redhat.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181128144527.44710-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128144527.44710-3-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 03 Dec 2018 16:02:29 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_080239_720713_390D253B 
X-CRM114-Status: GOOD (  15.27  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 02:45:17PM +0000, Steven Price wrote:
> From: Christoffer Dall <christoffer.dall@arm.com>
> 
> We currently intertwine the KVM PSCI implementation with the general
> dispatch of hypercall handling, which makes perfect sense because PSCI
> is the only category of hypercalls we support.
> 
> However, as we are about to support additional hypercalls, factor out
> this functionality into a separate hypercall handler file.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> [steven.price@arm.com: rebased]
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm/kvm/Makefile        |  2 +-
>  arch/arm/kvm/handle_exit.c   |  2 +-
>  arch/arm64/kvm/Makefile      |  1 +
>  arch/arm64/kvm/handle_exit.c |  4 +-
>  include/kvm/arm_hypercalls.h | 43 ++++++++++++++++++++
>  include/kvm/arm_psci.h       |  2 +-
>  virt/kvm/arm/hypercalls.c    | 51 ++++++++++++++++++++++++
>  virt/kvm/arm/psci.c          | 76 +-----------------------------------
>  8 files changed, 102 insertions(+), 79 deletions(-)
>  create mode 100644 include/kvm/arm_hypercalls.h
>  create mode 100644 virt/kvm/arm/hypercalls.c
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
