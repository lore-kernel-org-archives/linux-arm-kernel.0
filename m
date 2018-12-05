Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B7CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6967C2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMAA1a38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6967C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLbmhAGU9Y1y9DTrd+4Gmdl6tXDMJxfsrx7mJfR3KKA=; b=cMAA1a38HJySh1
	aY0FR6oz7/VOKe8DfhtFd10Wd8SvXkq9ZapfFJ2pINYsfpNqBrv4Z52hS2t4LeY5EVNBWn0He9Whs
	DvSW6CLwDZYz0FbHQRUiuz2KsnFkdYYwXnKrswYQKLZVfR4qo1E9Et+iRsDnfhKJnWTlMNQdtUqec
	exNVjo1Rz7/7zoWGw9IxOSTKBTY6D2U6vg6YrooP4suJIEWt60SR1uRXFkoFBUD42CVYDffklgl4D
	hhMroMd0fONFX2cfDOZa3y098lNUCCSLpi1c1a/km6+TroeSONb6wqrU5K9E1yMYXkaiIonKohj9R
	zgETWQbuVifx+vBD4CZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUWpP-0002X8-Sz; Wed, 05 Dec 2018 13:02:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWpI-0002WM-Co
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 13:02:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D5FA78;
 Wed,  5 Dec 2018 05:02:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0525D3F575;
 Wed,  5 Dec 2018 05:02:37 -0800 (PST)
Subject: Re: [PATCH v6 21/24] arm64: Handle serror in NMI context
To: Catalin Marinas <catalin.marinas@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
 <20181204180917.GE19210@arrakis.emea.arm.com>
From: James Morse <james.morse@arm.com>
Message-ID: <3ff15164-11db-d3c9-e194-a35facf9971d@arm.com>
Date: Wed, 5 Dec 2018 13:02:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181204180917.GE19210@arrakis.emea.arm.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_050252_440763_3653BA6E 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, daniel.thompson@linaro.org,
 Julien Thierry <julien.thierry@arm.com>, marc.zyngier@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
 joel@joelfernandes.org, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Catalin,

On 04/12/2018 18:09, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:57:12AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 5f4d9ac..66344cd 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -897,13 +897,17 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>>  
>>  asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>>  {
>> -	nmi_enter();
>> +	const bool was_in_nmi = in_nmi();
>> +
>> +	if (!was_in_nmi)
>> +		nmi_enter();
>>  
>>  	/* non-RAS errors are not containable */
>>  	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
>>  		arm64_serror_panic(regs, esr);
>>  
>> -	nmi_exit();
>> +	if (!was_in_nmi)
>> +		nmi_exit();
>>  }
> 
> Do we actually need nmi_enter/exit in the outer do_serror() function?
> Could we just move it to arm64_serror_panic()?

They might need to be here in the future: if we support kernel-first we would
have extra calls in here that need to be in_nmi(), the same if we call out to
APEI to support APCI's NOTIFY_SEI.


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
