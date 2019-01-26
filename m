Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2EC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:22:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5027218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lLnf2NPW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="US6bfJ3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5027218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XjGv572O5aUIbijHBauh2afW4vVg7So3+9p/oQrwoKk=; b=lLn
	f2NPWeTFYpu9EM1r8LJ6BIoN9EBZCuvJvHjEKiWrC7k7kG6W8Xml3r7SJgYuxN9cMAw/eq6d71lEg
	FDDOogcy/9YHd266MDGylL2Nx1iFwPHYLEW7j/8rlw3Uan1tmdkJaZTZhcb2I6zKJmdQ2CjowsjFI
	k8WgjDXANwCVKlnI/2KC+H48YpxNm6njuz4BIHweVmnUTPQWJrSUK/nSSkNFQ0/RW7i5dnooPRK8i
	hr73k2ZErYEIDlyDnekaayRCrfXF/u87NirnFYAlWH0cbGLL77YaVe3Z1UqBbW7TFsZ91mnqSrpSI
	ZUBW6Vnr04kQk1SACQFK02aZS2B9SNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnL6X-0003DM-Ht; Sat, 26 Jan 2019 10:22:25 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnL6T-0003Cm-Kt
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 10:22:23 +0000
Received: by mail-wr1-x442.google.com with SMTP id t27so12761787wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 26 Jan 2019 02:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=LPSux1Ow7b5gv5r9U7Upb1rNzKAqe3fdivFt3Ax38Nw=;
 b=US6bfJ3FgUYwtZaqDsFdnMuuDjEaWPGvIpwj+SZqXnhiAW1nUAQuI0ba0S/eKztZ6p
 wLQZ1sDKy/ZmJj4G0WFUxNy/bcpATq3euGOKGmqwXfEn9ha9/l/FxY5PRWemWG+vz4Oz
 75d5Nj9cr68+mZ6mfAEs0EQ55EXjWIvImWIik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=LPSux1Ow7b5gv5r9U7Upb1rNzKAqe3fdivFt3Ax38Nw=;
 b=OzTJ3da3SNBmq+w936nFrKggXqV75Fy2m5BYtL2otQ3dcqvcuV4nb9gZhSrTGInwPI
 VMwy1KVb99d7dZjOH3ao+VlS7NBtf5ZvmdAOr3llMS46h0FhDJL1cV+6N3FBakGixdOu
 beASDDSlyskbN/H8bZbmzfUzLyQokk8h09Dny4R9R8IbgoBbC/O9mfwJfQkhXKJEn71M
 JRl+4hXW2YCoCZaGSPcznXD6l1kEhtzMNsxBycuTMKC4wQEBBksisXm4ZDU4tPsd68SS
 6JcO08Gtr/nFvjpc44q8K3rIoswk275Ra1OdK3V95fSl2cWFks3xIqaeyz8IS/QBDRhD
 MDKg==
X-Gm-Message-State: AJcUukds4owalVBKOAP7J8sQtF68nXOYVkbhVaMGgQCPduW6dEsW/31V
 leRVHkdYygWjGBGpYvfdUlLIEQ==
X-Google-Smtp-Source: ALg8bN4D6cDgMEIK5hNr4yVVXahtbtWk7/52XbefeV1GRvwSdqdlCgWAzs5NZeuOH5ISWOkqLQPp7A==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr14210708wrn.307.1548498139302; 
 Sat, 26 Jan 2019 02:22:19 -0800 (PST)
Received: from dogfood.home ([2a01:cb1d:112:6f00:ccd2:d408:6bac:4700])
 by smtp.gmail.com with ESMTPSA id 60sm192265924wrb.81.2019.01.26.02.22.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 26 Jan 2019 02:22:18 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
Date: Sat, 26 Jan 2019 11:22:07 +0100
Message-Id: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_022221_704921_403FBA4C 
X-CRM114-Status: GOOD (  21.11  )
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
Cc: mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, will.deacon@arm.com,
 Alexander Graf <agraf@suse.de>, Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The UEFI spec revision 2.7 errata A section 8.4 has the following to
