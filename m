Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AAEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D4420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqmNvvdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D4420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tdDg2eCXed09PKOmCemsjD18fqg3kNV9FWGqS0Ln1iE=; b=WqmNvvdMGmXaU0
	5sGpLX3K9c9V/1mM8O2JDJ41QfF0rGjtOYU584jaenZ/AlKzN49VC2Ia83v0luXCyazCxr31WRfvP
	F6bVgn0iMwgh4EbyK01PsGQJttz0wwmCGK8q5A4DQCi2FkQ4Gf1lwLq1YIAYAhedHjP3g1PvwJWiM
	qWwBxxgA6zB2UtF7b0erRZKHA5u/lKuaZQeR52ZDCvgLWBmivSxIRCpAAp+wwBDfVqiIGw5Zmqog6
	mLuds+i3kfdZJJTKfjUVlZAfUWT6PKbsjCSs1gtJ8SHbXQmrEyaI5E/wmhRQMFooPZtgGPJPgpfg9
	xepX3JAxqpMST2iQ5IMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWxd-0006yN-Kh; Fri, 18 Jan 2019 16:25:37 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWtD-0001xP-JN
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:21:33 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Macay-1hMKfG0Vje-00cCjZ; Fri, 18 Jan 2019 17:19:48 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 24/29] x86/x32: use time64 versions of sigtimedwait and
 recvmmsg
Date: Fri, 18 Jan 2019 17:18:30 +0100
Message-Id: <20190118161835.2259170-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:bjQ71ntGniqBqrHuJ7nhcM56lXeeQkbnuYFrI+Mn+AONKiu8hm3
 ZfdgXFhiGNnHO//AoluNzCeO0kL22YQqbQi2edF+nGFhQKlnAM/wFiwMct2rm/oTbQw/dfG
 NW0sAWRGPprfVUER8dgBX8W4nNi71voW7ClXKpr6DLa2bdedfAUlZPkAvfVw5mQVYt4bn+U
 9SZ+sG+tOw97WshAsE8Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7vyNs/hjFE=:E5JYxrKYfXSvspqvYDThi2
 zRdSFKHKhBC95XRLLIotBJDFxRWr8YE9hRuVm5cixnR2Fat15uciTsUrb3Nee+8V/9jkdsp7S
 7WQMM6z4Rx8tQmY/ttpZhsD/obv2S33VJQhYwjv8ByKaOYStUY1Y9Caq1E6j8nODtLwNPc+AO
 MYhQEB5zgWu/X+w7nncFL2M+sWivBIQgy2ZHTbQYaUvsaBNUBb3znK61r6tod2EiA1Xq8ZtNx
 7trJlzqoshtQNs+l4LuQRLbI9vW0d0dyGGaiOHosMtJZhdeq6RRD8lc4zL2wgZ9/ly5GiNwpk
 AMoTJv2+3lrX7qJRkmPRvAVO6DQcibJPGHlmcXioT/AaRWC5ZIbDBDePtYofOW7vFfoqCyNOQ
 072BSrqwXTzKiU5zn+zO2AI0UL9lPLChurlNcEiH0C+VvNgvI4CHjkDe//ntGe27GCCnH1Dr6
 M4yjGrMJu+6aeFMcJo4w1UQHuEk+tkPXVC5exxExIV2SGo7/uArDS6u7ynjcFwosWZnfhzJJg
 bu861G0bv4iR2J8ABEMMvocoGN1fdydxMJvzB+vPbuRYBvmajg4bWH3Vesl9pCNRLGcb5Dl4M
 TICdFyVBNbKDvw0KF+9aOvpQDltHGoXNTnsHKd1AMNWQkP0W4NSJ242NO6hZzGvKuC3YniV8g
 Bptn5bsjlGFQqXFY2de7WXKnd6mrxFJcDg7t5q+EChvral9mavvP3PSWDyFO8CPtHHMIarTDn
 UBFzp4GLcnISS7CrL8RcfhB+mANlkmqu671lFQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082104_080029_3BDB65D4 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

x32 has always followed the time64 calling conventions of these
syscalls, which required a special hack in compat_get_timespec
aka get_old_timespec32 to continue working.

Since we now have the time64 syscalls, use those explicitly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..43a622aec07e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -361,7 +361,7 @@
 520	x32	execve			__x32_compat_sys_execve/ptregs
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
 524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
 525	x32	sigaltstack		__x32_compat_sys_sigaltstack
 526	x32	timer_create		__x32_compat_sys_timer_create
@@ -375,7 +375,7 @@
 534	x32	preadv			__x32_compat_sys_preadv64
 535	x32	pwritev			__x32_compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
 538	x32	sendmmsg		__x32_compat_sys_sendmmsg
 539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
 540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
