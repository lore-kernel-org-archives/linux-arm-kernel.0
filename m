Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF54C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9138420989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E3aeBeW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9138420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rkVbkm0F1dsKHR/Qmik7ZlS7E+1G8UAHitkD8i+p2q8=; b=E3aeBeW7LPS6j5sdWuPbW5c0fF
	k5iyPwlZ+7j7cjI7IfBOiJmNaRNJuVryOuCvBaOr5SJ7nw78CuIziA6SPt2tZrnZBe/jYVQjsrjFv
	XBsC/0IT8EDmaK+n2MSaSGqzIA2HexN5rqCgf+6uBl6q5B9z3Qm0R48O9KGlzMIpPbUJt/pJLOzaj
	D7DBvLaWuUBskVEKIiO5d1DLiJE5Czxpgqf2f5UhPXeMJ1u9wfzm0lao6AxImgm6W1At94NQZeihk
	GU6PUcF8c9YsooLukM0ueGnf6EvuMyIpw+tW6dEqNl734qHQas7pGqmoz3hsoiw0ZuKYzXELKkuDW
	V53jnBhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZgW4-0002VJ-SW; Wed, 19 Dec 2018 18:24:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZgW2-0002Lr-2A
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 18:24:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B80015AB;
 Wed, 19 Dec 2018 10:24:09 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55E5F3F59C;
 Wed, 19 Dec 2018 10:24:07 -0800 (PST)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpu/hotplug: Mute hotplug lockdep during init
Date: Wed, 19 Dec 2018 18:23:15 +0000
Message-Id: <1545243796-23224-2-git-send-email-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_102418_116009_44467760 
X-CRM114-Status: GOOD (  13.98  )
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
Cc: mark.rutland@arm.com, cai@gmx.us, marc.zyngier@arm.com,
 daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, peterz@infradead.org,
 longman@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since we've had:

  commit cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")

we've been getting some lockdep warnings during init, such as on HiKey960:

[    0.820495] WARNING: CPU: 4 PID: 0 at kernel/cpu.c:316 lockdep_assert_cpus_held+0x3c/0x48
[    0.820498] Modules linked in:
[    0.820509] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                4.20.0-rc5-00051-g4cae42a #34
[    0.820511] Hardware name: HiKey960 (DT)
[    0.820516] pstate: 600001c5 (nZCv dAIF -PAN -UAO)
[    0.820520] pc : lockdep_assert_cpus_held+0x3c/0x48
[    0.820523] lr : lockdep_assert_cpus_held+0x38/0x48
[    0.820526] sp : ffff00000a9cbe50
[    0.820528] x29: ffff00000a9cbe50 x28: 0000000000000000
[    0.820533] x27: 00008000b69e5000 x26: ffff8000bff4cfe0
[    0.820537] x25: ffff000008ba69e0 x24: 0000000000000001
[    0.820541] x23: ffff000008fce000 x22: ffff000008ba70c8
[    0.820545] x21: 0000000000000001 x20: 0000000000000003
[    0.820548] x19: ffff00000a35d628 x18: ffffffffffffffff
[    0.820552] x17: 0000000000000000 x16: 0000000000000000
[    0.820556] x15: ffff00000958f848 x14: 455f3052464d4d34
[    0.820559] x13: 00000000769dde98 x12: ffff8000bf3f65a8
[    0.820564] x11: 0000000000000000 x10: ffff00000958f848
[    0.820567] x9 : ffff000009592000 x8 : ffff00000958f848
[    0.820571] x7 : ffff00000818ffa0 x6 : 0000000000000000
[    0.820574] x5 : 0000000000000000 x4 : 0000000000000001
[    0.820578] x3 : 0000000000000000 x2 : 0000000000000001
[    0.820582] x1 : 00000000ffffffff x0 : 0000000000000000
[    0.820587] Call trace:
[    0.820591]  lockdep_assert_cpus_held+0x3c/0x48
[    0.820598]  static_key_enable_cpuslocked+0x28/0xd0
[    0.820606]  arch_timer_check_ool_workaround+0xe8/0x228
[    0.820610]  arch_timer_starting_cpu+0xe4/0x2d8
[    0.820615]  cpuhp_invoke_callback+0xe8/0xd08
[    0.820619]  notify_cpu_starting+0x80/0xb8
[    0.820625]  secondary_start_kernel+0x118/0x1d0

We've also had a similar warning in sched_init_smp() for every
asymmetric system that would enable the sched_asym_cpucapacity static
key, although that was singled out in:

  commit 40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")

Those warnings are actually harmless, since we cannot have hotplug
operations at the time they appear. Instead of starting to sprinkle
useless hotplug lock operations in the init codepaths, mute the
warnings until they start warning about real problems.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
FYI Thomas Gleixner suggested using SYSTEM_SCHEDULING instead of
SYSTEM_RUNNING, but that seems to still be too early - sched_init_smp()
(and kernel_init() actually) hasn't completed yet, so we'd still get
those warnings.
---
 kernel/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38..34e40ef 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -313,6 +313,15 @@ void cpus_write_unlock(void)
 
 void lockdep_assert_cpus_held(void)
 {
+	/*
+	 * We can't have hotplug operations before userspace starts running,
+	 * and some init codepaths will knowingly not take the hotplug lock.
+	 * This is all valid, so mute lockdep until it makes sense to report
+	 * unheld locks.
+	 */
+	if (system_state < SYSTEM_RUNNING)
+		return;
+
 	percpu_rwsem_assert_held(&cpu_hotplug_lock);
 }
 
--
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
