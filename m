Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71A9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:19:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E40217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K55094Ao";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Xl2Jxpxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E40217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FgaXqev+Gziy+BeGxRuZVU1F9UcK1QQRndq+64BDHAg=; b=K55
	094Aot6+WUMeFMna3pIW10DHWilAXRZNqywK9i+QqkIqIOGW9Zz/sFqG2UAqwY1l0WA3rbSx+2guf
	G33llIaMcXfXAAuro+ZtJnKgK78p4s0IO9MTXfjA0jmcJFY080TYB/OBh/XdTboppzpegkT00vB3M
	pkO9/x8po7Q1chmefbyqryM5i+ms6agN+63ks3V5USLPleJ3XUxfQGq5LevnSB/aZ+fCLBl1XzORk
	CbxnzQ/FEUjk/X5SjgWSkA4tPG9hgxJAtEaCS7DLXbgT32ioHkIwwzaWSuXgyIb/+BxFXKf95UJOJ
	+zRojA3wGOSHHehn+vSjW6dhX/RfLWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfDCi-0002a6-Je; Fri, 04 Jan 2019 00:19:12 +0000
Received: from conuserg-10.nifty.com ([210.131.2.77])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfDCd-0002Zm-Qx
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 00:19:10 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id x040Ijxk017309;
 Fri, 4 Jan 2019 09:18:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x040Ijxk017309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546561126;
 bh=IaD/HolgSGMUeGhnmpsyJZDiXgKRDX2gM/yw9Qup5i8=;
 h=From:To:Cc:Subject:Date:From;
 b=Xl2JxpxisNF6Imk/pq54MMqSBlX/6Z6plo4qk/hUSdPSDpIL5/pUtMGCEUYEr8Bfu
 kqw5SIAJmZ9wQFYdrwKH50EyxdZ/FEKiOKzWt90pqHJYBypJMb0Rhmwk86XGuxfp1S
 VTVdE1zWuXs3pU5HbucW58RT4I9S+X0kV4Fa3cTGiwzFqsOJHXP6RUYbBHW/Li27kC
 jw1EpUDIC5oI4WtfxBbcafBDxlEJXKIi4nURhzvWBghvwFAjzidyUUMpHA4oAVOHF7
 STcTVSOBH6yoRMakE4eLDrzRlHSC1y39UoBMHb79KWYQyArwIZ8NRnnO4Ww4Q1hQA5
 w992o92rQo1kQ==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] arm64: replace arm64-obj-* in Makefile with obj-*
Date: Fri,  4 Jan 2019 09:18:41 +0900
Message-Id: <1546561121-23086-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_161908_210031_E68EB52D 
X-CRM114-Status: UNSURE (   6.54  )
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
same.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rebase

 arch/arm64/kernel/Makefile | 61 +++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index df08d73..cd434d0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -12,7 +12,7 @@ CFLAGS_REMOVE_insn.o = -pg
 CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
-arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
+obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   entry-fpsimd.o process.o ptrace.o setup.o signal.o	\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
 			   hyp-stub.o psci.o cpu_ops.o insn.o	\
@@ -27,41 +27,40 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
+obj-$(CONFIG_COMPAT)			+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o
-arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
-arm64-obj-$(CONFIG_MODULES)		+= module.o
-arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
-arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
-arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
-arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
-arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
-arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
-arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
-arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
-arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
+obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
+obj-$(CONFIG_MODULES)			+= module.o
+obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
+obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
+obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
+obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
+obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
+obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
+obj-$(CONFIG_KGDB)			+= kgdb.o
+obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o		\
 					   efi-rt-wrapper.o
-arm64-obj-$(CONFIG_PCI)			+= pci.o
-arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
-arm64-obj-$(CONFIG_ACPI)		+= acpi.o
-arm64-obj-$(CONFIG_ACPI_NUMA)		+= acpi_numa.o
-arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
-arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
-arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
-arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
+obj-$(CONFIG_PCI)			+= pci.o
+obj-$(CONFIG_ARMV8_DEPRECATED)		+= armv8_deprecated.o
+obj-$(CONFIG_ACPI)			+= acpi.o
+obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
+obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
+obj-$(CONFIG_PARAVIRT)			+= paravirt.o
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
+obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
+obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
-arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
+obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
+obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
-arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
-arm64-obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
-arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
-arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
-arm64-obj-$(CONFIG_ARM64_PTR_AUTH)	+= pointer_auth.o
+obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
+obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
+obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
+obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 
-obj-y					+= $(arm64-obj-y) vdso/ probes/
-obj-m					+= $(arm64-obj-m)
+obj-y					+= vdso/ probes/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
