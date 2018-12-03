Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D434CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:32:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A604C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ilJ5Dva1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A604C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t22hw5EoG24Hgow6rW0NT/JC5kebRpJ7FpqsLn+eDHo=; b=ilJ5Dva10tZTLj
	XoN9cDtly8o5snGvHxrzWRGZSe4TbZb4xIEpjNVv7z7EXq99ay6Da99mC1oXpxYcqZTIUDxD9iwaR
	kXW4URCtfv7vEdDaG6Yv4F2X4V++a/9DJ6wYGT2FTPaZ0ovh2xVVePfkX+CIuV8deOa39wwZYb5Pp
	89RRFBOZmcP2HBomEW4sGVIz2Jb21kpq5WleVdHN+rb9ajk5DyqA+Q6BlXXuvHBRoxRKe6zyflOxi
	S5i9OAykU9bd2Jnt7gpursXC22Xy4ncqgHE1XJiRpAt4r4+AMiLEWAHCpsdQtf3f6eC6xDzT7Kepe
	0D3WaQ/jqllBQwf/brwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToKv-0005pi-8R; Mon, 03 Dec 2018 13:32:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToKr-0005p1-Ns
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:32:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D46E80D;
 Mon,  3 Dec 2018 05:32:19 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49D473F614;
 Mon,  3 Dec 2018 05:32:17 -0800 (PST)
Subject: Re: [PATCH v9 2/8] KVM: arm/arm64: Re-factor setting the Stage 2
 entry to exec on fault
To: Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-3-punit.agrawal@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
Date: Mon, 3 Dec 2018 19:02:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-3-punit.agrawal@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_053230_035678_BDA11FCD 
X-CRM114-Status: GOOD (  20.78  )
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
Cc: suzuki.poulose@arm.com, marc.zyngier@arm.com, will.deacon@arm.com,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 punitagrawal@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> Stage 2 fault handler marks a page as executable if it is handling an
> execution fault or if it was a permission fault in which case the
> executable bit needs to be preserved.
> 
> The logic to decide if the page should be marked executable is
> duplicated for PMD and PTE entries. To avoid creating another copy
> when support for PUD hugepages is introduced refactor the code to
> share the checks needed to mark a page table entry as executable.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 59595207c5e1..6912529946fb 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1475,7 +1475,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  unsigned long fault_status)
>  {
>  	int ret;
> -	bool write_fault, exec_fault, writable, force_pte = false;
> +	bool write_fault, writable, force_pte = false;
> +	bool exec_fault, needs_exec;

New line not required, still within 80 characters.

>  	unsigned long mmu_seq;
>  	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
>  	struct kvm *kvm = vcpu->kvm;
> @@ -1598,19 +1599,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (exec_fault)
>  		invalidate_icache_guest_page(pfn, vma_pagesize);
>  
> +	/*
> +	 * If we took an execution fault we have made the
> +	 * icache/dcache coherent above and should now let the s2

Coherent or invalidated with invalidate_icache_guest_page ?

> +	 * mapping be executable.
> +	 *
> +	 * Write faults (!exec_fault && FSC_PERM) are orthogonal to
> +	 * execute permissions, and we preserve whatever we have.
> +	 */

Otherwise looks good.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
