Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D92C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0048221104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bf40w+s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0048221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pXjfZd5BxO9k6pbp/3A9P5WKzU728zxik0JTQ3sx1DA=; b=bf40w+s6XumOpK
	idh8A3XyTsY24NPH/QRTdhBUM/B9voeUNK5qRq/if56wlbwXObiVMX8y3d6xQsx5ZnOuU7cPCi8+t
	ZxHYG0tGOVhGwhK4NpIYWCRzqwT0crUgz89PX8kHeGSYoS9BEoqM4iKrlDx8PnHQjDOnXieTMeXsq
	1xq9R86SfsvdlyUcFq9ALpVIBUV7Y9OOkeiBWg3bZz+Veo1f5k0AgwBJe57cW3U736GAicvU+y/Ty
	e8RISEogPNnj4RbQMarq2dNmNQWSy9YJq7hskDX7AIlMEbqg3l2bTGfAsLskCowHRgu1IZDne9WSu
	s52FZX7+8OCbd6q+RE+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQN2-0007t6-BR; Thu, 29 Nov 2018 17:45:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQMu-0007di-V8
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:44:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FDA580D;
 Thu, 29 Nov 2018 09:44:41 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A783F575;
 Thu, 29 Nov 2018 09:44:39 -0800 (PST)
Date: Thu, 29 Nov 2018 17:44:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 08/24] arm64: Unmask PMR before going idle
Message-ID: <20181129174436.avqjydyzvv6ubnjd@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-9-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-9-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094453_014675_95470F46 
X-CRM114-Status: GOOD (  23.58  )
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
Cc: daniel.thompson@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 james.morse@arm.com, joel@joelfernandes.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:59AM +0000, Julien Thierry wrote:
> CPU does not received signals for interrupts with a priority masked by
> ICC_PMR_EL1. This means the CPU might not come back from a WFI
> instruction.
> 
> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/proc.S | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 2c75b0b..3c7064c 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -20,6 +20,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/linkage.h>
> +#include <linux/irqchip/arm-gic-v3.h>
>  #include <asm/assembler.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/hwcap.h>
> @@ -53,10 +54,27 @@
>   *	cpu_do_idle()
>   *
>   *	Idle the processor (wait for interrupt).
> + *
> + *	If the CPU supports priority masking we must do additional work to
> + *	ensure that interrupts are not masked at the PMR (because the core will
> + *	not wake up if we block the wake up signal in the interrupt controller).
>   */
>  ENTRY(cpu_do_idle)
> +alternative_if_not ARM64_HAS_IRQ_PRIO_MASKING
> +	dsb	sy				// WFI may enter a low-power mode
> +	wfi
> +	ret
> +alternative_else
> +	mrs	x0, daif			// save I bit
> +	msr	daifset, #2			// set I bit
> +	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
> +alternative_endif
> +	mov	x2, #GIC_PRIO_IRQON
> +	msr_s	SYS_ICC_PMR_EL1, x2		// unmask PMR
>  	dsb	sy				// WFI may enter a low-power mode

Is the DSB SY sufficient and necessary to synchronise the update of
SYS_ICC_PMR_EL1? We don't need an ISB too?

>  	wfi
> +	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR

Likewise, we don't need any barriers here before we poke DAIF?

> +	msr	daif, x0			// restore I bit
>  	ret
>  ENDPROC(cpu_do_idle)

If we build without CONFIG_ARM64_PSEUDO_NMI surely we don't want to emit
the alternative?

How about we move this to C, and have something like the below?

For the !CONFIG_ARM64_PSEUDO_NMI case it generates identical assembly to the
existing cpu_do_idle(). Note that I've assumed we don't need barriers, which
(as above) I'm not certain of.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7f1628effe6d..ccd2ad8c5e2f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -73,6 +73,40 @@ EXPORT_SYMBOL_GPL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
+static inline void __cpu_do_idle(void)
+{
+       /* WFI may enter a low-power mode */
+       dsb(sy);
+       wfi();
+}
+
+/*
+ * When using priority masking we need to take extra care, etc.
+ */
+static inline void __cpu_do_idle_irqprio(void)
+{
+       unsigned long flags = arch_local_irq_save();
+       unsigned long pmr = gic_read_pmr();
+
+       gic_write_pmr(GIC_PRIO_IRQON);
+
+       __cpu_do_idle();
+
+       gic_write_pmr(pmr);
+       arch_local_irq_enable();
+}
+
+/*
+ * Idle the processor (wait for interrupt).
+ */
+void cpu_do_idle(void)
+{
+       if (system_uses_irq_prio_masking())
+               __cpu_do_idle_irqprio();
+       else
+               __cpu_do_idle();
+}
+
 /*
  * This is our default idle handler.
  */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 03646e6a2ef4..38c0171e52e2 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -49,17 +49,6 @@
 
 #define MAIR(attr, mt) ((attr) << ((mt) * 8))
 
-/*
- *     cpu_do_idle()
- *
- *     Idle the processor (wait for interrupt).
- */
-ENTRY(cpu_do_idle)
-       dsb     sy                              // WFI may enter a low-power mode
-       wfi
-       ret
-ENDPROC(cpu_do_idle)
-
 #ifdef CONFIG_CPU_PM
 /**
  * cpu_do_suspend - save CPU registers context
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
