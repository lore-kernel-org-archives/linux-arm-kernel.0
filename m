From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 Jul 2014 10:36:03 +0100
Subject: Kexec on arm64
In-Reply-To: <1406162287.4062.39.camel@smoke>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
Message-ID: <20140724093603.GC4079@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 01:38:07AM +0100, Geoff Levand wrote:
> Hi Arun,
> 
> On Tue, 2014-07-22 at 18:55 +0530, Arun Chandran wrote:
> 
> > I tried the same dtb with UP configuration. For UP kernel to compile
> > did the below modifications
> 
> I'll test and fixup the kexec UP build in the next few days.
> 
> ...
> 
> > With the default target configuration "kexec -e" failed to execute
> > in UP scenario also.

It would be helpful to know _how_ it failed. Do you have any log output?

> > 
> > But I had some luck when I did the same steps with L3 cache
> > disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
> > it has an L3 cache. Luckily I was able to disable it in u-boot.
> > 
> > With the L3 cache disabled configuration I am able to
> > do "kexec -e". Please see the log attached.

Hmm. We don't expect the kernel to do any L3 management. It seems that
memory subsystems with L3 caches respecting cache maintenance by VA are
going to become relatively common, and we expect to handle them all by
performing maintenance by VA. See commit c218bca74eea (arm64: Relax the
kernel cache requirements for boot) for what we do at boot time.

> 
> All memory management for the main cpu is done by the arch code.  Kexec
> and cpu hot plug only work with the secondary cpus, so the problem would
> be in the arch memory code, either in setup_restart() for shutdown, or
> in the startup code.

It's possible that soft_restart and setup_restart are a little dodgy, as
they also rely on the compiler being smart and not touching the stack
after setup_restart().

However, they provide absolutely no guarantee that any data has been
flushed out to the PoC [1]. If you require any data to be flushed out to the
PoC so as to be visible to noncacheable accesses, you will need to
ensure that this is flushed by VA before soft_restart is called. Data
may have migrated to another cache (e.g. another CPU, or the L3) where
it is not visible.

> 
> I guess setup_restart() is not doing something it needs to do for your
> platform.

Unless you can see soft_restart/setup_restart making stack accesses
after the first flush_cache_all call, I suspect your code is not
flushing some data it requires.

I'd been meaning to clean up soft_restart and setup_restart for a while.
I'll have a go at cleaning them up along with any remaining
flush_cache_all abuse in arm64.

Thanks,
Mark.
