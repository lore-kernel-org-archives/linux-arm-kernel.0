From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Wed, 27 Jan 2016 11:20:35 +0100
Subject: [PATCH 0/5] clk: rockchip: add full support for HDMI clock on
 rk3288
In-Reply-To: <CAD=FV=Une-DJ+0zV6Hmx5EmKXCEApb2Zx1FuJaUQf7MT9OPsug@mail.gmail.com>
References: <1415087559-19444-1-git-send-email-kever.yang@rock-chips.com>
 <48806799.thBSifdUp8@diego> <54647142.4080800@rock-chips.com>
 <CAD=FV=Vzec3Qm-kc6zZ4VxSREoZbzVkWbzp-noHYdcEVrLYYSw@mail.gmail.com>
 <CAAObsKChYN5nmcm5OWnAzNRGDi_QGSoKvN+0FizhjeT-3mmeXQ@mail.gmail.com>
 <CAD=FV=Wgu=xQ9PcVqfzcedXVU3Rh-HKbBVxHuqgV9OZJEYhYvg@mail.gmail.com>
 <CAAObsKC1v--mZwkiG-c7P2Bwi2-_txbeqaW4Vd5h-noAVNbhjA@mail.gmail.com>
 <CAD=FV=VB93wYigRJ8wa8YL6P+Q+-fRokPiCB-Fo1pC_zAdh2oA@mail.gmail.com>
 <CAAObsKCMh3Bk_oNJdLbU2F9b7jrnFZOp2uFR_oPqUoJ3W1gfaQ@mail.gmail.com>
 <CAD=FV=W=LCJk4m049hBnm7BOYudnVe=oa3jdcSrrZZUU9rFtog@mail.gmail.com>
 <CAAObsKBS45kbvdmdvFxwSo=B9GXRLoX2g7WQYVmZJ0KFnwSejw@mail.gmail.com>
 <CAD=FV=Une-DJ+0zV6Hmx5EmKXCEApb2Zx1FuJaUQf7MT9OPsug@mail.gmail.com>
Message-ID: <CAAObsKDsJgUA9dL+1Fdc616ofLdMqaUOwHhDkBWz7MV5_LJu9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 January 2016 at 17:32, Doug Anderson <dianders@chromium.org> wrote:
> Tomeu,
>
> On Tue, Jan 26, 2016 at 12:28 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>> On 22 January 2016 at 18:07, Doug Anderson <dianders@chromium.org> wrote:
>>> Tomeu,
>>>
>>> On Fri, Jan 22, 2016 at 6:00 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>>>> On 21 January 2016 at 21:11, Doug Anderson <dianders@chromium.org> wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Jan 21, 2016 at 1:03 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>>>>>> So we have a mechanism for detecting a conflict in the clock
>>>>>> hierarchy, and a mechanism to solve it, but we are missing a way for
>>>>>> userspace to communicate policy regarding which clocks should be given
>>>>>> priority when solving such a conflict?
>>>>>
>>>>> Hrmmm, I guess it could be userspace that makes the decision.  It does
>>>>> seem a little odd to force it to userspace in all cases, though.  For
>>>>> a particular laptop that is designed with a specific panel connected
>>>>> up eDP it seems less than ideal to push this into userspace.  If the
>>>>> kernel could just work in the expected sane way (or at least work that
>>>>> way by default) it would be ideal.
>>>>
>>>> Ah, I was wrongly assuming that the kernel didn't have enough
>>>> information to make an informed decision in this case, sorry.
>>>>
>>>> Guess the per-user rate limits don't help here because the consumer
>>>> with higher priority could work with frequencies other than the ideal.
>>>>
>>>> And we cannot have a consumer listening for PRE_RATE_CHANGE and
>>>> aborting unwanted changes or rerouting the ancestors of the clocks of
>>>> other consumers because that would be a massive violation of
>>>> separation of concerns.
>>>>
>>>> If we were to rearrange the clock topology from within the CCF, then
>>>> consumers need to have a way to communicate to the core that they are
>>>> more important than other consumers. clk_set_important(clk, true)
>>>> could be enough in this case, but would be insufficient in more
>>>> complex cases where more than two clocks could use the same PLL.
>>>
>>> With something like the above I'd still expect some complexity
>>> depending on the probe order.  If a less important device grabs the
>>> clock first, it might be forced to re-think its clocks later.  That
>>> might be disconcerting.
>>
>> How much disconcerting do you think this could be? Hopefully those
>> devices should probe quite close to each other, right?
>
> Probe: probably, though with defers it could be several seconds.
>
> ...but remember that display interfaces tend to be hotplug.  That
> might mean that the HDMI interface won't try to set the clock until
> much, much later.

I'm still having trouble grasping what's the impact to users. Is it
that if HDMI gets the contended clock first and the internal panel
device only probes after a second or so, then the user may notice a
change in frequency in the HDMI screen when the panel lights up?

Though in that particular case I'm not sure if the impact is that big
for the user, wonder if such rearranging of the clock hierarchy can
cause bigger problems in other situations.

The on-demand probing series could help here because a downstream that
cared about these issues could just rearrange the contents of the DT
(maybe with a script as part of the build process) so that the panel
is always probed first, but well, that one collided with an iceberg.

>>> OK, so I was just involved in a change recently that made me realize
>>> that maybe our original problems were tied to the fact that our
>>> builtin panels were trying to specify a clock that was impossible to
>>> achieve with CPLL / GPLL.  It was a known problem that the request
>>> would be denied and the CCF would just pick the closest rate it could.
>>> Probably the right thing is to solve _that_ problem first.  If using
>>> simple panel you could do a change like
>>> <https://chromium-review.googlesource.com/#/c/323211/> (though
>>> presumably you'd have to handle people using the same panel in other
>>> laptops).  You might also be able to do funny things to fixup the mode
>>> like dbehr tried to do in
>>> <https://chromium-review.googlesource.com/#/c/270017/>.  By doing this
>>> and making sure that
>>
>> Are we missing something here?
>
> Eh?

The sentence above seemed to have been cut in the middle and I was
wondering if there's something relevant I'm missing because of it.

Thanks,

Tomeu
