From: dianders@chromium.org (Doug Anderson)
Date: Wed, 19 Nov 2014 21:15:41 -0800
Subject: [PATCH v2] clk: Propagate prepare and enable when reparenting
 orphans
In-Reply-To: <20141120023050.12298.26964@quantum>
References: <1415408818-28028-1-git-send-email-dianders@chromium.org>
 <20141120023050.12298.26964@quantum>
Message-ID: <CAD=FV=VZJ_iSFoW39kbahFSZ_Ta4Qf7zxaCnJMWFVWhXzsLrWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On Wed, Nov 19, 2014 at 6:30 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Doug Anderson (2014-11-07 17:06:58)
>> With the existing code, if you find a parent for an orhpan that has
>> already been prepared / enabled, you won't enable the parent.  That
>> can cause later problems since the clock tree isn't in a consistent
>> state.  Fix by propagating the prepare and enable.
>>
>> NOTE: this does bring up the question about whether the enable of the
>> orphan actually made sense.  If the orphan's parent wasn't enabled by
>> default (by the bootloader or the default state of the hardware) then
>> the original enable of the orphan probably didn't do what the caller
>> though it would.  Some users of the orphan might have preferred an
>> EPROBE_DEFER be returned until we had a full path to a root clock.
>> This patch doesn't address those concerns and really just syncs up the
>> state.
>
> -ECANOFWORMS
>
> I'm thinking about this patch but I haven't quite made up my mind. It is
> reasonable, but also some nice kind of error might be preferable when
> preparing/enabling an orphaned clock.
>
> Under what conditions might a clock be orphaned? An obvious example is
> just bad luck during the thundering herd of clock registrations from a
> driver. In this case deferring the probe might be a good idea.
>
> However what about the case where a loadable module provides the parent
> clock? It might be a long time before the orphan clocks gets picked up
> from the orphanage. Is deferring probe the right thing here as well?

I will defer to your wisdom here.  I agree that these are the two
primary solutions and I've picked one, but I have no idea which will
be more of a PITA in the long run.

Note: I'm not sure that anyone expects EPROBE_DEFER to be returned
from a clk_enable() (do they?).  It almost seems like the right answer
is to fail to allow anyone to clk_get() any clock that doesn't have a
path to root.


I will say that without this patch or the EPROBE_DEFER solution we
have a clear bug.  You can get into a situation where a clock is
enabled/prepared but its parent isn't.

-Doug
