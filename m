Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D076C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:55:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C73521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P9qdKM2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C73521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGp4ZEHtqv5XX9LfkEyHdh2Kb4qDbRB/hdSRl1if940=; b=P9qdKM2Vayo7BS
	PQKdKv+JWFUSojXGa02A70DrZqA9igWbgR1NcApP/NzCst92+1GlbwHRjBnCiMgsU5FFakVwLumpn
	G2gMFwZLl0BPECBn5mZrqD+zianbZBS9COZ3zpGa9cWMPW5+d4YcWxa3CCnP1Jt7CtAdT5XOozbND
	wJEBtndyk3EVYqVkgk7CKHgeHhZ7/rxdQpJoU627IyLRPnqZF6q0VSVJ4Ed0roED9L0BT5O9HlTe7
	VDlwNLPzVgghyr3FU+Rhm8oLaq7ONbGtjacE+glfuJa0bIZtQ0HnAjXA4eOsz9b6+WZ28vqaCHxY9
	tk0gLUkziH1X7/aS+DsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glxSg-0006SK-0e; Tue, 22 Jan 2019 14:55:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glxSb-0006Rg-TT
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 14:55:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67EE4A78;
 Tue, 22 Jan 2019 06:55:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FFCE3F589;
 Tue, 22 Jan 2019 06:55:24 -0800 (PST)
Date: Tue, 22 Jan 2019 14:55:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190122145522.GC52887@lakrids.cambridge.arm.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122054400.GB6445@brain-police>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_065529_957755_7953E0E1 
X-CRM114-Status: GOOD (  25.10  )
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
Cc: "Wangkefeng \(Kevin\)" <wangkefeng.wang@huawei.com>,
 anshuman.khandual@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 chenwandun <chenwandun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Tue, Jan 22, 2019 at 05:44:02AM +0000, Will Deacon wrote:
> On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:
> > On Sat, Jan 19, 2019 at 11:58:27PM +0000, Will Deacon wrote:
> > > On Thu, Jan 17, 2019 at 07:42:44AM +0000, chenwandun wrote:
> > > > Recently, I do some tests on linux-4.19 and hit a softlockup issue.
> > > > 
> > > > I find some CPUs get the spinlock in the __split_huge_pmd function and
> > > > then send IPI to other CPUs, waiting the response, while several CPUs
> > > > enter the __split_huge_pmd function, want to get the spinlock, but always
> > > > in queued_spin_lock_slowpath,
> > > > 
> > > > Because long time no response to the IPI, that results in a softlockup.
> > > > 
> > > > As to sending IPI, it was in the patch
> > > > 3b8c9f1cdfc506e94e992ae66b68bbe416f89610.  The patch is mean to send IPI
> > > > to each CPU after invalidating the I-cache for kernel mappings.  In this
> > > > case, after modify pmd, it sends IPI to other CPUS to sync memory
> > > > mappings.
> > > > 
> > > > No stable test case to repeat the result, it is hard to repeat the test procedure.
> > > > 
> > > > The environment is arm64, 64 CPUs. Except for idle CPU, there are 6 kind
> > > > of callstacks in total.
> > > 
> > > This looks like another lockup that would be solved if we deferred our
> > > I-cache invalidation when mapping user-executable pages, and instead
> > > performed the invalidation off the back of a UXN permission fault, where we
> > > could avoid holding any locks.
> > 
> > Looking back at commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after
> > invalidating the I-cache for kernel mappings"), the text implies that it
> > should only do this for kernel mappings. I don't think we need this for
> > user mappings. We have a few scenarios where we invoke set_pte_at() with
> > exec permission:
> 
> Yes, I think you're right. I got confused because in this case we are
> invalidating lines written by the kernel, but actually it's not about who
> writes the data, but about whether or not the page table is being changed.

IIUC we may have a userspace problem analagous to the kernel modules
problem, if userspace uses dlopen/dlclose to dynamically load/unload
shared objects.

If userspace unloads an object, then loads another, the new object might
get placed at the same VA. A PE could have started speculating
instructions from the old object, and IIUC the TLB invalidation and
I-cache maintenance don't cause those instructions be re-fetched from
the I-cache unless there's a context synchronization event.

Do we require the use of membarrier when loading or unloading objects?
If so, when does that happen relative to the unmap or map?

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
