From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 16:28:38 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703104135.GA28175@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
Message-ID: <5534788.ziUvZhb6y0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 July 2014 11:41:35 Catalin Marinas wrote:
> 
> In my view, we don't break user space. It's rather a choice of how much
> legacy we support on ARMv8 hardware with an arm64 kernel. We don't even
> provide HWCAP_SWP for compat (not that anyone bothers checking that).
> It's a similar reason we choose not to support/emulate NWFPE or OABI
> even though there are existing binaries out there. If we choose to
> support SWP in the arm64 kernel, then we won't be able to break user
> space and have to carry it for a long time (unless you figure out a way
> to remove such features from the kernel because HWCAP certainly doesn't
> work, nor printk).
> 
> The ARM feature deprecation/removal cycle allows for two architecture
> revisions before being entirely removed. SWP has been deprecated in
> ARMv6, made optional in ARMv7 (with the possibility of disabling it if
> still available) and removed in ARMv8. The Thumb-1/2 instruction sets
> never had the SWP instruction. Even when SWP was available in certain
> ARMv7 implementations, it was no longer guaranteed to be atomic.

The problem really is that the ARM architecture deprecation method is
not compatible with the one we use in the kernel. I don't think there
is a good answer to that.

Note that other architectures have a different way of handling this
by never removing instructions. Obviously knowing that does not help
deal with the problem on ARM.

> > Android is not the embedded world where we could get away with a whole
> > lot. There is a *freaking huge* installed base of applications.
> > Breaking them is not an option, and I think Colin's question makes it
> > clear that Android is going make sure that doesn't happen regardless
> > of what the mainline kernel does... and they are right to do so.
> 
> I don't know how huge this installed base of applications is. AFAIK,
> it's limited to a (maybe significant) number of Android games all based
> on certain library which no longer uses SWP in its recent releases. I
> may be wrong but the information I have so far is that this huge base of
> applications does not go beyond Android. Furthermore, people getting a
> new Android phone with ARMv8 will have to re-download applications
> anyway, so the currently installed base does _not_ matter. What matters
> is what is provided in the Android _app store_.
>
> Note that I don't say Google should break those applications but they
> can carry a patch in their Android kernel while reaching out to
> developers to sort their code (can the Android app store be scanned?).
> What I don't want is to be in a situation 10 years from now when we
> still carry SWP emulation code that no-one uses but we can't remove
> because it would break the user space features we agreed upon.

The rule is still that we don't break stuff, it's not that we can't
make interface changes over a long period of time.

The way the ARM architecture feature deprecation works, we are pretty
much forced to make incompatible changes eventually, but we can
decide when to make them. Going from a 32-bit kernel to a 64-bit
kernel is a reasonable point for breaking compatibility with some
old features, but it's not the only option.

For someone shipping a device, it's pretty obvious that they want to
be as compatible as possible with existing applications, and they
definitely will patch their kernel to do this.

For someone shipping an Android SDK OTOH, it would be best to enforce
that no features that are deprecated in any architecture level are used,
and it would be good to provide a way for the kernel to allow that.
This has clearly not been the case in the past, and I find it hard
to blame the Android developers for that given the language in the
Kconfig help text ("if unsure, say Y", default y if SMP).\
It would be nice however to see that done now, to ensure that
all newly built applications are actually good in this regard.

There are two related questions that we have to ask ourselves:

a) I believe there are other instructions that are marked deprecated
   in ARMv8 and that will likely be removed at a later point. Can
   we add an option to the kernel to trap them all and either abort
   the program or emit a warning so we don't get another surprise
   like this when ARMv9 eventually comes out?

b) how do we deal with obsolete instructions in a the 32-bit kernel?
   Running a 32-bit kernel in a virtual machine on ARMv8 hardware
   should give a similar behavior to running them on a 64-bit kernel,
   so we probably have to deal with 32-bit ARMv8 environments as well.

> I have limited knowledge of Android user space but I think SWP emulation
> could also be implemented in user space via a SIGILL handler in the
> zygote thread and inherited by forked apps (performance doesn't really
> matter here). A similar example for Android is the binder driver
> user-kernel ABI. AFAIK, Google decided not to provide a compat ABI for
> the 64-bit compilation of this driver but update the AArch32 user-space
> library to use the new 64-bit ABI. That's perfectly fine by me, they
> chose not to provide such ABI in the kernel but solve it entirely in
> user space and could do the same with SWP.

I believe a difference here is that installable Android apps are not
expected to call the binder ioctls directly, so as long as the library
interface is unchanged, nothing is broken.

	Arnd
