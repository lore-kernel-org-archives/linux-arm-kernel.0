Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F44FC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:31:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC59820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OFkfncRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC59820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/lkFJaRSKoDqAB0KgYzatvDOcgwYXNzDbZ0ioC4OAfs=; b=OFkfncRWBkqEj8
	iJBwlVd7nXVNkdVF5gCr7mC/pr9BGwNyhDrJT9b6fsCsHgFqWmlhaBhPPsy0A2Rx/ySmWiO2Kx4R2
	+7qbX9CtJZbkZ6ihClyApeBEb5BC78aCYo7nO78ndRKmhc8vpUhDZNPQ+y2Ghr8hNDFnX/n3pCOPt
	n/m0KzdMXVXKT3TzmCgO91AzUxShjt6OGw/JsBqOdICPp7bxdiNZ29+IpEYiMoIT2duyBFuFvTXfw
	gE/Ox/rV+0ZQW6hfIEE6dC9rYRAfWMKlLS0GGvjtFpk5nLXFyDFLPJYaiRyQD4y7ufost+NC3TuvB
	8nBXz9kaVdYy/nnHkARA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMat-0000jE-IJ; Mon, 10 Dec 2018 14:31:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMaq-0000h4-2c
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:31:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A5615AD;
 Mon, 10 Dec 2018 06:31:24 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33CC13F575;
 Mon, 10 Dec 2018 06:31:20 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 1/3] elf: Make AT_FLAGS arch configurable
Date: Mon, 10 Dec 2018 14:30:42 +0000
Message-Id: <20181210143044.12714-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210143044.12714-1-vincenzo.frascino@arm.com>
References: <cover.1544445454.git.andreyknvl@google.com>
 <20181210143044.12714-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_063132_195338_FD75F66A 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>, Chintan Pandya <cpandya@codeaurora.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, the AT_FLAGS in the elf auxiliary vector are set to 0
by default by the kernel.
Some architectures might need to expose to the userspace a non-zero
value to advertise some platform specific ABI functionalities.

This patch makes AT_FLAGS configurable by the architectures that
require it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 fs/binfmt_elf.c        | 6 +++++-
 fs/binfmt_elf_fdpic.c  | 6 +++++-
 fs/compat_binfmt_elf.c | 5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 54207327f98f..9fa20cc4a437 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -86,6 +86,10 @@ static int elf_core_dump(struct coredump_params *cprm);
 #define ELF_CORE_EFLAGS	0
 #endif
 
+#ifndef ELF_AT_FLAGS
+#define ELF_AT_FLAGS	0
+#endif
+
 #define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
 #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
 #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
@@ -251,7 +255,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	NEW_AUX_ENT(AT_FLAGS, ELF_AT_FLAGS);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b53bb3729ac1..cf1e680a6b88 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -82,6 +82,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *,
 static int elf_fdpic_core_dump(struct coredump_params *cprm);
 #endif
 
+#ifndef ELF_AT_FLAGS
+#define ELF_AT_FLAGS	0
+#endif
+
 static struct linux_binfmt elf_fdpic_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_fdpic_binary,
@@ -651,7 +655,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	NEW_AUX_ENT(AT_FLAGS,	ELF_AT_FLAGS);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 15f6e96b3bd9..a21cf99701ae 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -79,6 +79,11 @@
 #define	ELF_HWCAP2		COMPAT_ELF_HWCAP2
 #endif
 
+#ifdef	COMPAT_ELF_AT_FLAGS
+#undef	ELF_AT_FLAGS
+#define	ELF_AT_FLAGS		COMPAT_ELF_AT_FLAGS
+#endif
+
 #ifdef	COMPAT_ARCH_DLINFO
 #undef	ARCH_DLINFO
 #define	ARCH_DLINFO		COMPAT_ARCH_DLINFO
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
