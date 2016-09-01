From: dianders@chromium.org (Doug Anderson)
Date: Wed, 31 Aug 2016 21:20:16 -0700
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <77f5cff1-80a2-76b3-40e9-f77caced2257@rock-chips.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-3-xzy.xu@rock-chips.com>
 <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
 <57C3A30B.5080707@rock-chips.com>
 <ceba6a89-6945-58c5-62e4-7d842cfa2312@rock-chips.com>
 <CAD=FV=W=LkVAm187hxp0Kbjxi5kSThwKnCMX+tr8SXQ-v_xQTQ@mail.gmail.com>
 <77f5cff1-80a2-76b3-40e9-f77caced2257@rock-chips.com>
Message-ID: <CAD=FV=WmoyoZmV_uj281S37ZpWqg8Dr2U8ntkD2Sr58qbcB0wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 31, 2016 at 7:29 PM, Ziyuan Xu <xzy.xu@rock-chips.com> wrote:
>> This is fine to pick up _only_ if you don't care about suspend/resume.
>> If you care about suspend/resume then someone needs to first write a
>> patch that will re-init all "corecfg" values after power is turned on.
>
>
> Do you mean corecfg_clockmultiplier and corecfg_baseclkfreq, if yes, we
> don't need to strore/re-init it after resume.
> corecfg_clockmultiplier is only used to fetch host->clk_mul, and
> host->clk_mul has been a fixed value at run-time, unless driver unbind.
> The same as corecfg_clockmultiplier, corecfg_baseclkfreq is used to check
> the xin_clk at probe time, we don't reference it at run-time.
> BTW, I have tested suspend/resume on rk3399 prior to this sumbit, eMMC works
> fine.

I guess I don't actually know how the corecfg_clockmultiplier and
corecfg_baseclkfreq fields are actually used, but I presume that they
actually do something useful and aren't used to just communicate back
to software?

I know that:

1. If I don't pick this patch and I suspend/resume,
corecfg_clockmultiplier and corecfg_baseclkfreq are still fine after
suspend / resume.

2. If I do pick this patch and I suspend/resume,
corecfg_clockmultiplier and corecfg_baseclkfreq are wrong after
suspend/resume (tested by reading /dev/mem directly from userspace
after suspend/resume).


Are you saying that it is unimportant that corecfg_clockmultiplier and
corecfg_baseclkfreq are wrong?

>> Technically I think this should probably use "pm runtime" and not
>> normal suspend/resume hooks.  Any time we end up pm runtime suspended
>> then I think our power will go off (because of genpd?) and we need to
>> restore values.
>
>
> I understand your consideration. BUT genpd is in charge of on/off pd if the
> corresponding device node has "power-domains" property. RPM is unnecessary
> for this situation, we will not use autosuspend, right?
>
> @shawn, what's your opinion?

I haven't dug.  If Runtime PM isn't enabled for sdhci-of-arasan then I
guess we can just worry about suspend/resume, though.

-Doug
