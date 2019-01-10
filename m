Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8296C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:39:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA6620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A5MI4/Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA6620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3kxrkxcsfqjRVZfbqPBgbDrbsfpN69zWB81a3DuKsRY=; b=A5MI4/DxMi/4APtq2QRE3rese
	+Q3OKlHy0zeDUO65808relSbGrfU672U1zpvS5HVQpECDlINI4f1t3x5sAG4vsbwkeESCTAJV0CW8
	msgPEWfXJYqNWEdQcumPtFTkl4hLkFGWdekRxQoB/vny44NESDOWty7db9rUaj+2XOGxlf3Ow6wYt
	+txMGzbkvYkWL+Zalz3SByG6pAI6Y4/FYhJW16nPVD6pW0d+oXgjuTR53v85ojpYlSngQ8P1UP6xO
	GvEkGkoNtMRsKPra0QcU9WQtARoVDdoFCnfas5v2WqshkBNIMxW4xIThDmQXP8iKb9VA39JNTafjO
	mGZjDMl8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gheIX-0000d6-A5; Thu, 10 Jan 2019 17:39:17 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gheIT-0000ck-MK
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:39:16 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DB76E518C091FE87EADF;
 Fri, 11 Jan 2019 01:39:05 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 11 Jan 2019
 01:39:05 +0800
Subject: Re: [PATCH v2] arm64: kpti: Avoid rewriting early page tables when
 KASLR is enabled
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon
 <will.deacon@arm.com>
References: <20190110105143.27008-1-will.deacon@arm.com>
 <CAKv+Gu8gJd6QSsB1X904g22+cE3m5SZcTRY-g+ro548BvCzS+w@mail.gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <fa658f4a-cf9c-18fe-b968-f400398d487f@huawei.com>
