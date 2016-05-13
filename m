From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 May 2016 21:36:41 -0700
Subject: [PATCH 2/2] clk: rockchip: fix the rk3399 sdmmc sample shift
In-Reply-To: <84673e7c-dd64-b2ca-5c7c-5c7f34d239d8@rock-chips.com>
References: <1463076197-15900-1-git-send-email-dianders@chromium.org>
 <1463076197-15900-2-git-send-email-dianders@chromium.org>
 <20160512231023.GA63308@google.com>
 <84673e7c-dd64-b2ca-5c7c-5c7f34d239d8@rock-chips.com>
Message-ID: <CAD=FV=WEAOwhDDBHBtuzSz35i0XRZw4LbFEnFCFYd-4NVH5d-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Thu, May 12, 2016 at 4:47 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> ? 2016/5/13 7:10, Brian Norris ??:
>>
>> On Thu, May 12, 2016 at 11:03:17AM -0700, Doug Anderson wrote:
>>>
>>> Just like every other Rockhip device, the MMC "_sample" clocks should
>>> have a shift of 0, not a shift of 1.  The rk3399 TRM agrees.  Presumably
>>> these values were set to 0 because of a typo.
>>
>>
>> I'll semi-disagree about the TRM: the TRM doesn't seem to agree with
>> itself, so it sometimes agrees with you and sometimes doesn't :)
>>
>> On page 79 of the 2nd (?) book, it looks like {SDMMC,SDIO}_CON{0,}[2:1]
>> are {drv,sample}_degree. But on page 208 of the 1st book, those are put
>> at bits [1:0].
>>
>
>
> Please refer to Mobile Strorage Host Controller section for anything
> about sdmmc/sdio. So shift should be 1.
>
> Sometime I also get bothered to address it. Anyway, I will always keep
> a eye on it from now on.....

I still in general have mistrust for TRM docs for things like this.
Have you verified that this was an intentional change for rk3399, or
could it be a  typo?  Typically SoCs don't change this type of stuff
for no reason.

This should be possible to verify in one of two ways.  If the TRM has
a typo and things truly _do_ start at 0 instead of 1, then:

1. There will be roughly mirrors of valid ranges.
2. Things won't match up if we change tuning to use 180 course offsets
and the rest fine offsets.

It would be ideal if you could confirm with the chip guys, but if you
can't I'll try to do more tests tomorrow.
