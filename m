Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:18:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DB220883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X/G9LVHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DB220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pVcVYW5e92knvGC1dswDI+w3FlXHY5FnK354SQ8DJ/k=; b=X/G9LVHN7jOQBI
	iiBB3bRVXJJRi8z/H4WtAxXmgikAqzxUr7mPaN712EaDjzuo0S58Nr3uGfUdOtHqGZ/9u2zRPNdGE
	u97se69G0lOXbVBV3S/VARvIu1nPuRPzlOti9b2+dEyVSEo098pExkhsm93Hraluhh+GO9uipQVc+
	OKHnBBRr9Vlj8qnDqUFIxINijSjqxfUuvtx5EWZ/7P9cJfehq+keDa2WTwXt1RhmAv742p+StFSF9
	3KELmVWCFThlOe2wXuCeZJhTR9kMWTrgkVmQ9SUerDo7bvFG7l5ZnWVIBV9aCjI7GTha3VpHcinsj
	HHH059Z/rA1JuRv0se/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUyF-0003Qz-Lj; Fri, 18 Jan 2019 14:18:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUyC-0003QZ-LE
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 14:18:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA5BEBD;
 Fri, 18 Jan 2019 06:18:02 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA20A3F5C1;
 Fri, 18 Jan 2019 06:18:01 -0800 (PST)
Date: Fri, 18 Jan 2019 14:17:59 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Message-ID: <20190118141758.GC12256@lakrids.cambridge.arm.com>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_061804_703759_C2D5891F 
X-CRM114-Status: GOOD (  31.60  )
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
Cc: "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
 "'will.deacon@arm.com'" <will.deacon@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Jan 18, 2019 at 12:52:38PM +0000, Zhang, Lei wrote:
> On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), 
> memory accesses may cause undefined fault (Data abort, DFSC=0b111111).

So that we can better understand the problem, could you please let us
know the following:

* Under what conditions can the fault occur? e.g. is this in place of
  some other fault, or completely spurious?

* Does this only occur for data abort? i.e. not instruction aborts?

* How often does this fault occur?

* Does this only apply to Stage-1, or can the same faults be taken at
  Stage-2?

> This problem will be fixed by next version of Fujitsu-A64FX.
> I would like to post a workaround to avoid this problem 
> on existing version.
> The workaround is to replace the fault handler for Data abort
> DFSC=0b111111 with a new one to ignore this undefined fault, 
> which will only affect the Fujitsu-A64FX.
> 
> I have tested this patch on A64FX and QEMU(2.9.0).The test passed.
> I will test this patch on ThunderX and report the result.
> I fully appreciate that if someone can test this patch on different 
> chips to verity no harmful effect on other chips.
> 
> If there is no problem on other chips, please merge this patch.
> 
> Below is my patch based on linux-5.0-rc2.
> 
> Signed-off-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
> Tested-by: Lei Zhang <zhang.lei@jp.fujitsu.com>
> ---
>  Documentation/arm64/silicon-errata.txt |    1 +
>  arch/arm64/Kconfig                     |   13 +++++++++++++
>  arch/arm64/include/asm/cputype.h       |    4 ++++
>  arch/arm64/mm/fault.c                  |   23 +++++++++++++++++++++++
>  4 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 1f09d04..26d64e9 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -80,3 +80,4 @@ stable kernels.
>  | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
>  | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
>  | Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
> +| Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d3..9c09b2b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -643,6 +643,19 @@ config QCOM_FALKOR_ERRATUM_E1041
>  
>  	  If unsure, say Y.
>  
> +config FUJITSU_ERRATUM_010001
> +	bool "Fujitsu-A64FX erratum E#010001: Undefined fault may occur wrongly"
> +	default y
> +	help
> +	  This option adds workaround for Fujitsu-A64FX erratum E#010001.
> +	  On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1), memory accesses
> +	  may cause undefined fault (Data abort, DFSC=0b111111).
> +	  The workaround is to replace the fault handler for Data abort DFSC=0b111111
> +	  with a new one to ignore this undefined fault, which will only affect
> +	  the Fujitsu-A64FX.
> +
> +	  If unsure, say Y.
> +
>  endmenu
>  
>  
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 951ed1a..166aa50 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -76,6 +76,7 @@
>  #define ARM_CPU_IMP_BRCM		0x42
>  #define ARM_CPU_IMP_QCOM		0x51
>  #define ARM_CPU_IMP_NVIDIA		0x4E
> +#define ARM_CPU_IMP_FUJITSU		0x46
>  
>  #define ARM_CPU_PART_AEM_V8		0xD0F
>  #define ARM_CPU_PART_FOUNDATION		0xD00
> @@ -104,6 +105,8 @@
>  #define NVIDIA_CPU_PART_DENVER		0x003
>  #define NVIDIA_CPU_PART_CARMEL		0x004
>  
> +#define FUJTISU_CPU_PART_A64FX		0x001
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -122,6 +125,7 @@
>  #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
>  #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
>  #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
> +#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJTISU_CPU_PART_A64FX)
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index efb7b2c..c465b2f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -666,6 +666,25 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static bool do_bad_ignore_first = FALSE;
> +static int do_bad_ignore(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +{
> +	if (do_bad_ignore_first == TRUE)
> +		return 0;
> +	if (do_bad_ignore_first == FALSE) {
> +		unsigned int current_cpu_midr = read_cpuid_id();
> +		const struct midr_range fujitsu_a64fx_midr_range = {
> +			MIDR_FUJITSU_A64FX, MIDR_CPU_VAR_REV(0, 0), MIDR_CPU_VAR_REV(1, 0)
> +		};
> +
> +		if (is_midr_in_range(current_cpu_midr, &fujitsu_a64fx_midr_range) == TRUE) {
> +			do_bad_ignore_first = TRUE;
> +			return 0;
> +		}
> +	}
> +	return 1; /* "fault" same as do_bad */
> +}

I'm a bit surprised by the single retry. Is there any guarantee that a
thread will eventually stop delivering this fault code?

Note that all CPUs and threads share the do_bad_ignore_first variable,
so this is going to behave non-deterministically and kill threads in
some cases.

This code is also preemptible, so checking the MIDR here doesn't make
much sense. Either this is always uniform (and we can check once in the
errata framework), or it's variable (e.g. on a big.LITTLE system) and we
need to avoid preemption up until this point.

Rather than dynamically checking the MIDR, this should use the errata
framework, and if any A64FX CPU is discovered, set an erratum cap like
ARM64_WORKAROUND_CONFIG_FUJITSU_ERRATUM_010001, so we can do something
like:

static int do_bad_unknown_63(unsigned long addr, unsigned int esr,
			     struct pt_regs *regs)
{
	/*
	 * On some variants of the Fujitsu-A64FX cores ver(1.0, 1.1),
	 * memory accesses may spuriously trigger data aborts with
	 * DFSC=0b111111.
	 */
	if (IS_ENABLED(CONFIG_FUJITSU_ERRATUM_010001) && 
	    cpus_have_const_cap(ARM64_WORKAROUND_E010001))
	    	return 0;

	return do_bad(addr, esr, regs);
}

> +
>  static const struct fault_info fault_info[] = {
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"ttbr address size fault"	},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"level 1 address size fault"	},
> @@ -730,7 +749,11 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 60"			},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"section domain fault"		},
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"page domain fault"		},
> +#ifdef	CONFIG_FUJITSU_ERRATUM_010001
> +	{ do_bad_ignore,	SIGKILL, SI_KERNEL,	"unknown 63"			},
> +#else
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
> +#endif

... with this unconditionally using do_bad_unknown_63.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
