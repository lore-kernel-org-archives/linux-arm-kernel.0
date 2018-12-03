Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE23BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9943D20864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OuBzM/oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9943D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=3enOsxRXg0aDC6/Ivb7syHqjlhLbaYfwR5Y7UGgSS+g=; b=OuB
	zM/oNyer0hXhtA8pFe/Kv0gB1k4ut+J5IH3ufL2ZZFXQcUGPQnDt4fK9Ki1qpdpcMIIXUYZfgmbJc
	lOQuD6UswEr1lEEvvmJyl/Z+Inm5xptMHs87g3CgcDp41b+XZ2COtOH5bmOv8wCisebg/VIj1hRda
	9vN1q6XFM/6beNcNjvy2CJfWxKJ4qZ23U7MOHk77mARWuvdHXUNgHEyDSPQnSDbiabnH5gjo02dDF
	J5pvYGj9ptX+TeJB9mP5ZKZRPMX6ENn8vvNCsPspRDO45nLV3sxgvNmk+Q128X2UQr8NaJ9QdlmKK
	5zwMiewXY5GOzuntie5Uhz63WdPx1SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwyw-0007lR-LJ; Mon, 03 Dec 2018 22:46:26 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwys-0007k9-TE
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:46:25 +0000
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MMjgF-1gZifp0J7X-008Yqq; Mon, 03
 Dec 2018 23:45:58 +0100
From: Qian Cai <cai@gmx.us>
To: mark.rutland@arm.com,
	marc.zyngier@arm.com
Subject: [PATCH v2] clocksource/arm_arch_timer: fix a lockdep warning
Date: Mon,  3 Dec 2018 17:45:21 -0500
Message-Id: <1543877121-4098-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:mPronifC4t5JDwHNkpMd3JGH1V/ug1P1l6n5sK0eVUFfGALXibc
 eYAsAzr8WfoZ1BceoyjNEyrKxz4YYVnOP+XWmU0IZds02+QOomUDr/J2827elRcX0CvS8v1
 RGnRMSKnFeRPL/ICXplz74d5Jl2iFs3Rdeecp+Lqu670Fn/TEMflkchwNyEzcskq1eqUC4B
 hn2VFTo52enb+HXXyS0iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rZZpkZY15Ng=:Sh0VFLRGZq0mQvNXgR6FD/
 mWOMVEzBekAMLwVKtL51N+6DsmcUxCt0uIXafERRppOA2pBR+iMFoPNN/keIdjyA8YQ/SUBSQ
 j6hHMoUhhujPy1uB/MhEL3vxRMWsT2+w7Zo3ue3TGzBKDElnxZvvbUcTOfLF3Q2k7HTo2H71m
 FLhu4g5Y/2bM6ykX8kfXfmDMkQZDwA5mGjwtypz2XGg6EUjlEu2nxyRTPjRdxQZ5agV3Ze7f4
 zz2ExbrhFQK471YHBL2pVYTdh3ZMeUkdNS2ten5x2RcoE9DUOR0BR733ee8+jbc8j0WAPsHax
 1ap07/+IT4cN24+j3XtpKvOu7Pb6Gb4DlBRbrZZQzENDFCMx1EGL1B1LsjoR1JRSN8UXT1GDW
 p/w3YYFzOR9AGrt4v8LQzhc8XbvXPoqXS5cWn5EVM7k0NZmQ2wIzjGRojdFoNo+RySMYiN/MG
 /aVG+ElOOStnLyfD+ehplpxH0rwUevAmINm89zUOcM5qaIw0hYCygNh1GFQmdRBccOyr41cT8
 LBWtds1/vp7QtsO9c+JnDKPpyucTeqGUWlU8uuD5Bxsq6COn+05OP9Ctfg2FKWnXwGeppMOEA
 xBUKftRrmFSZQDjOEO0+pdsMTD9s4H61x1AXrOXvJE4xGnmLbI8lXft39cA+PGQHiV0j+WmzA
 LbTcZ0/FqbSCjZRQEyh/YXwa2KE8i8ZHTz4NvbUDffFIh60shbwmNrqmvCqwowil8vWWwq4jm
 NPCmgDJIcgMHAzsohz/sJc1xnosFJ+R7/t7ttHAvjK0t79MPpRPjlZABFDPRNYh1JixgmBOms
 luwdTSFqfUFaysYUlTlH+e/CbmXqkB+sdahroKHoRywCKChFUKdIQZdguODliiiv79739NOIy
 Oj/AJujuPR18D+fSYqInVz0BbZZSX3ezJ2kj6kcps=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_144623_238646_299355F5 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Qian Cai <cai@gmx.us>, peterz@infradead.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, longman@redhat.com, tglx@linutronix.de,
 mingo@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
warning.

[    0.000000]  lockdep_assert_cpus_held+0x50/0x60
[    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
[    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
[    0.000000]  arch_timer_acpi_init+0x274/0x6ac
[    0.000000]  acpi_table_parse+0x1ac/0x218
[    0.000000]  __acpi_probe_device_table+0x164/0x1ec
[    0.000000]  timer_probe+0x1bc/0x254
[    0.000000]  time_init+0x44/0x98
[    0.000000]  start_kernel+0x4ec/0x7d4

This is due to the commit cb538267ea1e ("jump_label/lockdep: Assert we hold
the hotplug lock for _cpuslocked() operations").

Since it is applying a global workaround to all CPUs here, it did not hold
any CPU locks in this path.

arch_timer_acpi_init
  arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table)
    arch_timer_enable_workaround(wa, local = false)
      for_each_possible_cpu()
	per_cpu()

When hot-add a CPU, it will go with a slightly different route.

arch_timer_starting_cpu
  __arch_timer_setup
    arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL)
      arch_timer_enable_workaround(wa, local = true)
        __this_cpu_write()

Hence, deal with them differently.

Fixes: 450f9689f294 (clocksource/arm_arch_timer: Use
	static_branch_enable_cpuslocked())
Signed-off-by: Qian Cai <cai@gmx.us>
---

Changes since v1:
* Fixed the root cause instead of a workaround.

 drivers/clocksource/arm_arch_timer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..81dca7d31d13 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -492,18 +492,21 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 
 	if (local) {
 		__this_cpu_write(timer_unstable_counter_workaround, wa);
+
+		/*
+		 * Use the locked version, as we're called from the CPU
+		 * hotplug framework. Otherwise, we end-up in
+		 * deadlock-land.
+		 */
+		static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
 	} else {
 		for_each_possible_cpu(i)
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
+		/* A global workaround is not on the CPU hotplug path. */
+		static_branch_enable(&arch_timer_read_ool_enabled);
 	}
 
 	/*
-	 * Use the locked version, as we're called from the CPU
-	 * hotplug framework. Otherwise, we end-up in deadlock-land.
-	 */
-	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
-
-	/*
 	 * Don't use the vdso fastpath if errata require using the
 	 * out-of-line counter accessor. We may change our mind pretty
 	 * late in the game (with a per-CPU erratum, for example), so
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
