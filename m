Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:01:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1FF222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ye/Prajf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1FF222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ntVFRKDnJtPxIUR+pnHNQ1Y51/bmVJQ6ysmybZtbA0Q=; b=Ye/
	Prajf6pwsQ9O8YB/FiRi5068SD3ztO9f9mymwVLpxxWX6SNHjfkUXlElUFifXzcbuDPPLF+imYyoh
	PRVRxWUHLlPJXiroNm4C0CrGGEoPs5a1FFgDG0TOWBN8/mEbtlWr4uX3FMNjXwghf28+OUTRxZl6u
	pxCA/VR4crSfvJAjuKFjoXCXcbUyLfR1wK1ji+GiaZa52jFjUmypFR94lhPg1gjp1jCafJ5M/j5Ud
	droyTpJV8E1RrEpr2KL+EVcSzrdH1I7OqqBM9Sg0dwv8KGLkaQfBAHvDr+dnASlLW6qBrJ83Fbm5K
	yceVb9tGkWMUX2hrNhjpALp0SPxulDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2aP-0005sr-QQ; Wed, 13 Feb 2019 22:00:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2aM-0005sL-Ey; Wed, 13 Feb 2019 22:00:56 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0E6689AE0;
 Wed, 13 Feb 2019 22:00:52 +0000 (UTC)
Received: from llong.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1035C600C0;
 Wed, 13 Feb 2019 22:00:44 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Date: Wed, 13 Feb 2019 17:00:14 -0500
Message-Id: <1550095217-12047-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 13 Feb 2019 22:00:53 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_140054_542138_5F663DB5 
X-CRM114-Status: GOOD (  12.34  )
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
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 Waiman Long <longman@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>,
 linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

v4:
 - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.

v3:
 - Optimize __down_read_trylock() for the uncontended case as suggested
   by Linus.

v2:
 - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
 - Update performance test data in patch 1.

The goal of this patchset is to remove the architecture specific files
for rwsem-xadd to make it easer to add enhancements in the later rwsem
patches. It also removes the legacy rwsem-spinlock.c file and make all
the architectures use one single implementation of rwsem - rwsem-xadd.c.

Waiman Long (3):
  locking/rwsem: Remove arch specific rwsem files
  locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
    archs
  locking/rwsem: Optimize down_read_trylock()

 MAINTAINERS                     |   1 -
 arch/alpha/Kconfig              |   7 -
 arch/alpha/include/asm/rwsem.h  | 211 -------------------------
 arch/arc/Kconfig                |   3 -
 arch/arm/Kconfig                |   4 -
 arch/arm/include/asm/Kbuild     |   1 -
 arch/arm64/Kconfig              |   3 -
 arch/arm64/include/asm/Kbuild   |   1 -
 arch/c6x/Kconfig                |   3 -
 arch/csky/Kconfig               |   3 -
 arch/h8300/Kconfig              |   3 -
 arch/hexagon/Kconfig            |   6 -
 arch/hexagon/include/asm/Kbuild |   1 -
 arch/ia64/Kconfig               |   4 -
 arch/ia64/include/asm/rwsem.h   | 172 --------------------
 arch/m68k/Kconfig               |   7 -
 arch/microblaze/Kconfig         |   6 -
 arch/mips/Kconfig               |   7 -
 arch/nds32/Kconfig              |   3 -
 arch/nios2/Kconfig              |   3 -
 arch/openrisc/Kconfig           |   6 -
 arch/parisc/Kconfig             |   6 -
 arch/powerpc/Kconfig            |   7 -
 arch/powerpc/include/asm/Kbuild |   1 -
 arch/riscv/Kconfig              |   3 -
 arch/s390/Kconfig               |   6 -
 arch/s390/include/asm/Kbuild    |   1 -
 arch/sh/Kconfig                 |   6 -
 arch/sh/include/asm/Kbuild      |   1 -
 arch/sparc/Kconfig              |   8 -
 arch/sparc/include/asm/Kbuild   |   1 -
 arch/unicore32/Kconfig          |   6 -
 arch/x86/Kconfig                |   3 -
 arch/x86/include/asm/rwsem.h    | 237 ----------------------------
 arch/x86/lib/Makefile           |   1 -
 arch/x86/lib/rwsem.S            | 156 ------------------
 arch/x86/um/Kconfig             |   6 -
 arch/x86/um/Makefile            |   1 -
 arch/xtensa/Kconfig             |   3 -
 arch/xtensa/include/asm/Kbuild  |   1 -
 include/asm-generic/rwsem.h     | 140 -----------------
 include/linux/rwsem-spinlock.h  |  47 ------
 include/linux/rwsem.h           |   9 +-
 kernel/Kconfig.locks            |   2 +-
 kernel/locking/Makefile         |   4 +-
 kernel/locking/percpu-rwsem.c   |   2 +
 kernel/locking/rwsem-spinlock.c | 339 ----------------------------------------
 kernel/locking/rwsem.h          | 130 +++++++++++++++
 48 files changed, 135 insertions(+), 1447 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rwsem.h
 delete mode 100644 arch/ia64/include/asm/rwsem.h
 delete mode 100644 arch/x86/include/asm/rwsem.h
 delete mode 100644 arch/x86/lib/rwsem.S
 delete mode 100644 include/asm-generic/rwsem.h
 delete mode 100644 include/linux/rwsem-spinlock.h
 delete mode 100644 kernel/locking/rwsem-spinlock.c

-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
