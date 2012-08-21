From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue, 21 Aug 2012 12:48:16 -0500
Subject: [PATCH 1/3] ARM: OMAP: hwmod: partially un-reset hwmods might not
 be properly enabled
In-Reply-To: <50324E84.6080407@ti.com>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
 <1342466485-1050-2-git-send-email-omar.luna@linaro.org>
 <50324E84.6080407@ti.com>
Message-ID: <CALLhW=50Ro5T=u7KTObT6g7eF=835Ywj9sQ+z8kZ_+5U7U7fJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2012 09:49, Benoit Cousson <b-cousson@ti.com> wrote:
> On 07/16/2012 09:21 PM, Omar Ramirez Luna wrote:
>> Some IP blocks might not be using/controlling more than one
>> reset line, this check loosens the restriction to fully use
>> hwmod framework for those drivers.
>>
>> E.g.: ipu has reset lines: mmu_cache, cpu0 and cpu1.
>> - cpu1 might not be used and hence (with previous check)
>>   won't be fully enabled by hwmod code.
>
> You mean that you might have some case where you need to enable the
> mmu_cache and cpu0 and thus deassert only the mmu/cpu0 while keeping the
> cpu1 under reset?

Looks like I didn't reply to this question.

Yes, initially cpu1 might not be used and kept under reset. Or even
the mmu can be taken out of reset and configured, and cpu0 after it,
creating a small window where one is taken out and the other is under
reset.

> So the any_hardreset is indeed not appropriate in that case.
>
> In fact, since the hardreset cannot be handled at all by the hwmod fmwk,
> I'm even wondering if we should take care of checking the state at all.
> But as Paul stated, if was done due to the lack of understanding about
> the diver usage, so maybe things will become clearer once we will have
> that code available.

I still think it can, in fact all the code I'm using comes from the
hwmod fmwk. _deassert_reset is almost the same as _enable, I left it
this way to avoid reintroducing the issues that caused reset code to
be stripped out from _enable path.

Regards,

Omar
