From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 3 Jul 2014 17:22:30 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703104135.GA28175@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk> <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk> <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
Message-ID: <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 3, 2014 at 11:41 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> (I've been away for a day and missed all the fun ;))
>
> On Wed, Jul 02, 2014 at 11:14:47PM +0100, Grant Likely wrote:
>> Android is not the embedded world where we could get away with a whole
>> lot. There is a *freaking huge* installed base of applications.
>> Breaking them is not an option, and I think Colin's question makes it
>> clear that Android is going make sure that doesn't happen regardless
>> of what the mainline kernel does... and they are right to do so.
>
> I don't know how huge this installed base of applications is. AFAIK,
> it's limited to a (maybe significant) number of Android games all based
> on certain library which no longer uses SWP in its recent releases. I
> may be wrong but the information I have so far is that this huge base of
> applications does not go beyond Android. Furthermore, people getting a
> new Android phone with ARMv8 will have to re-download applications
> anyway, so the currently installed base does _not_ matter. What matters
> is what is provided in the Android _app store_.

Okay, I have to bite on this one....

Ah, no. The installed base *does* matter. Breaking things under the
assumption that they can be fixed with an update is a horrible reason
for breaking stuff. That creates hell for developers.

The first indication they'll have that something is wrong is they'll
start getting negative reviews in the Play store ("This software is
****, it crashes immediately"). Then they've got to figure out why
things have gone wrong. It won't necessarily be obvious that the
complaining users have v8 hardware. Obtain a v8 device, and then
figure out how to update all of their affected apps. During that
entire time their app is broken and they are getting blamed by users
for putting out crap software. And that assumes that the app is
actively maintained. Multiply this by every affected developer.

Then there are the apps that work just fine, but don't have any active
maintenance, either because it is an old project that doesn't have a
team on it anymore or the vendor has disappeared. Do you really think
it is okay to break working apps that are probably not going to get
updated?

Third, there are side loaded apps. An update may not be readily or
easily available. The Play store is not the only game in town. There
are also kioskified Android devices that are basically stock, but have
a custom application installed on it. There is also the Amazon app
store.

Finally, stating that "the developer can just fix it" is a huge
assumption. You're basically saying every app development shop has
extra resources to go back and fix things in their older apps.

So, no. I completely reject any notion that breaking existing apps is
okay. If we're going to say that v8 still supports 32-bit apps, then
it has to be all of v7, not just the 'good' bits. Nor do I think
saying "it's just a bunch of games" justifies anything. We're kernel
engineers. Applications are applications and we don't break userspace.
Period.

> Note that I don't say Google should break those applications but they
> can carry a patch in their Android kernel while reaching out to
> developers to sort their code (can the Android app store be scanned?).
> What I don't want is to be in a situation 10 years from now when we
> still carry SWP emulation code that no-one uses but we can't remove
> because it would break the user space features we agreed upon.

Welcome to system programming. This is what we do. It is a *good*
thing that an x86 userspace from 1995 can still be booted.

> I have limited knowledge of Android user space but I think SWP emulation
> could also be implemented in user space via a SIGILL handler in the
> zygote thread and inherited by forked apps (performance doesn't really
> matter here). A similar example for Android is the binder driver
> user-kernel ABI. AFAIK, Google decided not to provide a compat ABI for
> the 64-bit compilation of this driver but update the AArch32 user-space
> library to use the new 64-bit ABI. That's perfectly fine by me, they
> chose not to provide such ABI in the kernel but solve it entirely in
> user space and could do the same with SWP.

Really? Why would we even want that? We're far better positioned in
the kernel to present the correct behaviour that any trapping from a
userspace application.

g.
