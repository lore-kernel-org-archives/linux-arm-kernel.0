Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B3C10F02
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:41:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A5B222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uOre0tnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A5B222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=69TNEuDmN74Lnxe7kIujMky/3FRZckd6IZMHrZRkRPc=; b=uOre0tnHsgtr6b
	7HKWBORbD6fnD/nNdjuU7Uc/+gOeFujDSzIleehMkYgVgEl8Q9DtcxAC8AmtAqnalAJzX6AYMNJTf
	7E2YtXPOucm6zu1CfNh6eMAvs2vCNlQb/cLWwb/OvCQEqiyzfdhVjCsNNJgWv3OUZ1iPK7IUfD2Vg
	MiyfwEFcMvpymQczi/Iz+/IKJOyPz/vwHSuCsEDLbgMadh7KPFseZt36FS6evFSGPUejP+ED24CC/
	JxskJryuiqaRZ39RVLgaaSdAqjQx0L8XxfV/K+oJy10DYVB88IgTbFojcwNQ0AtLE4Dm42OS881vC
	ELEu1DNk/dpRlOX0Nfew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiQ7-0002af-5r; Fri, 15 Feb 2019 18:41:07 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiQ4-0002Zs-77; Fri, 15 Feb 2019 18:41:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F399A78;
 Fri, 15 Feb 2019 10:41:03 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937D53F589;
 Fri, 15 Feb 2019 10:40:58 -0800 (PST)
Date: Fri, 15 Feb 2019 18:40:56 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Message-ID: <20190215184056.GC15084@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <20190214103715.GI32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_104104_268020_F9D3C113 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:37:15AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> > v4:
> >  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> > 
> > v3:
> >  - Optimize __down_read_trylock() for the uncontended case as suggested
> >    by Linus.
> > 
> > v2:
> >  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
> >  - Update performance test data in patch 1.
> > 
> > The goal of this patchset is to remove the architecture specific files
> > for rwsem-xadd to make it easer to add enhancements in the later rwsem
> > patches. It also removes the legacy rwsem-spinlock.c file and make all
> > the architectures use one single implementation of rwsem - rwsem-xadd.c.
> > 
> > Waiman Long (3):
> >   locking/rwsem: Remove arch specific rwsem files
> >   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
> >     archs
> >   locking/rwsem: Optimize down_read_trylock()
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> with the caveat that I'm happy to exchange patch 3 back to my earlier
> suggestion in case Will expesses concerns wrt the ARM64 performance of
> Linus' suggestion.

Right, the current proposal doesn't work well for us, unfortunately. Which
was your earlier suggestion?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
