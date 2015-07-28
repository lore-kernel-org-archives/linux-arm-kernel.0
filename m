From: dianders@chromium.org (Doug Anderson)
Date: Tue, 28 Jul 2015 16:29:40 -0700
Subject: [RFC PATCH 0/3] clocksource: exynos_mct: allow mct to use 64-bit
 counter from coprocessor
In-Reply-To: <CALW4P+LqjhQ+Puadz4W-n_v=KEnwvQiUkk5jkDLRxhjVQGwFyw@mail.gmail.com>
References: <1438032507.17734.46.camel@gmail.com>
 <CAD=FV=W0PM57UJBQ1Vw4PNTapnPDvU1xtKP=9gdX6GBy+6yh1A@mail.gmail.com>
 <CALW4P+LqjhQ+Puadz4W-n_v=KEnwvQiUkk5jkDLRxhjVQGwFyw@mail.gmail.com>
Message-ID: <CAD=FV=VMEGrS7XdVDLTM89WHVd_zQtjs0aM2CaWCecE3WqG9Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 28, 2015 at 9:20 AM, Alexey Klimov <klimov.linux@gmail.com> wrote:
> Hi Doug,
>
> On Tue, Jul 28, 2015 at 6:24 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Alexey,
>>
>> On Mon, Jul 27, 2015 at 2:28 PM, Alexey Klimov <klimov.linux@gmail.com> wrote:
>>> Hi all,
>>>
>>> year(s) ago it was discovered that MCT timer and ARM architectured
>>> timer
>>> are the same hardware with different interface. Here [1].
>>>
>>> I followed mail-list discussions about removing MCT and using arch
>>> timer for Exynos5-based SoCs but things aren't moving at least latest
>>> upstream kernel on odroid-xu3 will use MCT as default timers.
>>> Maybe the reason are some power-management related things that very
>>> specific to Samsung. I don't know.
>>>
>>>
>>> Idea of this draft patchset comes from Doug patches when he tried to
>>> optimize read of 64-bit counter located in mmio. [2]
>>> Why not using cp15 counter instead if possible?
>>
>> I hate to burst your bubble here, but...
>>
>> ...I think it would be a bad idea to use the cp15 counter on exynos
>> 5422.  According to Samsung, there are issues where using cp15 could
>> sometimes return the wrong value, especially if you happen to read it
>> while on an A7 instead of an A15.  It will tend to work pretty well,
>> but Samsung claimed that it might not work right on some CPUs or at
>> some temperatures.
>
> I think this is right time when I can say "If only I had known about
> it before!".

Yeah, we spent a whole lot of time on this too before giving up after
we found out it was not possible to use.


> That's quite interesting especially about temperature issues.
> Maybe it's worth to insert comments in driver/docs about this.

Maybe not a bad idea.  Depends if you think someone else will try to
do this...  ...and if they do, will they check mailing list traffic.


>> Generally I'd say that if the arch timer works for you: use the arch
>> timer.  If the arch timer doesn't work for you, use the MCT.
>>
>> -Doug
>
> I possess no knowledge if there're any different hw revisions of
> odroid-xu3 on the field
> but looks like arch timer works fine for me on odroid-xu3 Exynos5422
> SoC with upstream kernel.

Well, it looked like it worked for us too.  In fact, I never saw a
failure.  All I know is that Samsung said: don't do this, it's not a
good idea.  The performance gain wasn't enough to go against that...
That's when I started trying to optimize the MCT a little bit.  ;)


-Doug
