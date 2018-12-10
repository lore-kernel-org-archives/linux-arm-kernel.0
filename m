Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:00:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53BA2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvnrPpXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53BA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iGqnIBUv1buEyxd7UIKoW0cEAwJh4x7fmYqK8+yRXM8=; b=IvnrPpXo4//PYA
	22YN+hiwV110t8KVPBzg3HhRHjr9W60JFhmlbVF1YWjTcY/l7dZCBYATlzRwaxH3xH7LopC6rS+gG
	vZUEE0aBedB/HrrU4d5b6hHNUjO1WSYUNJAes/c4aCNToXR0MR/wyja60vUX6xxcCltpN9ZRy8wFT
	q7fHpNMWbTFv3/egYyX/841rtHf6KWC804k+ByzDJqt4SKk4yQ7M4j7i5lWlVPvKGMDy8RoPxeGyC
	QAHbzK/ceowotuZsw0EhxHLwbCkGClVb8PvhoJ/+GmE1D908VBwsJiv2IvRLxNgUlfZfaUN3HDwu9
	ArwhD9NNrVwuDIIplkrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHQJ-0005KX-Aw; Mon, 10 Dec 2018 09:00:19 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHQE-0004DE-P6
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:00:17 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB321596;
 Mon, 10 Dec 2018 01:00:03 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4648C3F575;
 Mon, 10 Dec 2018 01:00:03 -0800 (PST)
Date: Mon, 10 Dec 2018 10:00:01 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v9 2/8] KVM: arm/arm64: Re-factor setting the Stage 2
 entry to exec on fault
Message-ID: <20181210090001.GD30263@e113682-lin.lund.arm.com>
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-3-punit.agrawal@arm.com>
 <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
 <f078ae84-9906-4394-957f-8f041b08827f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f078ae84-9906-4394-957f-8f041b08827f@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010014_885577_458C93B5 
X-CRM114-Status: GOOD (  21.33  )
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
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 Punit Agrawal <punit.agrawal@arm.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, punitagrawal@gmail.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 10:47:10AM +0000, Suzuki K Poulose wrote:
> 
> 
> On 03/12/2018 13:32, Anshuman Khandual wrote:
> >
> >
> >On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> >>Stage 2 fault handler marks a page as executable if it is handling an
> >>execution fault or if it was a permission fault in which case the
> >>executable bit needs to be preserved.
> >>
> >>The logic to decide if the page should be marked executable is
> >>duplicated for PMD and PTE entries. To avoid creating another copy
> >>when support for PUD hugepages is introduced refactor the code to
> >>share the checks needed to mark a page table entry as executable.
> >>
> >>Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> >>Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>Cc: Christoffer Dall <christoffer.dall@arm.com>
> >>Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>---
> >>  virt/kvm/arm/mmu.c | 28 +++++++++++++++-------------
> >>  1 file changed, 15 insertions(+), 13 deletions(-)
> >>
> >>diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> >>index 59595207c5e1..6912529946fb 100644
> >>--- a/virt/kvm/arm/mmu.c
> >>+++ b/virt/kvm/arm/mmu.c
> >>@@ -1475,7 +1475,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  			  unsigned long fault_status)
> >>  {
> >>  	int ret;
> >>-	bool write_fault, exec_fault, writable, force_pte = false;
> >>+	bool write_fault, writable, force_pte = false;
> >>+	bool exec_fault, needs_exec;
> >
> >New line not required, still within 80 characters.
> >
> >>  	unsigned long mmu_seq;
> >>  	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
> >>  	struct kvm *kvm = vcpu->kvm;
> >>@@ -1598,19 +1599,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >>  	if (exec_fault)
> >>  		invalidate_icache_guest_page(pfn, vma_pagesize);
> >>+	/*
> >>+	 * If we took an execution fault we have made the
> >>+	 * icache/dcache coherent above and should now let the s2
> >
> >Coherent or invalidated with invalidate_icache_guest_page ?
> 
> We also do clean_dcache above if needed. So that makes sure
> the data is coherent. Am I missing something here ?
> 

I think you've got it right.  We have made the icache coherent with the
data/instructions in the page by invalidating the icache.  I think the
comment is ok either way.

Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
