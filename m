From: rabin@rab.in (Rabin Vincent)
Date: Sun, 10 Jan 2016 16:43:26 +0100
Subject: [PATCH V7 02/24] coresight: associating path with session rather
 than tracer
In-Reply-To: <CANLsYkwN=SOnfDfd8oF-2Z5Ef8oTPao6H_auQhoMpVAnokYkrg@mail.gmail.com>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-3-git-send-email-mathieu.poirier@linaro.org>
 <20151220152939.GA11552@debian>
 <CANLsYkwhC0fSqrZrHH+P68Dev1j6n19o=2g8kJpZfzBMTbcNdA@mail.gmail.com>
 <20160105131505.GA32528@debian>
 <CANLsYkwN=SOnfDfd8oF-2Z5Ef8oTPao6H_auQhoMpVAnokYkrg@mail.gmail.com>
Message-ID: <20160110154326.GB13903@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 03:23:20PM -0700, Mathieu Poirier wrote:
> On 5 January 2016 at 06:15, Rabin Vincent <rabin@rab.in> wrote:
> > The command sequence is exactly as mentioned above.  The kernel is
> > v4.4rc-8 + all your patches from this thread + the OMAP coresight patch
> > I mentioned earlier.
> 
> What patch was that?  Would mind providing me with more information?

http://www.spinics.net/lists/kernel/msg2150809.html

> I fixed the kmalloc bug - it stemmed from a rebase conflict in the
> etm3x driver.  On the flip side I haven't been able to reproduce the
> lockdep problem.  But looking at the log you provided I can understand
> why the kernel is complaining.
> 
> I produced a patch [1] and added you as a reporter.  It would be great
> if you could give it a quick spin to see if the problem still persist.
> [1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/commit/914353d1b625eccb0d1dda71047408a52f8811d3

It does silence the warning but simply using mutex_trylock() instead of
mutex_lock() does not seem like the correct fix.  The lock dependency
problem lockdep is complaining about can be fixed for example by not
holding the coresight_mutex around the device_unregister()
coresight_unregister().  I don't quite see what the mutex is protecting
there?

BTW, there seem to be several problems with the unregistration:

  - csdev->refcnt which is allocated with kcalloc() in
    coresight_register() is never freed.

  - csdev->conns is freed before device_unregister() rather than in the
    release function. 

  - put_device() is not done on the csdev' conn->child_devs when it is
    unregistered, so the reference taken by the bus_find_device() in
    coresight_fixup_device_conns() is never released.

  - There is no reference taken for the csdev when it is assigned as
    some other device's child_dev in coresight_orphan_match()
