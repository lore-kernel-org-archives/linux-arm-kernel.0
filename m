Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF16C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6980520834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NA4IccEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6980520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9TurfU7Xh6brSTyHV6+H8xL2gXEvSvkjFf7FoDODVpY=; b=NA4
	IccEdNvGowxLQYPKUtEGAuUpRC+aclkpUG2LIs9eC5b96WxzGB1nop4lNozN8LdPdZmswtxdb7vWB
	SVKbguieIuoKy5THspykRojtVo36PZ8EKeEXntgogZqWLNKTBc0hzINzzmlJ39UHYzSJHNyO4vv1R
	yOgGvJdlFrnBRUkxc/Z7lEkydGhtA+pyLc/wwzhALjn4BiD9LQsqzjBx1YNPaeSLf13dPHVgR74Zt
	K3j95+iIprlvytash73dz3htGDF1kEc7LaEQiEr+p3qjtoN2G0Ob39gj5yJXnWdy0FU3o6w3xkguV
	6nwsgIl+vqXFAgW3Tl4myeKps6JwMvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmR7-0008Ba-88; Fri, 30 Nov 2018 17:18:41 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmR3-00085i-Hu
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:18:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCF6EBD;
 Fri, 30 Nov 2018 09:18:26 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 350DD3F5A0; Fri, 30 Nov 2018 09:18:25 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] arm64: capabilities: Optimize checking and enabling
Date: Fri, 30 Nov 2018 17:17:59 +0000
Message-Id: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091837_598680_EEC9D017 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: mark.rutland@arm.com, vladimir.murzin@arm.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, dave.martin@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We maintain two separate tables (i.e, arm64_features and arm64_errata) of
struct arm64_cpu_capabilities which decide the capabilities of the system.
We iterate over the two tables for detecting/verifying/enabling the capabilities.
e.g, this_cpu_has_cap() needs to iterate over the two tables one by one to
find the "capability" structure corresponding to the cap number and then
check it on the CPU.

Also, we enable all the non-boot scoped capabilities after all the SMP cpus
are brought up by the kernel, using stop_machine() for each available
capability. We could batch all the "enabling" activity to a single
stop_machine() callback. But that implies you need a way to map
a given capability number to the corresponding capability entry
to finish the operation quickly.

So we need a quicker way to access the entry for a given capability.
We have two choices :

 1) Unify both the tables to a static/dynamic sorted entry based on
    the capability number. This has the following drawbacks :
     a) The entries must be unique. i.e, no duplicate entries for a
        capability.
     b) Looses the separation of "features" vs. "errata" classification
     c) Statically sorting the list is error prone. Runtime sorting the
        array means more time for booting.

 2) Keep an array of pointers to the capability sorted at boot time
    based on the capability.
     a) As for (1), the entries must be unique for a capability.

This series implements (2) and uses the new list for optimizing the
operations on the entries. As a prepatory step, we remove the
duplicate entries for the same capabilities (Patch 1-3).

Changes since v1:
 - Fix merging workarounds for clean cache errata. Added
   a Kconfig symbol for covering the capability to make
   the handling better.
 - Make the WARNINGs meaningful on duplicate entries
 - Added tags from Vladimir

Suzuki K Poulose (7):
  arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE
  arm64: capabilities: Merge duplicate Cavium erratum entries
  arm64: capabilities: Merge duplicate entries for Qualcomm erratum 1003
  arm64: capabilities: Speed up capability lookup
  arm64: capabilities: Optimize this_cpu_has_cap
  arm64: capabilities: Use linear array for detection and verification
  arm64: capabilities: Batch cpu_enable callbacks

 arch/arm64/Kconfig                  |   7 ++
 arch/arm64/include/asm/cpufeature.h |   3 +
 arch/arm64/include/asm/cputype.h    |   2 +
 arch/arm64/kernel/cpu_errata.c      | 103 ++++++++++++----------
 arch/arm64/kernel/cpufeature.c      | 169 +++++++++++++++++++++---------------
 5 files changed, 165 insertions(+), 119 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
