Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:26:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E8A218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MESlhmNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E8A218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y0jPBFlZL6pjS/F/5nd3F+LSd2qGwzxVBXvWlXxjKXo=; b=MESlhmNg0fuBhv
	bE44NUeFa/YCXKq2BNXZIXOaVqo9bKaXLLDiW6DNrpUDZPGOTEaQiAON4pDgZYiDTSmIjA5F1wwej
	d2XuznwuaRFLhg07zrgckQ/cHgwEU3Iap+5LdPvE3JNhrymqby13Nju5h7tCMiI0dn7Nvm+yeHnbz
	sXI6m2bY/PnRl79anpPCt0vSpfMDiKuWwIXm9LTzm1yxUTMe/V90BoMJuePUrWYx+zF9JkcLaqdqj
	Ys/yBTpkvtP1ZNitUwGjvwDFm5L210ykgTRqAOHbbNNh18mzaN7Hzeprf7v6vmsa1pdZG2twqqNNJ
	vaxVI7H0NrsRe28GjqiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaI0N-000142-EW; Fri, 21 Dec 2018 10:26:07 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaI03-0000lW-BH
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:25:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 959A880D;
 Fri, 21 Dec 2018 02:25:31 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FED73F5C0;
 Fri, 21 Dec 2018 02:25:29 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
 <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
 <CAKv+Gu8+1JNzM4AUujiEfkYujpgakLXcUwTDG4eHwvQ7pKAzFA@mail.gmail.com>
 <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com>
 <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
 <bc27fb6d-1adf-d7e9-ded2-2cbed81b6e03@arm.com>
 <e0ecdb24-ef52-2c31-565d-66f7a2770f4a@arm.com>
 <7d42f570-541a-59a3-79fc-f00dc0b51689@arm.com>
 <CAKv+Gu8CNmL8v=ePXSvQ0vEAzD2O2YAKutQW-b+E6JmyYBPTnA@mail.gmail.com>
 <9c64a977-fdee-b2b2-d726-1e9744d229a7@arm.com>
 <0e6edb8d-dd41-fd3d-0598-7f02ce4ee9ef@arm.com>
 <CAKv+Gu-joM6GivoTqF1t8UKUwtfXkVZ5gTKL6JzMh3uCUJeWog@mail.gmail.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <361449d8-aaa6-7780-12bb-4b67625b7f00@arm.com>
Date: Fri, 21 Dec 2018 10:25:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-joM6GivoTqF1t8UKUwtfXkVZ5gTKL6JzMh3uCUJeWog@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_022547_393201_8EB47272 
X-CRM114-Status: GOOD (  20.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoffer Dall <christoffer.dall@arm.com>, James Morse <james.morse@arm.com>,
 oleg@redhat.com, joel@joelfernandes.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 20/12/2018 17:53, Ard Biesheuvel wrote:
> On Wed, 19 Dec 2018 at 18:01, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Hi Ard,
>>
>> On 14/12/2018 16:40, Julien Thierry wrote:
>>>
>>>
>>> On 14/12/2018 15:49, Ard Biesheuvel wrote:
>>>> On Fri, 14 Dec 2018 at 16:23, Julien Thierry <julien.thierry@arm.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 13/12/2018 15:03, Julien Thierry wrote:
>>>>>>
>>>>>> Argh, not as simple as I had expected.
>>>>>>
>>>>>> Turns out include/linux/efi.h does not include asm/efi.h (including it
>>>>>> at the beginning of the file breaks the build because asm/efi.h misses
>>>>>> the efi type definitions.
>>>>>>
>>>>>> So a thing like:
>>>>>>
>>>>>> #ifndef efi_get_irqflags
>>>>>> #define efi_get_irqflags(flags) local_save_flags(flags)
>>>>>> #endif
>>>>>>
>>>>>> in include/linux/efi.h cannot be overridden.
>>>>>>
>>>>>> Either I would need to introduce the definitions arm, arm64 and x86 (I
>>>>>> don't think there are other arch supporting EFI right now) or I'll need
>>>>>> to come up with another solution.
>>>>>>
>>>>>
>>>>
>>>> It might be a bit nasty, but can we put the #ifndef above in
>>>> runtime-wrappers.c directly? The only reference in linux/efi.h is a
>>>> macro, so that shouldn't matter afaict.
>>>>
>>>
>>> Sadly, in arch/x86/platform/uv/bios_uv.c, uv_bios_call() has a reference
>>> to the macro efi_call_virt_pointer() which wouldn't be able to see the
>>> definition in runtime-wrappers.c
>>>
>>> Otherwise, we could've moved efi_call_virt_pointer() and
>>> __efi_call_virt_pointer in runtime-wrappers.c and things would not have
>>> been as nasty.
>>>
>>> But no, I don't think we can do that without breaking some x86 build :( .
>>>
>>
>> Since the above does not work, would the solution with the
>> HAVE_GENERIC_EFI_FLAGS below be acceptable to you? Or would you rather I
>> defined helpers in <asm/efi.h> for all arm/arm64/x86?
>>
>> Or neither and I shall find another way?
>>
> 
> Would it be possible to introduce a function
> 
> efi_call_virt_save_flags()
> 
> [as a counterpart to efi_call_virt_check_flags()], and put the
> implementation in runtime-wrappers.c (which already includes
> asm/efi.h)?
> 
> That should allow you to put arch-specific hooks in asm/efi.h, and use
> them in the implementation of efi_call_virt_save_flags(). AFAICT, that
> removes the need for Kconfig glue.
> 

Yes, that seems to work and does not break other arch.

I'll go with that in my next version of the patches.

Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
