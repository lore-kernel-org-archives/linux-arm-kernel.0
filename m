From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 04 Jul 2014 14:22:50 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703174318.GE28175@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk> <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk> <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703174318.GE28175@arm.com>
Message-ID: <20140704132250.A2447C40ADD@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014 18:43:18 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:
> > On Thu, Jul 3, 2014 at 11:41 AM, Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > > (I've been away for a day and missed all the fun ;))
> > >
> > > On Wed, Jul 02, 2014 at 11:14:47PM +0100, Grant Likely wrote:
> > >> Android is not the embedded world where we could get away with a whole
> > >> lot. There is a *freaking huge* installed base of applications.
> > >> Breaking them is not an option, and I think Colin's question makes it
> > >> clear that Android is going make sure that doesn't happen regardless
> > >> of what the mainline kernel does... and they are right to do so.
> > >
> > > I don't know how huge this installed base of applications is. AFAIK,
> > > it's limited to a (maybe significant) number of Android games all based
> > > on certain library which no longer uses SWP in its recent releases. I
> > > may be wrong but the information I have so far is that this huge base of
> > > applications does not go beyond Android. Furthermore, people getting a
> > > new Android phone with ARMv8 will have to re-download applications
> > > anyway, so the currently installed base does _not_ matter. What matters
> > > is what is provided in the Android _app store_.
> > 
> > Okay, I have to bite on this one....
> > 
> > Ah, no. The installed base *does* matter. Breaking things under the
> > assumption that they can be fixed with an update is a horrible reason
> > for breaking stuff. That creates hell for developers.
> 
> My point is that you *cannot* upgrade your phone from ARMv7 to ARMv8
> without re-downloading the apps. You don't carry over your filesystem
> (installed base) on an SD card from the old phone to the new one. That's
> where Google has some control I didn't say that Google should break
> those apps but actively try to update them (in the meantime, they could
> provide some form of SWP emulation).

Look at Colin's original email. There are apps in the app store that
work fine now, but have seen zero updates in the last 2 years. It is
very unlikely that they will be upgraded. They will break on a v8 phone.
This is a software ecosystem issue. Yes of course Google should be
encouraging those apps to be updated, but the reality is there will be a
non-trivial percentage of them which never will be. Breaking those
applications is hostile to the platform.

I'm concerned that this whole debate shows contempt for any kind of
platform stability. For the first time *ever* (and, arguably, despite
our best efforts) we have a huge ISV ecosystem for Linux. Even more
amazingly, it's built around ARM, not x86! Woo! For years we hoped this
would happen. So then we choose to dump all over it by deciding old binaries
don't matter? For shame.

> > So, no. I completely reject any notion that breaking existing apps is
> > okay. If we're going to say that v8 still supports 32-bit apps, then
> > it has to be all of v7, not just the 'good' bits. Nor do I think
> > saying "it's just a bunch of games" justifies anything. We're kernel
> > engineers. Applications are applications and we don't break userspace.
> > Period.
> 
> Here you need to define user-space. OABI?

This is where we can be pragmatic. Listen to our users. Colin was very
clear about what some apps need in order to keep working. He's not even
asking for old kernels or system libraries to be supported because he
has control over those components and they can be fixed. The important
ABI is the ABI used by Android applications.

We can drop ABIs that nobody uses. If nobody complains, is it really
broken?

> > > Note that I don't say Google should break those applications but they
> > > can carry a patch in their Android kernel while reaching out to
> > > developers to sort their code (can the Android app store be scanned?).
> > > What I don't want is to be in a situation 10 years from now when we
> > > still carry SWP emulation code that no-one uses but we can't remove
> > > because it would break the user space features we agreed upon.
> > 
> > Welcome to system programming. This is what we do. It is a *good*
> > thing that an x86 userspace from 1995 can still be booted.
> 
> I'm not sure how much of it is just the merit of Linux but rather the
> hardware backwards compatibility. As you can see with SWP, we don't
> always have this on ARM (and don't blame the kernel maintainers for this
> ;)).
> 
> The same question again - shall we support OABI or we just add ABI
> features based on who shouts louder?

Yes. Listen to the people who shout. When they shout acknowledge it as a
bug and fix it. I'll defer to rmk on the OABI question. I don't think there
is a OABI ecosystem that needs to be carried over to v8, but I'm not
informed enough to take a position.

> > > I have limited knowledge of Android user space but I think SWP emulation
> > > could also be implemented in user space via a SIGILL handler in the
> > > zygote thread and inherited by forked apps (performance doesn't really
> > > matter here). A similar example for Android is the binder driver
> > > user-kernel ABI. AFAIK, Google decided not to provide a compat ABI for
> > > the 64-bit compilation of this driver but update the AArch32 user-space
> > > library to use the new 64-bit ABI. That's perfectly fine by me, they
> > > chose not to provide such ABI in the kernel but solve it entirely in
> > > user space and could do the same with SWP.
> > 
> > Really? Why would we even want that? We're far better positioned in
> > the kernel to present the correct behaviour that any trapping from a
> > userspace application.
> 
> Because by adding it to the kernel we declare it ABI (rather than just
> an Android issue on ARMv8 hardware; I'm not currently aware of other
> ARMv7 Linux distros affected).

It's already an ABI. That's the point. Cat, bag, out.

Arguing that other distros don't have the problem is bogus because it
presumes all distros have an ISV ecosystem. Despite trying, none of them
have been able to achieve that yet.

g.
