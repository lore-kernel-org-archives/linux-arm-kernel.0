Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81364C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E23720850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAvD5q7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E23720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FFNAbHbGLO+w/Jb43yq1H/0XErOEa8MN/VrV1Ns3uH8=; b=bAvD5q7fUlRvj3
	ns35ZAULJLwtZCMa/4uN8cYaYVWeovbzuzQHRSGpwjUHrOjcdDeOc4dCDP/iDKisp4ABmh1erhR7d
	sT3HTV7b+kX8JPpP7GidJrDC+QXvXtgPNt6eRly87e8PG2+p8b9UhqRfRIvzXIhVPBlBo4g1iXXFW
	iTTZG97A44p1NcRbK8LgLqLm0SAAEABKzfvM9Lt5T7SUSgfxIWkI4Cszm1Ehuvn5UIyWP5ZOvYMUL
	mqU4F+50b1SDhPd2hQiw3BOnNID8a+gUqc8d30AxJIU2Jr5z+JGsEzmrbPSwL5UEfX5RAh3JTKeL9
	OMCnBX2L2XO6tpBXKUjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTscC-0004ic-Ee; Mon, 03 Dec 2018 18:06:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsc9-0004iA-2r
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:06:38 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D92D1682;
 Mon,  3 Dec 2018 10:06:25 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BE2A3F59C;
 Mon,  3 Dec 2018 10:06:22 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 00/25] APEI in_nmi() rework and SDEI wire-up
