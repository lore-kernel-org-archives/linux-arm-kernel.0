From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jul 2012 00:23:05 +0200
Subject: [RFC] ARM: sched_clock: update epoch_cyc on resume
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB19376@DBDE01.ent.ti.com>
References: <1342567672-29071-1-git-send-email-ccross@android.com>
 <CACRpkdaHdCvx1HJNDsyJSZAN--sF+4-V1TbzXZL1v+7Asoe_oA@mail.gmail.com>
 <CAMbhsRR2-VjUeL2XPKubeaG=iLV5NE-i_sVYbuMAryXLxsbo1g@mail.gmail.com>
 <CACRpkdYayLaKzUSq5V9N5sRkV74a+nZ1CbLJzRW7RP=pOU9bfw@mail.gmail.com>
 <CAMbhsRQuXsytM9QLwjW1z1E=0XNztXP1xezbcDEj7Ra6deKLDQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EB19376@DBDE01.ent.ti.com>
Message-ID: <CACRpkdaiZKGEQatbLPpOQd-7J+m38mYFupLoOeALdhVUcUEdrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 11:16 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:

>> > A connecting theme is that of being avle to flag clock sources as
>> > sched_clock providers. If all clocksources were tagged with
>> > rating, and only clocksources were used for sched_clock(), the
>> > kernel could select the highest-rated clock under all circumstances.
>> >
>> > But that's quite intrusive, more of an idea. :-P
>>
>
> Too intrusive I guess ;)
>
> There were some discussions on this in the context of AM335x [1] [2].
> Right now only sched_clock can be registered and I guess this restriction
> is not going to go away any time soon.

Why do you think that? The restriction to only assign sched_clock() at
compile-time was recently removed so its now runtime assigned.

So yes, a clock source that can die and change frequency is no good
as primary system time, but the abstraction could still be used for
those that do, just add another flag NOT_CONTINUOUS or so, and
make sure the system does not select this for primary system
clock source.

Then modelling sched_clock() on clock sources makes all more
sense: just select the best one. For primary system clock source,
do not select one which is non-continous.

Yours,
Linus Walleij
