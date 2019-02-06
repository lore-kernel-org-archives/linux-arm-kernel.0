Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7996C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:12:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C97207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oP6AR/MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C97207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oMBdqMYI+m91OTnuW66wWl0wNWlW81oqDQ6CbocXUvo=; b=oP6AR/MRPl+DWh
	Dwv08QzUT9eQRDnDBzCrgydM1NkQ5PzM0ZLzDE/r89Bun0SAg26GNi+BLH0n0FCGHFfXSxwqaX4jl
	WQRynyybvAtB2WJ26C8UnXvJJhBZ/myvKXuJTAjk5cL+WjICTQoHNHoFcgXhptc39C0MwaEjYDc3C
	vtoMTh15ZqaIZxyaYo50WQCtxlZk+/Hw0Kd9y52y4n/dEtoDe7mCUFgb7EAh0e81xpxjlm2ECwUx6
	v1LbT+DHLy6XrKwWd5nccW3QttsdHHpgvJtxO+VPWJLnSdWIIxYXznU2tMPp521V2bbrPq7LTyJyf
	b436N7gLX+pzJ2uDCpOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJFt-0000fz-HO; Wed, 06 Feb 2019 09:12:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJFp-0000fY-Ml
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:12:27 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1C89C058CA8;
 Wed,  6 Feb 2019 09:12:23 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CE5C18E2A;
 Wed,  6 Feb 2019 09:12:14 +0000 (UTC)
Date: Wed, 6 Feb 2019 10:12:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 01/27] KVM: Call kvm_arch_memslots_updated() before
 updating memslots
Message-ID: <20190206101211.253cfbd9.cohuck@redhat.com>
In-Reply-To: <20190205205443.1059-2-sean.j.christopherson@intel.com>
References: <20190205205443.1059-1-sean.j.christopherson@intel.com>
 <20190205205443.1059-2-sean.j.christopherson@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 06 Feb 2019 09:12:24 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_011225_759750_15FA9EA5 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 kvm@vger.kernel.org, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvm-ppc@vger.kernel.org,
 linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  5 Feb 2019 12:54:17 -0800
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> kvm_arch_memslots_updated() is at this point in time an x86-specific
> hook for handling MMIO generation wraparound.  x86 stashes 19 bits of
> the memslots generation number in its MMIO sptes in order to avoid
> full page fault walks for repeat faults on emulated MMIO addresses.
> Because only 19 bits are used, wrapping the MMIO generation number is
> possible, if unlikely.  kvm_arch_memslots_updated() alerts x86 that
> the generation has changed so that it can invalidate all MMIO sptes in
> case the effective MMIO generation has wrapped so as to avoid using a
> stale spte, e.g. a (very) old spte that was created with generation==0.
> 
> Given that the purpose of kvm_arch_memslots_updated() is to prevent
> consuming stale entries, it needs to be called before the new generation
> is propagated to memslots.  Invalidating the MMIO sptes after updating
> memslots means that there is a window where a vCPU could dereference
> the new memslots generation, e.g. 0, and incorrectly reuse an old MMIO
> spte that was created with (pre-wrap) generation==0.
> 
> Fixes: e59dbe09f8e6 ("KVM: Introduce kvm_arch_memslots_updated()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/mips/include/asm/kvm_host.h    | 2 +-
>  arch/powerpc/include/asm/kvm_host.h | 2 +-
>  arch/s390/include/asm/kvm_host.h    | 2 +-
>  arch/x86/include/asm/kvm_host.h     | 2 +-
>  arch/x86/kvm/mmu.c                  | 4 ++--
>  arch/x86/kvm/x86.c                  | 4 ++--
>  include/linux/kvm_host.h            | 2 +-
>  virt/kvm/arm/mmu.c                  | 2 +-
>  virt/kvm/kvm_main.c                 | 7 +++++--
>  9 files changed, 15 insertions(+), 12 deletions(-)

Not an x86 person, but I think that makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
