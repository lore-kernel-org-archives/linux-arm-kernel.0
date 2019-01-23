Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59677C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:57:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262D3218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AtgfSOFL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIH7Rh9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262D3218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rtk6ij5wujMPMNF2PutQoZdcXQcJOIYTRjm8GmGMp6Y=; b=AtgfSOFLp5GAJCGsY/idH25OeC
	vDjkcpJBlA9HyPnMDmokK7Nc/bkCxlnKUofX7kmZUwPXhLG/zCS27UsL4ozpdde/FRSkWe+hu8lcf
	7ZE0T+Qrm1iBJaKYiRmc9aWKLKYD7b/ISH/r3SjwbYAbFS/zXLfnK5iIKLnIufdmYQvY+JBzUYuqU
	VaBEAYMsUmfiK91XTrAeqXk9F593KYcTURrWhbQUV6Xh0OxTFOeTPKS3XgF7FUyiNAIi1Qo5+pFvZ
	lAPHbzFCRjq8Hm0CnjuSIGAQNXXTEgwTibwIq7Tt7WOPrc9dw7bGo8WjnqsSwqhe4fcKXIatByG/9
	PSkE1uAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmRSu-00069e-On; Wed, 23 Jan 2019 22:57:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmRSq-00069C-Pf
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 22:57:46 +0000
Received: from localhost (unknown [23.100.24.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B814420856;
 Wed, 23 Jan 2019 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548284264;
 bh=RBBQYyushjJZUsXxefbvW1saQZJFLafTPDWXfaXwRks=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
 References:From;
 b=SIH7Rh9UzFDI1DTIZp/DxNzycSIcppa2OVDZd5GZAe76q92JZkc6fgon/gCw/WBkD
 NNDXVwCvFxi6mpU3hxCxMHJGnR5H+ApOC67MKUbQf7Qe2pL6QM6tyExJzPucYqN7cY
 bMzi5uokBh38fCoO1iB5rTAHe31Sl/uMllcgSxXc=
Date: Wed, 23 Jan 2019 22:57:42 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Julien Thierry <julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
In-Reply-To: <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
References: <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
Message-Id: <20190123225743.B814420856@mail.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_145744_861704_08C2574B 
X-CRM114-Status: UNSURE (   9.48  )
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
Cc: , linux-arch@vger.kernel.org, daniel.thompson@linaro.org,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 James Morse <james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v4.20.3, v4.19.16, v4.14.94, v4.9.151, v4.4.171, v3.18.132.

v4.20.3: Build OK!
v4.19.16: Build OK!
v4.14.94: Build OK!
v4.9.151: Failed to apply! Possible dependencies:
    096683724cb2 ("arm64: unwind: avoid percpu indirection for irq stack")
    34be98f4944f ("arm64: kernel: remove {THREAD,IRQ_STACK}_START_SP")
    a9ea0017ebe8 ("arm64: factor out current_stack_pointer")
    c02433dd6de3 ("arm64: split thread_info from task stack")
    c7365330753c ("arm64: unwind: disregard frame.sp when validating frame pointer")
    dbc9344a68e5 ("arm64: clean up THREAD_* definitions")
    f60ad4edcf07 ("arm64: clean up irq stack definitions")
    f60fe78f1332 ("arm64: use an irq stack pointer")

v4.4.171: Failed to apply! Possible dependencies:
    096683724cb2 ("arm64: unwind: avoid percpu indirection for irq stack")
    0a8ea52c3eb1 ("arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature")
    132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")
    1ffe199b1c9b ("arm64: when walking onto the task stack, check sp & fp are in current->stack")
    20380bb390a4 ("arm64: ftrace: fix a stack tracer's output under function graph tracer")
    7596abf2e566 ("arm64: irq: fix walking from irq stack to task stack")
    8e23dacd12a4 ("arm64: Add do_softirq_own_stack() and enable irq_stacks")
    971c67ce37cf ("arm64: reduce stack use in irq_handler")
    a80a0eb70c35 ("arm64: make irq_stack_ptr more robust")
    c7365330753c ("arm64: unwind: disregard frame.sp when validating frame pointer")
    f60ad4edcf07 ("arm64: clean up irq stack definitions")
    f60fe78f1332 ("arm64: use an irq stack pointer")
    fe13f95b7200 ("arm64: pass a task parameter to unwind_frame()")

v3.18.132: Failed to apply! Possible dependencies:
    020295b4cb5b ("ACPI / processor: Make it possible to get CPU hardware ID via GICC")
    132cd887b5c5 ("arm64: Modify stack trace and dump for use with irq_stack")
    13ca62b243f6 ("ACPI: Fix minor syntax issues in processor_core.c")
    37655163ce1a ("ARM64 / ACPI: Get RSDP and ACPI boot-time tables")
    587064b610c7 ("arm64: Add framework for legacy instruction emulation")
    652261a7a86c ("ACPI: fix acpi_os_ioremap for arm64")
    828aef376d7a ("ACPI / processor: Introduce phys_cpuid_t for CPU hardware ID")
    96f0e00378d4 ("ARM: add basic support for on-demand backtrace of other CPUs")
    af2c632e234f ("arm64/include/asm: Fixed a warning about 'struct pt_regs'")
    af8f3f514d19 ("ACPI / processor: Convert apic_id to phys_id to make it arch agnostic")
    b4ff8389ed14 ("xen/events: Always allocate legacy interrupts on PV guests")
    d02dc27db0dc ("ACPI / processor: Rename acpi_(un)map_lsapic() to acpi_(un)map_cpu()")
    d60fc3892c4d ("irqchip: Add GICv2 specific ACPI boot support")
    ecf5636dcd59 ("ACPI: Add interfaces to parse IOAPIC ID for IOAPIC hotplug")
    f60ad4edcf07 ("arm64: clean up irq stack definitions")
    f60fe78f1332 ("arm64: use an irq stack pointer")


How should we proceed with this patch?

--
Thanks,
Sasha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
