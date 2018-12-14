Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACBFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF529208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lqEMgLQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF529208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQA6dnr1l3iouS9d/kXf7ud++a8jbCrosiXk5b2z26M=; b=lqEMgLQTTHCw2p
	tV1op3+kuKWW1+aLZy2jL7xx9trEHYOAMSEwLjWqciUHi5A+ECGFndojh3J9e09D/LFNyGo0thtv/
	cnp3uFY/AzdlZ8q2+VQttsFejeNncgNdw4y8wlMJYgZ4nKUF/7aOLlq0BMUovkw1WMnWXfKdK+ZAM
	jc5kEynW1B4PqYolovNl4gkRNZ3nXw00kgrDGymcKuMTze6+XHRC7TZsfyDZ/AIqJuKbp+lcQZw2j
	V/UtJ6OSxM/kLMPge8/PxPsJY3WrQuxPbS/29HtcPLtcrZ7Bq4ZYDZmsoES5vFxVKFeIbtq1PV+i+
	yKosoy3gckh6hWXrKtfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmgJ-0001as-Oz; Fri, 14 Dec 2018 12:35:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmgG-0001Nw-Oe
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:35:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B412EBD;
 Fri, 14 Dec 2018 04:34:45 -0800 (PST)
Received: from [10.37.12.200] (unknown [10.37.12.200])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFCDF3F575;
 Fri, 14 Dec 2018 04:34:36 -0800 (PST)
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based
 mode
To: Andrey Konovalov <andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
 <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
 <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
Date: Fri, 14 Dec 2018 12:35:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_043500_808904_CAA9424F 
X-CRM114-Status: GOOD (  27.31  )
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
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/18 3:04 PM, Andrey Konovalov wrote:
> On Tue, Dec 11, 2018 at 5:22 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Andrey,
>>
>> On 06/12/2018 12:24, Andrey Konovalov wrote:
>>> This commit adds tag-based KASAN specific hooks implementation and
>>> adjusts common generic and tag-based KASAN ones.
>>>
>>> 1. When a new slab cache is created, tag-based KASAN rounds up the size of
>>>    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
>>>
>>> 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
>>>    memory, that corresponds to this object to this tag, and embeds this
>>>    tag value into the top byte of the returned pointer.
>>>
>>> 3. On each kfree tag-based KASAN poisons the shadow memory with a random
>>>    tag to allow detection of use-after-free bugs.
>>>
>>> The rest of the logic of the hook implementation is very much similar to
>>> the one provided by generic KASAN. Tag-based KASAN saves allocation and
>>> free stack metadata to the slab object the same way generic KASAN does.
>>>
>>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>> ---
>>>  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
>>>  mm/kasan/kasan.h  |   8 ++++
>>>  mm/kasan/tags.c   |  48 +++++++++++++++++++
>>>  3 files changed, 153 insertions(+), 19 deletions(-)
>>>
>>
>>
>> [...]
>>
>>> @@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>>>               return;
>>>       }
>>>
>>> +     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
>>> +
>>
>> Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?
> 
> I didn't know about this macro. Looks like we can use it to do the
> same thing. Do you think it's a better solution to redefine
> ARCH_SLAB_MINALIGN to KASAN_SHADOW_SCALE_SIZE for arm64 when tag-based
> KASAN is enabled instead of adjusting cache->align in
> kasan_cache_create?
>

Yes, I think it is better because in this way we do not need to add extra code
to do the rounding.

Curiosity, did you try your patches with SLUB red zoning enabled?
Since the area used for the Redzone is just after the payload, aligning the
object_size independently from the allocator could have side effects, at least
if I understand well how the mechanism works.

Setting ARCH_SLAB_MINALIGN should avoid this as well.

What do you think?

>>
>> --
>> Regards,
>> Vincenzo
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To post to this group, send email to kasan-dev@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2bf7415e-2724-b3c3-9571-20c8b6d43b92%40arm.com.
>> For more options, visit https://groups.google.com/d/optout.

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
