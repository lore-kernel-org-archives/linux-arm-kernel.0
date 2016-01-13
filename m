From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 13 Jan 2016 14:47:10 -0700
Subject: [PATCH V7 02/24] coresight: associating path with session rather
 than tracer
In-Reply-To: <20160110154326.GB13903@debian>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-3-git-send-email-mathieu.poirier@linaro.org>
 <20151220152939.GA11552@debian>
 <CANLsYkwhC0fSqrZrHH+P68Dev1j6n19o=2g8kJpZfzBMTbcNdA@mail.gmail.com>
 <20160105131505.GA32528@debian>
 <CANLsYkwN=SOnfDfd8oF-2Z5Ef8oTPao6H_auQhoMpVAnokYkrg@mail.gmail.com>
 <20160110154326.GB13903@debian>
Message-ID: <CANLsYkz2t1ytWUiV-i2tfe4J1Yfuyg6fiWL0nrNGA9QCph-XWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 January 2016 at 08:43, Rabin Vincent <rabin@rab.in> wrote:
> On Tue, Jan 05, 2016 at 03:23:20PM -0700, Mathieu Poirier wrote:
>> On 5 January 2016 at 06:15, Rabin Vincent <rabin@rab.in> wrote:
>> > The command sequence is exactly as mentioned above.  The kernel is
>> > v4.4rc-8 + all your patches from this thread + the OMAP coresight patch
>> > I mentioned earlier.
>>
>> What patch was that?  Would mind providing me with more information?
>
> http://www.spinics.net/lists/kernel/msg2150809.html
>
>> I fixed the kmalloc bug - it stemmed from a rebase conflict in the
>> etm3x driver.  On the flip side I haven't been able to reproduce the
>> lockdep problem.  But looking at the log you provided I can understand
>> why the kernel is complaining.
>>
>> I produced a patch [1] and added you as a reporter.  It would be great
>> if you could give it a quick spin to see if the problem still persist.
>> [1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/commit/914353d1b625eccb0d1dda71047408a52f8811d3
>
> It does silence the warning but simply using mutex_trylock() instead of
> mutex_lock() does not seem like the correct fix.  The lock dependency
> problem lockdep is complaining about can be fixed for example by not
> holding the coresight_mutex around the device_unregister()
> coresight_unregister().  I don't quite see what the mutex is protecting
> there?

You are correct, locking at that point doesn't help anything.

>
> BTW, there seem to be several problems with the unregistration:
>
>   - csdev->refcnt which is allocated with kcalloc() in
>     coresight_register() is never freed.
>
>   - csdev->conns is freed before device_unregister() rather than in the
>     release function.

I agree.

>
>   - put_device() is not done on the csdev' conn->child_devs when it is
>     unregistered, so the reference taken by the bus_find_device() in
>     coresight_fixup_device_conns() is never released.

Right, I'll fix that.

>
>   - There is no reference taken for the csdev when it is assigned as
>     some other device's child_dev in coresight_orphan_match()
>

The only time a device shouldn't be removed is when it is part of an
active trace session, something that shouldn't happen due to the
static nature of the coresight devices.  When coresight_unregister()
is called the framework should go through the topology and remove
references to the device that is being taken away, something that I
will fix promptly.

That way in 'coresight_fixup_device_conns()', put_device() can be
called when a match is found and references don't have to be taken in
'coresight_orphan_match()' when a device is assigned as a child.

Thanks for the review,
Mathieu
