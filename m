From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jul 2014 16:00:29 +0200
Subject: [PATCH] arm64: Move struct stat64 to uapi.
In-Reply-To: <1405420413.9794.10.camel@kazak.uk.xensource.com>
References: <1405409946-1790-1-git-send-email-ijc@hellion.org.uk>
 <20140715082040.GB24269@arm.com>
 <1405420413.9794.10.camel@kazak.uk.xensource.com>
Message-ID: <5805894.iOXIQkbsCh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 July 2014 11:33:33 Ian Campbell wrote:
> (dropping second incorrect CC to the wrong l-a-k)
> 
> On Tue, 2014-07-15 at 09:20 +0100, Will Deacon wrote:
> > Hi Ian,
> > 
> > On Tue, Jul 15, 2014 at 08:39:06AM +0100, Ian Campbell wrote:
> > > This struct is part of the user API for compat tasks so I think it belongs in
> > > uapi and should use the __uFOO types.
> > 
> > I don't think we should be exposing compat structures through the arm64
> > UAPI. Compat tasks should be built against the native arm headers and
> > nothing else.
> 
> Other 64bit arches do appear to define a struct stat64 in
> uapi/asm/stat.h though, arm64 is the only arch which even has asm/stat.h
> at all.

Other 64-bit architectures share this header file with their 32-bit
counterparts, arm64 does not, and should definitely not export a structure
to user space that is useless to user space.

If you look at the x86 variant for instance, you will notice that
it only contains a stat64 definition for 32-bit native mode, which
doesn't exist for the arm64 headers (we use the arm32 headers instead).

What is special about arm64 is the use of 'struct stat64' to implement
the compat version of stat64 syscalls for arm32, everything else
defines their own syscalls, e.g. sys32_stat64 in
arch/x86/ia32/sys_ia32.c. I think the arm64 method is much better
than the traditional one though, so we shouldn't give that up
easily.

> > > This was exposed by the Debian kernel's application of the aufs patches which
> > > led to:
> > > 
> > > In file included from /?PKGBUILDDIR?/include/linux/mm.h:23:0,
> > >                  from /?PKGBUILDDIR?/include/linux/pid_namespace.h:6,
> > >                  from /?PKGBUILDDIR?/include/linux/ptrace.h:9,
> > >                  from /?PKGBUILDDIR?/arch/arm64/include/asm/compat.h:26,
> > >                  from /?PKGBUILDDIR?/arch/arm64/include/asm/stat.h:23,
> > >                  from /?PKGBUILDDIR?/include/linux/stat.h:5,
> > >                  from /?PKGBUILDDIR?/include/linux/module.h:10,
> > >                  from /?PKGBUILDDIR?/init/main.c:15:
> > > /?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: 'struct kstat' declared inside parameter list [enabled by default]
> > >   int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
> > >                                                                 ^
> > > /?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> > > 
> > > This is due to an extra fs.h include added to mm.h. arm64 was the only arch built by
> > > Debian which had an issue with this, so I think it is an issue with the arm64
> > > headers rather than the aufs patches.
> > 
> > Hmm, but struct kstat is defined in linux/stat.h so I'm not sure why this is
> > arm64-specific. linux/fs.h includes that on line 10.
> 
> That include won't do anything because we already got here via
> linux/stat.h (6th line of "In file included from" above), so the guard
> has already been defined. IOW there is a loop in the includes, which
> starts before kstat is struct defined:
> 
> linux/stat.h -> asm/stat.h -> arm/compat.h -> linux/ptrace.h ->
> linux_pidnamespace.h -> linux/mm.h -> linux/fs.h
>
> The last link here is added by aufs patches, but all the other arches
> are ok with this because none of them have asm/stat.h, they only have
> uapi/asm/stat.h.

The added mm.h->fs.h looks like a mistake, it should not be there, and we have
in the past worked hard to separate mm.h, sched.h and fs.h from one another.

> The issue ultimately is down to the asm/stat.h -> asm/compat.h link
> though I think so an alternative fix could be to switch to a different
> set of types for the existing definition and ditching asm/compat.h from
> asm/stat.h. I don't think that's the correct fix though.

Much better than the move into the user-exported file though.

	Arnd
