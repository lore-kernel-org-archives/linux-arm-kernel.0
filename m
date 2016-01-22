From: dianders@chromium.org (Doug Anderson)
Date: Fri, 22 Jan 2016 09:07:50 -0800
Subject: [PATCH 0/5] clk: rockchip: add full support for HDMI clock on
 rk3288
In-Reply-To: <CAAObsKCMh3Bk_oNJdLbU2F9b7jrnFZOp2uFR_oPqUoJ3W1gfaQ@mail.gmail.com>
References: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
 <48806799.thBSifdUp8@diego> <54647142.4080800@rock-chips.com>
 <CAD=FV=Vzec3Qm-kc6zZ4VxSREoZbzVkWbzp-noHYdcEVrLYYSw@mail.gmail.com>
 <CAAObsKChYN5nmcm5OWnAzNRGDi_QGSoKvN+0FizhjeT-3mmeXQ@mail.gmail.com>
 <CAD=FV=Wgu=xQ9PcVqfzcedXVU3Rh-HKbBVxHuqgV9OZJEYhYvg@mail.gmail.com>
 <CAAObsKC1v--mZwkiG-c7P2Bwi2-_txbeqaW4Vd5h-noAVNbhjA@mail.gmail.com>
 <CAD=FV=VB93wYigRJ8wa8YL6P+Q+-fRokPiCB-Fo1pC_zAdh2oA@mail.gmail.com>
 <CAAObsKCMh3Bk_oNJdLbU2F9b7jrnFZOp2uFR_oPqUoJ3W1gfaQ@mail.gmail.com>
Message-ID: <CAD=FV=W=LCJk4m049hBnm7BOYudnVe=oa3jdcSrrZZUU9rFtog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomeu,

On Fri, Jan 22, 2016 at 6:00 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> On 21 January 2016 at 21:11, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Thu, Jan 21, 2016 at 1:03 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>>> So we have a mechanism for detecting a conflict in the clock
>>> hierarchy, and a mechanism to solve it, but we are missing a way for
>>> userspace to communicate policy regarding which clocks should be given
>>> priority when solving such a conflict?
>>
>> Hrmmm, I guess it could be userspace that makes the decision.  It does
>> seem a little odd to force it to userspace in all cases, though.  For
>> a particular laptop that is designed with a specific panel connected
>> up eDP it seems less than ideal to push this into userspace.  If the
>> kernel could just work in the expected sane way (or at least work that
>> way by default) it would be ideal.
>
> Ah, I was wrongly assuming that the kernel didn't have enough
> information to make an informed decision in this case, sorry.
>
> Guess the per-user rate limits don't help here because the consumer
> with higher priority could work with frequencies other than the ideal.
>
> And we cannot have a consumer listening for PRE_RATE_CHANGE and
> aborting unwanted changes or rerouting the ancestors of the clocks of
> other consumers because that would be a massive violation of
> separation of concerns.
>
> If we were to rearrange the clock topology from within the CCF, then
> consumers need to have a way to communicate to the core that they are
> more important than other consumers. clk_set_important(clk, true)
> could be enough in this case, but would be insufficient in more
> complex cases where more than two clocks could use the same PLL.

With something like the above I'd still expect some complexity
depending on the probe order.  If a less important device grabs the
clock first, it might be forced to re-think its clocks later.  That
might be disconcerting.

OK, so I was just involved in a change recently that made me realize
that maybe our original problems were tied to the fact that our
builtin panels were trying to specify a clock that was impossible to
achieve with CPLL / GPLL.  It was a known problem that the request
would be denied and the CCF would just pick the closest rate it could.
Probably the right thing is to solve _that_ problem first.  If using
simple panel you could do a change like
<https://chromium-review.googlesource.com/#/c/323211/> (though
presumably you'd have to handle people using the same panel in other
laptops).  You might also be able to do funny things to fixup the mode
like dbehr tried to do in
<https://chromium-review.googlesource.com/#/c/270017/>.  By doing this
and making sure that

With that being said, how about this as a solution:

1. Figure some way (presumably some type of device tree property?) to
make sure that the builtin panel chose a clock that was achievable by
dividing CPLL / GPLL on rk3288.  If you have eDP but no builtin panel
you wouldn't specify this and you'd just let the system pick whatever
it wanted.

2. We use "assigned-clocks" to (by default) make NPLL something silly
and unattractive.  This will keep the common clock framework from
picking it to use as the source if the clock could be made just as
well from CPLL / GPLL (or find some other way to make NPLL a lower
priority muxing option).

3. We use the "dibs" rule in that the first display driver to claim
NPLL blocks anyone else from changing things.


In the above on a laptop with a builtin panel and an HDMI port you'd
get the panel using CPLL / GPLL and HDMI getting CPLL, GPLL or NPLL
(and it would be able to change NPLL if needed).


In the above on a dev board with a lot of ports then the first device
probed would get the most flexibility.  Future devices would be
limited in their choices.

-Doug
