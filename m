Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D61C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8590E20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IKyu9i3A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZfjwtGQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8590E20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ZC9SUC1KZH/RbrmhwGMVFehvPq4afu6B07Ys2nX2Q5o=; b=IKy
	u9i3AzrZGiH9OWcFQaZS5n9eGQge91kFnPzP92WfD4j4IACxRbt3Ys2t9Tys60MlK4ttJTSqbCGGg
	t31Bohacf8EmSdPNTNm/QmpyF6q56StObMG4mlJZDWxE8FnX8UC8ybV9K6kY9Pi7HclsN9wBcDCiq
	H25NKBrmHNyrXy7xS1cuGrdkXM5W+nrNN0FSvVbjgEEsypWm3CIsfOZWHsiaOjmh3Z7cGMnreoK30
	rwKgtC9gMvUndOKFZ3AR7BLgSam+vSKqdJcDzldhqtO4RrTjZGDh8RsXoH2H0IhbGB8hbz8gZQE3k
	zA2las5VOuI8udA/MZUUbXq35YBbjbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdssd-0004y5-DM; Mon, 31 Dec 2018 08:24:59 +0000
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdssO-0004pk-3J
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 08:24:46 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id wBV8OIjp008355;
 Mon, 31 Dec 2018 17:24:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBV8OIjp008355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546244660;
 bh=G8pxkQmNDNH3vwq5DKqGPQ+ShnVl7BpdwBqJnR3pKbo=;
 h=From:To:Cc:Subject:Date:From;
 b=ZfjwtGQabuf0cb/sdFUOwqK57/lxOuu6+GbZXmf3IPAlLiPS6K0zcW2EMtFY4Lz1J
 RAGJHcHOV7QNVuhhvodMXrU8onxoZGi7uFMIuc9IYPvTe6BG1gSao331eGn2Ks9Mw/
 msE30BqsL25KsQkEtuEbS5KVOdRpEG+plIDegOCdt3Lw4HxIF0dTlGC7XVLBZLhPUx
 oN1LZFbTj+16yOFdpiRDladqZJuH0ZHRiT59CqMF1ODRioBXtW7/JFhzY4LTjUSCtx
 /ZNy4QskWbXpF10YTNm2WkIsv5kg0bykl+PVKHMGEchB69cEorLdO5wpSGwcYj0DZ3
 1XB1Pyk+XOdSg==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 1/4] kbuild: remove redundant target cleaning on failure
Date: Mon, 31 Dec 2018 17:24:08 +0900
Message-Id: <1546244651-10447-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_002444_468288_6DD0E00B 
X-CRM114-Status: GOOD (  11.79  )
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
 David Howells <dhowells@redhat.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, keyrings@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Russell King <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
target"), the target file is automatically deleted on failure.

The boilerplate code

  ... || { rm -f $@; false; }

is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/Makefile            |  2 +-
 arch/arm/boot/compressed/Makefile |  2 +-
 arch/arm/tools/Makefile           |  3 +--
 arch/sh/tools/Makefile            |  2 +-
 arch/x86/boot/compressed/Makefile |  2 +-
 arch/x86/lib/Makefile             |  2 +-
 certs/Makefile                    |  2 +-
 lib/raid6/Makefile                |  5 ++---
 scripts/Makefile.lib              | 21 +++++++--------------
 9 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index a3af4dc..0b3cd7a 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -32,7 +32,7 @@ targets := Image zImage xipImage bootpImage uImage
 ifeq ($(CONFIG_XIP_KERNEL),y)
 
 cmd_deflate_xip_data = $(CONFIG_SHELL) -c \
-	'$(srctree)/$(src)/deflate_xip_data.sh $< $@ || { rm -f $@; false; }'
+	'$(srctree)/$(src)/deflate_xip_data.sh $< $@'
 
 ifeq ($(CONFIG_XIP_DEFLATED_DATA),y)
 quiet_cmd_mkxip = XIPZ    $@
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 01bf258..6114ae6 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -170,7 +170,7 @@ check_for_bad_syms = \
 bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
 [ -z "$$bad_syms" ] || \
   ( echo "following symbols must have non local/private scope:" >&2; \
-    echo "$$bad_syms" >&2; rm -f $@; false )
+    echo "$$bad_syms" >&2; false )
 
 check_for_multiple_zreladdr = \
 if [ $(words $(ZRELADDR)) -gt 1 -a "$(CONFIG_AUTO_ZRELADDR)" = "" ]; then \
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index ddb89a7..27d8beb 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -35,8 +35,7 @@ _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
 
 quiet_cmd_gen_mach = GEN     $@
       cmd_gen_mach = mkdir -p $(dir $@) && \
