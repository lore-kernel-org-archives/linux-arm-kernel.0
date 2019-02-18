Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:32:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A767C2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N2iDXte9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A767C2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M5mujTQKKxzU+XMNKt4KjA9C3VVNWZhDmCxPSellpyo=; b=N2iDXte9Wdlkmo
	t3/tRylwwwUD7eLbxZwv2+MjyIaVpOfRQ2DU2NbFliypXLN2YulF6pEPDliombX67oYWlh2RrrK8l
	se7ML7i4+67boKeiXG7ySNgl8JSXmflF2EXxdIiJhsfRH9rQaP3GLpgRZ+KgKM0wNtkMG+F7OOsFQ
	Uirll2HGnhSIUuM5TCvwZYfMx0ePgdHKaVWqu1GZgjhK2OnFiCAPH8nDJa+tF5iveLC8EScId60sN
	GP64U3waBs21g5mABY7rnOo6C7BkX0HjmuDS4dIbTSWdy9SbeJDs5gVyFj785Qwo0xLRlWxXr3eOr
	fvs2A4h6C4X/msa+uR7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvh9U-0002B0-GA; Mon, 18 Feb 2019 11:32:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvh9P-000274-Uh
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 11:31:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB12080D;
 Mon, 18 Feb 2019 03:31:51 -0800 (PST)
Received: from [192.168.3.111] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8E5E3F73F;
 Mon, 18 Feb 2019 03:31:50 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: arm/arm64: Add save/restore support for firmware
 workaround state
To: Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <Dave.Martin@arm.com>
References: <20190107120537.184252-1-andre.przywara@arm.com>
 <20190107120537.184252-2-andre.przywara@arm.com>
 <20190122151714.GG3578@e103592.cambridge.arm.com>
 <20190125144657.3db91c91@donnerap.cambridge.arm.com>
 <20190129213223.GB3567@e103592.cambridge.arm.com>
 <20190130113900.10089070@donnerap.cambridge.arm.com>
 <20190215095857.2fd7e0fb@donnerap.cambridge.arm.com>
 <864l95s2fw.wl-marc.zyngier@arm.com>
 <20190215172558.GO3567@e103592.cambridge.arm.com>
 <20190218090731.3d313d81@why.wild-wind.fr.eu.org>
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <24383efc-795c-163b-0346-315f88f3774f@arm.com>
Date: Mon, 18 Feb 2019 11:29:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218090731.3d313d81@why.wild-wind.fr.eu.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_033156_372972_F52B11D7 
X-CRM114-Status: GOOD (  28.95  )
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
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 18/02/2019 09:07, Marc Zyngier wrote:
> On Fri, 15 Feb 2019 17:26:02 +0000
> Dave Martin <Dave.Martin@arm.com> wrote:

Hi,

> 
>> On Fri, Feb 15, 2019 at 11:42:27AM +0000, Marc Zyngier wrote:
>>> On Fri, 15 Feb 2019 09:58:57 +0000,
>>> Andre Przywara <andre.przywara@arm.com> wrote:  
>>>>
>>>> On Wed, 30 Jan 2019 11:39:00 +0000
>>>> Andre Przywara <andre.przywara@arm.com> wrote:
>>>>
>>>> Peter, Marc, Christoffer,
>>>>
>>>> can we have an opinion on whether it's useful to introduce some
>>>> common scheme for firmware workaround system registers (parts of
>>>> KVM_REG_ARM_FW_REG(x)), which would allow checking them for
>>>> compatibility between two kernels without specifically knowing about
>>>> them?
>>>> Dave suggested to introduce some kind of signed encoding in the 4
>>>> LSBs for all those registers (including future ones), where 0 means
>>>> UNKNOWN and greater values are better. So without knowing about the
>>>> particular register, one could judge whether it's safe to migrate.
>>>> I am just not sure how useful this is, given that QEMU seems to ask
>>>> the receiving kernel about any sysreg, and doesn't particularly care
>>>> about the meaning of those registers. And I am not sure we really
>>>> want to introduce some kind of forward looking scheme in the kernel
>>>> here, short of a working crystal ball. I think the kernel policy was
>>>> always to be as strict as possible about those things.  
>>>
>>> I honestly don't understand how userspace can decide whether a given
>>> configuration is migratable or not solely based on the value of such a
>>> register. In my experience, the target system has a role to play, and
>>> is the only place where we can find out about whether migration is
>>> actually possible.  
>>
>> Both origin and target system need to be taken into account.  I don't
>> think that's anything new.
> 
> Well, that was what I understood from Andre's question.
> 
>>
>>> As you said, userspace doesn't interpret the data, nor should it. It
>>> is only on the receiving end that compatibility is assessed and
>>> whether some level of compatibility can be safely ensured.
>>>
>>> So to sum it up, I don't believe in this approach as a general way of
>>> describing the handling or errata.  
>>
>> For context, my idea attempted to put KVM, not userspace, in charge of
>> the decision: userspace applies fixed comparison rules determined ahead
>> of time, but KVM supplies the values compared (and hence determines the
>> result).
>>
>> My worry was that otherwise we may end up with a wild-west tangle of
>> arbitrary properties that userspace needs specific knowledge about.
> 
> And this is where our understanding differs. I do not think userspace
> has to care at all. All it has to do is to provide the saved register
> values to the target system, and let KVM accept or refuse these
> settings. I can't see what providing a set of predefined values back to
> userspace gains us.
> 
> An unknown register on the target system fails the restore phase:
> that's absolutely fine, as we don't want to run on a system that
> doesn't know about the mitigation.
> 
> An incompatible value fails the restore as well, as KVM itself finds
> that this is a service it cannot safely provide.
> 
> No userspace involvement, no QEMU upgrade required. Only the kernel
> knows about it.

Yes, this is what I understand as well. From experience, many times when
we were not strict enough about some userland interface, it backfired.

The only case where such a forward-looking scheme would make sense is
the case where the source system has a new kernel, advertising a new
firmware workaround register, in an unknown or missing state (0 or -1).
An older kernel on the target system might not know about this register.
That would translate into "unknown", which is compatible with 0 or -1
from the source. So migration would be fine, but we deny it because the
new kernel returns -EINVAL.

But I am not sure this construct is worth implementing in the kernel. If
people care about this case, they could implement a workaround in
userland instead. Or just upgrade the target kernel before migration.

>> We can tolerate a few though.  If we accumulate a significant number
>> of errata/vulnerability properties that need to be reported to
>> userspace, this may be worth revisiting.  If not, it doesn't matter.
> 
> Andre: if you want this to make it into 5.1, the time is now.

OK. So is v2 [1] fine then? This implements the much easier "bigger is
better" scheme, but being 0 based instead of using a 4-bit signed encoding.
Let me know if there is something to rework in there.

Cheers,
Andre.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/627739.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
