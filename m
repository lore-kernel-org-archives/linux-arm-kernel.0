From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Jul 2015 15:43:27 -0700
Subject: [PATCH] clk: rockchip: Fix PLL bandwidth
In-Reply-To: <CAD=FV=VpY4j=HOGCMdFJ8g1bWeUTKqk=GWoEB+EB3y52UMbrLg@mail.gmail.com>
References: <1437511283-14216-1-git-send-email-dianders@chromium.org>
 <55AEB6AE.2070006@codeaurora.org>
 <CAD=FV=VpY4j=HOGCMdFJ8g1bWeUTKqk=GWoEB+EB3y52UMbrLg@mail.gmail.com>
Message-ID: <55AECB0F.3090701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 03:37 PM, Doug Anderson wrote:
> Stephen,
>
> On Tue, Jul 21, 2015 at 2:16 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 07/21/2015 01:41 PM, Douglas Anderson wrote:
>>> In the TRM we see that BWADJ is "a 12-bit bus that selects the values
>>> 1-4096 for the bandwidth divider (NB)":
>>>    NB = BWADJ[11:0] + 1
>>> The recommended setting of NB: NB = NF / 2.
>>>
>>> So:
>>>     NB = NF / 2
>>>     BWADJ[11:0] + 1 = NF / 2
>>>     BWADJ[11:0] = NF / 2 - 1
>>>
>>> Right now, we have:
>>>
>>> {                                               \
>>>           .rate   = _rate##U,                     \
>>>           .nr = _nr,                              \
>>>           .nf = _nf,                              \
>>>           .no = _no,                              \
>>>           .bwadj = (_nf >> 1),                    \
>>> }
>>>
>>> That means we set bwadj to NF / 2, not NF / 2 - 1
>>>
>>> All of this is a bit confusing because we specify "NR" (the 1-based
>>> value), "NF" (the 1-based value), "NO" (the 1-based value), but
>>> "BWADJ" (the 0-based value) instead of "NB" (the 1-based value).
>>>
>>> Let's change to working with "NB" and fix the off by one error.  This
>>> may affect PLL jitter in a small way (hopefully for the better).
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>
>> There's no Fixes tag or stable Cc so I take it this isn't fixing any
>> manifesting regression, more of a visual inspection bug find?
> There is no known problem fixed.  I've been looking at HDMI and
> controlling PLL jitter is an important part of supporting HDMI clock
> rates.  That got me to looking at this parameter and deciding that we
> should set it correctly.  Apparently it doesn't help in any hugely
> significant way...  I just got done re-testing a whole lot of rates
> and if it helped or hurt my jitter it's in the noise (AKA there's
> enough variance run-to-run that it's hard to tell if this made any
> difference).
>
>

Ok. Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
