From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 15 Jul 2014 11:33:33 +0100
Subject: [PATCH] arm64: Move struct stat64 to uapi.
In-Reply-To: <20140715082040.GB24269@arm.com>
References: <1405409946-1790-1-git-send-email-ijc@hellion.org.uk>
 <20140715082040.GB24269@arm.com>
Message-ID: <1405420413.9794.10.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(dropping second incorrect CC to the wrong l-a-k)

On Tue, 2014-07-15 at 09:20 +0100, Will Deacon wrote:
> Hi Ian,
> 
> On Tue, Jul 15, 2014 at 08:39:06AM +0100, Ian Campbell wrote:
> > This struct is part of the user API for compat tasks so I think it belongs in
> > uapi and should use the __uFOO types.
> 
> I don't think we should be exposing compat structures through the arm64
> UAPI. Compat tasks should be built against the native arm headers and
> nothing else.

Other 64bit arches do appear to define a struct stat64 in
uapi/asm/stat.h though, arm64 is the only arch which even has asm/stat.h
at all.

AIUI the idea is that the compat version provided by the 64bit headers
is supposed to provide the appropriate padding/packing such that the in
memory layout matches the 32-bit version even when built with a 64-bit
compiler, which might have different sized longs, different alignment
requirements etc.

I suppose this is for the benefit of 64-bit tools which want to
introspect 32-bit core dumps/processes or something. (I'm hoping David
can clarify what the intention was here...)

> What happens if you turn compat off (CONFIG_COMPAT=n)?

Due to the #ifdef CONFIG_COMPAT in the current asm/stat.h I'm pretty
sure it'll be fine.

> > This was exposed by the Debian kernel's application of the aufs patches which
> > led to:
> > 
> > In file included from /?PKGBUILDDIR?/include/linux/mm.h:23:0,
> >                  from /?PKGBUILDDIR?/include/linux/pid_namespace.h:6,
> >                  from /?PKGBUILDDIR?/include/linux/ptrace.h:9,
> >                  from /?PKGBUILDDIR?/arch/arm64/include/asm/compat.h:26,
> >                  from /?PKGBUILDDIR?/arch/arm64/include/asm/stat.h:23,
> >                  from /?PKGBUILDDIR?/include/linux/stat.h:5,
> >                  from /?PKGBUILDDIR?/include/linux/module.h:10,
> >                  from /?PKGBUILDDIR?/init/main.c:15:
> > /?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: 'struct kstat' declared inside parameter list [enabled by default]
> >   int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
> >                                                                 ^
> > /?PKGBUILDDIR?/include/linux/fs.h:1575:64: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> > 
> > This is due to an extra fs.h include added to mm.h. arm64 was the only arch built by
> > Debian which had an issue with this, so I think it is an issue with the arm64
> > headers rather than the aufs patches.
> 
> Hmm, but struct kstat is defined in linux/stat.h so I'm not sure why this is
> arm64-specific. linux/fs.h includes that on line 10.

That include won't do anything because we already got here via
linux/stat.h (6th line of "In file included from" above), so the guard
has already been defined. IOW there is a loop in the includes, which
starts before kstat is struct defined:

linux/stat.h -> asm/stat.h -> arm/compat.h -> linux/ptrace.h ->
linux_pidnamespace.h -> linux/mm.h -> linux/fs.h

The last link here is added by aufs patches, but all the other arches
are ok with this because none of them have asm/stat.h, they only have
uapi/asm/stat.h.

The issue ultimately is down to the asm/stat.h -> asm/compat.h link
though I think so an alternative fix could be to switch to a different
set of types for the existing definition and ditching asm/compat.h from
asm/stat.h. I don't think that's the correct fix though.

> Can you help me unconfuse myself, please?

I hope I've managed to reduce rather than increase the confusion ;-)

Ian.
