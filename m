From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Apr 2018 21:28:32 +0200
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for
 Apr 4
In-Reply-To: <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
References: <20180404175852.GI5700@atomide.com> <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com> <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
 <20180420191523.GA28597@amd>
 <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
Message-ID: <20180420192832.GA1870@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-04-20 15:18:32, Daniel Micay wrote:
> On 20 April 2018 at 15:15, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> >> Hi! Sorry I lost this email in my inbox. It seems this is specific to
> >> >> a particular subset of arm architectures? (My local builds of arm all
> >> >> succeed, for example. Can you send your failing config?) I'll take a
> >> >> closer look on Monday if Daniel doesn't beat me to it.
> >> >
> >> > Daniel, Kees: any news?
> >> >
> >> > I'm aware you did not specify which Monday :-).
> >>
> >> Hi! Sorry, I got distracted. So the .config you sent me builds fine
> >> with my cross compiler. I suspect this is something specific to ELDK's
> >> compiler. I can try some other compiler versions. What version of gcc
> >> is failing?
> >
> > I have:
> >
> > pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
> > arm-linux-gnueabi-gcc (GCC) 4.7.2
> > Copyright (C) 2012 Free Software Foundation, Inc.
> > pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
> > GNU ld (GNU Binutils) 2.23.1.20121113
> > Copyright 2012 Free Software Foundation, Inc.
> >
> > Let me try with eldk-5.6:
> >
> > pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
> > arm-linux-gnueabi-gcc (GCC) 4.8.2
> > pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
> > GNU ld (GNU Binutils) 2.24
> >
> > make  lib/string.o
> >
> > Seems to succeed, so I guess full build will succeed, too...
> 
> It doesn't imply that a full build would work.

You are right. eldk-5.6 does not have problem with string.o, but does
not compile the kernel, either...

  CC      arch/arm/kernel/asm-offsets.s
  arch/arm/kernel/asm-offsets.c:56:2: error: #error Your compiler is
  too buggy; it is known to miscompile kernels
   #error Your compiler is too buggy; it is known to miscompile
  kernels
    ^
    arch/arm/kernel/asm-offsets.c:57:2: error: #error and result in
  filesystem corruption and oopses.
   #error and result in filesystem corruption and oopses.
     ^

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/ce2edd82/attachment-0001.sig>
