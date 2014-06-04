From: dianders@chromium.org (Doug Anderson)
Date: Wed, 4 Jun 2014 11:49:50 -0700
Subject: [PATCH 3/3] clocksource: exynos_mct: Optimize register reads with
 ldmia
In-Reply-To: <alpine.DEB.2.10.1406042004140.3319@nanos>
References: <1401903034-20074-1-git-send-email-dianders@chromium.org>
 <1401903034-20074-3-git-send-email-dianders@chromium.org>
 <alpine.DEB.2.10.1406042004140.3319@nanos>
Message-ID: <CAD=FV=UDAcBeXewVinSG0WeoHkkw2zHe2ORp7BLW=NKxmKUiew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, Jun 4, 2014 at 11:05 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 4 Jun 2014, Doug Anderson wrote:
>
>> As we saw in (clocksource: exynos_mct: cache mct upper count), the
>> time spent reading the MCT shows up fairly high in real-world
>> profiles.  That means that it's worth some optimization.
>>
>> We get a roughly 10% speedup in userspace gettimeofday() by using an
>> ldmia to read the two halfs of the MCT.  That seems like a worthwhile
>> thing to do.
>>
>> Before: 1173084 us for 1000000 gettimeofday in userspace
>> After:  1045674 us for 1000000 gettimeofday in userspace
>>
>> NOTE: we could actually do better than this if we really wanted to.
>> Technically we could register the clocksource as a 32-bit timer and
>> only use the "lower" half.  Doing so brings us down to 1014429 us for
>> 1000000 gettimeofday in userspace (and doesn't even require assembly
>> code).  That would be an alternative to this change.
>
> I was about to ask exactly that question: What's the advantage of the
> 64 bit dance there? AFAICT nothing.

I debated whether to send out the 32-bit version, since I'd
implemented both.  I'm happy to send out the 32-bit version too and
people can pick which they like better.  Let me know.

The final thing that pushed me over the edge to send the 64-bit
version was that I didn't know enough about how MCT was used with
respect to low power modes (we don't use AFTR / LPA modes on our
system).  I could actually believe that we might want to set a timer
for more than 178 seconds into the future for these low power modes.
If that's the case, we still need to keep around the 64-bit read code
for that case.  ...and once we have the 64-bit code then we might as
well use it for the rest of the timers.

Perhaps Tomasz will comment on this.

-Doug
