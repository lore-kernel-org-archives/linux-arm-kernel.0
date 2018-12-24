Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC29C64E75
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1672184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tVepsyIU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="V7qedW9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1672184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P1rK1UgNfNeh6kIL0ETYI7XQO4BzTjTgbzxX0+LQcfw=; b=tVepsyIUc71XNa
	7eJmdZ3G2zFWRHRAbQmEr17hkJf3uC62pqy2ipOLgmeybBuVzifgu3oqEnrRkgqJVLy8DRY45TFMI
	EojfS/fzZLoPOzb2jsNvoUzHUNupavM3M6v4t7u8+zPRyDWCOX5DVVSItU3BAQ4bSRka714OamzUq
	XlQvKKxqZZ2vnUVf2OsHRDvwVb837ZWZGbtERP1WCdIZBUoohSCmA7y9ICtVR6SvYTAG1cAZ8uvrf
	W9tQ4X6mIURvPGhHmRPkgGy+4VDMZ94fCiyyK585RZqEF5QgiunwPORkMekgaqZWBc13pPSJsQBS+
	VIX2TdZbxTpV82/eKv/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbS13-0000Di-H7; Mon, 24 Dec 2018 15:19:37 +0000
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbS0z-0000Cx-N5
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 15:19:35 +0000
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wBOFIq8h016647
 for <linux-arm-kernel@lists.infradead.org>; Tue, 25 Dec 2018 00:18:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBOFIq8h016647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1545664733;
 bh=UXjlcCjNBYREdXZVkdbV9tZVMZM+rHkD94gGjCVeWRU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=V7qedW9REXOQ1L9cZ6RcS12Hrf8Ba9Q5WVW2jfUwcZ38eIvMBBOjmYNgNFYiLJMea
 YIkVTYhm9PRpNB9JOBw4HIf0yEX3gstqDcPgPbRDsnrhFYaqGIM+qfYY6C0uIGrfBJ
 B9ykGphR7tqYrKK/zZjF50cx1kNTxVxqYfk2b4q2OC9+4TY5plGp6HQA7VmqZcrWcN
 MrEPlArP1org01GH8+UCPVt/UPS5lto2lxpeqhi/RWm3Sp8JcUsAmw+PZ/vA/nYLmW
 Yijk7TMqd7f2WAbOJ55gft86LfoOzvlDHIG0oKFkH97WmokfNkxQh9xFu2gfLTkIP3
 TQZxtCoMPPtyg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id n7so3912740uao.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 07:18:52 -0800 (PST)
X-Gm-Message-State: AJcUukfmSyZK4ykFdhwLiODRi2bJAnlVRW+nviRnEYzPcBSIiweyZPWM
 01CdvXNpWGLuQo/iddPKPOMdMAYijOswFfO9BCk=
X-Google-Smtp-Source: ALg8bN45VGA3r/fkHUvZIsAF2hDkVlHRcnJf9QXZM8gm2WW9D0I2gwTzu8R+fcjlGcmnhwxPzSU1VIXVFfB/fCHKisY=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr4798362uaj.42.1545664731483;
 Mon, 24 Dec 2018 07:18:51 -0800 (PST)
MIME-Version: 1.0
References: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 25 Dec 2018 00:18:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVQY+w3o0j6sKp7ZiLMJX2SorddmsHbskqmMwimzPh7A@mail.gmail.com>
Message-ID: <CAK7LNATVQY+w3o0j6sKp7ZiLMJX2SorddmsHbskqmMwimzPh7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] treewide: remove explicit rules for *offsets.s
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_071933_970916_A4A062FA 
X-CRM114-Status: GOOD (  15.39  )
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, Tony Lindgren <tony@atomide.com>,
 Networking <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Russell King <linux@armlinux.org.uk>, Linux-OMAP <linux-omap@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 23, 2018 at 7:32 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> These explicit rules are unneeded because scripts/Makefile.build
> provides a pattern rule to create %.s from %.c
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Series, applied to linux-kbuild.


