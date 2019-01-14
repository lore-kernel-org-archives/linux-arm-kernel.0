Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F283C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:37:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C22206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/dDMQWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C22206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0n+gqMxA/pDTrxUMAFLXxVc5U1rezOrMa7KH/7vc5OY=; b=o/dDMQWNHxiEAzlD923RjNMy/
	cNNvjx/Hs1AF7cAOecSmEVK48Xt91/d91OEbRZ7Wq3aaHVKrw5c4A6OTK53dyH4qfhkwQDzBLtagM
	2TT8gBpopeUVq8zfhpmBztn252qkSnDmsjRsGdf4+LEzokN/4UC0Wqc8lp/5636heLqVJ9Jhsv0iU
	vF7XOZA4pbBTMpQ550tpB8X5JAuXbZXIeCmWE+I7FIqzUYf6vy/Bg6uNvIJA9Tyor6lnSjy/un0An
	x7pYIbnoRp6cPSNbO2CJ5l/bRsvwb5AtJiEWXs0cPDATQN3Ezv7Rb/oY81NsWig/h9zLp47af7nQY
	tvocF6tOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5F2-0004HI-As; Mon, 14 Jan 2019 16:37:36 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5Ew-0004Cm-4c
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 16:37:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3342A78;
 Mon, 14 Jan 2019 08:37:27 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E543F5BD;
 Mon, 14 Jan 2019 08:37:26 -0800 (PST)
Subject: Re: [PATCH v3 6/7] arm64: add sysfs vulnerability show for
 speculative store bypass
To: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-7-jeremy.linton@arm.com>
 <ac625845-fd40-ad87-4efd-ea0ed53274ec@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <762faf42-6806-bba9-091c-c21e6955e17d@arm.com>
Date: Mon, 14 Jan 2019 10:37:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ac625845-fd40-ad87-4efd-ea0ed53274ec@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_083730_187319_0939DB64 
X-CRM114-Status: GOOD (  20.84  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 01/14/2019 04:15 AM, Marc Zyngier wrote:
> On 09/01/2019 23:55, Jeremy Linton wrote:
>> Return status based on ssbd_state and the arm64 SSBS feature. If
>> the mitigation is disabled, or the firmware isn't responding then
>> return the expected machine state based on a new blacklist of known
>> vulnerable cores.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpu_errata.c | 48 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index ee286d606d9b..c8ff96158b94 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -288,6 +288,7 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>>   
>>   int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
>> +static bool __ssb_safe = true;
>>   
>>   static const struct ssbd_options {
>>   	const char	*str;
>> @@ -385,10 +386,18 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>   {
>>   	struct arm_smccc_res res;
>>   	bool required = true;
>> +	bool is_vul;
>>   	s32 val;
>>   
>>   	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>>   
>> +	is_vul = is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
>> +
>> +	if (is_vul)
>> +		__ssb_safe = false;
>> +
>> +	arm64_requested_vuln_attrs |= VULN_SSB;
>> +
>>   	if (this_cpu_has_cap(ARM64_SSBS)) {
>>   		required = false;
>>   		goto out_printmsg;
>> @@ -422,6 +431,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>   		ssbd_state = ARM64_SSBD_UNKNOWN;
>>   		return false;
>>   
>> +	/* machines with mixed mitigation requirements must not return this */
>>   	case SMCCC_RET_NOT_REQUIRED:
>>   		pr_info_once("%s mitigation not required\n", entry->desc);
>>   		ssbd_state = ARM64_SSBD_MITIGATED;
>> @@ -476,6 +486,17 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>>   
>>   	return required;
>>   }
>> +
>> +/* known vulnerable cores */
>> +static const struct midr_range arm64_ssb_cpus[] = {
>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
>> +	{},
>> +};
>> +
>>   #endif	/* CONFIG_ARM64_SSBD */
>>   
>>   static void __maybe_unused
>> @@ -762,6 +783,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>   		.capability = ARM64_SSBD,
>>   		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>>   		.matches = has_ssbd_mitigation,
>> +		.midr_range_list = arm64_ssb_cpus,
>>   	},
>>   #endif
>>   #ifdef CONFIG_ARM64_ERRATUM_1188873
>> @@ -809,4 +831,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>>   	return sprintf(buf, "Vulnerable\n");
>>   }
>>   
>> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	/*
>> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
>> +	 *  for hetrogenous machines, and that if SSBS is supported its
>> +	 *  supported by all cores.
>> +	 */
>> +	switch (arm64_get_ssbd_state()) {
>> +	case ARM64_SSBD_MITIGATED:
>> +		return sprintf(buf, "Not affected\n");
>> +
>> +	case ARM64_SSBD_KERNEL:
>> +	case ARM64_SSBD_FORCE_ENABLE:
>> +		if (cpus_have_cap(ARM64_SSBS))
>> +			return sprintf(buf, "Not affected\n");
>> +		return sprintf(buf,
>> +			"Mitigation: Speculative Store Bypass disabled\n");
>> +	}
>> +
>> +	if (__ssb_safe)
>> +		return sprintf(buf, "Not affected\n");
> 
> The kbuild robot reports that this fails if CONFIG_ARM64_SSBD is not
> selected. What should we print in this case? "Vulnerable"? Or "Unknown"?

The immediate fix is that the __ssb_safe variable should be in its own 
conditional block which is  CONFIG_GENERIC_CPU_VULNERABILITIES || 
CONFIG_ARM64_SSBD. If the mitigation isn't built in then this code won't 
be run anyway because the sysfs entry won't be populated.


But, these CONFIG_ conditionals are less than ideal (and would be even 
uglier if they were made more efficient). My own opinion at this point 
is that we should really remove the compile time configs and leave the 
mitigation built all the time. The raw code is fairly small, and we 
could add in the nospectre_v2 command line options so that users can 
choose to runtime disable them. That would also remove the need to 
modify the core cpu vulnerabilities sysfs code.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
