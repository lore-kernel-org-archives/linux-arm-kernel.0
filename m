Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C168BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:47:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915A3208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="paAz3UMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915A3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pygfRmeMo+pUh+ZFNetsUBOWEroMiBYsRkEw6p0a43c=; b=paAz3UMOusXjAm
	HaP2/+O7lZqvcab8rOnaZ4WjiYsEB5xd8jJL3CSJCPXCURWweGZSbX2Eb1U8nZcX6nPGMI/UgX/E6
	EAJe1KY9igVLBL1vNsfqHzXh9qO2r15gHVwtF3UsxCGkhoPIPjWyiwaaVSEZHpmZ+QwZ4QtLAh3ie
	v1FS+LLHSNyuxq4sqzSThWIt3xhFTvL8mYwWyooaBLNwe0aua4QfzwY2lOKxjIKxBiV5zupknHqfa
	BxUb8FoiWafkizm+spARajIwb14D3BKjdi+1M0Illu8a3eGQbtqt6ME6pi8giT5moqwtQN/hGLxKb
	XHiJZquGEjch41INO6bQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXNaF-00012e-Df; Thu, 13 Dec 2018 09:47:07 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXNaC-000128-0o
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 09:47:05 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B0D80D;
 Thu, 13 Dec 2018 01:46:51 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BD13F6A8;
 Thu, 13 Dec 2018 01:46:49 -0800 (PST)
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Arnd Bergmann <arnd@arndb.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <CAK8P3a1njNBWiMExBevqbT+AuUHdU4T2sc1o1rRTn+Ji=y2SbA@mail.gmail.com>
 <64ff3b50-ce55-ff69-ac3a-61f221299895@arm.com>
 <CAK8P3a0LgFuv_s4xiC_rD0X7-GxHRWfzmdDcxJ7vvHrEETApRw@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1071a68e-f671-b56e-e627-e83bb97da8bf@arm.com>
Date: Thu, 13 Dec 2018 09:46:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0LgFuv_s4xiC_rD0X7-GxHRWfzmdDcxJ7vvHrEETApRw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_014704_072452_259157B9 
X-CRM114-Status: GOOD (  22.70  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>,
 Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On 11/12/2018 21:41, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 2:39 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>> On 29/11/2018 20:42, Arnd Bergmann wrote:
>>> On Thu, Nov 29, 2018 at 6:06 PM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>
>>>> +/*
>>>> + * The definitions below are required to overcome the limitations
>>>> + * of time_t on 32 bit architectures, which overflows in 2038.
>>>> + * The new code should use the replacements based on time64_t and
>>>> + * timespec64.
>>>> + *
>>>> + * The abstraction below will be updated once the migration to
>>>> + * time64_t is complete.
>>>> + */
>>>> +#ifdef CONFIG_GENERIC_VDSO_32
>>>> +#define __vdso_timespec                old_timespec32
>>>> +#define __vdso_timeval         old_timeval32
>>>> +#else
>>>> +#ifdef ENABLE_COMPAT_VDSO
>>>> +#define __vdso_timespec                old_timespec32
>>>> +#define __vdso_timeval         old_timeval32
>>>> +#else
>>>> +#define __vdso_timespec                __kernel_timespec
>>>> +#define __vdso_timeval         __kernel_old_timeval
>>>> +#endif /* CONFIG_COMPAT_VDSO */
>>>> +#endif /* CONFIG_GENERIC_VDSO_32 */
>>>>
>>>
>>> Have you considered doing this in the reverse way, by including
>>> the common parts from multiple implementations (32 and 64
>>> bit), instead of compiling the same source file multiple
>>> times with different macros set? I think that would make it
>>> easier to understand.
>>>
>>
>> The common code is never compiled as standalone. It includes arch specific code
>> (for the fallbacks) and it is included in the arch specific vdso library (for
>> both 32 and 64 bit where it makes sense). Hence it is built once or twice.
>>
>> If I understand correctly your question, seems inline with what I am doing.
> 
> The result is very similar, it's just a question of which file includes which
> other file. If I understand your current method right, you use Makefile
> logic to build multiple object files from a single source file, and setting
> ENABLE_COMPAT_VDSO on one of them, right?
> 

First of all, thank you for explaining this further.

My approach seems currently in line with what happens in fs/compat_binfmt_elf.c,
the only differences are:
- Instead of doing (pseudo-code):

#ifdef CONFIG_XYZ
#include "../../../../../xyz.c"
#endif

inside of the C file, I am using the Makefile logic (-include of xyz.c) to
include the C file upon checking the config option and to generate the correct
include path. The object (from: lib/vdso/gettimeofday.c) is never built as a
standalone multiple times.

- The chain of inclusion is <arch>/include/asm/vdso/gettimeofday.h -->
lib/vdso/gettimeofday.c --> vdso/vgettimeofday.c (this is the only object that
we are building) and this is to keep the Makefile as simple as possible. In fact
the other way around would have resulted in copying the objects around (to not
override them when compat is present) with the implication of more complicated
Makefiles.

> My preference would be to keep that Makefile simpler and have one
> source file per object file, but have each one define a set of macros
> before including the common source file, similarly to how we deal
> with fs/compat_binfmt_elf.c. If that turns out to be worse than what
> you have here, I'm not overly attached to that solution since including
> C files is still ugly, but I think it's worth trying if that lets you end
> up with more easily understandable source code.
> 
>        Arnd
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
