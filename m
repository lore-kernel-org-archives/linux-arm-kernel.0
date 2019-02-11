Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A552BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651472186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NJdWVj2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651472186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=2iZvGgKLeFahmLXJlZPHxyBkJ2n3iXKLGW5sKppRJgs=; b=NJd
	WVj2UNftQ87r8EB4NE6hB8jj1AfxfQ1pXqwvzvWbcMEzcahquRfURWaA+Fj2Wum/YYI2WWOIP3Vgk
	g5/wizfkvebKFtVyLAun9T1Y3AWfoXwYNnmsMuZFTQcUkHbnubG536H1SwTiiWC/UHChsq9juHEGs
	boNnkPFhcVsSm+K58G6y/YYatwhFG7nxmdNYfQuyXJZLS+K48jNGwpYT0qgmP1U8xjMYnNQTXAR5h
	4rr9Kq0ojXCdRd5fASGRSPOI5g74Igu4XoH2R3+DDzYmu8E0J73dKhyPfqumajCiQSVBApMstaFLH
	1BQS2ENekzkkXmqeo6yvylxBhGHEIlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtHJ2-0006BL-Qr; Mon, 11 Feb 2019 19:31:52 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtHIy-0006AD-Kk
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 19:31:51 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BB6BA342F;
 Mon, 11 Feb 2019 19:31:47 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED255C21D;
 Mon, 11 Feb 2019 19:31:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 0/2] locking/rwsem: Remove arch specific rwsem files
Date: Mon, 11 Feb 2019 14:31:24 -0500
Message-Id: <1549913486-16799-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 11 Feb 2019 19:31:47 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_113148_707466_0DCF9312 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

v2:
 - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
 - Update performance test data in patch 1.

This is part 0 of my rwsem patchset. It just removes the architecture
specific files to make it easer to add enhancements in the upcoming
rwsem patches.

Since the two ll/sc platforms that I can tested on (arm64 & ppc) are
both using the generic C codes, the rwsem performance shouldn't be
affected by this patch except the down_read_trylock() code which was
included in patch 2 for arm64.

Waiman Long (2):
  locking/rwsem: Remove arch specific rwsem files
  locking/rwsem: Optimize down_read_trylock()

 MAINTAINERS                     |   1 -
 arch/alpha/include/asm/rwsem.h  | 211 -----------------------------------
 arch/arm/include/asm/Kbuild     |   1 -
 arch/arm64/include/asm/Kbuild   |   1 -
 arch/hexagon/include/asm/Kbuild |   1 -
 arch/ia64/include/asm/rwsem.h   | 172 -----------------------------
 arch/powerpc/include/asm/Kbuild |   1 -
 arch/s390/include/asm/Kbuild    |   1 -
 arch/sh/include/asm/Kbuild      |   1 -
 arch/sparc/include/asm/Kbuild   |   1 -
 arch/x86/include/asm/rwsem.h    | 237 ----------------------------------------
 arch/x86/lib/Makefile           |   1 -
 arch/x86/lib/rwsem.S            | 156 --------------------------
 arch/xtensa/include/asm/Kbuild  |   1 -
 include/asm-generic/rwsem.h     | 140 ------------------------
 include/linux/rwsem.h           |   4 +-
 kernel/locking/percpu-rwsem.c   |   2 +
 kernel/locking/rwsem.h          | 130 ++++++++++++++++++++++
 18 files changed, 133 insertions(+), 929 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rwsem.h
 delete mode 100644 arch/ia64/include/asm/rwsem.h
 delete mode 100644 arch/x86/include/asm/rwsem.h
 delete mode 100644 arch/x86/lib/rwsem.S
 delete mode 100644 include/asm-generic/rwsem.h

-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
