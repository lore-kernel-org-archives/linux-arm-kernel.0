From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 16 Jul 2014 16:50:10 +0100
Subject: [PATCH] arm64: Move struct stat64 to uapi.
In-Reply-To: <20140716132708.GP29414@arm.com>
References: <1405409946-1790-1-git-send-email-ijc@hellion.org.uk>
 <20140715082040.GB24269@arm.com>
 <1405420413.9794.10.camel@kazak.uk.xensource.com>
 <20140716132708.GP29414@arm.com>
Message-ID: <1405525810.1087.43.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-16 at 14:27 +0100, Will Deacon wrote:
> On Tue, Jul 15, 2014 at 11:33:33AM +0100, Ian Campbell wrote:
> > On Tue, 2014-07-15 at 09:20 +0100, Will Deacon wrote:
> > > Hmm, but struct kstat is defined in linux/stat.h so I'm not sure why this is
> > > arm64-specific. linux/fs.h includes that on line 10.
> > 
> > That include won't do anything because we already got here via
> > linux/stat.h (6th line of "In file included from" above), so the guard
> > has already been defined. IOW there is a loop in the includes, which
> > starts before kstat is struct defined:
> > 
> > linux/stat.h -> asm/stat.h -> arm/compat.h -> linux/ptrace.h ->
> > linux_pidnamespace.h -> linux/mm.h -> linux/fs.h
> > 
> > The last link here is added by aufs patches, but all the other arches
> > are ok with this because none of them have asm/stat.h, they only have
> > uapi/asm/stat.h.
> > 
> > The issue ultimately is down to the asm/stat.h -> asm/compat.h link
> > though I think so an alternative fix could be to switch to a different
> > set of types for the existing definition and ditching asm/compat.h from
> > asm/stat.h. I don't think that's the correct fix though.
> 
> Perhaps we could split asm/compat.h into asm/compat-types.h containing just
> the type definitions, then asm/compat.h can include that as well as defining
> any functions and macros.
> 
> Then asm/stat.h just needs to include asm/compat-types.h to avoid the
> issue.

I think that looks like it will work. I'll give it a go.

> > > Can you help me unconfuse myself, please?
> > 
> > I hope I've managed to reduce rather than increase the confusion ;-)
> 
> I think so, but it hurt :)

:)

Ian.