say about the virtual memory runtime services:

  "This section contains function definitions for the virtual memory
  support that may be optionally used by an operating system at runtime.
  If an operating system chooses to make EFI runtime service calls in a
  virtual addressing mode instead of the flat physical mode, then the
  operating system must use the services in this section to switch the
  EFI runtime services from flat physical addressing to virtual
  addressing."

So it is pretty clear that calling SetVirtualAddressMap() is entirely
optional, and so there is no point in doing so unless it achieves
anything useful for us.

This is not the case for 64-bit ARM. The native mapping used by the OS
is arbitrarily converted into another permutation of userland addresses
(i.e., bits [63:48] cleared), and the runtime code could easily deal
with the original layout in exactly the same way as it deals with the
converted layout. However, due to constraints related to page size
differences if the OS is not running with 4k pages, and related to
systems that may expose the individual sections of PE/COFF runtime
modules as different memory regions, creating the virtual layout is a
bit fiddly, and requires us to sort the memory map and reason about
adjacent regions with identical memory types etc etc.

So the obvious fix is to stop calling SetVirtualAddressMap() altogether
on arm64 systems. However, to avoid surprises, which are notoriously
hard to diagnose when it comes to OS<->firmware interactions, let's
start by making it an opt-out feature, and implement support for the
'efi=novamap' kernel command line parameter on ARM and arm64 systems.

(Note that 32-bit ARM generally does require SetVirtualAddressMap() to be
used, given that the physical memory map and the kernel virtual address
map are not guaranteed to be non-overlapping like on arm64. However,
having support for efi=novamap,noruntime on 32-bit ARM, combined with
the recently proposed support for earlycon=efi, is likely to be useful
to diagnose boot issues on such systems if they have no accessible serial
port)

Cc: Alexander Graf <agraf@suse.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm-stub.c        |  5 +++++
 drivers/firmware/efi/libstub/efi-stub-helper.c | 10 ++++++++++
 drivers/firmware/efi/libstub/efistub.h         |  1 +
 drivers/firmware/efi/libstub/fdt.c             |  3 +++
 4 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..626ec4b4a664 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -370,6 +370,11 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 		paddr = in->phys_addr;
 		size = in->num_pages * EFI_PAGE_SIZE;
 
+		if (novamap()) {
+			in->virt_addr = in->phys_addr;
+			continue;
+		}
+
 		/*
 		 * Make the mapping compatible with 64k pages: this allows
 		 * a 4k page size kernel to kexec a 64k page size kernel and
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index e94975f4655b..442f51c2a53d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -34,6 +34,7 @@ static unsigned long __chunk_size = EFI_READ_CHUNK_SIZE;
 
 static int __section(.data) __nokaslr;
 static int __section(.data) __quiet;
+static int __section(.data) __novamap;
 
 int __pure nokaslr(void)
 {
@@ -43,6 +44,10 @@ int __pure is_quiet(void)
 {
 	return __quiet;
 }
+int __pure novamap(void)
+{
+	return __novamap;
+}
 
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
@@ -482,6 +487,11 @@ efi_status_t efi_parse_options(char const *cmdline)
 			__chunk_size = -1UL;
 		}
 
+		if (!strncmp(str, "novamap", 7)) {
+			str += strlen("novamap");
+			__novamap = 1;
+		}
+
 		/* Group words together, delimited by "," */
 		while (*str && *str != ' ' && *str != ',')
 			str++;
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 32799cf039ef..337b52c4702c 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -27,6 +27,7 @@
 
 extern int __pure nokaslr(void);
 extern int __pure is_quiet(void);
+extern int __pure novamap(void);
 
 #define pr_efi(sys_table, msg)		do {				\
 	if (!is_quiet()) efi_printk(sys_table, "EFI stub: "msg);	\
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0dc7b4987cc2..f8f89f995e9d 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -327,6 +327,9 @@ efi_status_t allocate_new_fdt_and_exit_boot(efi_system_table_t *sys_table,
 	if (status == EFI_SUCCESS) {
 		efi_set_virtual_address_map_t *svam;
 
+		if (novamap())
+			return EFI_SUCCESS;
+
 		/* Install the new virtual address map */
 		svam = sys_table->runtime->set_virtual_address_map;
 		status = svam(runtime_entry_count * desc_size, desc_size,
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