Date: Mon,  3 Dec 2018 18:05:48 +0000
Message-Id: <20181203180613.228133-1-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100637_186858_0A83E354 
X-CRM114-Status: GOOD (  18.35  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This series aims to wire-up arm64's fancy new software-NMI notifications
for firmware-first RAS. These need to use the estatus-queue, which is
also needed for notifications via emulated-SError. All of these
things take the 'in_nmi()' path through ghes_copy_tofrom_phys(), and
so will deadlock if they can interact, which they might.

To that end, this series removes the in_nmi() stuff from ghes.c.
Locks are pushed out to the notification helpers, and fixmap entries
are passed in to the code that needs them. This means the estatus-queue
users can interrupt each other however they like.

While doing this there is a fair amount of cleanup, which is (now) at the
beginning of the series. NMIlike notifications interrupting
ghes_probe() can go wrong for three different reasons. CPER record
blocks greater than PAGE_SIZE dont' work.
The estatus-pool allocation is simplified and the silent-flag/oops-begin
is removed.

Nothing in this series is intended as fixes, as its all cleanup or
never-worked.


----------%<----------
The earlier boiler-plate:

What's SDEI? Its ARM's "Software Delegated Exception Interface" [0]. It's
used by firmware to tell the OS about firmware-first RAS events.

These Software exceptions can interrupt anything, so I describe them as
NMI-like. They aren't the only NMI-like way to notify the OS about
firmware-first RAS events, the ACPI spec also defines 'NOTFIY_SEA' and
'NOTIFY_SEI'.

(Acronyms: SEA, Synchronous External Abort. The CPU requested some memory,
but the owner of that memory said no. These are always synchronous with the
instruction that caused them. SEI, System-Error Interrupt, commonly called
SError. This is an asynchronous external abort, the memory-owner didn't say no
at the right point. Collectively these things are called external-aborts
How is firmware involved? It traps these and re-injects them into the kernel
once its written the CPER records).

APEI's GHES code only expects one source of NMI. If a platform implements
more than one of these mechanisms, APEI needs to handle the interaction.
'SEA' and 'SEI' can interact as 'SEI' is asynchronous. SDEI can interact
with itself: its exceptions can be 'normal' or 'critical', and firmware
could use both types for RAS. (errors using normal, 'panic-now' using
critical).
----------%<----------


Known issue:
 * ghes_copy_tofrom_phys() already takes a lock in NMI context, this
   series moves that around, and makes sure we never try to take the
   same lock from different NMIlike notifications. Since the switch to
   queued spinlocks it looks like the kernel can only be 4 context's
   deep in spinlock, which arm64 could exceed as it doesn't have a
   single architected NMI. It either needs an additional
   idx-bit in the qspinlock, or for ghes.c to switch to using a
   different type of lock for NMIlike notifications.

Changes since v6:
 * Changed the order of the series.
 * Made hest.c own the estatus pool, which is now vmalloc()d.
 * Culled #ifdef, hopefully without generating too much noise.
 * Added GHESv2 'ack' support to NMI-like notifications
 * Use task-work to kick the memory_failure_queue()

Specific changes are noted in each patch.

[v6] https://www.spinics.net/lists/linux-acpi/msg84228.html
[v5] https://www.spinics.net/lists/linux-acpi/msg82993.html
[v4] https://www.spinics.net/lists/arm-kernel/msg653078.html
[v3] https://www.spinics.net/lists/arm-kernel/msg649230.html

[0] https://static.docs.arm.com/den0054/a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf


Feedback welcome,

Thanks

James Morse (25):
  ACPI / APEI: Don't wait to serialise with oops messages when
    panic()ing
  ACPI / APEI: Remove silent flag from ghes_read_estatus()
  ACPI / APEI: Switch estatus pool to use vmalloc memory
  ACPI / APEI: Make hest.c manage the estatus memory pool
  ACPI / APEI: Make estatus pool allocation a static size
  ACPI / APEI: Don't store CPER records physical address in struct ghes
  ACPI / APEI: Remove spurious GHES_TO_CLEAR check
  ACPI / APEI: Don't update struct ghes' flags in read/clear estatus
  ACPI / APEI: Generalise the estatus queue's notify code
  ACPI / APEI: Tell firmware the estatus queue consumed the records
  ACPI / APEI: Move NOTIFY_SEA between the estatus-queue and NOTIFY_NMI
  ACPI / APEI: Switch NOTIFY_SEA to use the estatus queue
  KVM: arm/arm64: Add kvm_ras.h to collect kvm specific RAS plumbing
  arm64: KVM/mm: Move SEA handling behind a single 'claim' interface
  ACPI / APEI: Move locking to the notification helper
  ACPI / APEI: Let the notification helper specify the fixmap slot
  ACPI / APEI: Pass ghes and estatus separately to avoid a later copy
  ACPI / APEI: Split ghes_read_estatus() to allow a peek at the CPER
    length
  ACPI / APEI: Only use queued estatus entry during _in_nmi_notify_one()
  ACPI / APEI: Use separate fixmap pages for arm64 NMI-like
    notifications
  mm/memory-failure: Add memory_failure_queue_kick()
  ACPI / APEI: Kick the memory_failure() queue for synchronous errors
  arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work
  firmware: arm_sdei: Add ACPI GHES registration helper
  ACPI / APEI: Add support for the SDEI GHES Notification type

 arch/arm/include/asm/kvm_ras.h       |  14 +
 arch/arm/include/asm/system_misc.h   |   5 -
 arch/arm64/include/asm/acpi.h        |   4 +-
 arch/arm64/include/asm/daifflags.h   |   1 +
 arch/arm64/include/asm/fixmap.h      |   6 +-
 arch/arm64/include/asm/kvm_ras.h     |  25 +
 arch/arm64/include/asm/system_misc.h |   2 -
 arch/arm64/kernel/acpi.c             |  51 +++
 arch/arm64/mm/fault.c                |  25 +-
 drivers/acpi/apei/Kconfig            |  12 +-
 drivers/acpi/apei/ghes.c             | 652 ++++++++++++++++-----------
 drivers/acpi/apei/hest.c             |   5 +
 drivers/firmware/arm_sdei.c          |  70 +++
 include/acpi/ghes.h                  |   4 +-
 include/linux/arm_sdei.h             |   9 +
 include/linux/mm.h                   |   1 +
 mm/memory-failure.c                  |  15 +-
 virt/kvm/arm/mmu.c                   |   4 +-
 18 files changed, 606 insertions(+), 299 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_ras.h
 create mode 100644 arch/arm64/include/asm/kvm_ras.h

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
