From: joseph@codesourcery.com (Joseph Myers)
Date: Wed, 11 Feb 2015 21:41:27 +0000
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211190252.GB23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <CAMe9rOqX-VpjZ+E-JCusk+e4Kpw1V1tsFq1Kjtai5DR9saKLaA@mail.gmail.com>
 <20150211190252.GB23507@brightrain.aerifal.cx>
Message-ID: <alpine.DEB.2.10.1502112125560.19244@digraph.polyomino.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Feb 2015, Rich Felker wrote:

> > > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
> > 
> > Please leave x32 out of this discussion.  I have resolved this bug
> > as WONTFIX.
> 
> From the glibc side, I thought things went by a consensus process
> these days, not the old WONTFIX regime of he who shall not be named.
> If this is not fixed for x32, then x32 cannot provide a conforming C
> environment and thus it's rather a toy target. But I think we should
> discuss this on libc-alpha. In the mean time please leave it REOPENED.

Indeed.  x86 is handled primarily by community review, and even when we 
have maintainers for architectures or other subsystems, being maintainer 
serves as a shortcut to presume consensus in the absence of controversy 
(in the expectation that the community won't object), not to override 
community discussion if something is more controversial.  I've reopened 
the bug.

I believe I made clear in the discussion of 64-bit time interfaces for 
32-bit systems that the x32 ABI mistake was not one to be repeated - that 
since there is obviously no need for nanoseconds values that cannot fit in 
32 bits, nanoseconds (and microseconds) values should remain as long in 
accordance with POSIX.  It's absolutely fine for the userspace structures 
to have an explicit __glibc_reserved padding field in an endian-dependent 
place to keep the low part of the nanoseconds value in the same place as 
it would be for a 64-bit type, but if the kernel doesn't ignore that 
padding for the 64-bit time interfaces then all places that pass these 
structures from glibc to the kernel need to copy them and zero the padding 
in the copy.

Whether the high 32 bits can be treated as padding for interfaces where 
long is 64-bit depends on whether the interfaces in question are required 
to return an error such as EINVAL for out-of-range nanoseconds values.

-- 
Joseph S. Myers
joseph at codesourcery.com
