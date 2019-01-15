Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B75EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625C920657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IINzWyBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625C920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uifZnYPFTb40MI7b+EAGuT8kKzhffvKX9hxOFV3BYn0=; b=IINzWyBDIKTiZu
	XDP0slnMZwPRvvQuWbzNWmggTwYqjBLersfdOiPg223yYbjtBjgksB/b2AK3yjQTakOVJY5NYDiaA
	mi6KGp8KJrSRthx5GMtzmb+VZR62evbd4sONwk2u6XOH7CXwHgaBJ9ntxNtb8De4UYRmcdxuHq25V
	qu49FkTXClRFdk1AvLPr3p8ke8ytr4ENaPQ+fVExK/GMhZ45gADsLTLHxkKSUzryc63mrKGz4KzCv
	j5Wto+r9S0Wil3V6y2WL+xxVTtGA/ec+6c03R0aiqfw0BjkBooUP/bTc3dI/msLqw1lVYKgxB8KjQ
	iy2iPUazTfeg1Sd+NoyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjTmG-0006DE-2y; Tue, 15 Jan 2019 18:49:32 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjTmC-0006Ck-8e
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 18:49:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9875FA78;
 Tue, 15 Jan 2019 10:49:25 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 645193F70D;
 Tue, 15 Jan 2019 10:49:24 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: kpti: Update arm64_kernel_use_ng_mappings() when
 forced on
Date: Tue, 15 Jan 2019 18:49:17 +0000
Message-Id: <20190115184917.248995-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_104928_309965_E4B78BB9 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 John Garry <john.garry@huawei.com>, James Morse <james.morse@arm.com>,
 Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit b89d82ef01b3 ("arm64: kpti: Avoid rewriting early page
tables when KASLR is enabled"), a kernel built with CONFIG_RANDOMIZE_BASE
can decide early whether to use non-global mappings by checking the
kaslr_offset().

A kernel built without CONFIG_RANDOMIZE_BASE, instead checks the
cpufeature static-key.

This leaves a gap where CONFIG_RANDOMIZE_BASE was enabled, no
kaslr seed was provided, but kpti was forced on using the cmdline
option.

When the decision is made late, kpti_install_ng_mappings() will re-write
the page tables, but arm64_kernel_use_ng_mappings()'s value does not
change as it only tests the cpufeature static-key if
CONFIG_RANDOMIZE_BASE is disabled.
This function influences PROT_DEFAULT via PTE_MAYBE_NG, and causes
pgattr_change_is_safe() to catch nG->G transitions when the unchanged
PROT_DEFAULT is used as part of PAGE_KERNEL_RO:
[    1.942255] alternatives: patching kernel code
[    1.998288] ------------[ cut here ]------------
[    2.000693] kernel BUG at arch/arm64/mm/mmu.c:165!
[    2.019215] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    2.020257] Modules linked in:
[    2.020807] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2 #51
[    2.021917] Hardware name: linux,dummy-virt (DT)
[    2.022790] pstate: 40000005 (nZcv daif -PAN -UAO)
[    2.023742] pc : __create_pgd_mapping+0x508/0x6d0
[    2.024671] lr : __create_pgd_mapping+0x500/0x6d0

[    2.058059] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    2.059369] Call trace:
[    2.059845]  __create_pgd_mapping+0x508/0x6d0
[    2.060684]  update_mapping_prot+0x48/0xd0
[    2.061477]  mark_linear_text_alias_ro+0xdc/0xe4
[    2.070502]  smp_cpus_done+0x90/0x98
[    2.071216]  smp_init+0x100/0x114
[    2.071878]  kernel_init_freeable+0xd4/0x220
[    2.072750]  kernel_init+0x10/0x100
[    2.073455]  ret_from_fork+0x10/0x18

[    2.075414] ---[ end trace 3572f3a7782292de ]---
[    2.076389] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

If arm64_kernel_unmapped_at_el0() is true, arm64_kernel_use_ng_mappings()
should also be true.

Signed-off-by: James Morse <james.morse@arm.com>
CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: John Garry <john.garry@huawei.com>
CC: Will Deacon <will.deacon@arm.com>

---
 arch/arm64/include/asm/mmu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index ac352accb3d9..3e8063f4f9d3 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -60,8 +60,11 @@ static inline bool arm64_kernel_use_ng_mappings(void)
 	 * later determine that kpti is required, then
 	 * kpti_install_ng_mappings() will make them non-global.
 	 */
+	if (arm64_kernel_unmapped_at_el0())
+		return true;
+
 	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		return arm64_kernel_unmapped_at_el0();
+		return false;
 
 	/*
 	 * KASLR is enabled so we're going to be enabling kpti on non-broken
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