>  Kbuild                              | 9 +--------
>  arch/arm/mach-at91/Makefile         | 3 ---
>  arch/arm/mach-omap2/Makefile        | 3 ---
>  arch/ia64/kernel/Makefile           | 5 -----
>  drivers/memory/Makefile.asm-offsets | 3 ---
>  samples/bpf/Makefile                | 3 ---
>  6 files changed, 1 insertion(+), 25 deletions(-)
>
> diff --git a/Kbuild b/Kbuild
> index 0053042..b24210c 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -16,10 +16,6 @@ bounds-file := include/generated/bounds.h
>  always  := $(bounds-file)
>  targets := kernel/bounds.s
>
> -# We use internal kbuild rules to avoid the "is up to date" message from make
> -kernel/bounds.s: kernel/bounds.c FORCE
> -       $(call if_changed_dep,cc_s_c)
> -
>  $(obj)/$(bounds-file): kernel/bounds.s FORCE
>         $(call filechk,offsets,__LINUX_BOUNDS_H__)
>
> @@ -50,10 +46,7 @@ offsets-file := include/generated/asm-offsets.h
>  always  += $(offsets-file)
>  targets += arch/$(SRCARCH)/kernel/asm-offsets.s
>
> -# We use internal kbuild rules to avoid the "is up to date" message from make
> -arch/$(SRCARCH)/kernel/asm-offsets.s: arch/$(SRCARCH)/kernel/asm-offsets.c \
> -                                      $(obj)/$(timeconst-file) $(obj)/$(bounds-file) FORCE
> -       $(call if_changed_dep,cc_s_c)
> +arch/$(SRCARCH)/kernel/asm-offsets.s: $(obj)/$(timeconst-file) $(obj)/$(bounds-file)
>
>  $(obj)/$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
>         $(call filechk,offsets,__ASM_OFFSETS_H__)
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 7415f18..f87066b 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -19,9 +19,6 @@ ifeq ($(CONFIG_PM_DEBUG),y)
>  CFLAGS_pm.o += -DDEBUG
>  endif
>
> -arch/arm/mach-at91/pm_data-offsets.s: arch/arm/mach-at91/pm_data-offsets.c
> -       $(call if_changed_dep,cc_s_c)
> -
>  include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
>         $(call filechk,offsets,__PM_DATA_OFFSETS_H__)
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 01377c2..55c482c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -236,9 +236,6 @@ obj-y                                       += omap_phy_internal.o
>
>  obj-$(CONFIG_MACH_OMAP2_TUSB6010)      += usb-tusb6010.o
>
> -arch/arm/mach-omap2/pm-asm-offsets.s: arch/arm/mach-omap2/pm-asm-offsets.c
> -       $(call if_changed_dep,cc_s_c)
> -
>  include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
>         $(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
>
> diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
> index d0c0ccd..7372d99 100644
> --- a/arch/ia64/kernel/Makefile
> +++ b/arch/ia64/kernel/Makefile
> @@ -50,10 +50,5 @@ CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
>  # The gate DSO image is built using a special linker script.
>  include $(src)/Makefile.gate
>
> -# We use internal kbuild rules to avoid the "is up to date" message from make
> -arch/$(SRCARCH)/kernel/nr-irqs.s: arch/$(SRCARCH)/kernel/nr-irqs.c
> -       $(Q)mkdir -p $(dir $@)
> -       $(call if_changed_dep,cc_s_c)
> -
>  include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s FORCE
>         $(call filechk,offsets,__ASM_NR_IRQS_H__)
> diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
> index 843ff60..f968dfa 100644
> --- a/drivers/memory/Makefile.asm-offsets
> +++ b/drivers/memory/Makefile.asm-offsets
> @@ -1,5 +1,2 @@
> -drivers/memory/emif-asm-offsets.s: drivers/memory/emif-asm-offsets.c
> -       $(call if_changed_dep,cc_s_c)
> -
>  include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
>         $(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index be0a961..100a49d 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -227,9 +227,6 @@ $(LIBBPF): FORCE
>  # Fix up variables inherited from Kbuild that tools/ build system won't like
>         $(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
>
> -$(obj)/syscall_nrs.s:  $(src)/syscall_nrs.c
> -       $(call if_changed_dep,cc_s_c)
> -
>  $(obj)/syscall_nrs.h:  $(obj)/syscall_nrs.s FORCE
>         $(call filechk,offsets,__SYSCALL_NRS_H__)
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
