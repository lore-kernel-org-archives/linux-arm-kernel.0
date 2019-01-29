Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9333BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:04:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F2D21473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L6TV+IN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F2D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5Eol3P5sXGUzzdG+xUFBAQpWB2/ROtPE15biBUIUSto=; b=L6TV+IN1xIeGQ22DvGQ0BNP2L
	OawL4FSnZ3+tIjfsRcU1KwbGYv9fGrfFBx6gQ6+rl7UBAdeD2InHpzNa+HBP54TsC3R1nObHioeuz
	AB8gitm10TDuRYSZh6OK2TDy2+6tdayBdAgqF0rEsi6tIMlY02oKmQ96Shs+ukarozL+VDBqVynnF
	ZUvWIzH6bDtY918w4J8TQLkSYrzSxs8lQHBaCeWHI8pJniqkEdDsmY/JIZCC4omXGnxVKU8SWPcm9
	9ZkBzhxfZU7CW3A2N7QG/0tL+LdJ2wRmpiWcJ7fHwIVqwPyscEFsPaO1UXPrlehbvWRg/FCdNAUxY
	2sQGBgX0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goU0A-00030G-2B; Tue, 29 Jan 2019 14:04:34 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goU02-0002zc-5f
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:04:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 729A6AEFE;
 Tue, 29 Jan 2019 14:04:23 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] efi: x86: convert x86 EFI earlyprintk into generic
 earlycon implementation
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
 <20190129092150.15184-3-ard.biesheuvel@linaro.org>
 <0ea153fd-1c2b-c4e6-54d9-e31189f1b90c@suse.de>
 <CAKv+Gu8S-EFdVtuKHEtV=3Mi7tKWjxEbjovAdspaKTzmUwAfjQ@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <15bc4db9-779b-93b3-3e6a-be8cda07be67@suse.de>
Date: Tue, 29 Jan 2019 15:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8S-EFdVtuKHEtV=3Mi7tKWjxEbjovAdspaKTzmUwAfjQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_060426_538373_1FC87500 
X-CRM114-Status: GOOD (  23.33  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Graeme Gregory <graeme.gregory@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Peter Jones <pjones@redhat.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/29/2019 02:41 PM, Ard Biesheuvel wrote:
> Hi Alex,
>
> On Tue, 29 Jan 2019 at 14:37, Alexander Graf <agraf@suse.de> wrote:
>> On 01/29/2019 10:21 AM, Ard Biesheuvel wrote:
>>> Move the x86 EFI earlyprintk implementation to a shared location under
>>> drivers/firmware and tweak it slightly so we can expose it as an earlycon
>>> implementation (which is generic) rather than earlyprintk (which is only
>>> implemented for a few architectures)
>>>
>>> This also involves switching to write-combine mappings by default (which
>>> is required on ARM since device mappings lack memory semantics, and so
>>> memcpy/memset may not be used on them), and adding support for shared
>>> memory framebuffers on cache coherent non-x86 systems (which do not
>>> tolerate mismatched attributes)
>>>
>>> Note that 32-bit ARM does not populate its struct screen_info early
>>> enough for earlycon=efifb to work, so it is disabled there.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>    Documentation/admin-guide/kernel-parameters.txt |   8 +-
>>>    arch/x86/Kconfig.debug                          |  10 -
>>>    arch/x86/include/asm/efi.h                      |   1 -
>>>    arch/x86/kernel/early_printk.c                  |   4 -
>>>    arch/x86/platform/efi/Makefile                  |   1 -
>>>    arch/x86/platform/efi/early_printk.c            | 240 --------------------
>>>    drivers/firmware/efi/Kconfig                    |   6 +
>>>    drivers/firmware/efi/Makefile                   |   1 +
>>>    drivers/firmware/efi/earlycon.c                 | 208 +++++++++++++++++
>>>    9 files changed, 222 insertions(+), 257 deletions(-)
>>>
>> [...]
>>
>>> +static int __init efi_earlycon_setup(struct earlycon_device *device,
>>> +                                  const char *opt)
>>> +{
>>> +     struct screen_info *si;
>>> +     u16 xres, yres;
>>> +     u32 i;
>>> +
>>> +     if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>>> +             return -ENODEV;
>>> +
>>> +     fb_base = screen_info.lfb_base;
>>> +     if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>>> +             fb_base |= (u64)screen_info.ext_lfb_base << 32;
>>> +
>>> +     if (opt && !strcmp(opt, "ram"))
>>> +             fb_prot = PAGE_KERNEL;
>>> +     else
>>> +             fb_prot = pgprot_writecombine(PAGE_KERNEL);
>> Can you determine the default from the UEFI memory map?
>>
> No. This is being called way before we parse the system table and the
> memory map. Given that this is debug code, duplicating a significant
> chunk of that work here (and run the risk of crashing here due to
> unexpected contents in those tables) is not a great idea imo.

I see. Maybe we will want to have something there, but I tend to agree 
that for now we should keep bits as simple as possible.

>
>> Also, doesn't the current logic map it as WC on x86 too? Is that
>> intentional?
>>
> Yes. As mentioned in the cover letter, this aligns it with efifb which
> also uses WC by default (although there, it can be overridden for
> performance reasons, but due to the debug nature of earlycon, this
> doesn't matter, since higher performance only makes it more difficult
> to capture the log on your phone camera)

Well, the cover letter really only talks about arm :). But yeah, I think 
it's probably a good idea to map it WC regardless.

Overall, I would've preferred to have a larger patch set with more, but 
smaller changes that refactor the code. But it seems to be reviewable 
enough still. Let's cross our fingers it doesn't break :).


Reviewed-by: Alexander Graf <agraf@suse.de>

Thanks,

Alex


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
