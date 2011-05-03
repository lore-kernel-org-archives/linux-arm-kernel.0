From: vikram186@gmail.com (Vikram Narayanan)
Date: Tue, 3 May 2011 07:47:36 +0530
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <1304099849.30215.10.camel@work-vm>
References: <20110426203756.GD17290@n2100.arm.linux.org.uk>
	<BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
	<alpine.LFD.2.02.1104271015000.3323@ionos>
	<BANLkTi=WRw9pphieBAnDRhSH_WSdyUdb_A@mail.gmail.com>
	<20110428133826.GM17290@n2100.arm.linux.org.uk>
	<BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
	<20110428142822.GN17290@n2100.arm.linux.org.uk>
	<BANLkTin9_=zwLCkqVcAfg-_pGTXk9GaZsg@mail.gmail.com>
	<20110428182420.GF17290@n2100.arm.linux.org.uk>
	<BANLkTi=Xb7c9GeNJ_Our0+euEmumk_0-OA@mail.gmail.com>
	<20110429143435.GU5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291902370.3005@ionos>
	<1304099849.30215.10.camel@work-vm>
Message-ID: <BANLkTinzjQRvo7Rcouhw2GE-UC3LR4JSsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 11:27 PM, john stultz <johnstul@us.ibm.com> wrote:
> On Fri, 2011-04-29 at 19:05 +0200, Thomas Gleixner wrote:
>> On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
>>
>> > On Fri, Apr 29, 2011 at 07:56:56PM +0530, Vikram Narayanan wrote:
>> > > Can you also give some idea on how the system's RTC is hooked up with
>> > > the generic timekeeping code.
>> > > Is it hooked up in someway so that the walltime is calculated wrt the
>> > > initial value of the RTC?
>> >
>> > I'd like to pass you over to the RTC folk, but I don't think they're
>> > very active anymore.
>> >
>> > Suffice it to say that the RTC subsystem will set the system date/time
>> > on initialization from the RTC device if one is provided. ?All I can
>> > suggest is to look at drivers/rtc and include/linux/rtc.h for the
>> > details. ?The MAINTAINERS file should list who is responsible for RTC
>> > stuff as well as a mailing list for it.
>>
>> read_persistant_clock() is used for boottime / resume time readouts of
>> a direct accessible RTC.
>
> Right. read_persistent_clock has the benefit of being able to be read
> with irqs off, which really is useful in reducing error in the
> suspend/resume code. This makes it the preferred interface for
> timekeeping.
>
>
>> If the RTC sits behind a slow bus which is not accessible in early
>> boot, then the RTC framework will take care of updating the time once
>> the RTC becomes available.
>
> Right. I sent out a patch "Add timekeeping_inject_sleeptime" that
> corrects the irqs-required RTC paths on suspend and resume, which Thomas
> just pulled into -tip for 2.6.40. It should improve things on the
> non-read_persistent_clock/irq-required RTC side of things.
>
> With 2.6.39 and earlier, the RTC code basically just calls
> settimeofday() fairly late in the resume step, which makes a window for
> resume timestamps to show the suspend time, as well as not properly
> allowing us to account for the amount of time the system was sleeping
> (which mucks up the boot time).
>
> Of course, another issue with the RTC interface is that it
> isbottlenecked at second granularity, which also hurts suspend/resume
> time accuracy. Where as read_persistent_clock() allows for finer grained
> resolution (if possible).
>
> Let me know if you have any more questions I can try to answer.
Thank you all for the explanations. I will update the thread, if I
have more questions. :)

-
Thanks,
Vikram
