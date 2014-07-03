From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Jul 2014 11:41:35 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
Message-ID: <20140703104135.GA28175@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(I've been away for a day and missed all the fun ;))

On Wed, Jul 02, 2014 at 11:14:47PM +0100, Grant Likely wrote:
> On Wed, Jul 2, 2014 at 6:01 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 02, 2014 at 05:39:23PM +0100, Mark Brown wrote:
> >> On Wed, Jul 02, 2014 at 11:01:33AM +0100, Will Deacon wrote:
> >>
> >> >   (1) The hardware doesn't have the instruction at all. If we start
> >> >       emulating it, then we'll always have to emulate it and it doesn't
> >> >       encourage software migration.
> >>
> >> That's what the logging other architectures did in similar situations
> >> was intended to help address - even if people don't care about the
> >> performance impact having loud complaints in the logs tends to cause
> >> some useful subset of users to report it as a problem.
> >
> > I don't think logging something to dmesg is going to make a blind bit of
> > difference on an Android device. Maybe we could get SWP emulation to request
> > access to the users contacts and send everybody a text message each time
> > they issue the instruction?
> >
> > Seriously though, nothing causes loud complaints like a SIGILL. This thread
> > is evidence of that.
> 
> I think that looks at the problem entirely the wrong way around. We
> don't break userspace. That's been a rule for a very long time.

In my view, we don't break user space. It's rather a choice of how much
legacy we support on ARMv8 hardware with an arm64 kernel. We don't even
provide HWCAP_SWP for compat (not that anyone bothers checking that).
It's a similar reason we choose not to support/emulate NWFPE or OABI
even though there are existing binaries out there. If we choose to
support SWP in the arm64 kernel, then we won't be able to break user
space and have to carry it for a long time (unless you figure out a way
to remove such features from the kernel because HWCAP certainly doesn't
work, nor printk).

The ARM feature deprecation/removal cycle allows for two architecture
revisions before being entirely removed. SWP has been deprecated in
ARMv6, made optional in ARMv7 (with the possibility of disabling it if
still available) and removed in ARMv8. The Thumb-1/2 instruction sets
never had the SWP instruction. Even when SWP was available in certain
ARMv7 implementations, it was no longer guaranteed to be atomic.

> Android is not the embedded world where we could get away with a whole
> lot. There is a *freaking huge* installed base of applications.
> Breaking them is not an option, and I think Colin's question makes it
> clear that Android is going make sure that doesn't happen regardless
> of what the mainline kernel does... and they are right to do so.

I don't know how huge this installed base of applications is. AFAIK,
it's limited to a (maybe significant) number of Android games all based
on certain library which no longer uses SWP in its recent releases. I
may be wrong but the information I have so far is that this huge base of
applications does not go beyond Android. Furthermore, people getting a
new Android phone with ARMv8 will have to re-download applications
anyway, so the currently installed base does _not_ matter. What matters
is what is provided in the Android _app store_.

Note that I don't say Google should break those applications but they
can carry a patch in their Android kernel while reaching out to
developers to sort their code (can the Android app store be scanned?).
What I don't want is to be in a situation 10 years from now when we
still carry SWP emulation code that no-one uses but we can't remove
because it would break the user space features we agreed upon.

I have limited knowledge of Android user space but I think SWP emulation
could also be implemented in user space via a SIGILL handler in the
zygote thread and inherited by forked apps (performance doesn't really
matter here). A similar example for Android is the binder driver
user-kernel ABI. AFAIK, Google decided not to provide a compat ABI for
the 64-bit compilation of this driver but update the AArch32 user-space
library to use the new 64-bit ABI. That's perfectly fine by me, they
chose not to provide such ABI in the kernel but solve it entirely in
user space and could do the same with SWP.

-- 
Catalin
