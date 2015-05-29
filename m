From: rob@landley.net (Rob Landley)
Date: Thu, 28 May 2015 22:31:11 -0500
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <55670AD4.8020705@melag.de>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com>
 <1432322832.5304.63.camel@opteya.com>
 <CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>
 <55670AD4.8020705@melag.de>
Message-ID: <CAOS_Y6QXHdWfi9qkRmw=mCn0mqha5-NrzumBMqJ61_YRndypLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-28 7:32 GMT-05:00 Enrico Weigelt, metux IT consult <weigelt@melag.de>:
> Am 25.05.2015 um 09:14 schrieb Rob Landley:
>
>> Personally, I'm sad we're starting to get ACPI for arm but if device
>> tree data files are only available under GPL, people will hold their
>> nose and deploy ACPI.
>
>
> What's the big deal with having DTS/DTB under GPL ?

One problem is that there's no such thing as "The GPL" anymore. The
Linux kernel and Samba can't share code anymore, even though they
implement two ends of the same protocol, thanks to GPLv3.

This seems to have badly damaged the long term viability of GPLv2,
which used to be synonymous with copyleft (category killer license)
and acted as a universal receiver because it was a terminal node in a
directed graph of license convertibility reducing most licensing
decisions to a simple binary "is it GPL compatible or not", which
greatly appealed to developers who aren't lawyers and don't want to
be.

But now a project that's "GPLv2 or later" can't accept code from
_either_ the kernel or samba (neither provides the implicit dual
license they need). Projects like QEMU are stuck between wanting to
turn kernel drivers inside out to make device emulations (GPLv2 code)
and grab processor definitions from gcc or binutils (GPLv3 code) and
one project cannot accept both because GPL + GPL is a license
conflict.

In the absence of a universal receiver license, new developers
entering the community are mostly either opting for universal donor
(BSD-like*) licenses, or taking a Napster approach lumping copyright
in with software patents as "too dumb to live" and refusing to specify
any license at all. (The owners of github are trying very hard to make
"no license specified" stop being the most popular license on github.)

Of course "BSD-like" would be public domain except for 20 years of
FUD, so they're mostly choosing one of the dozens of public domain
equivalent licenses like the various BSDs and MIT and ISC and Apache
that are equivalent except for "copy this license text exactly"
clauses that cause endless license bloat over time. (I asked the
Android developers why
https://github.com/android/platform_system_core/blob/master/toolbox/NOTICE
had so many concatenated copies of seemingly identical license text,
and the answer was "the date at the top changed, and a strict reading
of the license says..." And if you think that's bad, somebody showed
me the about->license pulldown on their "kindle paperwhite" with over
THREE HUNDRED PAGES of concatenated licenses.)

Personally I prefer public domain equivalent licenses like CC0 or
unlicense.org or my own "zero clause bsd", which DON'T require you to
copy specific license text verbatim into derived works. When combining
BSD with other BSD it's merely annoying, but when combining BSD with
GPL? I'm still waiting for some troll to inherit somebody's copyrights
and sue a GPL developer for incorporating BSD code into a GPL project
and ignoring the "no additional restrictions" of GPL clashing with the
"copy this license text exactly into all derived works" of BSD, and
pointing to the BSDI vs AT&T lawsuit to go "no really, this matters,
pay up now". But sure, SCO was unique, it's not like dying business
models exploding into a cloud of intellectual property litigation
happens all the time. Oh wait.

So in general, there are a lot of people out there not wanting to get
any of this crap on them. And if you try to punish them for not doing
things your way, they write a crappy new one that gets widely deployed
as a "standard" anyway, and welcome back to the unix fragmentation of
the 1980's.

Most of this can be laid at the door of GPLv3.  Android's "no gpl in
userspace" policy is why they ripped out bluez and wrote a replacement
bluedroid from scratch. The bluez developers keep going "if we just
improve the code enough people will get over the license" (no really:
https://lwn.net/Articles/597293/) but their FAQ literally doesn't
specify _which_ GPL they're under: http://www.bluez.org/faq/common/
(Is it the one you can't use with kernel code, the one you can't
combine with samba code, or the or-later version that can't accept
code from either source into its next release? Do they even know? have
they been tracking this? Have they already accepted conflictingly
licensed patches without knowing it and somebody is going to sue _you_
instead of suing the upstream the way microsoft and oratroll went
after all the android vendors for cash but refused to allow google to
step in and defend them?)

Apple's great GPL purge
(http://meta.ath0.com/2012/02/05/apples-great-gpl-purge/) is why we
have LLVM replacing gcc, they literally stopped xcode on the last
GPLv2 releases (gcc 4.2.1 and binutils 2.17) for over five years while
they sponsored work on a replacement. When samba went gplv3, they did
http://www.osnews.com/story/24572/Apple_Ditches_SAMBA_in_Favour_of_Homegrown_Replacement
for samba and so on. But they _start_ by targeting GPLv3 code, and
then continue on to remove GPLv2 code because it's tarred with the
same brush.

The pro-gpl guys have tried various coercion tactics to get their way,
which hasn't helped. The FSF sued CISCO in 2008 over the same 2003
vendor BSP that had already been beaten out of them to produce OpenWRT
(and remember when I said you don't sue the upstream you sue the
individual customers when maximizing your payout? The BSP was from
Broadcom, so the FSF sued Cisco). Lesson: "These guys will never be
satisifed, they will come back years later for another bite at the
same apple, you only _think_ you're safe if you're using their stuff."
The FSF also retroactively deleted binutils 2.17 (the last GPLv2
version) off their ftp site and replaced it with a binutils 2.17a
containing GPLv3 code, which they symlinked from the old name. (No
really. They did the same thing with gdb 6.6 except there they didn't
put a symlink, http://ftp.gnu.org/gnu/gdb/ . Remember how I said qemu
wanted machine definitions they could get from _which_ two packages?
QEMU went GPLv2 only to stay compatible with the kernel.) The FSF's
"You _WILL_ bow down before version 3!" push included its own
sourceforge clone declaring GPLv2 only an unacceptable license (but
BSD still was, yes really, https://lwn.net/Articles/176582/) and don't
forget what the FSF did to Mepis
http://archive09.linux.com/articles/55285 (sued them for not mirroring
UNMODIFIED source tarballs readily available on the upstream website).

The moral here is that large portions of the industry are now
convinced GPL advocates can't be trusted. They desperately do not want
to get any of this _on_ them. The kernel is grandfathered in, in part
because it's always tolerated (if not enjoyed) binary modules, but do
you really think that if Android decided "time to switch to BSD" it
would take them longer than 18 months to port everything they care
about? They re-port every kernel release...

I gave a talk about this at Ohio LinuxFest in 2013:

outline: http://landley.net/talks/ohio-2013.txt
audio: https://archive.org/download/OhioLinuxfest2013/24-Rob_Landley-The_Rise_and_Fall_of_Copyleft.mp3

> Important Notice: This message may contain confidential or privileged
> information. It is intended only for the person it was addressed to. If you
> are not the intended recipient of this email you may not copy, forward,
> disclose or otherwise use it or any part of it in any form whatsoever. If
> you received this email in error please notify the sender by replying and
> delete this message and any attachments without retaining a copy.

P.S. some of us actually care about licenses being appropriate to what
they're applied to, and at least theoretically capable of being
honored. Your email footer may be very slightly undermining your
position here.

Rob
