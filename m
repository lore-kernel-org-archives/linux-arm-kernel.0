From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 31 Oct 2017 10:45:22 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <20171031165629.GF9463@n2100.armlinux.org.uk>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <CA+55aFzy9=RtFRuJhFbF+PL_PCrkZsKtAKrq6WJo1z9eW9gLSA@mail.gmail.com>
 <20171031165629.GF9463@n2100.armlinux.org.uk>
Message-ID: <CA+55aFwDquBXt_EYT3JFoWkeFsZTym5qUXig-DePXXzm07uABw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 9:56 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> Marc is stating something that's incorrect there.  On ARM32, we don't
> have a TSC, and we aren't guaranteed to have a timer usable for delays.
> Where there is a suitable timer, it can be used for delays.
>
> However, where there isn't a timer, we fall back to using the software
> loop, and that's where the problem lies.  For example, some platforms
> have a relatively slow timer (32kHz).

Right.

So that is actually the basic issue: there is no way for us to really
_ever_ give any kind of guarantees about the behavior of
udelay/ndelay() in every general case.

We can't even guarantee some kind of "at least" behavior, because on
some platforms there is no reasonable stable clock at all.

We can give good results in certain _particular_ cases, but not in
some kind of blanket "we will always do well" way.

Traditionally, we used to obviously do the bogo-loop, but it depends
on processor frequency, which can (and does) change even outside SW
control, never mind things like interrupts etc.

On lots of platforms, we can generally do platform-specific clocks. On
modern x86, as mentioned, the TSC is stable and fairly high frequency
(it isn't really the gigahertz frequency that it reports - reading it
takes time, and even ignoring that, the implementation is actually not
a true adder at the reported frequency, but it is generally tens of
hundreds of megahertz, so you should get something that is close to
the "tens of nanoseconds" resolution).

But on others we can't even get *close* to that kind of behavior, and
if the clock is something like a 32kHz timer that you mention, you
obviously aren't going to get even microsecond resotulion, much less
nanoseconds.

You can (and on x86 we do) calibrate a faster non-architected clock
against a slow clock, but all the faster clocks tend to have that
frequency shifting issue.

So then you tend to be forced to simply rely on platform-specific
hacks if you really need something more precise. Most people don't,
which is why most people just use udelay() and friends.

In particular, several drivers end up depending not on an explicit
clock at all, but on the IO fabric itself. For a driver for a
particular piece of hardware, that is often the sanest way to do
really short timing: if you know you are on a PCI bus and you know
your own hardware, you can often do things like "reading the status
register takes 6 bus cycles, which is 200 nsec". Things like that are
very hacky, but for a driver that is looking at times in the usec
range, it's often the best you can do.

Don't get me wrong. I think

 (a) platform code could try to make their udelay/ndelay() be as good
as it can be on a particular platform

 (b) we could maybe export some interface to give estimated errors so
that drivers could then try to corrtect for them depending on just how
much they care.

so I'm certainly not _opposed_ to trying to improve on
udelay/ndelay(). It's just that for the generic case, we know we're
never going to be very good, and the error (both absolute and
relative) can be pretty damn big.

One of the issues has historically been that because so few people
care, and because there are probably more platforms than there are
cases that care deeply, even that (a) thing is actually fairly hard to
do. On the x86 side, for example, I doubt that most core kernel
developers even have access to platforms that have unstable TSC's any
more. I certainly don't. I complained to Intel for many many _years_,
but they finally did fix it, and now it's been a long time since I
cared.

That's why I actually would encourage driver writers that really care
deeply about delays to look at ways to get those delays from their own
hardware (ie exactly that "read the status register three times" kind
of model). It sounds hacky, but it couples the timing constraint with
the piece of hardware that actually depends on it, which means that
you don't get the nasty kinds of "worry about each platform"
complications.

I realize that this is not what people want to hear. In a perfect
world, we'd just make "ndelay()" work and give the right behavior, and
have some strictly bounded error.

It's just that it's really fundamentally hard in the general case,
even if it sounds like it should be pretty trivial in most
_particular_ cases.

So I'm very much open to udelay improvements, and if somebody sends
patches for particular platforms to do particularly well on that
platform, I think we should merge them. But ...

                Linus
