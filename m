From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Jun 2016 14:27:10 +0100
Subject: [RFC PATCH] clocksource: arm_arch_timer: disable the evtstrm via
 the cmdline
In-Reply-To: <5767E89F.5020809@linaro.org>
References: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
 <5766FBC6.6000405@linaro.org> <20160620082157.GC29165@arm.com>
 <5767E89F.5020809@linaro.org>
Message-ID: <20160620132710.GA9246@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 02:59:11PM +0200, Daniel Lezcano wrote:
> On 06/20/2016 10:21 AM, Will Deacon wrote:
> >On Sun, Jun 19, 2016 at 10:08:38PM +0200, Daniel Lezcano wrote:
> >>On 06/17/2016 03:43 PM, Will Deacon wrote:
> >>
> >>[ Cc'ed tglx ]
> >>
> >>>Disabling the eventstream can be useful for debugging and development
> >>>purposes
> >>
> >>If it is for debugging and development, why upstream this change ?
> >
> >Mainly because it's desirable to be able to debug systems remotely, on
> >machines that you don't have direct access to and where recompiling the
> >kernel isn't necessarily an option. There are plenty of "no*" kernel
> >parameters already that fall into a similar category.
> 
> Hi Will,
> 
> if the kernel is in development and debug, why this option can't be
> part of debugging code ?
> 
> If recompiling isn't an option, how this can be for "debugging and
> development" ?

We already have the config option for the cases you wish to set this at
build time, and people use it.

There are situations where you do not know at build time that you want
this, e.g. debugging in the field, for which recompilation may change
the code in other ways (e.g. layout of data and functions).

For example, if we get a bug report that a production kernel wedges in
spinlock code after running for 10 hours, being able to say "pass
noevstrm" is much better than trying to get the end-user to recompile
their kernel, which may or may not be possible, and may (for other
reasons), mask the issue we wish to debug.

The code size impact is negligible, and there is no runtime performance
impact if this option is not used.

> I'm not a big fan of the all the specific driver options for the
> kernel parameters. If there is a real need to disable some parts of
> a driver, it would be much more interesting to write a framework for
> that and then use it from arm_arch_timer, thus giving the other
> drivers the opportunity to provide the same feature.

I'm not aware of other devices which have an event stream option.

Additionally, the architected timer is at least slightly special in that
it is architected, and this HW features was designed with architectural
implications in mind (e.g. the behaviour of locking primitives). So
while this happens to live in the driver code, it's in effect an
architecture option (note that we have HWCAP_EVTSTREAM).

Thanks,
Mark.
