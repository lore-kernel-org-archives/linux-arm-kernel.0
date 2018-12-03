Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD15C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:35:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3CB2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GzeJNLgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3CB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=1cDTm0ESRS6DUlFNA8+SPZ6XXds+aBnAUICkuJ8quhI=; b=Gze
	JNLgfls2pJUkVBJ/XNHo7cZ2WLwcMOsRU/5o58ZveG0qdUUaBAFQlrr8TUyxPl36DLnay/N2ZXH5a
	cU1WaLEIrwBz52zTTgTRMAufYLsHA04GuBnuRbGg7jrl/IQmsdkta2HZ4yrYguUWOVa14mPHTUI79
	AkTSiybHLfv7n2EY2BrRnz/L78yQq+2T2mN7eSaL0vWn3hXrfa0J2L+1hwJZn11BqAiPdkvTj57qb
	AkMb8wAUmCQqcFQjvZv3njdPj5dEFW6O/PjsRHfXGSyhTjXcc1dc0CPP6ZOJUijpBFr+tYj3dTaeq
	OgNkKwQwSdVNx34CVe1hSLqUu2/Ompw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtzi-0003DS-Iy; Mon, 03 Dec 2018 19:35:02 +0000
Received: from mout.gmx.net ([212.227.17.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtzc-0002qz-H8
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:35:00 +0000
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LrZOj-1hUIBS2GRp-013KJH; Mon, 03
 Dec 2018 20:34:28 +0100
From: Qian Cai <cai@gmx.us>
To: mark.rutland@arm.com,
	marc.zyngier@arm.com
Subject: [PATCH] clocksource/arm_arch_timer: fix a lockdep warning
Date: Mon,  3 Dec 2018 14:33:44 -0500
Message-Id: <1543865624-17301-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:T3JKhvsLTMlt02j5Xa/ivotfktyAs09MImuJwRehiTtilHpq/Sl
 QHFV3W8gGDf7joKXtImhbLUdJsrVUi2F/KgHBBqkzZmuIBJ54g5ETCslpgRs82y200AxAQh
 CXM+QmcpkrWpS6EUpnKBVccVQPvnq0X+dDVV8uR1zh2x57Vnmm8P+ETqB00KeIeD8oK7pjX
 21ltqjUqt9HYPmQEFm4tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZBS9a4/07Y=:mipIW+jv6ooWBP2gnLQdzF
 6dyRZuIDBmmIni7UM8zxefWxNaSPNyfPNPAEy2QLwGPdSKZvF7OZsCeLiAgCsukWToUP3rGK1
 nTqQLWVezoVvXaI/hpyb3fhFRPRzKKA91lvba8hBsH23yGrklAo5SHfB/4tLK3rIp7nv6HN6D
 VBh+s1dqQvlJ/QhZETzlqcvvyVVH6b3nHx/J2ddFsAHz5PlapEdG6AiTWAyl7IAIKVQ3JbZFi
 W4XF27cg+P5EQPUHcL0tiPlQ9WAOsYxijTSSg8UxtDcMy8P49QCR/9sHUu5FqUHheYUgJtUCu
 lf2Yu75arT9vbQqt9xFwcZUwZpNLD+GyjyvWyI4i8At/4dSoQaLHv676L0k9cmnU2vek0+2MJ
 z0gq1ttUsn35dIs+9aXBqut2iVygEzRDlxJAEQbPNMMKCPerU6QqQJ20bvJtCUL/mx0l/BXvv
 OKesVyqODlTArqP8QURaPwkhF+59HjC+UyL2abs3L76OmgZlqX85WZS/SGTVfoytkDtaPZeaZ
 BxRR4+lCo3OXG7dlDqNY9+lgG4lvfKLuqxrCJ/bjqhXiQFcLLWAohtU/SJdDMnoiPXvDP5OeJ
 +lc+56Z1yVSN1QQVILC5u42feTJXLBYFtPxsdXrNFCNouuyVz0YadCyp9o1wOtqXCtbNicDn1
 +EtX1JwFKqXUJ2Bd1PSZwSt0FPJAOq3jjEQ4XfplT5kitOk39lW2mcBCYtRj+CpR6v29vqrwt
 nLhxBK2UGnv1R/5iIkYyJKa1gWasTk7pKw09KWvLpKo7vAAwGlLy0LPbObLzJpQBQZKmne1lO
 6y5WbthM7HbH3YC89/kOSJgtm77o2M/w+5HOKJIke0XdbaYhyxM+A0gxFoK1B6FZDTiB5R/MN
 /15opRrc/Hw9MAAM++jH8g3wV/MzKRZbmY2Gq9Y/Y=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113458_653774_F855B56C 
X-CRM114-Status: UNSURE (   9.13  )
X-CRM114-Notice: Please train this message.
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
the hotplug lock for _cpuslocked() operations"). Therefore, it will check
if it is really in the CPU hotplug path or not, and work around this
problem by using cpus_read_trylock(). The chance of not getting the read
lock is very small. If that happens, it will report a lockdep warning at
most.

Signed-off-by: Qian Cai <cai@gmx.us>
---
 drivers/clocksource/arm_arch_timer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc..5c9acbd 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -497,11 +497,20 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	i = 0;
+
 	/*
 	 * Use the locked version, as we're called from the CPU
 	 * hotplug framework. Otherwise, we end-up in deadlock-land.
 	 */
+	i = cpus_read_trylock();
 	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
+	if (i)
+		cpus_read_unlock();
+#else
+	static_branch_enable(&arch_timer_read_ool_enabled);
+#endif
 
 	/*
 	 * Don't use the vdso fastpath if errata require using the
-- 
1.8.3.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