-		     $(AWK) -f $(filter-out $(PHONY),$^) > $@ || \
-		     { rm -f $@; /bin/false; }
+		     $(AWK) -f $(filter-out $(PHONY),$^) > $@
 
 $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
diff --git a/arch/sh/tools/Makefile b/arch/sh/tools/Makefile
index 2082af1..e5ba31c 100644
--- a/arch/sh/tools/Makefile
+++ b/arch/sh/tools/Makefile
@@ -13,4 +13,4 @@
 include/generated/machtypes.h: $(src)/gen-mach-types $(src)/mach-types
 	@echo '  Generating $@'
 	$(Q)mkdir -p $(dir $@)
-	$(Q)LC_ALL=C $(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
+	$(Q)LC_ALL=C $(AWK) -f $^ > $@
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 466f66c..f0515ac8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -151,7 +151,7 @@ suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
 suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
 
 quiet_cmd_mkpiggy = MKPIGGY $@
-      cmd_mkpiggy = $(obj)/mkpiggy $< > $@ || ( rm -f $@ ; false )
+      cmd_mkpiggy = $(obj)/mkpiggy $< > $@
 
 targets += piggy.S
 $(obj)/piggy.S: $(obj)/vmlinux.bin.$(suffix-y) $(obj)/mkpiggy FORCE
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 25a972c..89d0f37 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -9,7 +9,7 @@ KCOV_INSTRUMENT_delay.o	:= n
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables = GEN     $@
-      cmd_inat_tables = $(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@ || rm -f $@
+      cmd_inat_tables = $(AWK) -f $(inat_tables_script) $(inat_tables_maps) > $@
 
 $(obj)/inat-tables.c: $(inat_tables_script) $(inat_tables_maps)
 	$(call cmd,inat_tables)
diff --git a/certs/Makefile b/certs/Makefile
index 5d0999b..f4c25b6 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -22,7 +22,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 AFLAGS_system_certificates.o := -I$(srctree)
 
 quiet_cmd_extract_certs  = EXTRACT_CERTS   $(patsubst "%",%,$(2))
-      cmd_extract_certs  = scripts/extract-cert $(2) $@ || ( rm $@; exit 1)
+      cmd_extract_certs  = scripts/extract-cert $(2) $@
 
 targets += x509_certificate_list
 $(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 7ed43ea..4e90d44 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -13,8 +13,7 @@ raid6_pq-$(CONFIG_S390) += s390vx8.o recov_s390xc.o
 hostprogs-y	+= mktables
 
 quiet_cmd_unroll = UNROLL  $@
-      cmd_unroll = $(AWK) -f$(srctree)/$(src)/unroll.awk -vN=$(UNROLL) \
-                   < $< > $@ || ( rm -f $@ && exit 1 )
+      cmd_unroll = $(AWK) -f$(srctree)/$(src)/unroll.awk -vN=$(UNROLL) < $< > $@
 
 ifeq ($(CONFIG_ALTIVEC),y)
 altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
@@ -160,7 +159,7 @@ $(obj)/s390vx8.c:   $(src)/s390vx.uc $(src)/unroll.awk FORCE
 	$(call if_changed,unroll)
 
 quiet_cmd_mktable = TABLE   $@
-      cmd_mktable = $(obj)/mktables > $@ || ( rm -f $@ && exit 1 )
+      cmd_mktable = $(obj)/mktables > $@
 
 targets += tables.c
 $(obj)/tables.c: $(obj)/mktables FORCE
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d10c61e..390957f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -242,8 +242,7 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------
 
 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@) || \
-	(rm -f $@ ; false)
+      cmd_gzip = cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@
 
 # DTC
 # ---------------------------------------------------------------------------
@@ -336,26 +335,22 @@ printf "%08x\n" $$dec_size |						\
 
 quiet_cmd_bzip2 = BZIP2   $@
 cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
-	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
 cmd_lzma = (cat $(filter-out FORCE,$^) | \
-	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 quiet_cmd_lzo = LZO     $@
 cmd_lzo = (cat $(filter-out FORCE,$^) | \
-	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 quiet_cmd_lz4 = LZ4     $@
 cmd_lz4 = (cat $(filter-out FORCE,$^) | \
-	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -399,13 +394,11 @@ quiet_cmd_uimage = UIMAGE  $@
 quiet_cmd_xzkern = XZKERN  $@
 cmd_xzkern = (cat $(filter-out FORCE,$^) | \
 	sh $(srctree)/scripts/xz_wrap.sh && \
-	$(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	$(call size_append, $(filter-out FORCE,$^))) > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
 cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
-	xz --check=crc32 --lzma2=dict=1MiB) > $@ || \
-	(rm -f $@ ; false)
+	xz --check=crc32 --lzma2=dict=1MiB) > $@
 
 # ASM offsets
 # ---------------------------------------------------------------------------
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
