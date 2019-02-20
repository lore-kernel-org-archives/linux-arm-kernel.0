Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F68C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AB321902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGLCe3q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AB321902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2nKqDARUPAwqZkPDzI7rOLM07aKbtcmI2QLM2F32bls=; b=OGLCe3q4oPXFgF
	2h0WxM4LRYtYZP6WXeR1xM5XJWRHTtdYatw/vzH/callQwe/Ha9i1YF3JS1ZYqvcTCPjUyc+aY34C
	O7OWjTSpt8HC3EtzEHa62WmsPevPNFGYYBJ5wCGls5yvz15O+1hQLfNHPnVEI2F3CvDd8ZdWFKz2t
	NuEOQiZBu+SilFD69MAx0uTZou3eGFA2ssZvITQHndlj/3Scl28pJSYWd3GJypKns/0A6vHzoVpaT
	63LZE8iGolOeCdYey7TDKndKMYsV+8S5JuM+lwMV26nQk8FJDBt2/VAl6GrlMABMb07YLgSH8FAT/
	G8BpBeCAkonCjsn7jpiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTAN-0000J9-IZ; Wed, 20 Feb 2019 14:48:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTAK-0000If-U4; Wed, 20 Feb 2019 14:48:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2FA15AB;
 Wed, 20 Feb 2019 06:48:04 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312643F5C1;
 Wed, 20 Feb 2019 06:47:59 -0800 (PST)
Date: Wed, 20 Feb 2019 14:47:56 +0000
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
Message-ID: <20190220144756.GK7523@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550095217-12047-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_064804_979685_4AFBDB83 
X-CRM114-Status: GOOD (  17.12  )
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
 Peter Zijlstra <peterz@infradead.org>, linux-mips@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
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

On Wed, Feb 13, 2019 at 05:00:16PM -0500, Waiman Long wrote:
> Currently, we have two different implementation of rwsem:
>  1) CONFIG_RWSEM_GENERIC_SPINLOCK (rwsem-spinlock.c)
>  2) CONFIG_RWSEM_XCHGADD_ALGORITHM (rwsem-xadd.c)
> 
> As we are going to use a single generic implementation for rwsem-xadd.c
> and no architecture-specific code will be needed, there is no point
> in keeping two different implementations of rwsem. In most cases, the
> performance of rwsem-spinlock.c will be worse. It also doesn't get all
> the performance tuning and optimizations that had been implemented in
> rwsem-xadd.c over the years.
> 
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.
> 
> All references to RWSEM_GENERIC_SPINLOCK and RWSEM_XCHGADD_ALGORITHM
> in the code are removed.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/alpha/Kconfig              |   7 -
>  arch/arc/Kconfig                |   3 -
>  arch/arm/Kconfig                |   4 -
>  arch/arm64/Kconfig              |   3 -
>  arch/c6x/Kconfig                |   3 -
>  arch/csky/Kconfig               |   3 -
>  arch/h8300/Kconfig              |   3 -
>  arch/hexagon/Kconfig            |   6 -
>  arch/ia64/Kconfig               |   4 -
>  arch/m68k/Kconfig               |   7 -
>  arch/microblaze/Kconfig         |   6 -
>  arch/mips/Kconfig               |   7 -
>  arch/nds32/Kconfig              |   3 -
>  arch/nios2/Kconfig              |   3 -
>  arch/openrisc/Kconfig           |   6 -
>  arch/parisc/Kconfig             |   6 -
>  arch/powerpc/Kconfig            |   7 -
>  arch/riscv/Kconfig              |   3 -
>  arch/s390/Kconfig               |   6 -
>  arch/sh/Kconfig                 |   6 -
>  arch/sparc/Kconfig              |   8 -
>  arch/unicore32/Kconfig          |   6 -
>  arch/x86/Kconfig                |   3 -
>  arch/x86/um/Kconfig             |   6 -
>  arch/xtensa/Kconfig             |   3 -
>  include/linux/rwsem-spinlock.h  |  47 ------
>  include/linux/rwsem.h           |   5 -
>  kernel/Kconfig.locks            |   2 +-
>  kernel/locking/Makefile         |   4 +-
>  kernel/locking/rwsem-spinlock.c | 339 ----------------------------------------
>  kernel/locking/rwsem.h          |   3 -
>  31 files changed, 2 insertions(+), 520 deletions(-)
>  delete mode 100644 include/linux/rwsem-spinlock.h
>  delete mode 100644 kernel/locking/rwsem-spinlock.c

Another nice cleanup, and it looks like the optimistic spinning in the xadd
implementation is predicated on ARCH_SUPPORTS_ATOMIC_RMW, so we're all good
there too.

Acked-by: Will Deacon <will.deacon@arm.com>

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
