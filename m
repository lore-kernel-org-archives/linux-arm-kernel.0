From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2016 10:37:02 +0100
Subject: [PATCH] ARM: fix kmemleak for XIP_KERNEL
In-Reply-To: <CAJpBn1zow6P5MUFP+jbOXafoH9dLV8Ng7cJqfRsE8FMEEe9J8Q@mail.gmail.com>
References: <20161122142829.1776129-1-arnd@arndb.de>
 <CAJpBn1zow6P5MUFP+jbOXafoH9dLV8Ng7cJqfRsE8FMEEe9J8Q@mail.gmail.com>
Message-ID: <2275597.t9zIij20nT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 24, 2016 1:30:03 AM CET Jakub Kicinski wrote:
> On Tue, Nov 22, 2016 at 6:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The newly added check for RO_AFTER_INIT_DATA in kmemleak breaks ARM whenever
> > XIP_KERNEL is enabled:
> >
> > mm/kmemleak.o: In function `kmemleak_scan':
> > kmemleak.c:(.text.kmemleak_scan+0x2e4): undefined reference to `__end_data_ro_after_init'
> > kmemleak.c:(.text.kmemleak_scan+0x2e8): undefined reference to `__start_data_ro_after_init'
> >
> > This adds the start/end symbols for the section even in the case of having
> > no data in the section, to make the check work while keeping the architecture
> > specific override in one place.
> >
> > Fixes: d7c19b066dcf ("mm: kmemleak: scan .data.ro_after_init")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > The patch causing this was merged late into v4.9-rc, this one should
> > probably go there as well.
> >
> > I assume the same problem exists on s390, but I have not checked that.
> 
> Hi Arnd!
> 
> Sorry for breaking things again :( The confusion must have been caused
> by going via different trees.  Actually, Russell's commit is dated 6
> days after mine so could as well be:
> 
> Fixes: 2a3811068fbc ("ARM: Fix XIP kernels")
> 
> Not that it matters.

Got it. I guess it's really the combination of the two, so I'd clarify
that in the changelog and list both commits.
 
> About s390 - I thought I took care of it in d7c19b066dcf ("mm:
> kmemleak: scan .data.ro_after_init"), do you see anything suspicious
> in the way I did it?  I'll do some more s390 builds just to triple
> check.

You are right, I had already noticed that too but not replied yet.
s390 is ok as far as I can tell.

	Arnd