Date: Thu, 10 Jan 2019 17:39:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8gJd6QSsB1X904g22+cE3m5SZcTRY-g+ro548BvCzS+w@mail.gmail.com>
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_093914_089540_0BAB646E 
X-CRM114-Status: GOOD (  20.59  )
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
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/01/2019 17:03, Ard Biesheuvel wrote:
> On Thu, 10 Jan 2019 at 11:51, Will Deacon <will.deacon@arm.com> wrote:
>>
>> A side effect of commit c55191e96caa ("arm64: mm: apply r/o permissions
>> of VM areas to its linear alias as well") is that the linear map is
>> created with page granularity, which means that transitioning the early
>> page table from global to non-global mappings when enabling kpti can
>> take a significant amount of time during boot.
>>
>> Given that most CPU implementations do not require kpti, this mainly
>> impacts KASLR builds where kpti is forcefully enabled. However, in these
>> situations we know early on that non-global mappings are required and
>> can avoid the use of global mappings from the beginning. The only gotcha
>> is Cavium erratum #27456, which we must detect based on the MIDR value
>> of the boot CPU.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Reported-by: John Garry <john.garry@huawei.com>

The specific issue I reported has not been seen in linux-next for some 
time, so no point in a Tested-by from me.

Cheers,
John

>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
>> ---
>>
>> v2: Fix module builds by exporting kimage_vaddr and avoiding references
>>     to cavium_erratum_27456_cpus. Minor comment tweaks.
>>
>>  arch/arm64/include/asm/mmu.h          | 41 +++++++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/pgtable-prot.h |  4 ++--
>>  arch/arm64/kernel/cpu_errata.c        |  2 +-
>>  arch/arm64/kernel/cpufeature.c        |  9 ++++++--
>>  arch/arm64/kernel/head.S              |  1 +
>>  5 files changed, 52 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 43596b1a5897..bbb47402cd2b 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -16,6 +16,8 @@
>>  #ifndef __ASM_MMU_H
>>  #define __ASM_MMU_H
>>
>> +#include <asm/cputype.h>
>> +
>>  #define MMCF_AARCH32   0x1     /* mm context flag for AArch32 executables */
>>  #define USER_ASID_BIT  48
>>  #define USER_ASID_FLAG (UL(1) << USER_ASID_BIT)
>> @@ -44,6 +46,45 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
>>                cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
>>  }
>>
>> +static inline bool arm64_kernel_use_ng_mappings(void)
>> +{
>> +       bool tx1_bug;
>> +
>> +       /* What's a kpti? Use global mappings if we don't know. */
>> +       if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
>> +               return false;
>> +
>> +       /*
>> +        * Note: this function is called before the CPU capabilities have
>> +        * been configured, so our early mappings will be global. If we
>> +        * later determine that kpti is required, then
>> +        * kpti_install_ng_mappings() will make them non-global.
>> +        */
>> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>> +               return arm64_kernel_unmapped_at_el0();
>> +
>> +       /*
>> +        * KASLR is enabled so we're going to be enabling kpti on non-broken
>> +        * CPUs regardless of their susceptibility to Meltdown. Rather
>> +        * than force everybody to go through the G -> nG dance later on,
>> +        * just put down non-global mappings from the beginning.
>> +        */
>> +       if (!IS_ENABLED(CONFIG_CAVIUM_ERRATUM_27456)) {
>> +               tx1_bug = false;
>> +#ifndef MODULE
>> +       } else if (!static_branch_likely(&arm64_const_caps_ready)) {
>> +               extern const struct midr_range cavium_erratum_27456_cpus[];
>> +
>> +               tx1_bug = is_midr_in_range_list(read_cpuid_id(),
>> +                                               cavium_erratum_27456_cpus);
>> +#endif
>> +       } else {
>> +               tx1_bug = __cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456);
>> +       }
>> +
>> +       return !tx1_bug && kaslr_offset() > 0;
>> +}
>> +
>>  typedef void (*bp_hardening_cb_t)(void);
>>
>>  struct bp_hardening_data {
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index 78b942c1bea4..986e41c4c32b 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -37,8 +37,8 @@
>>  #define _PROT_DEFAULT          (PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>>  #define _PROT_SECT_DEFAULT     (PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
>>
>> -#define PTE_MAYBE_NG           (arm64_kernel_unmapped_at_el0() ? PTE_NG : 0)
>> -#define PMD_MAYBE_NG           (arm64_kernel_unmapped_at_el0() ? PMD_SECT_NG : 0)
>> +#define PTE_MAYBE_NG           (arm64_kernel_use_ng_mappings() ? PTE_NG : 0)
>> +#define PMD_MAYBE_NG           (arm64_kernel_use_ng_mappings() ? PMD_SECT_NG : 0)
>>
>>  #define PROT_DEFAULT           (_PROT_DEFAULT | PTE_MAYBE_NG)
>>  #define PROT_SECT_DEFAULT      (_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index 09ac548c9d44..9950bb0cbd52 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -553,7 +553,7 @@ static const struct midr_range arm64_repeat_tlbi_cpus[] = {
>>  #endif
>>
>>  #ifdef CONFIG_CAVIUM_ERRATUM_27456
>> -static const struct midr_range cavium_erratum_27456_cpus[] = {
>> +const struct midr_range cavium_erratum_27456_cpus[] = {
>>         /* Cavium ThunderX, T88 pass 1.x - 2.1 */
>>         MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
>>         /* Cavium ThunderX, T81 pass 1.0 */
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 4f272399de89..f6d84e2c92fe 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -983,7 +983,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>
>>         /* Useful for KASLR robustness */
>>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>> -               return true;
>> +               return kaslr_offset() > 0;
>>
>>         /* Don't force KPTI for CPUs that are not vulnerable */
>>         if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
>> @@ -1003,7 +1003,12 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>>         static bool kpti_applied = false;
>>         int cpu = smp_processor_id();
>>
>> -       if (kpti_applied)
>> +       /*
>> +        * We don't need to rewrite the page-tables if either we've done
>> +        * it already or we have KASLR enabled and therefore have not
>> +        * created any global mappings at all.
>> +        */
>> +       if (kpti_applied || kaslr_offset() > 0)
>>                 return;
>>
>>         remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index c7213674cb24..15d79a8e5e5e 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -475,6 +475,7 @@ ENDPROC(__primary_switched)
>>
>>  ENTRY(kimage_vaddr)
>>         .quad           _text - TEXT_OFFSET
>> +EXPORT_SYMBOL(kimage_vaddr)
>>
>>  /*
>>   * If we're fortunate enough to boot at EL2, ensure that the world is
>> --
>> 2.11.0
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
