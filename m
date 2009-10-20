From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Mon, 19 Oct 2009 23:21:40 -0500
Subject: [PATCH] input/touchscreen: add S3C24XX SoC touchscreen input
	driver
In-Reply-To: <20091019120744.GB7412@n2100.arm.linux.org.uk>
References: <mailman.4020.1255949705.2256.linux-arm-kernel@lists.infradead.org>
	<4ADC4D4D.5020508@gmail.com>
	<20091019120744.GB7412@n2100.arm.linux.org.uk>
Message-ID: <2accc2ff0910192121t27387b90t9cfd5a5252aa00cc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2009 at 7:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 19, 2009 at 01:28:13PM +0200, Maurus Cuelenaere wrote:
>> Do you know that there's another patch (at Openmoko) created by Nelson
>> Castillo that does the same, but also has support for kernel-space
>> touchscreen filters? (I think [1] is his latest version)
>> I don't know how your patch performs, but according to [2] the filters
>> should help a lot avoiding jitter etc.
>> I'm not sure whether Nelson has submitted his patches for mainline
>> review yet and what the status is on the kernel filters, but IMHO doing
>> some filtering in kernel space (see the "Why are we doing filtering in
>> kernel space?" part of [2]) which results in a "cleaner" output is
>> preferred over reporting possible "jittery" data.

I did submit the filter stuff once and I applied ALL the upstream
feedback we got from Andrew M.

> It doesn't really describe why doing the filtering in kernel space is
> apparantly soo much better than doing it in tslib - it's seems to just
> do some handwaving kind of argument:

Some drivers do some kind of filtering. Even the other one for this
chip submitted to linux-arm-kernel a few days ago.

> ? Let's say we would like to deliver a TS event to user space each 10
> ? milliseconds. In the GTA02 with the current configuration the
> ? Analog/Digital conversion time of a sample is 0.4697 milliseconds, thus
> ? can get 18 samples for each event that we send to user-space. Sending the
> ? event (with 18 samples) takes us about 8.45 milliseconds.
>
> So far so good. ?But, according to my maths, 8.45ms is less than 10ms.

In practice the event is generated each 10ms because of the jiffies
resolution and the use of a timer but this might not be true if
someone uses the filters with a different driver/configuration.

> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? Sometimes we
> ? even decide that the event should not be sent to user-space (because the
> ? hardware didn't provide reliable data), and our tests show that it's the
> ? right thing to do. In previous versions of the driver light taps would
> ? confuse the driver (that would report bad clicks) and this is no longer an
> ? issue.
>
> Err, that doesn't seem to follow on from the previous point.
>
> The reason that we decided raw events should be passed to userspace and
> the processing done there is that it allows all of the _policy_ of
> deciding how to process touchscreen events to be configured. ?There's
> lots of different parameters and ways to filter touchscreens, and some
> are specific to individual touchscreen setups.

Yes, ignoring the event might not be the best thing to do if this is a policy.

"Giving up" could be implemented as sending a point of bad quality
instead of ignoring the event. It's better to implement "I give up
trying to get a better point for you" instead of "I driver decide you
should never know someone touched the screen because it was all
noise".

> This is why tslib is entirely modular, and allows any combination of
> modules to be loaded to process the touchscreen samples - it's there
> to provide a totally flexible infrastructure to filter and scale
> the output from the touchscreen in whatever way is required for the
> hardware.

There is one case where "whatever way" fails here. If you get a set of
points and you notice they have noise you can schedule more
conversions _right_away_ without latency to get new points from the
ADC. That's what the "group filter" does and you can not do that from
tslib and I say it after learning how to write tslib filters.

Most people who hear about the filters blindly say "this should be
done in user-space" without considering this fact.

> I don't think there is any single filtering system which can properly
> filter the output of any one touchscreen, and I don't think that putting
> this filtering in the kernel is a sane approach. ?It _may_ be a sane
> approach for one particular touchscreen setup, but it certainly isn't
> for all.

I've found the filters to be useful and I would like to see them
upstream but not if people don't find them to be useful.
