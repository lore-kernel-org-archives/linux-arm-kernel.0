From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 7 Dec 2010 10:45:42 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <4CFD87A6.8030104@codesourcery.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101203165105.GD30898@n2100.arm.linux.org.uk>
	<AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
	<4CFBAC6D.5060507@codesourcery.com>
	<AANLkTi=woxGqfpd12tr32FymOx77UnVehvEFQt5GnRzG@mail.gmail.com>
	<4CFD87A6.8030104@codesourcery.com>
Message-ID: <AANLkTikh-a++NQj+cUJOf9B3tjr_=CvAqJmjhLGA0Xt7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 7, 2010 at 1:02 AM, Mark Mitchell <mark@codesourcery.com> wrote:
> On 12/6/2010 5:07 AM, Dave Martin wrote:
>
>>> But,
>>> to enable binary distribution, having to have N copies of a library (let
>>> alone an application) for N different ARM core variants just doesn't
>>> make sense to me.
>>
>> Just so, and as discussed before improvements to package managers
>> could help here to avoid installing duplicate libraries. ?(I believe
>> that rpm may have some capability here (?) but deb does not at
>> present).
>
> Yes, a smarter package manager could help a device builder automatically
> get the right version of a library. ?But, something more fundamental has
> to happen to avoid the library developer having to *produce* N versions
> of a library. ?(Yes, in theory, you just type "make" with different
> CFLAGS options, but in practice of course it's often more complex than
> that, especially if you need to validate the library.)

Yes-- though I didn't elaborate on it.  You need a packager that can
understand, say, that a binary built for ARMv5 EABI can interoperate
with ARMv7 binaries etc.
Again, I've heard it suggested that RPM can handle this, but I haven't
looked at it in detail myself.

>
>> Currently, I don't have many examples-- the main one is related to the
>> discussions aroung using NEON for memcpy(). ?This can be a performance
>> win on some platforms, but except when the system is heavily loaded,
>> or when NEON happens to be turned on anyway, it may not be
>> advantageous for the user or overall system performance.
>
> How good of a proxy would the length of the copy be, do you think? ?If
> you want to copy 1G of data, and NEON makes you 2x-4x faster, then it
> seems to me that you probably want to use NEON, almost independent of
> overall system load. ?But, if you're only going to copy 16 bytes, even
> if NEON is faster, it's probably OK not to use it -- the function-call
> overhead to get into memcpy at all is probably significant relative to
> the time you'd save by using NEON. ?In between, it's harder, of course
> -- but perhaps if memcpy is the key example, we could get 80% of the
> benefit of your idea simply by a test inside memcpy as to the length of
> the data to be copied?

For the memcpy() case, the answer is probably yes, though how often
memcpy is called by a given thread is also of significance.

However, there's still a problem: NEON is not designed for
implementing memcpy(), so there's no guarantee that it will always be
faster ... it is on some SoCs in some situations, but much less
beneficial on others -- the "sweet spots" both for performance and
power may differ widely from core to core and from SoC to SoC.  So
running benchmarks on one or two boards and then hard-compiling some
thresholds into glibc may not be the right approach.  Also, gcc
implements memcpy directly too for some cases (but only for small
copies?)

The dynamic hwcaps approach doesn't really solve that problem: for
adapting to different SoCs, you really want a way to run a benchmark
on the target to make your decision (xine-lib chooses an internal
memcpy implementation this way for example), or a way to pass some
platform metrics to glibc / other affected libraries.  Identifying the
precise SoC from /proc/cpuinfo isn't always straightforward, but I've
seen some code making use of it in similar ways.

Cheers
---Dave
